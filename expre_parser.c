#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"

int token;
int term();
int expr();
int factor();
int yylex();
extern char *yytext;

int expr(){
	
	int result = term();
	switch (token){
		case TK_Op_sub:
		case TK_Op_add : {
							while ((token == TK_Op_add)||(token == TK_Op_sub))
							{
								int op = token;
								token = yylex();
								if(op == TK_Op_add)
									result += term();
								else
									result -= term();
							}
						
						break;
	}
		
	default :
		break;
}
return result;
}

int term(){
	int result = factor();
	switch (token){
		case TK_Op_div : 
		case TK_Op_mul : {
							while ((token == TK_Op_mul)||(token == TK_Op_div))
							{
								int op = token;
								token = yylex();
								if(op == TK_Op_mul)
									result *= term();
								else
									result /= term();
							}
						
						break;
	}
		
	default :
		break;
}
return result;
}


int factor(){
	int result;
	switch (token){
		case TK_NUMERO:
			result = atoi(yytext);
			token = yylex();
			return result;
		case TK_left_par:
			token = yylex();
			result = expr();
			if ( token == TK_rigth_par)
				{
					token = yylex();
				}
			else{
				printf("Error expected ')'\n");
			}
			return result;
				
	
		default:
			printf("Error expected number or '(' \n" );
			return 0; 	
	}
}
