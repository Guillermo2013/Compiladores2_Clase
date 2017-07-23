#include <stdio.h>
#include "tokens.h"
int expr();
extern int token;
int yylex();

int main (){

while((token = yylex())!= TK_EOF){
 int r = expr();
 printf("resultado =  %d\n",r);
 }
}
