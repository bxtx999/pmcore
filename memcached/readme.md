# Memcached

## Memcached结构和线程

## memtier_benchmark测试

memtier bench生成针对Memcached和Redis实例的各种流量模式。它提供了一组健壮的自定义和报告功能，这些功能都封装在一个方便且易于使用的命令行界面中。我们广泛地使用它来满足我们所有的基准测试需求，既用于开发，也用于帮助与更广泛的社区分享我们的知识(例如，正如我们在这篇博文中所做的那样)。我们已经在GPLv2许可计划下发布了memtier bench源代码，你可以从我们的github帐户下载它。以下是一些关于的重点：

- It supports both Redis and Memcached (binary and text) protocols so you can use it to test both and even compare their performance under different scenarios

- memtier_benchmark is capable of launching multiple worker threads (using the `-t` option), with each thread driving a configurable number of clients (the `-c` option). Multiple threads enable you to better utilize the hardware resources of your benchmarking client and generate high traffic loads even using a single server.

- When you instruct the tool to do multiple iterations of the benchmark run (the `-x` option), it will automatically produce reports for the best and worst runs as well as aggregated averages

- You can control the ratio between `GET` and `SET` operations with the `ratio` option to measure performance when dealing with different access patterns

- The tool offers control over the pattern of keys used by the `GET` and `SET` operations (`key-pattern` option). Each operation’s pattern can be set independently to be random or sequential.

- Keys’ expiry can be common or randomly set from a configurable range (the `expiry-range` option)

### 使用方法

```bash
Usage: memtier_benchmark [options]
A memcache/redis NoSQL traffic generator and performance benchmarking tool.

Connection and General Options:
  -s, --server=ADDR              Server address (default: localhost)
  -p, --port=PORT                Server port (default: 6379)
  -S, --unix-socket=SOCKET       UNIX Domain socket name (default: none)
  -P, --protocol=PROTOCOL        Protocol to use (default: redis).  Other
                                 supported protocols are memcache_text,
                                 memcache_binary.
  -x, --run-count=NUMBER         Number of full-test iterations to perform
  -D, --debug                    Print debug output
      --client-stats=FILE        Produce per-client stats file
      --out-file=FILE            Name of output file (default: stdout)
      --show-config              Print detailed configuration before running

Test Options:
  -n, --requests=NUMBER          Number of total requests per client (default: 10000)
  -c, --clients=NUMBER           Number of clients per thread (default: 50)
  -t, --threads=NUMBER           Number of threads (default: 4)
      --test-time=SECS           Number of seconds to run the test
      --ratio=RATIO              Set:Get ratio (default: 1:10)
      --pipeline=NUMBER          Number of concurrent pipelined requests (default: 1)
      --reconnect-interval=NUM   Number of requests after which re-connection is performed
      --multi-key-get=NUM        Enable multi-key get commands, up to NUM keys (default: 0)
  -a, --authenticate=PASSWORD    Authenticate to redis using PASSWORD
      --select-db=DB             DB number to select, when testing a redis server

Object Options:
  -d  --data-size=SIZE           Object data size (default: 32)
  -R  --random-data              Indicate that data should be randomized
      --data-size-range=RANGE    Use random-sized items in the specified range (min-max)
      --data-size-list=LIST      Use sizes from weight list (size1:weight1,..sizeN:weightN)
      --expiry-range=RANGE       Use random expiry values from the specified range

Imported Data Options:
      --data-import=FILE         Read object data from file
      --generate-keys            Generate keys for imported objects

Key Options:
      --key-prefix=PREFIX        Prefix for keys (default: memtier-)
      --key-minimum=NUMBER       Key ID minimum value (default: 0)
      --key-maximum=NUMBER       Key ID maximum value (default: 10000000)
      --key-pattern=PATTERN      Set:Get pattern (default: R:R)

      --help                     Display this help
      --version                  Display version information
```

### 代码

Github：https://github.com/RedisLabs/memtier_benchmark

使用docker运行

```bash
# latest stable release
$ docker run --rm redislabs/memtier_benchmark:latest --help

# master branch edge build
$ docker run --rm redislabs/memtier_benchmark:edge --help
```

执行：

```bash
docker build -t memtier_benchmark .
docker run --rm memtier_benchmark --help
```

或者使用docker-compose

```bash
docker-compose -f docker-compose.yml up --build
```

## 参考

1. [memtier_benchmark: A High-Throughput Benchmarking Tool for Redis & Memcached](https://redislabs.com/blog/memtier_benchmark-a-high-throughput-benchmarking-tool-for-redis-memcached/)

2. [memtier_github](https://github.com/RedisLabs/memtier_benchmark)
