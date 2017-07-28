%option noyywrap
%option yylineno
%x commentMultLine
%x include
%{
#include <stdio.h>
#include "tokens.h"

typedef struct include_stack{
 struct include_stack *prev;
 FILE *f;
 int lineno;
 char *filename;
 YY_BUFFER_STATE bs;
} include_stack_t;

include_stack_t *inc_stack = NULL;
char *yyfilename;
int pop_file();
int push_file(char *filename);
%}
%%
[ \t]   { /*nada */} 
"//".*\n { return TK_EOL;}
^"#"[ \t]*"include"[ \t]*\" { BEGIN(include);} 
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
<INITIAL><<EOF>> { if(pop_file() != 0 ) yyterminate(); }
.	{ return TK_Error;}

<include>[^\"\n]+ { 
			{
				int c;
				while((c = input()) != 0 && c != '\n');
				yylineno++;
				if(push_file(yytext) != 0)
					yyterminate();	
			}
			BEGIN(INITIAL);
		  }

<commentMultLine>"*/" { BEGIN(INITIAL);}
<commentMultLine>.|\n { /*nada */ }
<commentMultLine><<EOF>> { printf("line: %d Block comment without end \n",yylineno); return 0;}
%%
int push_file (char *filename ){
	FILE *f  = fopen(filename,"r");
       if(f == NULL){
		fprintf(stderr,"file %s no found",filename);
		return 1;
	}
	
	include_stack_t *is = malloc(sizeof(include_stack_t));
	if(is == NULL){
		fprintf(stderr,"out memory");
		return 1;
	}
	is->f = f;
	is->lineno = yylineno;
        is->filename = yyfilename; 
        is->bs = yy_create_buffer(f,YY_BUF_SIZE);
        is->prev = inc_stack;
        inc_stack = is;
        yyfilename = filename;
        yylineno = 1;
        yy_switch_to_buffer(is->bs);
	return 0;
}
int pop_file(){
        include_stack_t * prev_is = inc_stack->prev;
	fclose(inc_stack->f);
	yy_delete_buffer(inc_stack->bs);
	yylineno = inc_stack->lineno;
	yyfilename = inc_stack->filename;
	free(inc_stack);
	if(prev_is == NULL) return 1;
        yy_switch_to_buffer(prev_is->bs);
	inc_stack = prev_is;
	return 0;
}
