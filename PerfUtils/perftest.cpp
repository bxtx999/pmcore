//
// Created by hoo on 2021/7/13.
//

#include "PerfUtils/TimeTrace.h"

using PerfUtils::TimeTrace;

int main(){
    TimeTrace::record("Start of execution");
    uint64_t sum = 0;
    for (int i = 0; i < (1 << 20); i++) {
        sum += i;
    }
    TimeTrace::record("End of a counting loop");
    TimeTrace::record("Hello world");
    TimeTrace::print();
    return 0;
}