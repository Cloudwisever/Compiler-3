#ifndef _OC_H
#define _OC_H

#include<stdio.h>
#include<stdlib.h>
#include<memory.h>
#include <string.h>
#include "syntax_tree.h"
#include "symbol_table.h"
#include "IR.h"

char* reglist[32];

struct BB_
{
	InterCodes* code;
	int length;
	int* leader;
	int leader_length;
};

typedef struct OperandsInBlock_* OperandsInBlock ;
struct OperandsInBlock_
{
	Operand op;
	int reg;
	int remcnt;
	int pos;
	struct OperandsInBlock_* next;
};

//int reg_status[32];
int curfpoff;
extern FILE* global_stream;
OperandsInBlock position_list;

void GenerateObjectCode(InterCodes ircodes);
struct BB_ GenerateBasicBlock(InterCodes head);

OperandsInBlock findOP(OperandsInBlock list, Operand op);
OperandsInBlock OIBlistCreate(InterCodes* codes, int start, int end);
OperandsInBlock addOIBlist(OperandsInBlock tail,  Operand op);
int allocate(Operand op,OperandsInBlock list, int* reg_status);
int ensure(Operand op, OperandsInBlock list, int*reg_status);
void SelectOC(InterCodes* codes, int start, int end);

#endif
