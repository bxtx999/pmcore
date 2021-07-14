# CoreArbiter st

## useage

```bash
cd CoreArbiter
sudo make test
```

## resutls

### CoreArbiterServerTest

```bash
$ sudo ./CoreArbiterServerTest
Running main() from ../googletest/googletest/src/gtest_main.cc
[==========] Running 22 tests from 1 test suite.
[----------] Global test environment set-up.
[----------] 22 tests from CoreArbiterServerTest
[ RUN      ] CoreArbiterServerTest.constructor_notRoot
[       OK ] CoreArbiterServerTest.constructor_notRoot (0 ms)
[ RUN      ] CoreArbiterServerTest.constructor_socketError
[       OK ] CoreArbiterServerTest.constructor_socketError (47 ms)
[ RUN      ] CoreArbiterServerTest.constructor_bindError
[       OK ] CoreArbiterServerTest.constructor_bindError (29 ms)
[ RUN      ] CoreArbiterServerTest.constructor_listenError
[       OK ] CoreArbiterServerTest.constructor_listenError (30 ms)
[ RUN      ] CoreArbiterServerTest.constructor_chmodError
[       OK ] CoreArbiterServerTest.constructor_chmodError (19 ms)
[ RUN      ] CoreArbiterServerTest.constructor_epollCreateError
[       OK ] CoreArbiterServerTest.constructor_epollCreateError (16 ms)
[ RUN      ] CoreArbiterServerTest.constructor_epollCtlError
[       OK ] CoreArbiterServerTest.constructor_epollCtlError (20 ms)
[ RUN      ] CoreArbiterServerTest.endArbitration
[       OK ] CoreArbiterServerTest.endArbitration (21 ms)
[ RUN      ] CoreArbiterServerTest.defaultCores
[       OK ] CoreArbiterServerTest.defaultCores (0 ms)
[ RUN      ] CoreArbiterServerTest.threadBlocking_basic
[       OK ] CoreArbiterServerTest.threadBlocking_basic (0 ms)
[ RUN      ] CoreArbiterServerTest.threadBlocking_preemptedThread
[       OK ] CoreArbiterServerTest.threadBlocking_preemptedThread (0 ms)
[ RUN      ] CoreArbiterServerTest.threadBlocking_movePreemptedThread
[       OK ] CoreArbiterServerTest.threadBlocking_movePreemptedThread (0 ms)
[ RUN      ] CoreArbiterServerTest.coresRequested
[       OK ] CoreArbiterServerTest.coresRequested (0 ms)
[ RUN      ] CoreArbiterServerTest.distributeCores_noBlockedThreads
[       OK ] CoreArbiterServerTest.distributeCores_noBlockedThreads (0 ms)
[ RUN      ] CoreArbiterServerTest.distributeCores_niceToHaveSinglePriority
[       OK ] CoreArbiterServerTest.distributeCores_niceToHaveSinglePriority (0 ms)
[ RUN      ] CoreArbiterServerTest.distributeCores_niceToHaveMultiplePriorities
[       OK ] CoreArbiterServerTest.distributeCores_niceToHaveMultiplePriorities (0 ms)
[ RUN      ] CoreArbiterServerTest.distributeCores_scaleUnmanagedCore
[       OK ] CoreArbiterServerTest.distributeCores_scaleUnmanagedCore (0 ms)
[ RUN      ] CoreArbiterServerTest.handleEvents_scaleUnmanagedCore
[       OK ] CoreArbiterServerTest.handleEvents_scaleUnmanagedCore (10 ms)
[ RUN      ] CoreArbiterServerTest.timeoutThreadPreemption_basic
[       OK ] CoreArbiterServerTest.timeoutThreadPreemption_basic (2 ms)
[ RUN      ] CoreArbiterServerTest.timeoutThreadPreemption_invalidateOldTimeout
[       OK ] CoreArbiterServerTest.timeoutThreadPreemption_invalidateOldTimeout (0 ms)
[ RUN      ] CoreArbiterServerTest.cleanupConnection
15482083011640 CoreArbiterServer.cc:880 in cleanupConnection ERROR: Error closing socket: Operation not permitted
15482083033728 CoreArbiterServer.cc:880 in cleanupConnection ERROR: Error closing socket: Operation not permitted
15482083048165 CoreArbiterServer.cc:880 in cleanupConnection ERROR: Error closing socket: Operation not permitted
15482083057437 CoreArbiterServer.cc:929 in cleanupConnection ERROR: Error closing sharedMemFd: Operation not permitted
[       OK ] CoreArbiterServerTest.cleanupConnection (0 ms)
[ RUN      ] CoreArbiterServerTest.advisoryLock_multiServer
[       OK ] CoreArbiterServerTest.advisoryLock_multiServer (18 ms)
[----------] 22 tests from CoreArbiterServerTest (218 ms total)

[----------] Global test environment tear-down
[==========] 22 tests from 1 test suite ran. (218 ms total)
[  PASSED  ] 22 tests.
```

### CoreArbiterClientTest

```bash
sudo ./CoreArbiterClientTest 
Running main() from ../googletest/googletest/src/gtest_main.cc
[==========] Running 9 tests from 1 test suite.
[----------] Global test environment set-up.
[----------] 9 tests from CoreArbiterClientTest
[ RUN      ] CoreArbiterClientTest.setRequestedCores_invalidRequest
15826251494113 CoreArbiterClient.cc:118 in setRequestedCores ERROR: Core request must have 8 priorities
15826251674976 CoreArbiterClient.cc:118 in setRequestedCores ERROR: Core request must have 8 priorities
[       OK ] CoreArbiterClientTest.setRequestedCores_invalidRequest (0 ms)
[ RUN      ] CoreArbiterClientTest.setRequestedCores_establishConnection
15826251766608 CoreArbiterClient.cc:497 in sendData ERROR: Error sending core request prefix: Bad file descriptor
[       OK ] CoreArbiterClientTest.setRequestedCores_establishConnection (0 ms)
[ RUN      ] CoreArbiterClientTest.setRequestedCores
[       OK ] CoreArbiterClientTest.setRequestedCores (0 ms)
[ RUN      ] CoreArbiterClientTest.mustReleaseCore
[       OK ] CoreArbiterClientTest.mustReleaseCore (0 ms)
[ RUN      ] CoreArbiterClientTest.blockUntilCoreAvailable_establishConnection
15826251871686 CoreArbiterClient.cc:220 in blockUntilCoreAvailable ERROR: Error sending block message: Bad file descriptor
[       OK ] CoreArbiterClientTest.blockUntilCoreAvailable_establishConnection (0 ms)
[ RUN      ] CoreArbiterClientTest.blockUntilCoreAvailable_alreadyExclusive
[       OK ] CoreArbiterClientTest.blockUntilCoreAvailable_alreadyExclusive (0 ms)
[ RUN      ] CoreArbiterClientTest.getNumOwnedCores
[       OK ] CoreArbiterClientTest.getNumOwnedCores (0 ms)
[ RUN      ] CoreArbiterClientTest.setRequestedCores_shim
[       OK ] CoreArbiterClientTest.setRequestedCores_shim (0 ms)
[ RUN      ] CoreArbiterClientTest.mustReleaseCore_shim
[       OK ] CoreArbiterClientTest.mustReleaseCore_shim (0 ms)
[----------] 9 tests from CoreArbiterClientTest (0 ms total)

[----------] Global test environment tear-down
[==========] 9 tests from 1 test suite ran. (0 ms total)
[  PASSED  ] 9 tests.
```

### othertest.
