#include "objectcode.h"

struct BB_ GenerateBasicBlock(InterCodes head)
{
	InterCodes cur = head;
	int count = 0;
	int headcount = 0;
	while(cur != NULL)
	{
		if(cur == head || cur->code.kind == IFGOTO || cur->code.kind == GOTO || cur->code.kind == FUNCDEC || cur->code.kind == LABEL)
		{
			headcount ++;
		}
		cur = cur->next;
		count ++;
	}
	InterCodes* codept = (InterCodes*)malloc(count*sizeof(struct InterCodes_));
	int* headpt = (int*)malloc(headcount*sizeof(int));
	
	printf("count: %i, headcont: %i\n", count, headcount);
	
	cur = head;
	count = 0;
	headcount = 0;
	while(cur != NULL)
	{
		if(cur == head || cur->prev->code.kind == IFGOTO || cur->prev->code.kind == GOTO || cur->code.kind == FUNCDEC || cur->code.kind == LABEL)
		{
			headpt[headcount++] = count;
		}
		codept[count ++] = cur;
		cur = cur->next;
	}
	struct BB_ ret;
	ret.code = codept;
	ret.leader = headpt;
	ret.length = count;
	ret.leader_length = headcount;
	return ret;
}

void GenerateObjectCode(InterCodes ircodes)
{
	struct BB_ blocks = GenerateBasicBlock(ircodes);
	
	int i = 0;
	int hdi = 0;
	for( ; i < blocks.length; i++)
	{
		if(i == blocks.leader[hdi])
		{
			printf("\nbegin of a block\n");
			hdi++;
		}
		printf("%i: ", i);
		//if(blocks.code[i]->prev == NULL)
		//	printf("this is the code without prev:\n");
		IRPrint(stdout, blocks.code[i]);
		
	}
}
OperandsInBlock addOIBlist(OperandsInBlock tail,  Operand op)
{
	OperandsInBlock newone = (OperandsInBlock)malloc(sizeof(struct OperandsInBlock_));
	memset(newone, 0, sizeof(struct OperandsInBlock_));
	newone->op = op;
	newone->remcnt = 1;
	tail->next = newone;
	return newone;
}

OperandsInBlock OIBlistCreate(InterCodes* codes, int start, int end)
{
	int i;
	OperandsInBlock head = (OperandsInBlock)malloc(sizeof(struct OperandsInBlock_)), tail;
	memset(head, 0, sizeof(struct OperandsInBlock_));
	tail = head;
	
	for(i = start; i <  end; i++)
	{
		if(codes[i]->code.kind >= ASSIGN&&codes[i]->code.kind <= DIVIDE)
		{
			if(codes[i]->code.u.binop.op1 != NULL||codes[i]->code.u.binop.op2 != NULL)
			{
				if(findOP(head->next, codes[i]->code.u.binop.op1) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.binop.op1);
				else
					findOP(head->next, codes[i]->code.u.binop.op1)->remcnt++;
				if(findOP(head->next, codes[i]->code.u.binop.op2) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.binop.op2);
				else
					findOP(head->next, codes[i]->code.u.binop.op1)->remcnt++;
			}
		}
	}
	return head->next;
}

int isOperandeq(Operand op1, Operand op2)
{
	if(op1->kind != op2->kind)
	{
		return 0;
	}
	if(op1->u.value != op2->u.value)
	{
		return 0;
	}
	return 1;
}

OperandsInBlock findOP(OperandsInBlock list, Operand op)
{
	OperandsInBlock cur = list;
	while(cur != NULL)
	{
		if(isOperandeq(cur->op, op))
			return cur; 
	}
	return NULL;
}
int get_place_on_fp(OperandsInBlock itm)
{
	if(itm->pos == 0)
	{
		itm->pos = curfpoff+4;
		curfpoff += 4;
	}
	return itm->pos;
}

int ensure(Operand op, OperandsInBlock list, int*reg_status, InterCodes* codes, int start, int end)
{
	OperandsInBlock tmp = findOP(list, op);
	if(tmp->reg != 0)
		return tmp->reg;
	else
	{
		int result = allocate(list, reg_status);
		reg_status[result] = 1;
		tmp->reg = result;
		if(op->kind == CONSTANT )
		{
			fprintf(global_stream, "lw $%s, %i", reglist[result],op->u.value);
		}
		else if(op->kind == VARI || op->kind == TEMP)
		{
			int pos = get_place_on_fp(tmp);
			fprintf(global_stream, "lw $%s, -%i($fp)", reglist[result], pos);
		}
		else if(op->kind == ADDRESS || op->kind == TEMPADDRESS)
		{
			int pos = get_place_on_fp(tmp);
			fprintf(global_stream, "la $%s, -%i($fp)", reglist[result], pos);
		}
		else
		{
			printf("unexpected operand type.\n");
		}
		return result;
	}
}

void spill(OperandsInBlock itm)
{
	if(itm->pos == 0)
	{
		itm->pos = curfpoff+4;
		curfpoff += 4;
		fprintf(global_stream, "sw $%s, -%i($fp)", reglist[itm->reg], itm->pos*4);
	}
	else
	{
		fprintf(global_stream, "sw $%s, -%i($fp)", reglist[itm->reg], itm->pos*4);
	}
}

int allocate(OperandsInBlock list, int* reg_status)
{
	int i;
	for(i = 8; i <= 25; i++)
	{
		if(reg_status[i] == 0)
		{
			return i;
		}
	}
	OperandsInBlock cur = list, min = list;
	while(cur != NULL)
	{
		if(cur->remcnt < min->remcnt)
			min = cur;
		if(min->remcnt == 0)
			break;
	}
	int result = min->reg;
	spill(min);
	return result;
}

