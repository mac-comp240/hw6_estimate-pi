#!/bin/bash

# this runs either the sequential or parallel omp version of the monte carlo
# pi program 'n' times for a given problem size and number of threads.

# Author: Libby Shoop

# Usage:
#         bash ./run_a_test.sh 1024 4 6
#    Runs the omp verion 6 times using a problem size of 1024 'samples' with 4 threads

problem_size=$1   #first argument is problem size
num_threads=$2    #second argument is number of threads
num_times=$3      #third argument is number of times to run the test

if [  "$num_threads" == "1"  ]; then
  command="./monteCarloPi_Seq $problem_size"
else
  command="./monteCarloPi_omp $problem_size $num_threads"
fi

echo "==============  Running " $num_times "tests of : " $command

#for test in {1..$numtimes}
#do
counter=1
while [ $counter -le $num_times ]
do
  echo "++++++++++++++++++++++ test" $counter "+++++++++++++++++++++++++++"
  $command
  ((counter++))
done
