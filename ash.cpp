#include "ash.h"
#include <iostream>
using namespace std;
int vars[8];

int AddExpr::eval(){
  int v1 = expr1->eval();
  int v2 = expr2->eval();
  return v1 + v2;	
}

int SubExpr::eval(){
  int v1 = expr1->eval();
  int v2 = expr2->eval();
  return v1 - v2;	
}

int MultExpr::eval(){
  int v1 = expr1->eval();
  int v2 = expr2->eval();
  return v1 * v2;	
}

int DivExpr::eval(){
  int v1 = expr1->eval();
  int v2 = expr2->eval();
  return v1 / v2;	
}
int IgualExpr::eval(){
  int v1 = expr1->eval();
  int v2 = expr2->eval();
  return v1 == v2;	
}
int DistintoExpr::eval(){
  int v1 = expr1->eval();
  int v2 = expr2->eval();
  return v1 != v2;	
}
int MayorExpr::eval(){
  int v1 = expr1->eval();
  int v2 = expr2->eval();
  return v1 > v2;	
}
int MenorExpr::eval(){
  int v1 = expr1->eval();
  int v2 = expr2->eval();
  return v1 < v2;	
}
int MayorIgualExpr::eval(){
  int v1 = expr1->eval();
  int v2 = expr2->eval();
  return v1 >= v2;	
}
int MenorIgualExpr::eval(){
  int v1 = expr1->eval();
  int v2 = expr2->eval();
  return v1 <= v2;	
}

int VarExpr::eval(){
  return vars[index];	
}

void AssignStatement:: exec(){
  int v1 = expr->eval();
  vars[index] = v1;	
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
