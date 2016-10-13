# edit this file to build/clean chello as required for quesiton 6
main: chello.c writeexit.s
	gcc -c chello.c -o chello.o
	as writeexit.s -o writeexit.o
	ld -N chello.o writeexit.o -o chello
chellomain: chello.c
		gcc -c chello.c -o chello.o
		ld -N chello.o writeexit.o -o chello
writeexitmain: writeexit.s
		as writeexit.s -o writeexit.o
		ld -N chello.o writeexit.o -o chello
clean:
	rm -rf *.o
