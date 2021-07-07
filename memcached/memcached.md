# Memcached的线程管理

在memcached最初的版本中，memcached的线程管理很简单。

- 1个监听线程

- n个事件工作线程

- 一些其他后台线程

每个工作线程被分配连接，并运行自己的epoll循环。Global lock负责中央散列表、LRU列表和一些统计计数器。工作线程负责协议解析、数据传输。所有的数据查找和修改操作都使用centrol lock。

在v1.4.9代码版本中的`thread.c`文件定义锁的代码：

```c
/* Lock for cache operations (item_*, assoc_*) */
pthread_mutex_t cache_lock;

/* Connection lock around accepting new connections */
pthread_mutex_t conn_lock = PTHREAD_MUTEX_INITIALIZER;

/* Lock for global stats */
static pthread_mutex_t stats_lock;

/* Free list of CQ_ITEM structs */
static CQ_ITEM *cqi_freelist;
static pthread_mutex_t cqi_freelist_lock;

static LIBEVENT_DISPATCHER_THREAD dispatcher_thread;

/*
 * Each libevent instance has a wakeup pipe, which other threads
 * can use to signal that they've put a new connection on its queue.
 */
static LIBEVENT_THREAD *threads;

/*
 * Number of worker threads that have finished setting themselves up.
 */
static int init_count = 0;
static pthread_mutex_t init_lock;
static pthread_cond_t init_cond;
```

现在的线程模型改变了。以v1.6.9的代码为例：

```c
/* Locks for cache LRU operations */
pthread_mutex_t lru_locks[POWER_LARGEST];

/* Connection lock around accepting new connections */
pthread_mutex_t conn_lock = PTHREAD_MUTEX_INITIALIZER;

#if !defined(HAVE_GCC_ATOMICS) && !defined(__sun)
pthread_mutex_t atomics_mutex = PTHREAD_MUTEX_INITIALIZER;
#endif

/* Lock for global stats */
static pthread_mutex_t stats_lock = PTHREAD_MUTEX_INITIALIZER;

/* Lock to cause worker threads to hang up after being woken */
static pthread_mutex_t worker_hang_lock;

/* Free list of CQ_ITEM structs */
static CQ_ITEM *cqi_freelist;
static pthread_mutex_t cqi_freelist_lock;

static pthread_mutex_t *item_locks;
/* size of the item lock hash table */
static uint32_t item_lock_count;
unsigned int item_lock_hashpower;
#define hashsize(n) ((unsigned long int)1<<(n))
#define hashmask(n) (hashsize(n)-1)

/*
 * Each libevent instance has a wakeup pipe, which other threads
 * can use to signal that they've put a new connection on its queue.
 */
static LIBEVENT_THREAD *threads;

/*
 * Number of worker threads that have finished setting themselves up.
 */
static int init_count = 0;
static pthread_mutex_t init_lock;
static pthread_cond_t init_cond;


static void thread_libevent_process(evutil_socket_t fd, short which, void *arg);

/* item_lock() must be held for an item before any modifications to either its
 * associated hash bucket, or the structure itself.
 * LRU modifications must hold the item lock, and the LRU lock.
 * LRU's accessing items must item_trylock() before modifying an item.
 * Items accessible from an LRU must not be freed or modified
 * without first locking and removing from the LRU.
 */

void item_lock(uint32_t hv) {
    mutex_lock(&item_locks[hv & hashmask(item_lock_hashpower)]);
}

void *item_trylock(uint32_t hv) {
    pthread_mutex_t *lock = &item_locks[hv & hashmask(item_lock_hashpower)];
    if (pthread_mutex_trylock(lock) == 0) {
        return lock;
    }
    return NULL;
}

void item_trylock_unlock(void *lock) {
    mutex_unlock((pthread_mutex_t *) lock);
}

void item_unlock(uint32_t hv) {
    mutex_unlock(&item_locks[hv & hashmask(item_lock_hashpower)]);
}
```

- 一个次要的小型锁的哈希表被用来按其哈希值锁定一个item。这可以防止多个线程在同一时间对同一item采取行动。

- 这个二级哈希表被映射到中央哈希表桶中。这允许多个线程并行地访问哈希表。只有一个线程可以对一个特定的哈希表桶进行读或写。

- 每个item的原子计数（atomic refcounts）被用来管理垃圾收集和可变性。

- 当从LRU尾部拉出一个item进行驱逐或重新分配时，系统必须尝试使用trylock锁定这个item的桶来避免死锁。如果一个桶在使用中（而且不是由该线程使用），它将在LRU上寻找并试图获取一个not-busy的item。

- 每个LRU（以及较新模式下的子LRU）都有一个独立的锁。

- 对`slab class`的原生访问受`global slabs_lock`的保护。这是一个简短的锁，包括push和pop空闲内存的功能。

- `item_lock`在修改一个item时必须获取。

- `slabs_lock`在修改一个item中的`ITEM_SLABBED`标志位时必须保持。

- `ITEM_LINKED`不能在一个item有一个键被复制到它之前被设置。

- 没有设置`ITEM_SLABBED`的item不能将其内存清零。

锁的顺序：

item_lock -> lru_lock -> slabs_lock

lru_lock -> item_trylock

不同的stats_locks不应该有其他的锁作为依赖。

后台线程有各种各样的锁。它们可用于在线程空闲时暂停线程执行或更新设置。它们可以调用item锁或lru锁。

一个低优先级的问题：

- 如果你去掉每线程的统计锁，CPU的使用率会下降不到百分之一点，而且也不会提高可扩展性。

- 在我的测试中，剩余的全局STATS LOCK调用似乎永远不会发生冲突。

是的，更多的stats可以转移到线程，这些锁实际上可以在x86-64系统上完全删除。在x86-64系统上完全删除。然而，我的测试并没有显示出这是一个好处，所以我优先考虑了其他工作。

## 参考

1. [memcached-thread](https://github.com/memcached/memcached/blob/master/doc/threads.txt)
