all: main

main: main.o
	gcc -o main main.o $(shell pkgconf --cflags --libs raylib) -no-pie

main.o: main.s
	as -o main.o main.s

clean:
	rm -rf main.o main
