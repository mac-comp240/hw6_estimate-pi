# Estimating Pi using the Monte Carlo Method

In this assignment, you will write a parallel program that estimates the value of pi using the monte carlo method. You will run your program many times on different input values in order to examine two parallel programming concepts: **speedup** and **efficiency**.  You will also analyze the strong and weak scalability of your solution.

For this assignment, you will be working in pairs and turning in a written report. You can choose to work individually also.

## Report Criteria

You can write your report in the shared Google Drive folder that you instructor sets up for you. Having the report as a Google doc in that directory constitutes turning it in. You should keep your original data spreadsheet there also.

Your written report should have the following content:

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
pi) for each problem size (read on to see how far you can go). Try more than one execution of the code, because you will notice that the accuracy can vary. (You will never get really good accuracy, but you should see it improve with increase in problem size, and you should see it be poor and very a lot at very small problem sizes, because you are covering less of the 'unit circle' with 'throws' or 'trials'.)

**IMPORTANT:** Please note that just like the older C  `rand_r` function, even the C++ distribution classes can only create a certain number of random numbers. On our server using g++, the std::uniform_real_distribution<double> class can create MAX_INT different real numbers. Therefore, highest number of 'throws' or 'trials' of x,y values you can use is 2147483647.

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
- Remember also from the random number activity that when generating more than one random number in a loop, you should use one C++ generator variable (including seeding it) and two different distribution variables that use that same generator.
- Use  `omp_get wtime()` for timing
- add pragmas for OpenMP. Note that you will need to worry about what shared variables need to be reduced. You can again use rand_demo.cpp as a guide for the pragmas.

### Test by hand with printing as it exists

Then you will want to make sure the code is correct and also spend some more
time determining what problem sizes as powers of 2 give how many digits of
accuracy for pi. Make sure the results for accuracy of the parallel version match the sequential results. If they don't, there is something wrong with your parallel code.

## Run your code, record results

Run several trials of your sequential and parallel versions to see what sizes of number of trials seem to have some strong scalability and which ones aren't quite as good. Your results should include both good strongly scalable problems sizes at certain numbers of threads, and some that don't do quite as well, so that you can provide a good analysis about what works and what doesn't.

### Change printing so scripts work well

- Before running your formal tests, you should fix up printing to print out data as comma-separated (or tab-separated) list:

    numThreads, numSamples, time_spent, accuracy

You can  omit the accuracy eventually, but it helps to keep it while you run trials of the scripts just to be certain that you have a sense of which problem sizes give you proper accuracy (lower problem sizes may not).

You are provided with two shell scripts that will run your code in batches. Examine the scripts to see how they work. **You will want to change the problem sizes you choose to run.** Temporary problems sizes are given in the scripts. Experiment with a range of problem sizes (different for each of the scripts) and run the script with just a few trials (2-3) to get a sense of the accuracy and the scalability. (Ask you instructor if you are struggling with this.)

Only after you are satisfied that you have picked good problem sizes should you work through how to get the results into a spreadsheet document like what you used for the activities. At this point you might want to remove the printing of the accuracy values and just have time_spent followed by a tab, like was done for the activity:

    time_spent\t

Try out the shell scripts with one or two experiments, perhaps with just a few problem sizes, to be sure they are printing correctly. Then fill out all the problem sizes to run your complete tests.

### Choose good problem sizes

Update `run_strong_tests.sh` to run a range of problem sizes that are powers of 2. Use a lower value that gives you reasonable accuracy, and go up to the highest value possible, 2147483647, which is one less than a power of 2. This may be a large number of problem sizes for one speedup graph, so you will want to choose to run fewer or display fewer of the problem sizes on your final graph in your report.

For the weak tests script, your goal is to choose a starting problem size such that you get a good range of sizes (the script does not have to be changed). You want to have your third 'line' in the weak scalability graph to end up at a power of two **near, but not including** the maximum number of trials you can do (2147483647). Beware of starting at a problem size that is too low- testing for weak scalability often makes more sense in cases where there is some amount of strong scalability.

### Run your scripts in 'the background'

Please watch this [video that demonstrates a convenient that way you can run scripts like this](https://www.screencast.com/t/S78iUMzrO) that will take some time on linux. You will see how to indicate that your script should run on the machine, but give you a command line prompt back, enabling you to let it run while you go away and do other things.

#### For a challenge

OPTIONAL: Additionally, one of our past preceptors has written a script that will automatically upload your code's output to Google Sheets using the Google Drive API. You can find that in `upload_script/`. We didn't get around to documenting it with a README this semester, but if you want a challenge, give it a try with a test sheet using the directions in the comments.
