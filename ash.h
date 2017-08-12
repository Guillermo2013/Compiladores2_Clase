#ifndef _ASI_H
#define _ASI_H
#include <list>
#include <map>
#include <iostream>
#include <stdio.h>	
using namespace std;



class Expr{
public:
 virtual int eval() = 0;
};

class BinaryExpr:public Expr{
 protected:
	BinaryExpr(Expr *expr1,Expr *expr2){
		this->expr1 = expr1;
		this->expr2 = expr2;	
	}
 public:
	Expr *expr1,*expr2;
 	
};
#define DEFINE_BINARY_EXPR(name) \
	class name##Expr : public BinaryExpr { \
	public : \
		name##Expr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){} \
		int eval(); \
}

DEFINE_BINARY_EXPR(Add);
DEFINE_BINARY_EXPR(Sub);
DEFINE_BINARY_EXPR(Mult);
DEFINE_BINARY_EXPR(Div);
DEFINE_BINARY_EXPR(Igual);
DEFINE_BINARY_EXPR(Distinto);
DEFINE_BINARY_EXPR(Mayor);
DEFINE_BINARY_EXPR(Menor);
DEFINE_BINARY_EXPR(MayorIgual);
DEFINE_BINARY_EXPR(MenorIgual);

class NumberExpr:public Expr{
 public:
	NumberExpr(int value){
		this->value = value;	
	}	
	int value;
	int eval(){ return value;}
};
class VarExpr:public Expr{
 public:
	int index;
	int eval();
	VarExpr(int index){
		this->index = index;	
	}	
	
};
class VarNombreExpr:public Expr{
 public:
	char *index;
	int eval();
	VarNombreExpr(char * index){
		this->index = index;	
	}	
	
};
class Statement{
 public: 
	virtual void exec() = 0;

	
};

class AssignStatement : public Statement{
	public:
		int index = -1;
                char * nombre;
		Expr *expr;
		AssignStatement(int index, Expr * expr){
			this->index = index;
			this->expr = expr;
		}
		AssignStatement(char * nombre, Expr * expr){
			this->nombre = nombre;
			this->expr = expr;
                      
		}
		void exec();
		
};
class PrintStatement : public Statement{
	public: 
		Expr *expr;
		PrintStatement(Expr *expr){
			this->expr = expr;
		}

		void exec();
};
class If_Statement : public Statement{
	public: 
		Expr *expr;
		Statement *ifStatement;
		Statement *elseStatement;
		If_Statement(Expr *expr,Statement *ifStatement,Statement *elseStatement){
			this->expr = expr;
			this->ifStatement = ifStatement;
			this->elseStatement = elseStatement;
		}

		void exec();
};
class While_Statement : public Statement{
	public: 
		Expr *expr;
		Statement *whileStatement;
		
		While_Statement(Expr *expr,Statement *whileStatement){
			this->expr = expr;
			this->whileStatement = whileStatement;
			
		}

		void exec();
};
class BlockStatement : public Statement
{
 public :
	BlockStatement(){};
	void addStatement(Statement *statement){
	 listStatement.push_back(statement);
	}
	list<Statement*> listStatement;
	void exec();
};
#endif 
