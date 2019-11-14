#!/bin/bash

# Runs and uploads the results of a series of tests

# Author: Libby Shoop, Modified by Preston Locke and Abby Marsh

# Usage:
#          bash ./upload_tests.sh 4 kj2l3k2h34l5kh3ljlkhk2gh34 R11:V75
#    will run each problem size set below 4 times using a variety of thread counts
#    then upload the results to the google sheet with given ID at the range R11:V75

# Note: you can set the number of time you want to run each test
#       by including it on the command line
num_times=$1
spreadsheet_id=$2
spreadsheet_range=$3

file_name=temp.txt

rm -f $file_name

# Note: you should set the problem sizes that you want to run-
#        the following are very poor problem sizes
for problem_size in 4194304 8388608 16777216 33554432 67108864 134217728 268435456
do

  for num_threads in 1 2 4 #8 12 16 24
  do

    if [  "$num_threads" == "1"  ]; then
      command="../monteCarloPi_Seq $problem_size"
    else
      command="../monteCarloPi_omp $problem_size $num_threads"
    fi

    counter=1
    while [ $counter -le $num_times ]
    do
      $command  >> $file_name
      ((counter++))
    done
    
  done

  printf "\n" >> $file_name

done

python upload_test.py $file_name $num_times $spreadsheet_id $spreadsheet_range
