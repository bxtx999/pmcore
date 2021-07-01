#!/bin/bash

# Reproduces data for figure 4
# Interference

PMDK=/home/aim/hjn/pmdk

clang++ -g0 -O3 -DNDEBUG=1 -march=native -std=c++17 bench/interference.cpp -IArachne/include -ICoreArbiter/include  -IPerfUtils/include -I${PMDK}/src/include/ ${PMDK}/src/nondebug/libpmem.a ${PMDK}/src/nondebug/libpmemlog.a -LArachne/lib -lArachne -LCoreArbiter/lib -lCoreArbiter -LPerfUtils/lib/ -lPerfUtils  -lpcrecpp -lpthread -lndctl -ldaxctl || exit -1

# Seqential ram
echo "" > results/interference_seq_ram.txt
./a.out 10  0  0  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  1  0  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  5  0  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10 10  0  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  1  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  5  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0 10  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  0  1  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  0  5  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  0 10  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  0  0  1  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  0  0  5  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  0  0 10  0 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  0  0  0  1 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  0  0  0  5 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt
./a.out 10  0  0  0  0 10 /mnt/pmem0/renen | tee -a results/interference_seq_ram.txt

# Seqential nvm
echo "" > results/interference_seq_nvm.txt
./a.out  0 10  0  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  1 10  0  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  5 10  0  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out 10 10  0  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  1  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  5  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10 10  0  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  0  1  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  0  5  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  0 10  0  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  0  0  1  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  0  0  5  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  0  0 10  0 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  0  0  0  1 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  0  0  0  5 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt
./a.out  0 10  0  0  0 10 /mnt/pmem0/renen | tee -a results/interference_seq_nvm.txt

# Random ram
echo "" > results/interference_rnd_ram.txt
./a.out  0  0 10  0  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  1  0 10  0  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  5  0 10  0  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out 10  0 10  0  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  1 10  0  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  5 10  0  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0 10 10  0  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  0 10  1  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  0 10  5  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  0 10 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  0 10  0  1  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  0 10  0  5  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  0 10  0 10  0 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  0 10  0  0  1 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  0 10  0  0  5 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt
./a.out  0  0 10  0  0 10 /mnt/pmem0/renen | tee -a results/interference_rnd_ram.txt

# Random nvm
echo "" > results/interference_rnd_nvm.txt
./a.out  0  0  0 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  1  0  0 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  5  0  0 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out 10  0  0 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  1  0 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  5  0 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0 10  0 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  0  1 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  0  5 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  0 10 10  0  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  0  0 10  1  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  0  0 10  5  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  0  0 10 10  0 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  0  0 10  0  1 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  0  0 10  0  5 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt
./a.out  0  0  0 10  0 10 /mnt/pmem0/renen | tee -a results/interference_rnd_nvm.txt

## Log nvm
#./a.out  0  0  0  0 10  0 /mnt/pmem0/renen
#./a.out  1  0  0  0 10  0 /mnt/pmem0/renen
#./a.out  5  0  0  0 10  0 /mnt/pmem0/renen
#./a.out 10  0  0  0 10  0 /mnt/pmem0/renen
#./a.out  0  1  0  0 10  0 /mnt/pmem0/renen
#./a.out  0  5  0  0 10  0 /mnt/pmem0/renen
#./a.out  0 10  0  0 10  0 /mnt/pmem0/renen
#./a.out  0  0  1  0 10  0 /mnt/pmem0/renen
#./a.out  0  0  5  0 10  0 /mnt/pmem0/renen
#./a.out  0  0 10  0 10  0 /mnt/pmem0/renen
#./a.out  0  0  0  1 10  0 /mnt/pmem0/renen
#./a.out  0  0  0  5 10  0 /mnt/pmem0/renen
#./a.out  0  0  0 10 10  0 /mnt/pmem0/renen
#./a.out  0  0  0  0 10  1 /mnt/pmem0/renen
#./a.out  0  0  0  0 10  5 /mnt/pmem0/renen
#./a.out  0  0  0  0 10 10 /mnt/pmem0/renen
#
## Page nvm
#./a.out  0  0  0  0  0 10 /mnt/pmem0/renen
#./a.out  1  0  0  0  0 10 /mnt/pmem0/renen
#./a.out  5  0  0  0  0 10 /mnt/pmem0/renen
#./a.out 10  0  0  0  0 10 /mnt/pmem0/renen
#./a.out  0  1  0  0  0 10 /mnt/pmem0/renen
#./a.out  0  5  0  0  0 10 /mnt/pmem0/renen
#./a.out  0 10  0  0  0 10 /mnt/pmem0/renen
#./a.out  0  0  1  0  0 10 /mnt/pmem0/renen
#./a.out  0  0  5  0  0 10 /mnt/pmem0/renen
#./a.out  0  0 10  0  0 10 /mnt/pmem0/renen
#./a.out  0  0  0  1  0 10 /mnt/pmem0/renen
#./a.out  0  0  0  5  0 10 /mnt/pmem0/renen
#./a.out  0  0  0 10  0 10 /mnt/pmem0/renen
#./a.out  0  0  0  0  1 10 /mnt/pmem0/renen
#./a.out  0  0  0  0  5 10 /mnt/pmem0/renen
#./a.out  0  0  0  0 10 10 /mnt/pmem0/renen