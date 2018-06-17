#ifndef _OC_H
#define _OC_H

#include<stdio.h>
#include<stdlib.h>
#include<memory.h>
#include <string.h>
#include "syntax_tree.h"
#include "symbol_table.h"
#include "IR.h"

char* reglist[] = {"r0", "at", "v0", "v1", "a0", "a1","a2","a3", "t0","t1","t2","t3","t4","t5","t6","t7", "s0","s1","s2","s3","s4","s5","s6","s7","t8", "t9", "k0", "k1", "gp", "sp", "fp", "ra"};

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

void GenerateObjectCode(InterCodes ircodes);
struct BB_ GenerateBasicBlock(InterCodes head);

OperandsInBlock findOP(OperandsInBlock list, Operand op);
OperandsInBlock OIBlistCreate(InterCodes* codes, int start, int end);
OperandsInBlock addOIBlist(OperandsInBlock tail,  Operand op);
int allocate(OperandsInBlock list, int* reg_status);
int ensure(Operand op, OperandsInBlock list, int*reg_status, InterCodes* codes, int start, int end);

#endif