/*
int free_reg(Operand op, OperandsInBlock list, int* reg_status, InterCodes* codes, int start, int end)
{
	OperandsInBlock cur = list;
	while(cur != NULL)
	{
		ffor(i = start; i < end; i++)
		{
			if(codes[i]->kind != LABEL && codes[i]->kind != IFGOTO && codes[i] != GOTO && codes[i] != DEC)
			{
				if(codes[i]->u.binop.op1 != NULL||codes[i]->u.binop.op2 != NULL)
				{
					if(*(cur->op) == *(codes[i]->u.binop.op1) || *(cur->op) == *(codes[i]->u.binop.op2))
					{
						cur->nextplace = i;
						break;
					}
				}
			}
		}
		if(i == end)//the cur op will not be used
		{
			cur->nextplace = end;
			if(cur->reg != 0)
			{
				reg_status[cur->reg] = 0;
				cur->reg = 0;
			}
		}
		cur = cur->next;
	}
}*/

void SelectOC(InterCodes* codes, int start, int end)
{
	curfpoff = 0;
	int i;
	OperandsInBlock list = OIBlistCreate(codes, start, end);
	int reg_status[32] = {0};
	for(i = start; i < end; i ++)
	{
		InterCode cur = &(codes[i]->code);
		switch (codes[i]->code.kind)
		{
		case ASSIGN:
			if(cur->u.assign.right->kind == CONSTANT)
			{
				int forleft = allocate(list, reg_status); 
				fprintf(global_stream, "li $%s, %i", reglist[forleft], cur->u.assign.right->u.value);
			}
			else 
			{
				;
			}
			break;
		case STAR_ASSIGN_:
			break;
		case _ASSIGN_AND:
			break;
		case _ASSIGN_STAR:
			break;
		case ADD:
			
			break;
		case ADDR_ADD_VAR:
			OperandPrint(stream, cur->code.u.binop.result);
			fprintf(stream, " := ");
			fprintf(stream, "&");
			OperandPrint(stream, cur->code.u.binop.op1);
			fprintf(stream, " + ");
			OperandPrint(stream, cur->code.u.binop.op2);
			fputc('\n', stream);
			break;
		case SUB:
			OperandPrint(stream, cur->code.u.binop.result);
			fprintf(stream, " := ");
			OperandPrint(stream, cur->code.u.binop.op1);
			fprintf(stream, " - ");
			OperandPrint(stream, cur->code.u.binop.op2);
			fputc('\n', stream);
			break;
		case MUL:
			OperandPrint(stream, cur->code.u.binop.result);
			fprintf(stream, " := ");
			OperandPrint(stream, cur->code.u.binop.op1);
			fprintf(stream, " * ");
			OperandPrint(stream, cur->code.u.binop.op2);
			fputc('\n', stream);
			break;
		case DIVIDE:
			OperandPrint(stream, cur->code.u.binop.result);
			fprintf(stream, " := ");
			OperandPrint(stream, cur->code.u.binop.op1);
			fprintf(stream, " / ");
			OperandPrint(stream, cur->code.u.binop.op2);
			fputc('\n', stream);
			break;
		case LABEL:
			fprintf(stream, "LABEL label%i :\n", cur->code.u.label.label_no);
			break;
		case IFGOTO:
			fprintf(stream, "IF ");
			OperandPrint(stream, cur->code.u.condjmp.op1);
			fputc(' ', stream);
			OperandPrint(stream, cur->code.u.condjmp.rel);
			fputc(' ', stream);
			OperandPrint(stream, cur->code.u.condjmp.op2);
			fprintf(stream, " GOTO label%i\n", cur->code.u.condjmp.dest_label);
			break;
		case GOTO:
			fprintf(stream, "GOTO label%i\n", cur->code.u.jmp.dest_label);
			break;
		case READ:
			fprintf(stream, "READ ");
			OperandPrint(stream, cur->code.u.single.op);
			fputc('\n', stream);
			break;
		case WRITE:
			fprintf(stream, "WRITE ");
			OperandPrint(stream, cur->code.u.single.op);
			fputc('\n', stream);
			break;
		case CALL:
			if(cur->code.u.assign.left != NULL)
			{
				OperandPrint(stream, cur->code.u.assign.left);
				fprintf(stream, " := ");
			}
			else
			{
				fprintf(stream, "NOONE := ");
			}
			fprintf(stream, "CALL ");
			OperandPrint(stream, cur->code.u.assign.right);
			fputc('\n', stream);
			break;
		case ARG:
			fprintf(stream, "ARG ");
			OperandPrint(stream, cur->code.u.single.op);
			fputc('\n', stream);
			break;
		case RET:
			fprintf(stream, "RETURN ");
			OperandPrint(stream, cur->code.u.single.op);
			fputc('\n', stream);
			break;
		case FUNCDEC:
			fprintf(stream, "FUNCTION ");
			OperandPrint(stream, cur->code.u.single.op);
			fprintf(stream, " :\n");
			break;
		case PARAM:
			fprintf(stream, "PARAM ");
			OperandPrint(stream, cur->code.u.single.op);
			fputc('\n', stream);
			break;
		case DEC: 
			fprintf(stream, "DEC ");
			OperandPrint(stream, cur->code.u.dec.var);
			fprintf(stream, " %i\n", cur->code.u.dec.size);
		}
	}
}


