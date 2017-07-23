TARGET=exemploClase
C_SRCFILE = main.c expre_parser.c exemploClase.c
OBJ_FILE = ${C_SRCFILE:.c=.o}

.PHONY: clean 

$(TARGET): $(OBJ_FILE)
	gcc -o $@ $(OBJ_FILE)

exemploClase.c : exemploClase.l
	flex -o $@ $^

%.o: %.c tokens.h
	gcc -c -o $@ $<

run : $(TARGET)
	./$(TARGET) < exemplo.txt
clean:
	rm -f exemploClase.c
	rm -f exemploClase
