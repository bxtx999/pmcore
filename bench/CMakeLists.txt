cmake_minimum_required (VERSION 3.13)

project (bench LANGUAGES CXX)

IF( NOT CMAKE_BUILD_TYPE )
    SET( CMAKE_BUILD_TYPE Release ... FORCE )
ENDIF()

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set (CMAKE_INCLUDE_CURRENT_DIR ON)

set(PMDK /home/aim/hjn/pmdk)

file(GLOB BENCH_SOURCE ./*.hpp)
add_executable(bench_origin interference.cpp ${BENCH_SOURCE})
target_compile_features(bench_origin PRIVATE cxx_std_17)
target_include_directories(bench_origin PRIVATE ${PMDK}/src/include/)
target_link_libraries(bench_origin RPIVATE daxctl pthread ndctl ${PMDK}/src/nondebug/libpmem.a ${PMDK}/src/nondebug/libpmemlog.a)
target_compile_options(bench_origin PRIVATE -g0 -O3 -march=native)