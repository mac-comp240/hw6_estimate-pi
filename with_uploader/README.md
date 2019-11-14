# A Team project

You should do this assignment with one other person in your class. You may share account information so that you both use one of the accounts that you have been given.

You may complete this homework with a partner from class. In the report
that you will create and upload to moodle, please indicate your team
member names. You should upload one report per team to moodle-- we do not
want confusion about which report we should grade, so only turn in one
(one person on the team can upload it).

This homework is different than others for this course, in that it is a
longer project for which you will write a professional-style report that
demonstrates your understanding of speedup and scalability based on
experiments you have run on OpenMP code.

# Report Criteria

-   Team member names
-   location of code on wulver (which account to look at and which machine)
-   Well-written prose explaining:
        1.  Updates to the code
        2.  How to compile the code
        3.  How to run the program
        
-   Well-written prose explaining the methods you used to obtain your data:      
        1.  What scripts you used to generate your data
        1. Description of your methodology: how many times you ran your experiments and what conditions you used (i.e. cases you tried)

-   Well-written prose containing your findings regarding the speedup of the parallel version, including
    :   1.  Clear explanation of test cases you tried
        2.  Graphs depicting speedup and efficiency and weak scalability
        3.  Explanation of results (see more below)
        

Note that the report should have sections with headers so that each part of what you are reporting is obvious to the reader.

# Estimating pi using a monte carlo method

Please see [this blog post for an explanation of the code you will be working from](https://learntofish.wordpress.com/2010/10/13/calculating-pi-with-the-monte-carlo-method/).

## How fast can we go and how effective is the parallel version?

Your goal will be to determine the speedup and efficiency of a parallel version of this algorithm, which you will create. You will be given a sequential version as a guide.

## You will not use a codio VM

You have been given account information for Libby's server, named wulver.macalester.edu.


## The starting code

Get the starter code containing a sequential version and a makefile by doing this:

    cp -r ../shared/hw6/ .
    
You will now have a directory called hw6 that contains 2 files. Go into it:

    cd hw6

There is a sequential version (does not use multiple threads, just one process) of C code for this problem called `monteCarloPi_Seq.c`. The Makefile will make it.

Run it like this:

    ./monteCarloPi_Seq 4194304
    
The command line argument is a number of sample 'throws' or tries. *Note that the number of tries given above is actually rather small for this problem.* We would call that a small **problem size**.

Study the code so you understand it. Note that we are determining how many digits of accuracy for pi we can get by reporting this in the code.

### How accurate?

Spend some time determining what problems sizes as powers of 2 give how many digits of accuracy for pi.

Keep a record of this information and the following:

Please note: the rand_r function can only create a certain number of random numbers before it starts taking too much time. The most you can create is about 2,145,000,000. I suggest stopping there. How long does that take? Starting from 4194304, how long do other powers of 2 problem sizes take? 

## Your goal: create an openMP threaded version of this code

Now we want to make code that will run faster.

You can copy the original sequential version into a separate file **that must be called** monteCarloPi_omp.c

Please be very certain that you name the parallel openMP version of your file correctly.

**You will need to make substantial changes to your parallel version from the original.** They can be summarized as follows:

- update the all: line in the makefile to remove the comment for monteCarloPi_omp
- take in number of threads from command line
- change seeds so there is one per thread in an array (see the monte carlo coin flip example, provided in a subdirectory called monte_carlo and described [in this explanation of how to set up one seed per thread](http://selkie-macalester.org/csinparallel/modules/MonteCarloSimulationExemplar/build/html/SeedingThreads/SeedEachThread.html) and in a codio activity). Note that there are variations on this idea that also work; just ensure that you are creating a private seed that is different for each thread.
- change to omp_get wtime() for timing
- add pragmas for openMP

Then you will want to make sure the code is correct and also spend some more time determining what problems sizes as powers of 2 give how many digits of accuracy for pi. Make sure the results for accuracy match the sequential results. If they don't there is something wrong with your parallel code.

- fix up printing to print out data as comma-separated list:

    numThreads, numSamples, time_spent, accuracy

## Run experiments

You will want to create a shell script to run your code several times for each case you choose. You may end up deciding to show all of them in your report, and to also show a subset of them as a separate digram in your report, choosing ultimately the ones that best illustrate the sppedup and scalability of this program.

The shell scripts from the trapazoidal rule activity example is given to you in the hw6 directory. **You will need to update these scripts to use them for this problem.**

You should choose problem sizes that give varying amounts of accuracy of pi, up to the most we can do because of how rand_r behaves.

For the omp version of your code, you should vary the threads from 2 to some size that makes sense. (After a certain number of threads, which varies by problem size, there are no more gains in speedup.)

Use the sequential version you were given to gather the timing numbers for the sequential case.

## Plot your data

Use the spreadsheet you will get in class for the trapezoidal rule example as your guide for creating the data and graphs that you need.

## Write a report that will go on moodle

You will turn in your code and a report of your devised tests and the results. In your report, please show your work and compute values for estimated speedup of your code. Your report should contain at least one graph showing speedup and one graph showing efficiency for:

-   Varying numbers of threads for a set of fixed problem sizes
    (x-axis is number of threads; y-axis is speedup or efficiency, each line is for
    problem size).

You should also gather data and show a graph for weak scalability.

You must not only show your work, but describe what the results mean in terms of the scalability of your algorithm for varying problem sizes. This is the important part:

1. When does your program exhibit *strong scalability*?
2. When does your program exhibit *weak scalability* ?

I expect a professional report with a reasoned explanation of your data. Be certain to make sure that you have chosen your tests correctly. If you believe you did not choose your test cases well and cannot explain your results, then explain what further tests you need to complete the picture of the scalability of your algorithm.


