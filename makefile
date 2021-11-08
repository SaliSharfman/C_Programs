CC = gcc
AR = ar
OBJECTS_MAIN = main.o 

OBJECTS_LOOPS= basicClassification.o advancedClassificationLoop.o
OBJECTS_REC= basicClassification.o advancedClassificationRecursion.o
HEADER = NumClass.h

FLAGS= -g -Wall 
basicClassifigication.o: basicClassification.c $(HEADER)
	$(CC) $(FLAGS) -c basicClassification.c
advancedClassificationLoop.o: advancedClassificationLoop.c $(HEADER)
	$(CC) $(FLAGS) -c advancedClassificationLoop.c
advancedClassificationRecursion.o: advancedClassificationRecursion.c $(HEADER)
	$(CC) $(FLAGS) -c advancedClassificationRecursion.c
main.o: main.c $(HEADER)
	$(CC) $(FLAGS) -c main.c
	
all: libclassloops.a libclassloops.so libclassrec.a libclassrec.so mains maindloop maindrec
loops: libclassloops.a 
loopd: libclassloops.so
recursives: libclassrec.a
recursived: libclassrec.so

libclassloops.a: $(OBJECTS_LOOPS)
	$(AR) -rcs libclassloops.a $(OBJECTS_LOOPS)
libclassloops.so: $(OBJECTS_LOOPS)
	$(CC) -shared -o libclassloops.so $(OBJECTS_LOOPS) 
libclassrec.a: $(OBJECTS_REC)
	$(AR) -rcs libclassrec.a $(OBJECTS_REC)
libclassrec.so: $(OBJECTS_REC)
	$(CC) -shared -o libclassrec.so $(OBJECTS_REC) 

mains: $(OBJECTS_MAIN) libclassrec.a
	$(CC) $(FLAGS) -o mains $(OBJECTS_MAIN) libclassrec.a -lm
maindloop: $(OBJECTS_MAIN) libclassloops.so
	$(CC) $(FLAGS) -o maindloop $(OBJECTS_MAIN) ./libclassloops.so -lm
maindrec: $(OBJECTS_MAIN) libclassrec.so
	$(CC) $(FLAGS) -o maindrec $(OBJECTS_MAIN) ./libclassrec.so -lm

.PHONY: clean all 

clean: 
	rm -f *.o *.a *.so mains maindloop maindrec