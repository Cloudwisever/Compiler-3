#include "objectcode.h"
char* reglist[32] = {"r0", "at", "v0", "v1", "a0", "a1","a2","a3", "t0","t1","t2","t3","t4","t5","t6","t7", "s0","s1","s2","s3","s4","s5","s6","s7","t8", "t9", "k0", "k1", "gp", "sp", "fp", "ra"};

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

void PrintProgramHead(FILE* stream)
{
	fprintf(stream, ".data\n_prompt: .asciiz \"Enter an integer:\"\n_ret: .asciiz \"\\n\"\n.globl main\n.text\nread:\nli $v0, 4\n	la $a0, _prompt\n	syscall\n	li $v0, 5\n	syscall\n	jr $ra\nwrite:\n	li $v0, 1\n	syscall\n	li $v0, 4\n	la $a0, _ret\n	syscall\n	move $v0, $0\n	jr $ra\n");
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
	if(global_stream != stdout)
		PrintProgramHead(global_stream);
	
	//printf("creating positionlist\n");
	position_list = OIBlistCreate(blocks.code, 0, blocks.length);
	//printf("creatation complete.\n");
	
	curfpoff = 4;
	//SelectOC(blocks.code, 0, blocks.length);
	
	OperandsInBlock itr = position_list;
	int list_len = 0;
	while(itr != NULL)
	{
		list_len++;
		itr = itr->next;
	} 
	


	for(hdi = 0; hdi < blocks.leader_length; hdi++)
	{
		if(hdi == blocks.leader_length-1)
			SelectOC(blocks.code, blocks.leader[hdi], blocks.length, list_len);
		SelectOC(blocks.code, blocks.leader[hdi], blocks.leader[hdi+1], list_len);
	}
}
OperandsInBlock addOIBlist(OperandsInBlock tail,  Operand op)
{
	OperandsInBlock newone = (OperandsInBlock)malloc(sizeof(struct OperandsInBlock_));
	memset(newone, 0, sizeof(struct OperandsInBlock_));
	newone->op = op;
	newone->remcnt = 1;
	newone->reg = 0;
	tail->next = newone;
	/*
	printf("add: ");
	OperandPrint(stdout, newone->op);
	printf("\n");
	*/
	return newone;
}

