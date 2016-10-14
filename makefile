
#edit this file to build/clean chello as required for quesiton 6
all: chello

chello: chello.o writeexit.o
	ld -N chello.o writeexit.o -o chello
chello.o: chello.c
	gcc chello.c -c chello.o
writeexit.o: writeexit.s
	as writeexit.s -o writeeixt.o
clean:
	rm -rf *.o chello
.PHONY: all clean


