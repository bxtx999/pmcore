cmake_minimum_required (VERSION 3.13)

project (bench LANGUAGES CXX)

IF( NOT CMAKE_BUILD_TYPE )
    SET( CMAKE_BUILD_TYPE Release ... FORCE )
ENDIF()

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set (CMAKE_INCLUDE_CURRENT_DIR ON)

set(PMDK /home/aim/hjn/pmdk)

add_executable(example ./example.cpp)
target_compile_features(example PRIVATE cxx_std_17)
target_include_directories(example PRIVATE Arachne/include CoreArbiter/include PerfUtils/include)
target_link_directories(example PRIVATE PerfUtils/lib Arachne/lib CoreArbiter/lib)
target_link_libraries(example PRIVATE Arachne CoreArbiter PerfUtils pthread pcrecpp stdc++)


#clang++ -g0 -O3 -DNDEBUG=1 -march=native -std=c++17
#bench/interference.cpp -IArachne/include -ICoreArbiter/include
#-IPerfUtils/include -I${PMDK}/src/include/
#${PMDK}/src/nondebug/libpmem.a ${PMDK}/src/nondebug/libpmemlog.a
#-LArachne/lib -lArachne -LCoreArbiter/lib -lCoreArbiter
#-LPerfUtils/lib/ -lPerfUtils  -lpcrecpp -lpthread -lndctl -ldaxctl

file(GLOB BENCH_SOURCE bench/*.hpp)
add_executable(bench_origin bench/interference.cpp ${BENCH_SOURCE})
target_compile_features(bench_origin PRIVATE cxx_std_17)
target_include_directories(bench_origin PRIVATE ${PMDK}/src/include/)
target_link_libraries(bench_origin RPIVATE daxctl pthread ndctl ${PMDK}/src/nondebug/libpmem.a ${PMDK}/src/nondebug/libpmemlog.a)
target_compile_options(bench_origin PRIVATE -g0 -O3 -march=native)


add_executable(bench bench/interference.cpp ${BENCH_SOURCE})
target_compile_features(bench PRIVATE cxx_std_17)
target_include_directories(bench PRIVATE ${PMDK}/src/include PerfUtils/include CoreArbiter/include Arachne/include)
target_link_libraries(bench RPIVATE daxctl pthread ndctl ${PMDK}/src/nondebug/libpmem.a ${PMDK}/src/nondebug/libpmemlog.a Arachne CoreArbiter PerfUtils stdc++)
target_link_directories(bench PRIVATE PerfUtils/lib Arachne/lib CoreArbiter/lib)
target_compile_options(bench PRIVATE -g0 -O3 -march=native)