CC = gcc
AR = ar
STATIC_LOOP = basicClassification.o advancedClassificationLoop.o
STATIC_RECURSION = basicClassification.o advancedClassificationRecursion.o
DYNAMIC_LOOP = basicClassification.o advancedClassificationLoop.o
DYNAMIC_RECURSION = basicClassification.o advancedClassificationRecursion.o
FLAGS = -g -Wall
LM = -lm
HEADER = NumClass.h
MAIN = main.o

all: libclassloops.a libclassrec.a libclassloops.so libclassrec.so mains maindloop maindrec

#creat libraries
loops: libclassloops.a
libclassloops.a: $(STATIC_LOOP)
	$(AR) -rcs libclassloops.a $(STATIC_LOOP)
recursives: libclassrec.a
libclassrec.a: $(STATIC_RECURSION)
	$(AR) -rcs libclassrec.a $(STATIC_RECURSION)
loopd: libclassloops.so
libclassloops.so: $(DYNAMIC_LOOP)
	$(CC) -shared -o libclassloops.so $(DYNAMIC_LOOP)
recursived: libclassrec.so
libclassrec.so: $(DYNAMIC_RECURSION)
	$(CC) -shared -o libclassrec.so $(DYNAMIC_RECURSION)

basicClassification.o: basicClassification.c $(HEADER)
	$(CC) $(FLAGS) -c basicClassification.c
advancedClassificationLoop.o: advancedClassificationLoop.c $(HEADER)
	$(CC) $(FLAGS) -c advancedClassificationLoop.c
advancedClassificationRecursion.o: advancedClassificationRecursion.c $(HEADER)
	$(CC) $(FLAGS) -c advancedClassificationRecursion.c

#creat main
mains: $(MAIN) libclassrec.a
	$(CC) $(FLAGS) -o mains $(MAIN) libclassrec.a $(LM)
maindloop: $(MAIN) libclassloops.so
	$(CC) $(FLAGS) -o maindloop $(MAIN) ./libclassloops.so $(LM)
maindrec: $(MAIN) libclassrec.so
	$(CC) $(FLAGS) -o maindrec $(MAIN) ./libclassrec.so $(LM)

main.o: main.c $(HEADER)
	$(CC) $(FLAGS) -c main.c

.PHONY: clean all

clean:
	rm -f *.o *.a *.so mains maindloop maindrec