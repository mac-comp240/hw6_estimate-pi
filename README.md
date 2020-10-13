# Estimating Pi using the Monte Carlo Method

In this assignment, you will write a parallel program that estimates the value of pi using the monte carlo method. You will run your program many times on different input values in order to examine two parallel programming concepts: **speedup** and **efficiency**.  You will also analyze the strong and weak scalability of your solution.

For this assignment, you will be working in pairs and turning in a written report.

## Report Criteria

Turn in a written report to Moodle (one per group, please) with the following
content:

-   Team member names
-   location of code on GitHub (which user account to look at)
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

## Sequential starter code: use C++ version

There is a sequential C version (does not use multiple threads, just one process)
of the C code for this problem called `monteCarloPi_Seq.c`. The Makefile can make it if you remove a comment in the all: line, but this is really there just for reference to see an older C version using rand_r().

**Use this:** There is newer C++ version called `monteCarloPi_Seq.cpp` (note it ends in .cpp). Use this one 

Run it like this:

    ./monteCarloPi_Seq 4194304
    
The command line argument is a number of sample 'throws' or tries. *Note that
the number of tries given above is actually rather small for this problem.* We
would call that a small **problem size**.

Study the code so you understand it. Note that we are determining how many digits of accuracy for pi we can get by reporting this in the code. This is a simple way to do it that could report a positive or negative number as the difference between 3.1415926535 and the value computed using the number of 'trials'. For example, a number reported for accuracy as -0.004785 gives you only 2 digits of pi, because it was off in the third digit.

### How accurate?

Spend some time determining what problems sizes as powers of 2 give how many
digits of accuracy for pi. Record the precision (number of accurate digits of
pi) for each problem size (read on to see how far you can go).

**IMPORTANT: ** Please note that just like the older C  `rand_r` function, even the C++ distribution classes can only create a certain number of random numbers. On our server using g++, the std::uniform_real_distribution<double> class can create MAX_INT different real numbers. Therefore, highest number of 'throws' or 'trials' of x,y values you can us is 2147483647.

You must stop at this number. You can try this if you like- the sequential version takes about 5 minutes, so you will need to be patient. Starting from 4194304, how long do some of the powers of 2 problem sizes take? 

## Create an OpenMP threaded version of this code

Now we want to make code that will run faster.

You will make a new code file called `monteCarloPi_omp.cpp`, which will hold the
parallelized version of the algorithm. Start by copying the code from the
sequential version.

Please be very certain that you name the parallel openMP version of your file
correctly.

**You will need to make substantial changes to your parallel version from the
original.** They can be summarized as follows:

- update the `all:` line in the makefile to remove the comment for
  `monteCarloPi_omp`
- take in the number of threads from command line
- change seeds so there is one per thread in an array. Use the rand_demo.cpp code from an activity as your guide (function parallelGenRandValues()).  Ensure that you have the main thread create the array of seeds first, containing a different value for each thread.
- Use to `omp_get wtime()` for timing
- add pragmas for OpenMP. Note that you will need to worry about what shared variables need to be reduced. You can again use rand_demo.cpp as a guide for the pragmas.

Then you will want to make sure the code is correct and also spend some more
time determining what problem sizes as powers of 2 give how many digits of
accuracy for pi. Make sure the results for accuracy match the sequential
results. If they don't, there is something wrong with your parallel code.

- fix up printing to print out data as comma-separated list:

    numThreads, numSamples, time_spent, accuracy


## Run your code, record results

Run several trials of your sequential and parallel versions to see what sizes of number of trials seem to have some strong scalability and which ones aren't quite as good. Your results should include both good strongly scalable problems sizes at certain numbers of threads, and some that don't do quite as well, so that you can provide a good analysis about what works and what doesn't.

You are provided with two shell scripts that will run your code in batches. Examine the scripts to see how they work. **You will want to change the problem sizes you choose to run.** Temporary problems sizes are given in the scripts. Work through how to get the results into a spreadsheet document like what you used for the activities.

OPTIONAL: Additionally, one of our past preceptors has written a script that will automatically upload your code's output to Google Sheets using the Google Drive API. You can find that in `upload_script/`. We didn't get around to documenting it with a README this semester, but if you want a challenge, give it a try with a test sheet using the directions in the comments.
