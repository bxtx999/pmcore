# pmcore

## 运行

1. example

   - 编译 example

     `g++ -std=c++11 -o example example.cpp   -IArachne/include -ICoreArbiter/include  -IPerfUtils/include -LArachne/lib -lArachne -LCoreArbiter/lib -lCoreArbiter -LPerfUtils/lib/ -lPerfUtils  -lpcrecpp -pthread`

   - 运行 coreArbiterServer

   - 运行 example

     ```bash
     $ sudo ./example 
     0.1067042283: DEBUG: Number of cores increased from 0 to 1

     Arachne says hello world and creates a thread.
     NumberPrinter says 5
     ```

2. Other

   测试
