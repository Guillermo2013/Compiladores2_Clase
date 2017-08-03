%code requires {
 #include "ash.h"
}
%{
#include <stdio.h>


#define SZ 32

int yylex();
extern int yylineno;
extern char *yyfilename;
void yyerror(const char *msg){
printf("Line %d : %s  file: %s \n",yylineno,msg,yyfilename);
}


	
#define YYERROR_VERBOSE 1
%}

%union {
  Statement *statement_t;
  Expr *expr_t; 
  int int_t;
}

%token TK_Op_add TK_Op_sub TK_Op_mul TK_Op_div TK_left_par TK_rigth_par TK_EOL TK_Error TK_EOF TK_ERROR TK_Asignacion TK_Dolar 
%token TK_NUMERO TK_Print TK_Separador TK_Val TK_Igual TK_Distinto TK_Menor TK_Mayor TK_MenorIgual TK_MayorIgual TK_IF TK_Else 
%token TK_left_llave TK_rigth_llave

%type <int_t> TK_NUMERO TK_Val
%type <statement_t> statement assign_statement print_statement if_statement statementList Opt_Else BlockStatementOrStatement
%type <expr_t> expr term factor add

%%

inputs : opt_eols statementList opt_eols {  $2->exec();}
;

statementList:statementList  eols statement  {$$ = $1; ((BlockStatement*)$$)->addStatement($3);}
	     |statement { $$ = new BlockStatement(); ((BlockStatement*)$$)->addStatement($1);}
	      	
;
eols:eols TK_EOL
     |
;
opt_eols: opt_eols TK_EOL
     	| 
;
statement : assign_statement { $$ = $1; }
	  | print_statement  { $$ = $1; } 
	  | if_statement { $$ = $1; }    
;
if_statement : TK_IF TK_left_par expr TK_rigth_par opt_eols BlockStatementOrStatement Opt_Else { $$ = new If_Statement($3,$6,$7);}

; 

Opt_Else:TK_Else opt_eols BlockStatementOrStatement { $$ = $3;}
	| { $$ = new BlockStatement(); }

;
BlockStatementOrStatement: statement opt_eols { $$ = new BlockStatement(); ((BlockStatement*)$$)->addStatement($1);}
			 |TK_left_llave statementList TK_rigth_llave { $$ = $2;}	
;
print_statement : TK_Print expr { $$ = new PrintStatement($2);}

;

assign_statement : TK_Val TK_Asignacion expr{  $$  = new AssignStatement($1,$3); } 
;

expr: add TK_Igual add {$$ = new IgualExpr($1,$3);}
     |add TK_Distinto add {$$ = new DistintoExpr($1,$3);}
     |add TK_Menor add {$$ = new MenorExpr($1,$3);}
     |add TK_Mayor add {$$ = new MayorExpr($1,$3);}
     |add TK_MenorIgual add {$$ = new MenorIgualExpr($1,$3);}
     |add TK_MayorIgual add {$$ = new MayorIgualExpr($1,$3);}
     |add {$$ = $1;}
;
add :  add TK_Op_add term { $$ = new AddExpr($1,$3);}
      | add TK_Op_sub term { $$ = new SubExpr($1,$3);}
      | term { $$ = $1;}
;

term :  term TK_Op_mul factor { $$ = new MultExpr($1,$3);}
      | term TK_Op_div factor { $$ = new DivExpr($1,$3);}
      | factor { $$ = $1;}
;
	
factor:  TK_NUMERO { $$ = new NumberExpr($1);}
       | TK_left_par expr TK_rigth_par { $$ = $2;}
       | TK_Val {  $$ = new VarExpr($1);}
;

