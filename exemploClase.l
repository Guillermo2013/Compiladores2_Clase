%option noyywrap
%{
#include <stdio.h>
#include "tokens.h"
%}
%%
[ \t]   { /*nada */} 
"+"	{ return TK_Op_add;}
"-"	{ return TK_Op_sub;}
"*"	{ return TK_Op_mul;}
"/"	{ return TK_Op_div;}
"("	{ return TK_left_par;}
")"	{ return TK_rigth_par;}
[0-9]+	{ return TK_NUMERO;}
"\n"  	{ return TK_EOL;}
.	{ return TK_Error;}

%%
	
