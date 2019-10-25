CC=gcc

all: monteCarloPi_Seq  #monteCarloPi_omp

monteCarloPi_Seq: monteCarloPi_Seq.c seq_time.h
	${CC} -o monteCarloPi_Seq monteCarloPi_Seq.c

monteCarloPi_omp: monteCarloPi_omp.c
	${CC} -o monteCarloPi_omp monteCarloPi_omp.c -fopenmp

clean:
	rm -f monteCarloPi_Seq monteCarloPi_omp
	
