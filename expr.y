%{
#include <stdio.h>
int yylex();
extern int yylineno;
void yyerror(char *msg){
printf("Line %d : %s \n",yylineno,msg);
}
int valores[8];
	
#define YYERROR_VERBOSE 1
%}


%token TK_Op_add TK_Op_sub TK_Op_mul TK_Op_div TK_left_par TK_rigth_par TK_NUMERO TK_EOL TK_Error TK_EOF TK_ERROR TK_Asignacion
%token TK_Print TK_Dolar

%%

start : start TK_EOL Asignacion 
      | start TK_EOL Print
      | start TK_EOL
      | Asignacion
      |	Print
      | 
     		      
           
;

Print : TK_Print expr { printf("%d\n", $2);}
;

Asignacion : TK_Dolar TK_NUMERO TK_Asignacion expr{ if($2>7) yyerror(" Error Asignacion el numero tiene que se menor que 7"); 
else valores[$2] = $4; } 
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
       | TK_Dolar TK_NUMERO { if($2>7) yyerror(" Error Asignacion el numero tiene que se menor que 7");else $$ =  valores[$2] ;}
;

