%option noyywrap
%option yylineno
%x commentMultLine
%{
#include <stdio.h>
#include "tokens.h"

%}
%%
[ \t]   { /*nada */} 
"//".*\n { return TK_EOL;}
"/*" 	{ BEGIN(commentMultLine);}
"+"	{ return TK_Op_add;}
"-"	{ return TK_Op_sub;}
"*"	{ return TK_Op_mul;}
"/"	{ return TK_Op_div;}
"("	{ return TK_left_par;}
")"	{ return TK_rigth_par;}
[0-9]+	{ yylval = atoi(yytext); return TK_NUMERO;}
"$"	{ return TK_Dolar;}
"="  	{ return TK_Asignacion;}
"print" { return TK_Print;}	
"\n"  	{ return TK_EOL;}
.	{ return TK_Error;}

<commentMultLine>"*/" { BEGIN(INITIAL);}
<commentMultLine>.|\n { /*nada */ }
<commentMultLine><<EOF>> { printf("line: %d Block comment without end \n",yylineno); return 0;}
%%
	
