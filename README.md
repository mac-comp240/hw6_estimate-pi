# Estimating Pi using the Monte Carlo Method

In this assignment, you will write a parallel program that estimates the value
of pi using the monte carlo method. You will run your program many times on
different input values in order to examine two parallel programming concepts:
**speedup** and **efficiency**.

For this assignment, you will be working in pairs and turning in a written
report.

## Report Criteria

Turn in a written report to Moodle (one per group, please) with the following
content:

-   Team member names
-   location of code on wulver (which user account to look at)
-   Well-written prose explaining:
	1.  Updates to the code
	2.  How to compile the code
	3.  How to run the program
        
-   Well-written prose explaining the methods you used to obtain your data:      
	1.  What scripts you used to generate your data
	2. Description of your methodology: how many times you ran your experiments and what conditions you used (i.e. cases you tried)

-   Well-written prose containing your findings regarding the speedup of the parallel version, including: 
	1.  Clear explanation of test cases you tried
	2.  Graphs depicting speedup, efficiency, and weak scalability
	3.  Explanation of when your program exhibits strong scalability
	4.  Explanation of when your program exhibits weak scalability
        
Your report must have obvious section headers for each of the above.

## Problem Definition

Please see [this blog post for an explanation of the code you will be working from](https://learntofish.wordpress.com/2010/10/13/calculating-pi-with-the-monte-carlo-method/).

### How effective is the parallel version?

Your goal is to determine the speedup and efficiency of a parallel version
of this algorithm, which you will create. You are given a sequential version
as a guide.

## Sequential starter code

There is a sequential version (does not use multiple threads, just one process)
of the C code for this problem called `monteCarloPi_Seq.c`. The Makefile will
make it.

Run it like this:

    ./monteCarloPi_Seq 4194304
    
The command line argument is a number of sample 'throws' or tries. *Note that
the number of tries given above is actually rather small for this problem.* We
would call that a small **problem size**.

Study the code so you understand it. Note that we are determining how many
digits of accuracy for pi we can get by reporting this in the code.

### How accurate?

Spend some time determining what problems sizes as powers of 2 give how many
digits of accuracy for pi. Record the precision (number of accurate digits of
pi) for each problem size.

Please note: the `rand_r` function can only create a certain number of random
numbers before it starts taking too much time. The most you can create is about
2,145,000,000. I suggest stopping there. How long does that take? Starting from
4194304, how long do other powers of 2 problem sizes take? 

## Create an OpenMP threaded version of this code

Now we want to make code that will run faster.

You will make a new code file called `monteCarloPi_omp.c`, which will hold the
parallelized version of the algorithm. Start by copying the code from the
sequential version.

Please be very certain that you name the parallel openMP version of your file
correctly.

**You will need to make substantial changes to your parallel version from the
original.** They can be summarized as follows:

- update the `all:` line in the makefile to remove the comment for
  `monteCarloPi_omp`
- take in the number of threads from command line
- change seeds so there is one per thread in an array (see the monte carlo coin
  flip example in Parallel Activity 3, and [this
  page](http://selkie-macalester.org/csinparallel/modules/MonteCarloSimulationExemplar/build/html/SeedingThreads/SeedEachThread.html).
  Note that there are variations on this idea that also work; just ensure that
  you are creating a private seed that is different for each thread.
- Use to `omp_get wtime()` for timing
- add pragmas for OpenMP

Then you will want to make sure the code is correct and also spend some more
time determining what problems sizes as powers of 2 give how many digits of
accuracy for pi. Make sure the results for accuracy match the sequential
results. If they don't there is something wrong with your parallel code.

- fix up printing to print out data as comma-separated list:

    numThreads, numSamples, time_spent, accuracy

## Run experiments

You will want to create a shell script to run your code several times for each
case you choose. You may end up deciding to show all of them in your report, and
to also show a subset of them as a separate digram in your report, choosing
ultimately the ones that best illustrate the sppedup and scalability of this
program.

The shell scripts from the trapazoidal rule activity example is given to you in
the hw6 directory. **You will need to update these scripts to use them for this
problem.**

You should choose problem sizes that give varying amounts of accuracy of pi, up
to the most we can do because of how `rand_r` behaves.

For the omp version of your code, you should vary the threads from 2 to some
size that makes sense. (After a certain number of threads, which varies by
problem size, there are no more gains in speedup.)

Use the sequential version you were given to gather the timing numbers for the
sequential case.
