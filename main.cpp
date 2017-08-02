#include <stdio.h>
#include "tokens.h"

 int expr();
 int yylex();
extern FILE *yyin;
 int push_file(char *filename);

int main (int argc , char * argv[]){
 
 if(argc != 2){
	fprintf(stderr,"USAGE : %s <input file>\n",argv[0]);	
	return 1;
 }
 if(push_file(argv[1]) != 0){
	return 1;
 }
 	
 
 yyparse();


}
