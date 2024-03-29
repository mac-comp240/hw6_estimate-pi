#!/bin/bash

# Runs a series of tests that can fairly easily be copied into the spreadsheet.

# Author: Libby Shoop

# Example Usage:
#          bash ./run_weak_tests.sh 10 1048576 3 > weak_tests.tsv
#
#    will run 10 replicas for 3 separate weak scaling tests,
#    each one starting from  problem sizes
#    1048576, 1048576*2, and 1048576*4 respectively

# Notes: 1. you must set the number of times you want to run each test,
#           the starting problem size, and the number of weak scaling tests.
#           by including it on the command line.
#       2. both monteCarloPi_seq.c and monteCarloPi_omp.cpp need to be updated to print out only
#          this line and ALL OTHER printf lines should be commented:
#         printf("%lf\t",time_spent);
num_times=$1
initial_size=$2
weak_scale_lines=$3

# print a header for the trial, #threads, and set of probelm sizes
# Note: you should set the problem sizes that you want to run for a problem.
#       The following are fairly good for the trapezoidal rule problem
#       and for the strong scalability problem sizes and number of threads.
printf "trial \tprobsiz\tthreads\t time\n"
problem_size=$initial_size
double=0

# for line in 1,2,3,..,$weak_scale_lines
for line in $(seq 1 $weak_scale_lines)
do
  #echo "line: " $line

  # each trial will run num_times using a cretain number of threads
  for num_threads in 1 2 4 8 16
  do
    #echo "problem: " $problem_size    #debug
    #echo "threads: " $num_threads     #debug

    # run the series of tests with the current value of num_threads
    # and current problem size
    counter=1
    while [ $counter -le $num_times ]
    do
       # $counter is the trial number
        printf "$counter\t$problem_size\t$num_threads\t"

     # run the problem size
      # for problem_size in 1048576 2097152 4194304 8388608 16777216 33554432
      # do
        if [  "$num_threads" == "1"  ]; then
          command="./monteCarloPi_Seq $problem_size"
        else
          command="./monteCarloPi_omp $problem_size $num_threads"
        fi

        $command
        # printf "$command  "    #debug

        printf "\n"
        ((counter++))
    done     # number of trials
    problem_size=$(( $problem_size*2 ))
  done       # sets of threads
  printf "\n"

  # set the next starting problem size for the next weak sclability line
  double=$(( 2**$line )) # 2 ^ $line
  problem_size=$(( $initial_size*$double )) # problem size double each line

done    # number of weak scale lines
