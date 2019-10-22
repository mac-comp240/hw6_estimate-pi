#!/bin/bash

# Runs a series of tests using the run_a_test.sh script

# Author: Libby Shoop

# Usage:
#          bash ./run_tests.sh 4
#    will run each problem size set below 4 times using a variety of thread counts

# Note: you can set the number of time you want to run each test
#       by including it on the command line
num_times=$1

# Note: you should set the problem sizes that you want to run-
#        the following are very poor problem sizes
for problem_size in 4194304 8388608 16777216 33554432 67108864 134217728 268435456
do

  echo "******************  Problem Size: " $problem_size "  **********************"

  for num_threads in 1 2 4 #8 12 16 24
  do
    bash ./run_a_test.sh $problem_size $num_threads $num_times
  done

done