OperandsInBlock OIBlistCreate(InterCodes* codes, int start, int end)
{
	int i;
	OperandsInBlock head = (OperandsInBlock)malloc(sizeof(struct OperandsInBlock_)), tail;
	memset(head, 0, sizeof(struct OperandsInBlock_));
	tail = head;
	
	//printf("start: %i. end:%i\n", start, end);
	for(i = start; i <  end; i++)
	{
		//IRPrint(stdout, codes[i]);
		/*
		if(codes[i]->code.kind == LABEL || codes[i]->code.kind == GOTO)
			continue;
		if(codes[i]->code.kind == IFGOTO)
		{
			if(codes[i]->code.u.condjmp.op1 != NULL)
			{
				if(findOP(head->next, codes[i]->code.u.condjmp.op1) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.condjmp.op1);
				else
					findOP(head->next, codes[i]->code.u.condjmp.op1)->remcnt++;
			}
			if(codes[i]->code.u.binop.op2 != NULL)
			{
				if(findOP(head->next, codes[i]->code.u.condjmp.op2) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.condjmp.op2);
				else
					findOP(head->next, codes[i]->code.u.condjmp.op2)->remcnt++;
			}
		}
		else if(codes[i]->code.kind == DEC)
		{
			if(codes[i]->code.u.single.op != NULL)
			{
				if(findOP(head->next, codes[i]->code.u.single.op) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.single.op);
				else
					findOP(head->next, codes[i]->code.u.single.op)->remcnt++;
			}
		}
		else
		{
		if(codes[i]->code.u.binop.result != NULL && (codes[i]->code.u.binop.op1->kind == VARI || codes[i]->code.u.binop.op1->kind == ADDRESS||codes[i]->code.u.binop.op1->kind == TEMP || codes[i]->code.u.binop.op1->kind == TEMP))
		{
			if(findOP(head->next, codes[i]->code.u.binop.op1) == NULL)
				tail = addOIBlist(tail, codes[i]->code.u.binop.op1);
			else
				findOP(head->next, codes[i]->code.u.binop.op1)->remcnt++;
		}
		if(codes[i]->code.u.binop.op1 != NULL && (codes[i]->code.u.binop.op1->kind == VARI || codes[i]->code.u.binop.op1->kind == ADDRESS||codes[i]->code.u.binop.op1->kind == TEMP || codes[i]->code.u.binop.op1->kind == TEMP))
		{
			if(findOP(head->next, codes[i]->code.u.binop.op1) == NULL)
				tail = addOIBlist(tail, codes[i]->code.u.binop.op1);
			else
				findOP(head->next, codes[i]->code.u.binop.op1)->remcnt++;
		}
		if(codes[i]->code.u.binop.op2 != NULL && (codes[i]->code.u.binop.op2->kind == VARI || codes[i]->code.u.binop.op2->kind == ADDRESS||codes[i]->code.u.binop.op2->kind == TEMP || codes[i]->code.u.binop.op2->kind == TEMP))
		{
			if(findOP(head->next, codes[i]->code.u.binop.op2) == NULL)
				tail = addOIBlist(tail, codes[i]->code.u.binop.op2);
			else
				findOP(head->next, codes[i]->code.u.binop.op2)->remcnt++;
		}
		}
		*/
		
		if(codes[i]->code.kind >= ASSIGN&&codes[i]->code.kind <= DIVIDE||codes[i]->code.kind == CALL)
		{
			if(codes[i]->code.u.single.op != NULL)
			{
				if(findOP(head->next, codes[i]->code.u.single.op) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.single.op);
				else
					findOP(head->next, codes[i]->code.u.single.op)->remcnt++;
			}
			if(codes[i]->code.u.binop.op1 != NULL)
			{
				if(findOP(head->next, codes[i]->code.u.binop.op1) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.binop.op1);
				else
					findOP(head->next, codes[i]->code.u.binop.op1)->remcnt++;
			}
			if(codes[i]->code.u.binop.op2 != NULL)
			{
				if(findOP(head->next, codes[i]->code.u.binop.op2) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.binop.op2);
				else
					findOP(head->next, codes[i]->code.u.binop.op2)->remcnt++;
			}
		}
		else if(codes[i]->code.kind == READ||codes[i]->code.kind == WRITE || codes[i]->code.kind == RET||codes[i]->code.kind == DEC||codes[i]->code.kind == ARG || codes[i]->code.kind == PARAM)
		{
			if(codes[i]->code.u.single.op != NULL)
			{
				if(findOP(head->next, codes[i]->code.u.single.op) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.single.op);
				else
					findOP(head->next, codes[i]->code.u.single.op)->remcnt++;
			}
		}
		else if(codes[i]->code.kind == IFGOTO)
		{
			if(codes[i]->code.u.condjmp.op1 != NULL)
			{
				if(findOP(head->next, codes[i]->code.u.condjmp.op1) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.condjmp.op1);
				else
					findOP(head->next, codes[i]->code.u.condjmp.op1)->remcnt++;
			}
			if(codes[i]->code.u.binop.op2 != NULL)
			{
				if(findOP(head->next, codes[i]->code.u.condjmp.op2) == NULL)
					tail = addOIBlist(tail, codes[i]->code.u.condjmp.op2);
				else
					findOP(head->next, codes[i]->code.u.condjmp.op2)->remcnt++;
			}
		}
		
	}
	//printf("created.\n");
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
	if(op == NULL)
	{
		printf("op shouldnt be NULL\n");
		return NULL;
	}
	OperandsInBlock cur = list;
	while(cur != NULL)
	{
		if(isOperandeq(cur->op, op))
			return cur; 
		cur = cur->next;
	}
	return NULL;
}
int get_place_on_fp(OperandsInBlock itm)
{
	OperandsInBlock positm = findOP(position_list, itm->op);
	if(positm == NULL)
	{
		printf("cant find the op in position_list.\n");
		return 0;
	}
	else{
		if(positm->pos == 0)
		{
			positm->pos = curfpoff+4;
			itm->pos = curfpoff+4;
			curfpoff += 4;
		}
		return positm->pos;
	}
}

int get_place_for_array(Operand op, int size)
{
	OperandsInBlock positm = findOP(position_list, op);
	if(positm == NULL)
	{
		printf("cant find the op in position_list.\n");
		return 0;
	}
	else{
		if(positm->pos == 0)
		{
			curfpoff += size;
			positm->pos = curfpoff;
		}
		return positm->pos;
	}
}

