#ifndef _ASI_H
#define _ASI_H
#include <list>
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
class AddExpr:public BinaryExpr{
 public:
 	AddExpr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){}
 	int eval();
};
class SubExpr:public BinaryExpr{
 public:
 	SubExpr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){}
	int eval();
};
class MultExpr:public BinaryExpr{
 public:
 	MultExpr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){}
	int eval();
};
class DivExpr:public BinaryExpr{
 public:
 	DivExpr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){}
	int eval();
};
class IgualExpr:public BinaryExpr{
 public:
 	IgualExpr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){}
	int eval();
};
class DistintoExpr:public BinaryExpr{
 public:
 	DistintoExpr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){}
	int eval();
};
class MayorExpr:public BinaryExpr{
 public:
 	MayorExpr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){}
	int eval();
};
class MenorExpr:public BinaryExpr{
 public:
 	MenorExpr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){}
	int eval();
};
class MayorIgualExpr:public BinaryExpr{
 public:
 	MayorIgualExpr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){}
	int eval();
};
class MenorIgualExpr:public BinaryExpr{
 public:
 	MenorIgualExpr(Expr *expr1,Expr *expr2):BinaryExpr(expr1,expr2){}
	int eval();
};
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
class Statement{
 public: 
	virtual void exec() = 0;

	
};

class AssignStatement : public Statement{
	public:
		int index;
		Expr * expr;
		AssignStatement(int index, Expr * expr){
			this->index= index;
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
