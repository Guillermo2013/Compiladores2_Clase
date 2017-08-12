%option noyywrap
%option yylineno
%x commentMultLine
%x include
%x includeM

%{
#include <stdio.h>
#include "tokens.h" 
#include "ash.h"
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
%}z<sd 
%%
[ \t]   { /*nada */} 
"//".*\n {return TK_EOL;}
"#"[ \t]*"include"[ \t]*\" { BEGIN(include);} 
"#"[ \t]*"include"[ \t]*< { BEGIN(includeM);} 
"/*" 	{ BEGIN(commentMultLine);}
"+"	{ return TK_Op_add;}
"-"	{ return TK_Op_sub;}
"*"	{ return TK_Op_mul;}
"/"	{ return TK_Op_div;}
"("	{ return TK_left_par;}
")"	{ return TK_rigth_par;}
"\n"	{ return TK_EOL;}
"="  	{ return TK_Asignacion;}
"if"    { return TK_IF;}
"else"  { return TK_Else;}
"print" { return TK_Print;}
"while"  { return TK_While;}
[0-9]+	{ yylval.int_t = atoi(yytext); return TK_NUMERO;}
\$[0-7] { yylval.int_t = yytext[1]-'0'; return TK_Val;}
[a-zA-Z_][a-zA-Z0-9_]* {  yylval.char_t = strdup(yytext); return TK_VarNombre; }
"=="    { return TK_Igual;}
"!="    { return TK_Distinto;}
"<"     { return TK_Menor;}
">"     { return TK_Mayor;}
"<="    { return TK_MenorIgual;}
">="    { return TK_MayorIgual;}
"{"     { return TK_left_llave;}
"}"     { return TK_rigth_llave;}



<INITIAL><<EOF>> { if(pop_file() != 0 ) yyterminate(); }

.	{ return TK_Error;}

<include>[^\"\n]+ { 
			{
				int c;
				int cerrado = 0;
				while((c = yyinput()) != '\n'){						
					if(c != 34 && c != 32){
					  fprintf(stderr,"line %d Error :include no more expression \n",yylineno);
					 yyterminate();		
					}
					cerrado = 1;				
				}
				if(cerrado == 0){ 
					 fprintf(stderr,"line %d Error :include without end \n",yylineno);
					 yyterminate();
				}
				yylineno++;
				if(push_file(yytext) != 0)
					yyterminate();	
			}
			BEGIN(INITIAL);
		  }
<includeM>[^>\n]+ { 
			{
				int c;
				int cerrado = 0;
				while((c = yyinput()) != '\n'){						
									
					if(c != 62 && c != 32){
					 fprintf(stderr,"line %d Error :include no more expression \n",yylineno);
					 yyterminate();		
					}		
					cerrado = 1;		
				}
				if(cerrado == 0){ 
					 fprintf(stderr,"line %d Error :include without end \n",yylineno);
					 yyterminate();
				}
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
	
	include_stack_t *is = (include_stack_t*)malloc(sizeof(include_stack_t));
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
