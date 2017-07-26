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

start : start TK_EOL expr { printf("%d\n",$3);}
      | expr { printf("%d\n",$1);}
      |     
;
	 

expr :  expr TK_Op_add term { $$ = $1 + $3;}
      | expr TK_Op_sub term { $$ = $1 - $3;}
      | term { $$ = $1;}
;

term :  term TK_Op_mul factor { $$ = $1 * $3;}
      | term TK_Op_div factor { $$ = $1 / $3;}
      | factor { $$ = $1;}
;

factor:  TK_NUMERO { $$ = $1;}
       | TK_left_par expr TK_rigth_par { $$ = $2;}
;

