TARGET=exemploClase
EXPR_PARSE_SRC = expr_parser.cpp
EXPR_LEXER_SRC = expr_lexer.cpp
SRCFILES = $(EXPR_PARSE_SRC) $(EXPR_LEXER_SRC) ash.cpp main.cpp 
OBJ_FILE = ${SRCFILES:.cpp=.o}

.PHONY: clean 

$(TARGET): $(OBJ_FILE)
	g++ -o $@ $(OBJ_FILE)


$(EXPR_LEXER_SRC) : exemploClase.l
	flex -o $@ $^

$(EXPR_PARSE_SRC) : expr.y
	bison --defines=tokens.h -rall -o  $@ $< 

%.o: %.cpp 
	g++ -c -o $@ $<

run : $(TARGET)
	./$(TARGET) exemplo.txt 
clean:
	rm -f exemploClase.c
	rm -f $(TARGET)
	rm -f *.o
	rm -f $(EXPR_LEXER_SRC)
	rm -f $(EXPR_PARSE_SRC)
	
