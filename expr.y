%{
#include <stdio.h>
int yylex();
void yyerror(char *msg){
printf(msg);
}
#define YYERROR_VERBOSE 1
%}


%token TK_Op_add TK_Op_sub TK_Op_mul TK_Op_div TK_left_par TK_rigth_par TK_NUMERO TK_EOL TK_Error TK_EOF TK_ERROR

%%

start : expr TK_EOL start
      | expr 
      |
     
;
	 

expr :  expr TK_Op_add term
      | expr TK_Op_sub term
      | term
;

term :  term TK_Op_mul factor
      | term TK_Op_div factor
      | factor
;

factor:  TK_NUMERO
       | TK_left_par expr TK_rigth_par
;

