#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <random>        // newer C++ library with better ways 
                         // of generating random numbers of variaous types
#include <omp.h>         // use omp version of timing functions

#define DEFAULT_THROWS 500000
#define PI     3.1415926535

int main(int argc, char** argv) {
    long numSamples = DEFAULT_THROWS;
    long numInCircle = 0;       //number of throws in the unit circle
    double x, y;                //hold x,y position of each sample 'throw'

    // We will use these to time our code
    double begin, end;
    double time_spent;

    // take in how many 'throws', or samples
    if (argc > 1) {
        numSamples = strtol(argv[1], NULL, 10);
    }

    // print "problem size" for debugging
    //printf("Number of throws: %ld\n", numSamples);

    begin = omp_get_wtime();  // start the timing

    // set seeds for the random number generator
    // for both an x and y position
    // Note: two seeds needed because we have to get a random
    //       x, y position
    std::random_device rd; 
    unsigned long seedx = rd();
    // unsigned long seedy = rd();
    
    // create two generators and seed each one
    std::mt19937_64 generator;   //declaration of a generator
    generator.seed(seedx);
    
    // declare a distribution of real numbers that we want
    std::uniform_real_distribution<double> distributionX(0.0,1.0);
    std::uniform_real_distribution<double> distributionY(0.0,1.0);
    
    for(int n=0; n<numSamples; n++) {
      // generate random numbers between 0.0 and 1.0
      x = distributionX(generator);
      y = distributionY(generator);;

      if ( (x*x + y*y) <= 1.0 ) {
        numInCircle++;
      }
    }

    double pi = 4.0 * (double)(numInCircle) / (numSamples);

// completion of work
    end = omp_get_wtime();  // end the timing
    time_spent = end - begin;

    printf("Calculation of pi using %ld samples: %15.14lf\n", numSamples, pi);
    printf("Accuracy of pi calculation: %lf\n", pi - PI);
    printf("Time spent: %15.12lf seconds\n", time_spent);

}
