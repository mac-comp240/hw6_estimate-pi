CC=gcc
FLAGS=-std=gnu99

all: monteCarloPi_Seq  #monteCarloPi_omp

monteCarloPi_Seq: monteCarloPi_Seq.c
	${CC} ${FLAGS} -o monteCarloPi_Seq monteCarloPi_Seq.c

monteCarloPi_omp: monteCarloPi_omp.c
	${CC} ${FLAGS} -o monteCarloPi_omp monteCarloPi_omp.c -fopenmp
  
clean:
	rm -rf monteCarloPi_Seq monteCarloPi_omp