int ensure(Operand op, OperandsInBlock list, int*reg_status)
{
	/*
	printf("trying to ensure:");
	OperandPrint(stdout, op);
	//*/
	OperandsInBlock tmp = findOP(list, op);
	if(tmp == NULL)
	{
		printf("operand not in OIBlist.\n");
		return 0;
	}
	int i;
	/*
	for(i = 8; i <= 25; i++)
	{
		printf("%i, ", reg_status[i]);
	}
	printf(",reg = %i\n", tmp->reg);
	//*/
	if(tmp->reg != 0)
		return tmp->reg;
	else
	{
		int result = allocate(op, list, reg_status);
		if(op->kind == CONSTANT )
		{
			fprintf(global_stream, "li $%s, %i\n", reglist[result],op->u.value);
		}
		else if(op->kind == VARI || op->kind == TEMP)
		{
			int pos = get_place_on_fp(tmp);
			fprintf(global_stream, "lw $%s, -%i($fp)\n", reglist[result], pos);
		}
		else if(op->kind == ADDRESS)
		{
			int pos = get_place_on_fp(tmp);
			fprintf(global_stream, "la $%s, -%i($fp)\n", reglist[result], pos);
		}
		else
		{
			printf("unexpected operand type:");
			OperandPrint(stdout, op);
			printf("\n");
		}
		return result;
	}
}

void spill(OperandsInBlock itm, int* reg_status)
{
	OperandsInBlock positm = findOP(position_list, itm->op);
	if(positm == NULL)
	{
		printf("cant find the op in position_list.\n");
		return;
	}
	else{
		//printf("spilling :op is:");
		//OperandPrint(stdout, itm->op);
		//printf("\n");
		if(positm->pos == 0)
		{
			positm->pos = curfpoff+4;
			itm->pos = curfpoff+4;
			curfpoff += 4;
			//printf("the positm is new, adding sw %i\n", positm->pos
			fprintf(global_stream, "sw $%s, -%i($fp)\n", reglist[itm->reg], positm->pos);
		}
		else
		{
			fprintf(global_stream, "sw $%s, -%i($fp)\n", reglist[itm->reg], positm->pos);
		}
		reg_status[itm->reg] = 0;
		itm->reg = 0;
	}
}

int allocate(Operand op, OperandsInBlock list, int* reg_status)
{
	int i;
	/*
	printf("trying to allocate:");
	OperandPrint(stdout, op);
	for(i = 8; i <= 25; i++)
	{
		printf("%i, ", reg_status[i]);
	}
	//*/
	OperandsInBlock itm = findOP(list, op);
	if(itm == NULL)
	{
		printf("operand not in OIBlist.\n");
		return 0;
	}
	//printf("reg: %i\n", itm->reg);
	if(itm->reg != 0)
	{
		return itm->reg;
	}
	for(i = 8; i <= 25; i++)
	{
		if(reg_status[i] == 0)
		{
			itm->reg = i;
			reg_status[i] = 1;
			return i;
		}
	}
	OperandsInBlock cur = list, min = NULL;
	while(cur != NULL)
	{
	
		if(cur->reg != 0)
		{
			if(min == NULL)
				min = cur;
			else if(cur->remcnt <= min->remcnt)//= is for make the spilled one show up later.
				min = cur;
		}
		if(min != NULL && min->remcnt == 0)
			break;
		cur = cur->next;
	}
	if(min == NULL)
	{
		printf("why min is null?\n");
		return 0;
	}
	int result = min->reg;
	spill(min, reg_status);
	reg_status[result] = 1;
	itm->reg = result;
	return result;
}

void free_reg(OperandsInBlock itm, int* reg_status)
{
	itm->remcnt = 0;
	reg_status[itm->reg] = 0;
	itm->reg = 0;
}

