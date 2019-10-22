#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define DEFAULT_THROWS 500000
#define PI     3.1415926535

int main(int argc, char** argv) {
    long numSamples = DEFAULT_THROWS;
    long numInCircle = 0;       //number of throws in the unit circle
    double x, y;                //hold x,y position of each sample 'throw'

    // We will use these to time our code
    clock_t begin, end;
    double time_spent;

    // take in how many 'throws', or samples
    if (argc > 1) {
        numSamples = strtol(argv[1], NULL, 10);
    }

    // print "problem size" for debugging
    //printf("Number of throws: %ld\n", numSamples);

    // set seeds for the random number generator
    // for both an x and y position
    unsigned int seedx = (unsigned) time(NULL)+ 120975;
    unsigned int seedy = (unsigned) time(NULL)- 120975;
    srand(seedx);
    srand(seedy);


    begin = clock();  // start the timing
///////////  work being done that we will time
    for(int n=0; n<numSamples; n++) {
      // generate randome numbers between 0.0 and 1.0
      x = (double)rand_r(&seedx)/RAND_MAX;
      y = (double)rand_r(&seedy)/RAND_MAX;

      if ( (x*x + y*y) <= 1.0 ) {
        numInCircle++;
      }
    }

    double pi = 4.0 * (double)(numInCircle) / (numSamples);
// completion of work
    end = clock();  // end the timing
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;

    printf("Calculation of pi using %ld samples: %15.14lf\n", numSamples, pi);
    printf("Accuracy of pi calculation: %lf\n", pi - PI);
    printf("Time spent: %15.12lf seconds\n", time_spent);

}
