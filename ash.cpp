#include "ash.h"

#include <stdio.h>
#include <cstring>

#include <stdlib.h>
int vars[8];

map< char *, int > variablesNombres;

typedef pair<char *, int> elemento;

#define IMPLEMENT_BINARY_EXPR_EVAL(name,opr) \
	int name##Expr::eval(){ \
	int v1 = expr1->eval(); \
	int v2 = expr2->eval(); \
	return v1 opr v2; \
}

	
IMPLEMENT_BINARY_EXPR_EVAL(Add,+);
IMPLEMENT_BINARY_EXPR_EVAL(Sub,-);
IMPLEMENT_BINARY_EXPR_EVAL(Mult,*);
IMPLEMENT_BINARY_EXPR_EVAL(Div,/);
IMPLEMENT_BINARY_EXPR_EVAL(Igual,==);
IMPLEMENT_BINARY_EXPR_EVAL(Distinto,!=);
IMPLEMENT_BINARY_EXPR_EVAL(Mayor,>);
IMPLEMENT_BINARY_EXPR_EVAL(Menor,<);
IMPLEMENT_BINARY_EXPR_EVAL(MayorIgual,>=);
IMPLEMENT_BINARY_EXPR_EVAL(MenorIgual,<=);




int VarNombreExpr::eval(){
map<char *, int>::iterator p = variablesNombres.begin();
  while (p != variablesNombres.end() )
  {
    if(strcmp(p->first,index) == 0)
      return p->second;
   
    p ++;
    
  }
 cout<<"Error : Variable not exit "<<endl;
 exit (1);
  
}
int VarExpr::eval(){
  return vars[index];	
}
void AssignStatement:: exec(){
  int v1 = expr->eval();
  if(index != -1)
   vars[index] = v1;
   else if(index == -1){
	int existe = 0;
      map<char *, int>::iterator p = variablesNombres.begin();
	  while (p != variablesNombres.end() )
	  {
	    if(strcmp(p->first,nombre) == 0){
	       p->second = v1;
	  	existe = 1;  
	   }
	    p ++;
	    
	  }
	if(existe == 0) 
    variablesNombres.insert(elemento(nombre,v1));
   
	
       
 }
  
}

void PrintStatement:: exec(){
  int v1 = expr->eval();
  cout << v1 << "\n";
}
void If_Statement::exec(){
 int v1 = expr->eval();

 if(v1 == 1)
   ifStatement->exec();
 else
   elseStatement->exec();
}
	void While_Statement::exec(){


 while( expr->eval()  == 1)
   whileStatement->exec();
 
}

void BlockStatement::exec(){
  if(!listStatement.empty())
  {
    list<Statement*>::iterator pos;
    pos = listStatement.begin();
    while(pos != listStatement.end())
    {
      (*pos)->exec();
      pos++;
    }
  }	
}