void SelectOC(InterCodes* codes, int start, int end, int length)
{
	int i, spilled = 0;
	OperandsInBlock list = OIBlistCreate(codes, start, end);
	
	int list_len = length;
	OperandsInBlock itr = list;
	/*
	while(itr != NULL)
	{
		list_len++;
		itr = itr->next;
	} 
	*/
	
	printf("selecting a new part: from %i to %i.\n", start, end);
	int argscnt = 0, paramcnt = 0, idx;
	int reg_status[32] = {0};
	for(i = start; i < end; i ++)
	{
		InterCode cur = &(codes[i]->code);
		int right = 0, forleft = 0, right2 = 0;
		OperandsInBlock rightitm, rightitm2;
		IRPrint(stdout, codes[i]);

		
		switch (codes[i]->code.kind)
		{
		case ASSIGN:
			if(cur->u.assign.right->kind == CONSTANT)
			{
				forleft = allocate(cur->u.assign.left, list, reg_status); 
				fprintf(global_stream, "li $%s, %i\n", reglist[forleft], cur->u.assign.right->u.value);
			}
			else 
			{
				//printf("ensuring\n");
				right = ensure(cur->u.assign.right, list, reg_status);
				rightitm = findOP(list,cur->u.assign.right);
				//printf("ensured\n");
				if(rightitm->remcnt == 1)
				{
					free_reg(rightitm, reg_status);
				}
				else
					rightitm->remcnt--;
				
				forleft = allocate(cur->u.assign.left, list, reg_status); 
				
				if(forleft == 0)
				{
					printf("forleft is zero:\n");
				}
				//printf("forleft is %i\n", forleft);
				fprintf(global_stream, "move $%s, $%s\n", reglist[forleft], reglist[right]);
			}
			break;
		case STAR_ASSIGN_:
			right = ensure(cur->u.assign.right, list, reg_status);
			rightitm = findOP(list,cur->u.assign.right);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			else
				rightitm->remcnt--;
				
			forleft = allocate(cur->u.assign.left, list, reg_status); 
			if(forleft != 0)
			{
				fprintf(global_stream, "sw $%s, 0($%s)\n", reglist[right], reglist[forleft]);
			}
			break;
		case _ASSIGN_AND:
			right = ensure(cur->u.assign.right, list, reg_status);
			rightitm = findOP(list,cur->u.assign.right);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			else
				rightitm->remcnt--;
				
			forleft = allocate(cur->u.assign.left, list, reg_status); 
			if(forleft != 0)
			{
				fprintf(global_stream, "la $%s, 0($%s)\n", reglist[forleft], reglist[right]);
			}
			break;
		case _ASSIGN_STAR:
			right = ensure(cur->u.assign.right, list, reg_status);
			rightitm = findOP(list,cur->u.assign.right);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			else
				rightitm->remcnt--;
				
			forleft = allocate(cur->u.assign.left, list, reg_status); 
			if(forleft != 0)
			{
				fprintf(global_stream, "lw $%s, 0($%s)\n", reglist[forleft], reglist[right]);
			}
			break;
		case ADD:
		case ADDR_ADD_VAR:
			right = ensure(cur->u.binop.op1, list, reg_status);
			
			if(cur->u.binop.op2->kind != CONSTANT)
			{
				right2 = ensure(cur->u.binop.op2, list, reg_status);
			}
			rightitm = findOP(list,cur->u.binop.op1);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			else
				rightitm->remcnt--;
			if(cur->u.binop.op2->kind != CONSTANT)
			{
				rightitm2  = findOP(list,cur->u.binop.op2);
				if(rightitm2->remcnt == 1)
				{
					free_reg(rightitm2, reg_status);
				}
				else
					rightitm2->remcnt--;	
			}
			forleft = allocate(cur->u.binop.result, list, reg_status); 
			if( forleft != 0)
			{
				if(cur->u.binop.op2->kind != CONSTANT)
					fprintf(global_stream, "add $%s, $%s, $%s\n", reglist[forleft], reglist[right], reglist[right2]);
				else
					fprintf(global_stream, "addi $%s, $%s, %i\n", reglist[forleft], reglist[right], cur->u.binop.op2->u.value);
			}
			break;
		case SUB:
			right = ensure(cur->u.binop.op1, list, reg_status);
			if(cur->u.binop.op2->kind != CONSTANT)
			{
				right2 = ensure(cur->u.binop.op2, list, reg_status);
			}
			rightitm = findOP(list,cur->u.binop.op1);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			else
				rightitm->remcnt--;
			if(cur->u.binop.op2->kind != CONSTANT)
			{
				rightitm2  = findOP(list,cur->u.binop.op2);
				if(rightitm2->remcnt == 1)
				{
					free_reg(rightitm2, reg_status);
				}
				else
					rightitm2->remcnt--;	
			}
			forleft = allocate(cur->u.binop.result, list, reg_status); 
			if( forleft != 0)
			{
				if(cur->u.binop.op2->kind != CONSTANT)
					fprintf(global_stream, "sub $%s, $%s, $%s\n", reglist[forleft], reglist[right], reglist[right2]);
				else
					fprintf(global_stream, "addi $%s, $%s, -%i\n", reglist[forleft], reglist[right], cur->u.binop.op2->u.value);
			}
			break;
		case MUL:
			right = ensure(cur->u.binop.op1, list, reg_status);
			right2 = ensure(cur->u.binop.op2, list, reg_status);
			

			rightitm = findOP(list,cur->u.binop.op1);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			else
				rightitm->remcnt--;
			rightitm2  = findOP(list,cur->u.binop.op2);
			if(rightitm2->remcnt == 1)
			{
				free_reg(rightitm2, reg_status);
			}
			else
				rightitm2->remcnt--;	
			forleft = allocate(cur->u.binop.result, list, reg_status); 
			
			//printf("right1: %i, right2:%i, forleft:%i\n", right, right2, forleft);
			if( forleft != 0)
			{
				fprintf(global_stream, "mul $%s, $%s, $%s\n", reglist[forleft], reglist[right], reglist[right2]);
			}
			break;
		case DIVIDE:
			right = ensure(cur->u.binop.op1, list, reg_status);
			right2 = ensure(cur->u.binop.op2, list, reg_status);

			rightitm = findOP(list,cur->u.binop.op1);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			else
				rightitm->remcnt--;
			rightitm2  = findOP(list,cur->u.binop.op2);
			if(rightitm2->remcnt == 1)
			{
				free_reg(rightitm2, reg_status);
			}
			else
				rightitm2->remcnt--;	
			forleft = allocate(cur->u.binop.result, list, reg_status); 
			if( forleft != 0)
			{
				fprintf(global_stream, "div $%s, $%s\n",reglist[right], reglist[right2]);
				fprintf(global_stream, "mflo $%s\n",reglist[forleft]);
			}
			break;
		case LABEL:
			
			fprintf(global_stream, "label%i:\n", cur->u.label.label_no);
			break;
		case IFGOTO:
			itr = list;
			while(itr != NULL)
			{
				if(itr->reg != 0&&(itr->op->kind == VARI || itr->op->kind == ADDRESS ||itr->op->kind == TEMP ||itr->op->kind == TEMPADDRESS))
				{
					spill(itr,reg_status);
				}
				itr = itr->next;
			}
			spilled = 1;
	
			right = ensure(cur->u.condjmp.op1, list, reg_status);
			right2 = ensure(cur->u.condjmp.op2, list, reg_status);

			rightitm = findOP(list,cur->u.condjmp.op1);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			else
				rightitm->remcnt--;
			rightitm2  = findOP(list,cur->u.condjmp.op2);
			if(rightitm2->remcnt == 1)
			{
				free_reg(rightitm2, reg_status);
			}
			else
				rightitm2->remcnt--;
			int rel = cur->u.condjmp.rel->u.rel;
			switch(rel)
			{
			case LEQ: fprintf(global_stream, "ble $%s, $%s, label%i\n", reglist[right], reglist[right2], cur->u.condjmp.dest_label);break;
			case L: fprintf(global_stream, "blt $%s, $%s, label%i\n", reglist[right], reglist[right2], cur->u.condjmp.dest_label);break;
			case GEQ: fprintf(global_stream, "bge $%s, $%s, label%i\n", reglist[right], reglist[right2], cur->u.condjmp.dest_label);break;
			case G: fprintf(global_stream, "bgt $%s, $%s, label%i\n", reglist[right], reglist[right2], cur->u.condjmp.dest_label);break;
			case EQ: fprintf(global_stream, "beq $%s, $%s, label%i\n", reglist[right], reglist[right2], cur->u.condjmp.dest_label);break;
			case NEQ:fprintf(global_stream, "bne $%s, $%s, label%i\n", reglist[right], reglist[right2], cur->u.condjmp.dest_label);break;
			}
			break;
		case GOTO:
			if(i == end - 1)
			{
				itr = list;
				while(itr != NULL)
				{
					if(itr->reg != 0&&(itr->op->kind == VARI || itr->op->kind == ADDRESS ||itr->op->kind == TEMP ||itr->op->kind == TEMPADDRESS))
					{
						spill(itr,reg_status);
					}
					itr = itr->next;
				}
			}
			fprintf(global_stream, "j label%i\n", cur->u.jmp.dest_label);
			break;
		case READ:
			forleft = allocate(cur->u.single.op, list, reg_status); 
			fprintf(global_stream, "addi $sp, $sp, -4\nsw $ra, 0($sp)\njal read\nlw $ra, 0($sp)\naddi $sp, $sp, 4\nmove $%s, $v0\n", reglist[forleft]);
			break;
		case WRITE:
			right = ensure(cur->u.single.op, list, reg_status);
			rightitm = findOP(list,cur->u.single.op);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			fprintf(global_stream, "move $a0, $%s\naddi $sp, $sp, -4\nsw $ra, 0($sp)\njal write\nlw $ra, 0($sp)\naddi $sp, $sp, 4\n", reglist[right]);
			break;
		case CALL:
			itr = list;
			while(itr != NULL)
			{
				if(itr->reg != 0&&(itr->op->kind == VARI || itr->op->kind == ADDRESS ||itr->op->kind == TEMP ||itr->op->kind == TEMPADDRESS))
				{
					spill(itr,reg_status);
				}
				itr = itr->next;
			}
			
			fprintf(global_stream, "addi $sp, $sp, -4\nsw $ra, 0($sp)\njal %s\n", cur->u.assign.right->u.var_name);
			
			fprintf(global_stream, "lw $ra, 0($sp)\naddi $sp, $sp, 4\n");
			if(cur->u.assign.left != NULL)
			{
				forleft = allocate(cur->u.single.op, list, reg_status); 
				fprintf(global_stream, "move $%s, $v0\n", reglist[forleft]);
			}
			
			break;
		case ARG:
			idx = i+1;
			while(codes[idx]->code.kind == ARG)
			{
				idx ++;
			}
			argscnt = idx - i;
			right = ensure(cur->u.single.op, list, reg_status);
			rightitm = findOP(list,cur->u.single.op);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			if(argscnt > 4)//push args to stack
			{
				fprintf(global_stream, "addi $sp, $sp, -4\nsw $%s, 0($sp)\n", reglist[right]);
			}
			else
			{
				fprintf(global_stream, "move $%s, $%s\n",reglist[3+argscnt], reglist[right]);
			}		
			break;
		case RET:
			right = ensure(cur->u.single.op, list, reg_status);
			rightitm = findOP(list,cur->u.single.op);
			if(rightitm->remcnt == 1)
			{
				free_reg(rightitm, reg_status);
			}
			fprintf(global_stream, "move $v0, $%s\nmove $sp, $fp\nlw $fp, 0($sp)\naddi $sp, $sp, 4\njr $ra\n", reglist[right]);
			break;
		case FUNCDEC:
			
			paramcnt = 0;
			fprintf(global_stream, "%s:\n", cur->u.single.op->u.var_name);
			fprintf(global_stream, "addi $sp, $sp, -4\nsw $fp, 0($sp)\nmove $fp, $sp\n");
			curfpoff = 4;
			fprintf(global_stream, "addi $sp, $sp, -%i\n", list_len*4);
			break;
		case PARAM:
			forleft = allocate(cur->u.single.op, list, reg_status); 
			if(paramcnt < 4)
			{
				fprintf(global_stream, "move $%s, $%s\n", reglist[forleft], reglist[4+paramcnt]);
			}
			else
			{
				fprintf(global_stream, "lw $%s, %i($fp)\n", reglist[forleft], (paramcnt-2)*4);
			}
			paramcnt++;
			break;
		case DEC: 
			get_place_for_array(cur->u.dec.var, cur->u.dec.size);
			fprintf(global_stream, "addi $sp, $sp, -%i\n", cur->u.dec.size);
			break;
		}
		
		//printf("at end: i is %i, spilled %i\n", i, spilled);
		if(i == end-1 && spilled == 0)
		{
			itr = list;
			while(itr != NULL)
			{
				if(itr->reg != 0&&(itr->op->kind == VARI || itr->op->kind == ADDRESS ||itr->op->kind == TEMP ||itr->op->kind == TEMPADDRESS))
				{
					spill(itr,reg_status);
				}
				itr = itr->next;
			}
			spilled  = 1;
		}
		//spill all to stack
	}
	/*
	itr = list;
	while(itr != NULL)
	{
		if(itr->reg != 0&&(itr->op->kind == VARI || itr->op->kind == ADDRESS ||itr->op->kind == TEMP ||itr->op->kind == TEMPADDRESS))
		{
			spill(itr);
		}
		itr = itr->next;
	}*/
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

