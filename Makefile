CC=gcc
CPP=g++
FLAGS=-std=gnu99

all: monteCarloPi_Seq #monteCarloPi_omp #monteCarloPi_Seq_old  


monteCarloPi_Seq: monteCarloPi_Seq.cpp
	${CPP} -o monteCarloPi_Seq monteCarloPi_Seq.cpp -fopenmp

monteCarloPi_omp: monteCarloPi_omp.cpp
	${CPP} -o monteCarloPi_omp monteCarloPi_omp.cpp -fopenmp

monteCarloPi_Seq_old: monteCarloPi_Seq.c
	${CC} ${FLAGS} -o monteCarloPi_Seq_old monteCarloPi_Seq.c

clean:
	rm -rf monteCarloPi_Seq monteCarloPi_omp monteCarloPi_Seq_old
