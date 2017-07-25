#include <stdio.h>
#include "tokens.h"
int expr();
int yylex();

int main (){

 yyparse();
/*while((token = yylex())!= TK_EOF){
 int r = expr();
 printf("resultado =  %d\n",r);
 }*/
}
