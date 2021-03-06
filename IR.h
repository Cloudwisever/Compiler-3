#ifndef _IR_H
#define _IR_H

#include<stdio.h>
#include<stdlib.h>
#include<memory.h>
#include <string.h>
#include "syntax_tree.h"
#include "symbol_table.h"

#define TEMP_SIZE 1000


typedef struct Operand_* Operand;
struct Operand_
{
	enum { VARI, FUNCNAMES, CONSTANT, ADDRESS, TEMP, TEMPADDRESS, RELATOP } kind;
	union
	{
		int value;
		char* var_name;
		int temp_no;
		enum{LEQ, L, GEQ, G, EQ, NEQ} rel;
		struct {char* name; int no;} var_idfr;
	}u;
};
typedef struct Operands_* Operands;
struct Operands_
{
	Operand op;
	Operands next;
};

typedef struct InterCode_* InterCode;
struct InterCode_
{
	enum {ASSIGN, STAR_ASSIGN_STAR, STAR_ASSIGN_, _ASSIGN_AND, _ASSIGN_STAR, ADD, ADDR_ADD_VAR, SUB, MUL, DIVIDE, LABEL, IFGOTO, GOTO, READ, WRITE, CALL, ARG, RET, FUNCDEC, PARAM, DEC} kind;
	union
	{
		struct { Operand left, right; }assign;
		struct { Operand result, op1, op2; }binop;
		struct { int label_no;}label;
		struct { Operand rel, op1, op2; int dest_label;}condjmp;
		struct { int dest_label;}jmp;
		struct { Operand op;}single;
		struct { Operand var; int size;}dec;
	}u;
};
typedef struct InterCodes_* InterCodes;
struct InterCodes_ { struct InterCode_ code; struct InterCodes_ *prev, *next; };

Operand getConstant(int num);
Operand getRelop(char* relop);
Operand new_temp();
struct InterCode_ new_label();

InterCodes addIR(struct InterCode_ ir, struct InterCodes_* head, struct InterCodes_* tail);
InterCodes addIRhead(struct InterCode_ ir, InterCodes head);
InterCodes findIRtail(InterCodes head);
InterCodes IRaddIR(InterCodes code1, InterCodes code2);

InterCodes translate_Program(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_ExtDefList(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_ExtDef(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_FunDec(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_VarList(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_ParamDec(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_VarDec(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_CompSt(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_DefList(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_Def(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_DecList(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_Dec(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_Stmt(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_StmtList(Syntax_Leaf* root, HashItem* sym_table);
InterCodes translate_Cond(Syntax_Leaf* root, struct InterCode_ label_true, struct InterCode_ label_false, HashItem* sym_table);
InterCodes translate_Args(Syntax_Leaf* root, HashItem* sym_table, Operands* arg_list);
InterCodes translate_Exp(Syntax_Leaf* root, HashItem* sym_table, Operand place);

void addDummy();
void OperandPrint(FILE* stream, Operand op);
void IRPrint(FILE* stream, InterCodes irtable);
void IRtablePrint(FILE* stream, InterCodes irtable);


#endif
