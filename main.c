#include <stdio.h>
#include "tokens.h"
int expr();
int yylex();
extern FILE *yyin;

int main (int argc , char * argv[]){
 if(argc != 2){
	fprintf(stderr,"USAGE : %s <input file>\n",argv[0]);	
	return 1;
 }
 
 yyin = fopen (argv[1],"r");
 if(yyin == NULL){
 	fprintf(stderr,"Cannot open file: %s \n",argv[0]);	
	return 1;
 }	
 
 yyparse();
 fclose(yyin);
/*while((token = yylex())!= TK_EOF){
 int r = expr();
 printf("resultado =  %d\n",r);
 }*/
}
