#include"IR.h"
InterCodes IRtable_head, IRtable_tail;
Operand temp_list[TEMP_SIZE];
Operand constant_list[TEMP_SIZE];

struct Operand_ relop_list[6] = {{RELATOP, LEQ}, {RELATOP, L}, {RELATOP, GEQ},{RELATOP, G},{RELATOP, EQ}, {RELATOP, NEQ}};

static int variable_no_cnt = 0; 

Operands addOperands(Operand opd, Operands head)//shall we use head insert? inverted list is just suitable for the args of function.
{	
	struct Operands_* temp = (struct Operands_*)malloc(sizeof(struct Operands_));
	memset(temp, 0, sizeof(struct Operands_));

	temp->op = opd;
	if(head == NULL)
		return temp;
	temp->next = head;
	head = temp;
	return head;
	
	/*Operands tail = NULL, cur = head;
	
	while(cur != NULL)
	{
		if(cur->next == NULL)
		{
			tail = cur;
		}
	}
	if(head == NULL)
	{
		head = (Operands)malloc(sizeof(struct Operand_));
		memset(head, 0, sizeof(struct Operand_));
		tail = head;
		head->op = opd;
		return head;
	}
	else
	{
		struct InterCodes_* temp = (struct Operand_*)malloc(sizeof(struct Operand_));
		memset(temp, 0, sizeof(struct Operand_));

		temp->op = opd;
		tail->next = temp;
		tail = temp;
		return head;
	}*/
}
InterCodes addIR(struct InterCode_ ir, struct InterCodes_* head, struct InterCodes_* tail)
{
	if (tail == NULL)
	{
		head = (InterCodes)malloc(sizeof(struct InterCodes_));
		memset(head, 0, sizeof(struct InterCodes_));
		tail = head;
		head->code = ir;
		return head;
	}
	else
	{
		struct InterCodes_* temp = (struct InterCodes_*)malloc(sizeof(struct InterCodes_));
		memset(temp, 0, sizeof(struct InterCodes_));

		temp->code = ir;
		tail->next = temp;
		printf("adding prev for:\n");
		IRPrint(stdout, temp);
		temp->prev = IRtable_tail;
		tail = temp;
		return tail;
	}
}

InterCodes IRaddIR(InterCodes code1, InterCodes code2)
{
	if(code1 == NULL)
		return code2;
	else if(code2 == NULL)
		return code1;
	InterCodes tail1 = findIRtail(code1);
	tail1->next = code2;
	printf("adding prev for:\n");
	IRPrint(stdout, code2);
	code2->prev = tail1;
	return code1;
}

InterCodes findIRtail(InterCodes head)
{
	InterCodes tail = NULL, cur = head;
	while(cur != NULL)
	{
		if(cur->next == NULL)
		{
			tail = cur;
		}
		cur = cur->next;
	}
	return tail;
}

InterCodes addIRhead(struct InterCode_ ir, InterCodes head)
{
	InterCodes tail = NULL, cur = head;
	while(cur != NULL)
	{
		if(cur->next == NULL)
		{
			tail = cur;
		}
		cur = cur->next;
	}
	if (tail == NULL)
	{
		head = (InterCodes)malloc(sizeof(struct InterCodes_));
		memset(head, 0, sizeof(struct InterCodes_));
		tail = head;
		head->code = ir;
	}
	else
	{
		struct InterCodes_* temp = (struct InterCodes_*)malloc(sizeof(struct InterCodes_));
		memset(temp, 0, sizeof(struct InterCodes_));

		temp->code = ir;
		tail->next = temp;
		printf("adding prev for:\n");
		IRPrint(stdout, temp);
		temp->prev = IRtable_tail;
		tail = temp;
	}
	return head;
}

Operand new_temp()
{
	static int temp_count = 0;
	if(temp_count >= TEMP_SIZE)
	{
		printf("more than 1000 temps: %i\n", temp_count);
		return NULL;
	}
	Operand newOP = (Operand)malloc(sizeof(struct Operand_));
	newOP->kind = TEMP;
	temp_list[temp_count++] = newOP;
	newOP->u.temp_no = temp_count;
	return newOP;
}
struct InterCode_ new_label()
{
	static int label_count = 0;
	struct InterCode_ ir = {0};
	ir.kind = LABEL;
	ir.u.label.label_no = ++label_count;
	return ir;
}

Operand getConstant(int num)
{
	if(num >= TEMP_SIZE)
	{
		Operand newOP = (Operand)malloc(sizeof(struct Operand_));
		newOP->kind = CONSTANT;
		newOP->u.value = num;
		return newOP;
	}
	else
	{
		if(constant_list[num] == NULL)
		{
			Operand newOP = (Operand)malloc(sizeof(struct Operand_));
			newOP->kind = CONSTANT;
			newOP->u.value = num;
			constant_list[num] = newOP;
			return newOP;
		}
		else
			return constant_list[num];
	}
}
Operand getRelop(char* relop)
{
	if(strcmp(relop, "<=") == 0)
	{
		return &relop_list[LEQ];
	}
	else if(strcmp(relop, "<") == 0)
	{
		return &relop_list[L];
	}
	else if(strcmp(relop, ">=") == 0)
	{
		return &relop_list[GEQ];
	}
	else if(strcmp(relop, ">") == 0)
	{
		return &relop_list[G];
	}
	else if(strcmp(relop, "==") == 0)
	{
		return &relop_list[EQ];
	}
	else if(strcmp(relop, "!=") == 0)
	{
		return &relop_list[NEQ];
	}
	else
	{
		printf("unknown relop: %s\n", relop);
		return &relop_list[EQ];
	}
}

void addDummy()
{
	struct InterCodes_* temp = (struct InterCodes_*)malloc(sizeof(struct InterCodes_));
	memset(temp, 0, sizeof(struct InterCodes_));

	struct Operand_ opp1 = { VARI, 1 };
	struct Operand_ opp2 = { CONSTANT, 2 };
	struct Operand_ opp3 = { VARI, 3 };
	temp->code.kind = ASSIGN;
	temp->code.u.assign.left = &opp1;
	temp->code.u.assign.right = &opp2;

	addIR(temp->code, IRtable_head, IRtable_tail);

	temp->code.kind = ADD;
	temp->code.u.binop.result = &opp1;
	temp->code.u.binop.op1 = &opp2;
	temp->code.u.binop.op2 = &opp3;

	addIR(temp->code,IRtable_head, IRtable_tail);

	IRtablePrint(stdout, NULL);
}



void OperandPrint(FILE *stream, Operand op)
{
	if (op == NULL)
	{
		return;
	}
	switch (op->kind)
	{
	case VARI:
		fprintf(stream, "VAR_%s", op->u.var_name); break;
	case FUNCNAMES:
		fprintf(stream, "%s", op->u.var_name); break;
	case CONSTANT:
		fprintf(stream, "#%i", op->u.value); break;
	case ADDRESS:
		fprintf(stream, "VAR_%s", op->u.var_name); break;
	case TEMP:
		fprintf(stream, "t%i", op->u.temp_no);break;
	case TEMPADDRESS:
		fprintf(stream, "t%i", op->u.temp_no);break;
	case RELATOP:
		switch(op->u.rel)
		{
			case LEQ: fprintf(stream, "<=");break;
			case L: fprintf(stream, "<");break;
			case GEQ: fprintf(stream, ">=");break;
			case G: fprintf(stream, ">");break;
			case EQ: fprintf(stream, "==");break;
			case NEQ: fprintf(stream, "!=");break;
		}
		break;
	}
}

void IRPrint(FILE* stream, InterCodes irtable)
{
	InterCodes cur = irtable;
	switch (cur->code.kind)
		{
		case ASSIGN:
			OperandPrint(stream, cur->code.u.assign.left);
			fprintf(stream, " := ");
			OperandPrint(stream, cur->code.u.assign.right);
			fputc('\n', stream);
			break;
		case STAR_ASSIGN_:
			fputc('*', stream);
			OperandPrint(stream, cur->code.u.assign.left);
			fprintf(stream, " := ");
			OperandPrint(stream, cur->code.u.assign.right);
			fputc('\n', stream);
			break;
		case _ASSIGN_AND:
			OperandPrint(stream, cur->code.u.assign.left);
			fprintf(stream, " := ");
			fputc('&', stream);
			OperandPrint(stream, cur->code.u.assign.right);
			fputc('\n', stream);
			break;
		case _ASSIGN_STAR:
			OperandPrint(stream, cur->code.u.assign.left);
			fprintf(stream, " := ");
			fputc('*', stream);
			OperandPrint(stream, cur->code.u.assign.right);
			fputc('\n', stream);
			break;
		case ADD:
			OperandPrint(stream, cur->code.u.binop.result);
			fprintf(stream, " := ");
			OperandPrint(stream, cur->code.u.binop.op1);
			fprintf(stream, " + ");
			OperandPrint(stream, cur->code.u.binop.op2);
			fputc('\n', stream);
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

void Addprev4IR(InterCodes irtable)
{
	InterCodes cur = irtable, before = NULL;
	while(cur != NULL)
	{
		cur->prev = before;
		before = cur;
		cur = cur->next;
	}
}

void IRtablePrint(FILE* stream, InterCodes irtable)
{
	struct InterCodes_* cur = irtable;
	Addprev4IR(irtable);
	while (cur != NULL)
	{
		switch (cur->code.kind)
		{
		case ASSIGN:
			if(cur->code.u.assign.left == NULL)
			{
				if(cur->prev != NULL)
					cur->prev->next = cur->next;
				if(cur->next != NULL)
					cur->next->prev = cur->prev;
				break;
			}
			OperandPrint(stream, cur->code.u.assign.left);
			fprintf(stream, " := ");
			OperandPrint(stream, cur->code.u.assign.right);
			fputc('\n', stream);
			break;
		case STAR_ASSIGN_:
			if(cur->code.u.assign.left == NULL)
			{
				if(cur->prev != NULL)
					cur->prev->next = cur->next;
				if(cur->next != NULL)
					cur->next->prev = cur->prev;
				break;
			}
			fputc('*', stream);
			OperandPrint(stream, cur->code.u.assign.left);
			fprintf(stream, " := ");
			OperandPrint(stream, cur->code.u.assign.right);
			fputc('\n', stream);
			break;
		case _ASSIGN_AND:
			if(cur->code.u.assign.left == NULL)
			{
				if(cur->prev != NULL)
					cur->prev->next = cur->next;
				if(cur->next != NULL)
					cur->next->prev = cur->prev;
				break;
			}
			OperandPrint(stream, cur->code.u.assign.left);
			fprintf(stream, " := ");
			fputc('&', stream);
			OperandPrint(stream, cur->code.u.assign.right);
			fputc('\n', stream);
			break;
		case _ASSIGN_STAR:
			if(cur->code.u.assign.left == NULL)
			{
				if(cur->prev != NULL)
					cur->prev->next = cur->next;
				if(cur->next != NULL)
					cur->next->prev = cur->prev;
				break;
			}
			OperandPrint(stream, cur->code.u.assign.left);
			fprintf(stream, " := ");
			fputc('*', stream);
			OperandPrint(stream, cur->code.u.assign.right);
			fputc('\n', stream);
			break;
		case ADD:
			OperandPrint(stream, cur->code.u.binop.result);
			fprintf(stream, " := ");
			OperandPrint(stream, cur->code.u.binop.op1);
			fprintf(stream, " + ");
			OperandPrint(stream, cur->code.u.binop.op2);
			fputc('\n', stream);
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
		cur = cur->next;
	}
}

InterCodes translate_Program(Syntax_Leaf* root, HashItem* sym_table)
{
	return translate_ExtDefList(root->children[0], sym_table);
}
InterCodes translate_ExtDefList(Syntax_Leaf* root, HashItem* sym_table)
{
	InterCodes extdefls = NULL, ext;
	while(root != NULL && root->children[0] != NULL)
	{
		ext = translate_ExtDef(root->children[0], sym_table);
		
		extdefls = IRaddIR(extdefls, ext);
		root = root->children[1];
		
	}
	return extdefls;
}
InterCodes translate_ExtDef(Syntax_Leaf* root, HashItem* sym_table)
{//printf("shall we begin?\n");
	//printf("extdefcild1:%s\n", root->name);
	if(strcmp(root->children[1]->name, "FunDec") == 0)
	{
		InterCodes code1,code2;
		code1 = translate_FunDec(root->children[1], sym_table);
		code2 = translate_CompSt(root->children[2], sym_table);
		//printf("add fun and comp\n");
		return IRaddIR(code1, code2);
	}
	return NULL;
}

InterCodes translate_FunDec(Syntax_Leaf* root, HashItem* sym_table)
{
	HashItem idhash = SymbolTable_Find(sym_table, root->children[0]->content);
	
	Operand opID = (Operand)malloc(sizeof(struct Operand_));
	opID->kind = FUNCNAMES;
	opID->u.var_name = idhash->symbol->name;
	
	InterCodes fundec = NULL;
	struct InterCode_ ir = {0};
	ir.kind = FUNCDEC;
	ir.u.single.op = opID;
	
	fundec = addIRhead(ir, fundec);
	
	if(strcmp(root->children[2]->name, "VarList") == 0)
	{
		InterCodes varls = translate_VarList(root->children[2], sym_table);
		fundec = IRaddIR(fundec, varls);
	}
	
	return fundec;
}
InterCodes translate_VarList(Syntax_Leaf* root, HashItem* sym_table)
{
	InterCodes varls = NULL;
	while(root != NULL)
	{
		//printf("varlsit begin\n");
		InterCodes var = translate_ParamDec(root->children[0], sym_table);
		varls = IRaddIR(varls, var);
		root = root->children[2];
	}
	return varls;
}
InterCodes translate_ParamDec(Syntax_Leaf* root, HashItem* sym_table)
{
	return translate_VarDec(root->children[1], sym_table);
}
InterCodes translate_VarDec(Syntax_Leaf* root, HashItem* sym_table)
{
	if(strcmp(root->children[0]->name, "ID") == 0)
	{
		HashItem idhash = SymbolTable_Find(sym_table, root->children[0]->content);
		/*if(idhash == NULL)struct InterCode_
		{
			printf("Error type 1 at Line %i: Undefined variable \"%s\".\n", ID_root->lineno, ID_root->content);
			return NULL;
		}*/
		Operand opID = (Operand)malloc(sizeof(struct Operand_));
		opID->kind = VARI;
		opID->u.var_idfr.name = idhash->symbol->name;
		if(idhash->symbol->no != 0)
		{
			opID->u.var_idfr.no = idhash->symbol->no;
		}
		else
		{
			idhash->symbol->no = ++variable_no_cnt;
			opID->u.var_idfr.no = idhash->symbol->no;
		}
				
		InterCodes code1 = NULL;
				
		struct InterCode_ ir = {0};
		ir.kind = PARAM;
		ir.u.single.op = opID;
			
		code1 = addIRhead(ir, code1);
		return code1;
	}
	else
	{
		printf("Cannot translate: Code contains parameters of array type.\n");
		return NULL;
	}
}


InterCodes translate_CompSt(Syntax_Leaf* root, HashItem* sym_table)
{
	InterCodes code1, code2;
	code1 = translate_DefList(root->children[1], sym_table);
	//printf("def done.\n");
	code2 = translate_StmtList(root->children[2], sym_table);
	return IRaddIR(code1, code2);
}


InterCodes translate_DefList(Syntax_Leaf* root, HashItem* sym_table)
{
	InterCodes defls = NULL;
	while(root != NULL && root->children[0] != NULL)
	{
		InterCodes def = translate_Def(root->children[0], sym_table);
		defls = IRaddIR(defls, def);
		root = root->children[1];
	}
	return defls;
}
InterCodes translate_Def(Syntax_Leaf* root, HashItem* sym_table)
{
	return translate_DecList(root->children[1], sym_table);
}
InterCodes translate_DecList(Syntax_Leaf* root, HashItem* sym_table)
{
	InterCodes decls = NULL;
	while(root != NULL)
	{
		//printf("to dec\n");
		InterCodes dec = translate_Dec(root->children[0], sym_table);
		decls = IRaddIR(decls, dec);
		root = root->children[2];
	}
	return decls;
}

InterCodes translate_Dec(Syntax_Leaf* root, HashItem* sym_table)
{
	Syntax_Leaf* vardec = root->children[0]; 
	int good = 0;
	if(vardec->children[0]->type == ID_&&vardec->children[1] == NULL)
	{
		good = 1;
	}
	else if((strcmp(vardec->children[0]->name, "VarDec") == 0)&&(strcmp(vardec->children[1]->name, "LB") == 0))//vardec[int] 
	{
		good = 2;
	}
	printf("good = %i\n", good);
	if(root->children[1] != NULL)
	{
		if(good == 1)//exp1->ID
		{
			HashItem idhash = SymbolTable_Find(sym_table, vardec->children[0]->content);
			/*if(idhash == NULL)struct InterCode_
			{
				printf("Error type 1 at Line %i: Undefined variable \"%s\".\n", ID_root->lineno, ID_root->content);
				return NULL;
			}*/
			Operand opID = (Operand)malloc(sizeof(struct Operand_));
			opID->kind = VARI;
			opID->u.var_idfr.name = idhash->symbol->name;
		
			struct InterCode_ ir = {0};
			InterCodes code1 = NULL, code2 = NULL;
			if(idhash->symbol->no != 0)
			{
				opID->u.var_idfr.no = idhash->symbol->no;
			}
			else
			{
				idhash->symbol->no = ++variable_no_cnt;
				opID->u.var_idfr.no = idhash->symbol->no;
				if(idhash->symbol->SymbolType->kind == STRUCTURE)
				{
					ir.kind = DEC;
					ir.u.dec.var = opID;
					ir.u.dec.size = idhash->symbol->size;
					code1 = addIRhead(ir, code1);
				}
				
			}
			
			Operand t1 = new_temp();
			code2 = translate_Exp(root->children[2], sym_table, t1);
			
			ir.kind = ASSIGN;
			ir.u.assign.left = opID;
			ir.u.assign.right = t1;
			
			code2 = addIRhead(ir, code2);
			/*
			memset(&ir, 0, sizeof(ir));
			ir.kind = ASSIGN;
			ir.u.assign.left = place;
			ir.u.assign.right = opID;
			expIR_head = addIRhead(ir, code1);
			*/
			code1 = IRaddIR(code1, code2);
			return code1;
		}
		else if(good == 2)//exp[exp]
		{
			printf("Can't init an arrary.\n"); 
		}
		else
		{
			printf("bad good\n");
			return NULL;
		}
	}
	else
	{
		if(good == 2)
		{
			vardec = vardec->children[0];
			//printf("vardec->content: %s, vardec->name: %s\n", vardec->children[0]->children[0]->content, vardec->children[0]->children[0]->name);
			HashItem idhash = SymbolTable_Find(sym_table, vardec->children[0]->content);
			if(idhash == NULL)
			{
				printf("Error type 1 at Line %i: Undefined variable \"%s\".\n",vardec->lineno, vardec->children[0]->name);
				return NULL;
			}
			//printf("found ID[]: %s\n", idhash->symbol->name);
			Operand opID = (Operand)malloc(sizeof(struct Operand_));
			opID->kind = ADDRESS;
			opID->u.var_idfr.name = idhash->symbol->name;
		
			struct InterCode_ ir = {0};
			InterCodes code1 = NULL;
			if(idhash->symbol->no != 0)
			{
				opID->u.var_idfr.no = idhash->symbol->no;
			}
			else
			{
				idhash->symbol->no = ++variable_no_cnt;
				opID->u.var_idfr.no = idhash->symbol->no;
				ir.kind = DEC;
				ir.u.dec.var = opID;
				ir.u.dec.size = idhash->symbol->size;
				code1 = addIRhead(ir, code1);
				
			}
			return code1;
		}
		else if(good == 1)
		{
			//printf("struct dec ppppeeppee beg.\n");
			HashItem idhash = SymbolTable_Find(sym_table, vardec->children[0]->content);
			/*if(idhash == NULL)struct InterCode_
			{
				printf("Error type 1 at Line %i: Undefined variable \"%s\".\n", ID_root->lineno, ID_root->content);
				return NULL;
			}*/
			if(idhash->symbol->SymbolType->kind != STRUCTURE)
			{
				return NULL;
			}
			Operand opID = (Operand)malloc(sizeof(struct Operand_));
			opID->kind = VARI;
			opID->u.var_idfr.name = idhash->symbol->name;
		
			struct InterCode_ ir = {0};
			InterCodes code1 = NULL;
			//printf("symbolno = %i\n", idhash->symbol->no);
			if(idhash->symbol->no != 0)
			{
				opID->u.var_idfr.no = idhash->symbol->no;
			}
			else
			{
				idhash->symbol->no = ++variable_no_cnt;
				opID->u.var_idfr.no = idhash->symbol->no;
				
				//printf("idhash->symbol->SymbolType->kind = %i\n", idhash->symbol->SymbolType->kind);
				
				ir.kind = DEC;
				ir.u.dec.var = opID;
				ir.u.dec.size = idhash->symbol->size;
				code1 = addIRhead(ir, code1);
				
			}
			//printf("struct dec fin.\n");
			return code1;
		}
	}
	return NULL;
}

InterCodes translate_StmtList(Syntax_Leaf* root, HashItem* sym_table)
{
	if(root == NULL || root->children[0] == NULL)
		return NULL;
	InterCodes st = translate_Stmt(root->children[0], sym_table);
	InterCodes stls = translate_StmtList(root->children[1], sym_table);
	return IRaddIR(st, stls);
}

InterCodes translate_Stmt(Syntax_Leaf* root, HashItem* sym_table)
{
	int i = 0;
	//printf("shall we begin stmt\n");
	Syntax_Leaf* stmt = root;
	if(strcmp(stmt->children[0]->name, "Exp")==0)
	{
		//printf("shall we begin exp\n");
		return translate_Exp(stmt->children[0], sym_table, NULL);
	}
	else if(strcmp(stmt->children[0]->name,"CompSt") == 0)
	{
		return translate_CompSt(stmt->children[0], sym_table);
	}
	else if(strcmp(stmt->children[0]->name,"RETURN") == 0)
	{
		Operand t1 = new_temp();
		InterCodes code1;
		code1 = translate_Exp(stmt->children[1], sym_table, t1);
		struct InterCode_ ir = {0};
		ir.kind = RET;
		ir.u.single.op = t1;
		addIRhead(ir, code1);
		return code1;
	}
	else if(strcmp(stmt->children[0]->name, "IF") == 0)
	{
		if(stmt->childrennum == 5)
		{
			struct InterCode_ label1, label2;
			label1 = new_label();
			label2 = new_label();
			InterCodes code1, code2;
			code1 = translate_Cond(root->children[2], label1, label2, sym_table);
			code2 = translate_Stmt(root->children[4], sym_table);
			
			code1 = addIRhead(label1, code1);
			code1 = IRaddIR(code1, code2);
			code1 = addIRhead(label2, code1);
			return code1;
		}
		else//if(exp)stmt else stmt
		{
			struct InterCode_ label1, label2, label3;
			label1 = new_label();
			label2 = new_label();
			label3 = new_label();
			InterCodes code1, code2, code3;
			code1 = translate_Cond(root->children[2], label1, label2, sym_table);
			code2 = translate_Stmt(root->children[4], sym_table);
			code3 = translate_Stmt(root->children[6], sym_table);
			
			code1 = addIRhead(label1, code1);
			code1 = IRaddIR(code1, code2);
			
			struct InterCode_ ir = {0};
			ir.kind = GOTO;
			ir.u.jmp.dest_label = label3.u.label.label_no;
			code1 = addIRhead(ir, code1);
			
			code1 = addIRhead(label2, code1);
			code1 = IRaddIR(code1, code3);
			code1 = addIRhead(label3, code1);
			
			return code1;
		}
	}
	else if(strcmp(stmt->children[0]->name, "WHILE") == 0)
	{
		struct InterCode_ label1, label2, label3;
		label1 = new_label();
		label2 = new_label();
		label3 = new_label();
		InterCodes code1, code2, code3;
		code1 = translate_Cond(root->children[2], label2, label3, sym_table);
		code2 = translate_Stmt(root->children[4], sym_table);
		
		InterCodes stmtIR = NULL;
		stmtIR = addIRhead(label1, stmtIR);
		stmtIR = IRaddIR(stmtIR, code1);
		stmtIR = addIRhead(label2, stmtIR);
		stmtIR = IRaddIR(stmtIR, code2);
		
		struct InterCode_ ir = {0};
		ir.kind = GOTO;
		ir.u.jmp.dest_label = label1.u.label.label_no;
		stmtIR = addIRhead(ir, stmtIR);
		
		stmtIR = addIRhead(label3, stmtIR);
		return stmtIR;
	}
	else
	{
		printf("unknown stmt\n");
		return NULL;
	}
}

InterCodes translate_Args(Syntax_Leaf* root, HashItem* sym_table, Operands* arg_list)
{
	if(root == NULL)
	{
		return NULL;
	}
	Syntax_Leaf* exp = root->children[0];
	if(root->children[1] == NULL)//exp
	{
		Operand t1 = new_temp();
		InterCodes code1 = translate_Exp(exp, sym_table, t1);
		*arg_list  = addOperands(t1, *arg_list);
		//printf("arg end\n");
		return code1;
	}
	else
	{
		Operand t1 = new_temp();
		InterCodes code1 = translate_Exp(exp, sym_table, t1);
		*arg_list  = addOperands(t1, *arg_list);
		InterCodes code2 = translate_Args(root->children[2], sym_table, arg_list);
		return IRaddIR(code1, code2);
	}
}


InterCodes translate_Exp(Syntax_Leaf* root, HashItem* sym_table, Operand place)
{
	InterCodes expIR_head = NULL, expIR_tail = NULL;
	if(root->children[0]->type == ID_)
	{
		Syntax_Leaf* ID_root = root->children[0];
		
		if(root->children[1] == NULL)//Exp : ID
		{
			//printf("shall we begin find\n");
			HashItem idhash = SymbolTable_Find(sym_table, ID_root->content);
			/*if(idhash == NULL)struct InterCode_
			{
				printf("Error type 1 at Line %i: Undefined variable \"%s\".\n", ID_root->lineno, ID_root->content);
				return NULL;
			}*/
			//printf("found ID: %s\n", idhash->symbol->name);
			Operand opID = (Operand)malloc(sizeof(struct Operand_));
			opID->kind = VARI;
			/*if(idhash->symbol->SYmbolType->kind == STRUCTURE || idhash->symbol->SYmbolType->kind == ARRAY)
			{
				opID->kind = ADDRESS;
			}*/
			opID->u.var_idfr.name = idhash->symbol->name;
		
			if(idhash->symbol->no != 0)
			{
				opID->u.var_idfr.no = idhash->symbol->no;
			}
			else
			{
				idhash->symbol->no = ++variable_no_cnt;
				opID->u.var_idfr.no = idhash->symbol->no;
			}
			struct InterCode_ ir = {0};
			//printf("sym = %s, kind = %i\n", idhash->symbol->name, idhash->symbol->kind);
			if( idhash->symbol->SymbolType->kind == STRUCTURE || idhash->symbol->SymbolType->kind == ARRAY)
			{
				if(idhash->symbol->kind == FUNCDEFPARAM)
					ir.kind = ASSIGN;
				else
					ir.kind = _ASSIGN_AND;
			}
			else
				ir.kind = ASSIGN;
			ir.u.assign.right = opID;
			ir.u.assign.left = place;
			
			expIR_tail = addIR(ir, expIR_head, expIR_tail);
			expIR_head = expIR_tail;
			
			return expIR_head;
		}
		else if(strcmp(root->children[1]->name, "LP") == 0)//function
		{
			HashItem idhash = SymbolTable_Find(sym_table, ID_root->content);
			
			Operand opID = (Operand)malloc(sizeof(struct Operand_));
			opID->kind = FUNCNAMES;
			opID->u.var_name = idhash->symbol->name;
			
				
			if(strcmp(root->children[2]->name, "Args") == 0)//with Args
			{
				struct InterCode_ ir = {0};
				Operands arg_list = NULL;
				expIR_head = translate_Args(root->children[2], sym_table, &arg_list);
				
				//printf("\nargs translated. args func name %s\n", idhash->symbol->name);
				if(strcmp(idhash->symbol->name, "write") == 0)
				{
					
					//printf("args func 2e12e1e21 name %s\n", idhash->symbol->name);
					 ir.kind = WRITE;
					 ir.u.single.op = arg_list->op;
					 expIR_head = addIRhead(ir, expIR_head);
					 return expIR_head;
				}
				//printf("args func herarename %s\n", idhash->symbol->name);
				Operands cur = arg_list;
				memset(&ir, 0, sizeof(ir));
				while(cur != NULL)
				{
					
					ir.kind = ARG;
					ir.u.single.op = cur->op;
					expIR_head = addIRhead(ir, expIR_head);
					cur = cur->next;
				}
				memset(&ir, 0, sizeof(ir));
				//printf("Calling: func name %s\n", idhash->symbol->name);
				ir.kind = CALL;
				ir.u.assign.left = place;
				ir.u.assign.right = opID;
				expIR_head = addIRhead(ir, expIR_head);
				return expIR_head;
			}
			else
			{
				struct InterCode_ ir = {0};
				if(strcmp(idhash->symbol->name, "read") == 0)
				{
					ir.kind = READ;
					ir.u.single.op = place;
					expIR_head = addIRhead(ir, expIR_head);
					return expIR_head;
				}
				
				ir.kind = CALL;
				ir.u.assign.left = place;
				ir.u.assign.right = opID;
				expIR_head = addIRhead(ir, expIR_head);
				return expIR_head;
				
			}
		}
		else
		{
			printf("bad expression.\n");
			return NULL;
		}
	}
	else if(root->children[0]->type == INT_)
	{
		int num = atoi(root->children[0]->content);
		Operand opINT = (Operand)malloc(sizeof(struct Operand_));
		opINT->kind = CONSTANT;
		opINT->u.value = num;
		struct InterCode_ ir = {0};
		ir.kind = ASSIGN;
		ir.u.assign.right = opINT;
		ir.u.assign.left = place;
			
		expIR_tail = addIR(ir, expIR_head, expIR_tail);
		expIR_head = expIR_tail;
			
		return expIR_head;
	}
	else if(root->children[0]->type == FLOAT_)//will not happpen
	{
		printf("should be no float in program\n");	
		return NULL;
	}
	else if(root->children[0]->type == ARITH_)// MINUS Exp
	{
		//printf("shall we begin sub\n");
		Operand t1 = new_temp();
		InterCodes code1 = translate_Exp(root->children[1], sym_table, t1);
		
		struct InterCode_ ir = {0};
		ir.kind = SUB;
		ir.u.binop.result = place;
		ir.u.binop.op1 = getConstant(0);
		ir.u.binop.op2 = t1;
		
		//printf("sub to added code1%p\n", code1);
		code1 = addIRhead(ir, code1);
		//printf("sub added code1%p\n", code1);
		return code1;
	}
	else if(root->children[0]->type == LEX_)//NOT Exp
	{ 	
		if(strcmp(root->children[0]->name, "LP") == 0)//(exp)
		{
			return translate_Exp(root->children[1], sym_table, place);
		}
		struct InterCode_ label1 = new_label();
		struct InterCode_ label2 = new_label();
			
		struct InterCode_ ir = {0};
		ir.kind = ASSIGN;
		ir.u.assign.left = place;
		ir.u.assign.right = getConstant(0);
			
		InterCodes code0 = addIR(ir, expIR_head, expIR_tail);
			
		InterCodes code1 = translate_Cond(root, label1, label2, sym_table);
			
		expIR_head = IRaddIR(expIR_head, code1);
		
		expIR_head = addIRhead(label1, expIR_head);
		
		memset(&ir, 0, sizeof(ir));
		ir.u.assign.left = place;
		ir.u.assign.right = getConstant(1);
		expIR_head = addIRhead(ir, expIR_head);
			
		expIR_head = addIRhead(label2, expIR_head);
			
		return expIR_head;
	}
	else if(root->children[0]->type == TOKEN_)//Exp : Exp ...
	{
		Syntax_Leaf* exp1_root = root->children[0], *exp2_root = root->children[2];
		if(strcmp(root->children[1]->name, "LB") == 0)//exp[exp]
		{
			if(exp1_root->children[0]->type != ID_)
			{
				//printf("exp1: %s, exp2:%s\n", exp1_root->children[0]->content, exp2_root->children[0]->content);
				printf("can't translate: code contains variables of multi-dimensional array types.\n");
				return NULL;
			}
			HashItem idhash = SymbolTable_Find(sym_table, exp1_root->children[0]->content);
			/*if(idhash == NULL)struct InterCode_
			{
				printf("Error type 1 at Line %i: Undefined variable \"%s\".\n", ID_root->lineno, ID_root->content);
				return NULL;
			}*/
			//printf("found ID[]: %s\n", idhash->symbol->name);
			Operand opID = (Operand)malloc(sizeof(struct Operand_));
			opID->kind = ADDRESS;
			opID->u.var_idfr.name = idhash->symbol->name;
		
			struct InterCode_ ir = {0};
			
			if(idhash->symbol->no != 0)
			{
				opID->u.var_idfr.no = idhash->symbol->no;
			}
			else
			{
				idhash->symbol->no = ++variable_no_cnt;
				opID->u.var_idfr.no = idhash->symbol->no;
				ir.kind = DEC;
				ir.u.dec.var = opID;
				ir.u.dec.size = idhash->symbol->size;
				expIR_head = addIRhead(ir, expIR_head);
			}
			
			Operand t1 = new_temp();
			printf("to deal exp2: %s, content: %s\n", exp2_root->name, exp2_root->children[0]->content);
			InterCodes code1 = translate_Exp(exp2_root, sym_table, t1);
			expIR_head = IRaddIR(expIR_head, code1);
			
			ir.kind = MUL;
			ir.u.binop.result = t1;
			ir.u.binop.op1 = t1;
			ir.u.binop.op2 = getConstant(4);
			expIR_head = addIRhead(ir, expIR_head);
			//IRtablePrint(stdout, expIR_head);
			
			memset(&ir, 0, sizeof(ir));
			
			//int num = atoi(exp2_root->children[0]->content);
			//printf("num: %i, content: %s\n", num, exp2_root->children[0]->content);
			
			Operand t2 = new_temp();
			ir.kind = ADDR_ADD_VAR;
			ir.u.binop.result = t2;
			ir.u.binop.op1 = opID;
			ir.u.binop.op2 = t1;
			
			expIR_head = addIRhead(ir, expIR_head);
			
			memset(&ir, 0, sizeof(ir));
			
			if(place == NULL)
				return expIR_head;
			else if(place->kind == TEMPADDRESS)
			{
				ir.kind = ASSIGN;
			}
			else
			{
				ir.kind = _ASSIGN_STAR;
			}
			ir.u.assign.left = place;
			ir.u.assign.right = t2;
			expIR_head = addIRhead(ir, expIR_head);
			return expIR_head;
		}
		else if(strcmp(root->children[1]->name, "DOT") == 0)//Exp : Exp DOT ID
		{
			Operand t1 = new_temp();
			t1->kind = TEMPADDRESS;
			Operand t2 = new_temp();
			t2->kind = TEMPADDRESS;
			
			InterCodes code1 = translate_Exp(exp1_root, sym_table, t2);
			
			HashItem idhash = SymbolTable_Find(sym_table, root->children[2]->content);
			//printf("found FIELD: %s\n", idhash->symbol->name);
			
			expIR_head = IRaddIR(expIR_head, code1);
			
			struct InterCode_ ir = {0};
			ir.kind = ADD;
			ir.u.binop.result = t1;
			ir.u.binop.op1 = t2;
			ir.u.binop.op2 = getConstant(idhash->symbol->offset);
			
			expIR_head = addIRhead(ir, expIR_head);
			
			memset(&ir, 0, sizeof(ir));
			
			if(place == NULL)
				return expIR_head;
			else if(place->kind == TEMP)
				ir.kind = _ASSIGN_STAR;
			else
				ir.kind = ASSIGN;
			ir.u.assign.left = place;
			ir.u.assign.right = t1;
			expIR_head = addIRhead(ir, expIR_head);
			
			return expIR_head;
		}
		else if(root->children[1]->type == ASSIGNOP_ )
		{
			int good = 0;
			if(exp1_root->children[0]->type == ID_&&exp1_root->children[1] == NULL)//exp is ID, not func
			{
				good = 1;
			}
			else if((strcmp(exp1_root->children[0]->name, "Exp") == 0)&&(strcmp(exp1_root->children[1]->name, "LB") == 0)&&(strcmp(exp1_root->children[2]->name, "Exp") == 0)&&(strcmp(exp1_root->children[3]->name, "RB") == 0))//exp[exp]
			{
				good = 2;
			}
			else if((strcmp(exp1_root->children[0]->name, "Exp") == 0)&&(strcmp(exp1_root->children[1]->name, "DOT") == 0)&&(strcmp(exp1_root->children[2]->name, "ID") == 0))//exp.id
			{
				good = 3;
			}
			if(good == 1)//exp1->ID
			{
				//printf("shall we begin fijnd?\n");
				HashItem idhash = SymbolTable_Find(sym_table, exp1_root->children[0]->content);
			/*if(idhash == NULL)struct InterCode_
			{
				printf("Error type 1 at Line %i: Undefined variable \"%s\".\n", ID_root->lineno, ID_root->content);
				return NULL;
			}*/
				Operand opID = (Operand)malloc(sizeof(struct Operand_));
				opID->kind = VARI;
				opID->u.var_name = idhash->symbol->name;
			
				Operand t1 = new_temp();
				
				//printf("exp2 to added\n");
				InterCodes code1 = translate_Exp(exp2_root, sym_table, t1);
				
				//printf("exp2 added\n");
				struct InterCode_ ir = {0};
				ir.kind = ASSIGN;
				ir.u.assign.left = opID;
				ir.u.assign.right = t1;
			
				code1 = addIRhead(ir, code1);
				
				
				memset(&ir, 0, sizeof(ir));
				ir.kind = ASSIGN;
				ir.u.assign.left = place;
				ir.u.assign.right = opID;
				
				expIR_head = addIRhead(ir, code1);
				//printf("assigdn added\n");
				return expIR_head;
			}
			else if(good == 2)//exp[exp]
			{
				
				Operand t1 = new_temp();
				t1->kind = TEMPADDRESS;
				Operand t2 = new_temp();	
				
				InterCodes code1 = translate_Exp(exp2_root, sym_table, t2);
				
				InterCodes code2 = translate_Exp(exp1_root, sym_table, t1);
				
				code1 = IRaddIR(code1, code2);
				struct InterCode_ ir = {0};
				
				ir.kind = STAR_ASSIGN_;
				ir.u.assign.left = t1;
				ir.u.assign.right = t2;
				
				expIR_head = addIRhead(ir, code1);
				
				memset(&ir, 0, sizeof(ir));
				ir.kind = STAR_ASSIGN_;
				ir.u.assign.left = place;
				ir.u.assign.right = t2;
				
				expIR_head = addIRhead(ir, expIR_head);
				//printf("assigdn added\n");
				return expIR_head;
			}
			else if(good == 3)//exp.id
			{
				Operand t1 = new_temp();
				t1->kind = TEMPADDRESS;
				Operand t2 = new_temp();
				
				InterCodes code1 = translate_Exp(exp2_root, sym_table, t2);
				
				InterCodes code2 = translate_Exp(exp1_root, sym_table, t1);
				
				code1 = IRaddIR(code1, code2);
				struct InterCode_ ir = {0};
				
				ir.kind = STAR_ASSIGN_;
				ir.u.assign.left = t1;
				ir.u.assign.right = t2;
				
				expIR_head = addIRhead(ir, code1);
				
				memset(&ir, 0, sizeof(ir));
				ir.kind = ASSIGN;
				ir.u.assign.left = place;
				ir.u.assign.right = t2;
				
				expIR_head = addIRhead(ir, expIR_head);
				//printf("assigdn added\n");
				return expIR_head;
			}
			else
			{
				printf("bad good\n");
				return NULL;
			}
		}
		else if(root->children[1]->type == LOGICAL_)//only int
		{
			//printf("logical begin\n");
			struct InterCode_ label1 = new_label();
			struct InterCode_ label2 = new_label();
			
			struct InterCode_ ir = {0};
			ir.kind = ASSIGN;
			ir.u.assign.left = place;
			ir.u.assign.right = getConstant(0);
			
			InterCodes code0 = addIR(ir, expIR_head, expIR_tail);
			
			InterCodes code1 = translate_Cond(root, label1, label2, sym_table);
			
			expIR_head = IRaddIR(expIR_head, code1);
		
			expIR_head = addIRhead(label1, expIR_head);
			
			memset(&ir, 0, sizeof(ir));
			ir.u.assign.left = place;
			ir.u.assign.right = getConstant(1);
			expIR_head = addIRhead(ir, expIR_head);
			
			expIR_head = addIRhead(label2, expIR_head);
			
			return expIR_head;
		}
		else if(root->children[1]->type == ARITH_)
		{
			Operand t1 = new_temp();
			Operand t2 = new_temp();
			InterCodes code1 = translate_Exp(exp1_root, sym_table, t1);
			InterCodes code2 = translate_Exp(exp2_root, sym_table, t2);
			
			code1 = IRaddIR(code1, code2);
			
			struct InterCode_ ir = {0};
			ir.u.binop.result = place;
			ir.u.binop.op1 = t1;
			ir.u.binop.op2 = t2;
			
			if(strcmp(root->children[1]->name, "PLUS") == 0)
				ir.kind = ADD;
			else if(strcmp(root->children[1]->name, "MINUS") == 0)
				ir.kind = SUB;
			else if(strcmp(root->children[1]->name, "STAR") == 0)
				ir.kind = MUL;
			else if(strcmp(root->children[1]->name, "DIV") == 0)
				ir.kind = DIVIDE;
			else 
				ir.kind = ADD;
			
			expIR_head = addIRhead(ir, code1);
			return expIR_head;
		}
		else
		{
			printf("unknown expression : Exp : %s %s %s \n", root->children[0]->name, root->children[1]->name, root->children[2]->name);
			return NULL;
		}
	}
	else
	{
		//printf("here?Exp type = %i\n",root->children[0]->type);
		printf("unknown expression : Exp : %s %s %s \n", root->children[0]->name, root->children[1]->name, root->children[2]->name);
		return NULL;
	}
	printf("using finall return\n");
	return expIR_head;
}

InterCodes translate_Cond(Syntax_Leaf* root, struct InterCode_ label_true, struct InterCode_ label_false, HashItem* sym_table)
{
	printf("cond begin root %s\n", root->name);
	if(root->children[0]->type == LEX_)//NOT exp
	{
		return translate_Cond(root->children[1], label_false, label_true, sym_table);
	}
	else 
	{
		printf("child1 name%s\n", root->children[1]->name);
		Syntax_Leaf* exp1 = root->children[0], *exp2 = root->children[2];
		if(strcmp(root->children[1]->name, "RELOP")==0)
		{	
			Operand t1 = new_temp();
			Operand t2 = new_temp();
			InterCodes code1, code2;
			code1 = translate_Exp(exp1, sym_table, t1);
			code2 = translate_Exp(exp2, sym_table, t2);
			Operand relop = getRelop(root->children[1]->content);
			struct InterCode_ ir = {0};
			ir.kind = IFGOTO;
			ir.u.condjmp.op1 = t1;
			ir.u.condjmp.op2 = t2;
			ir.u.condjmp.rel = relop;
			ir.u.condjmp.dest_label = label_true.u.label.label_no;
			code1 = IRaddIR(code1, code2);
			code1 = addIRhead(ir, code1);
			
			memset(&ir, 0, sizeof(ir));
			ir.kind = GOTO;
			ir.u.jmp.dest_label = label_false.u.label.label_no;
			code1 = addIRhead(ir, code1);
			
			printf("relop done\n");
			return code1;
		}
		else if(strcmp(root->children[1]->name, "AND")==0)
		{
			struct InterCode_ label1 = new_label();
			InterCodes code1, code2;
			code1 = translate_Cond(exp1, label1, label_false, sym_table);
			code2 = translate_Cond(exp2, label_true, label_false, sym_table);
			
			code1 = addIRhead(label1, code1);
			return IRaddIR(code1, code2);
		}
		else if(strcmp(root->children[1]->name, "OR")==0)
		{
			struct InterCode_ label1 = new_label();
			InterCodes code1, code2;
			code1 = translate_Cond(exp1, label_true, label1, sym_table);
			code2 = translate_Cond(exp2, label_true, label_false, sym_table);
			
			code1 = addIRhead(label1, code1);
			return IRaddIR(code1, code2);
		}
		else
		{
			Operand t1 = new_temp();
			InterCodes code1, code2;
			code1 = translate_Exp(root, sym_table, t1);
			struct InterCode_ ir = {0};
			ir.kind = IFGOTO;
			ir.u.condjmp.op1 = t1;
			ir.u.condjmp.op2 = getConstant(0);
			ir.u.condjmp.rel = getRelop("!=");
			ir.u.condjmp.dest_label = label_true.u.label.label_no;
			code1 = addIRhead(ir, code1);
			
			memset(&ir, 0, sizeof(ir));
			ir.kind = GOTO;
			ir.u.jmp.dest_label = label_false.u.label.label_no;
			code1 = addIRhead(ir,code1);
			return code1;
		}
	}
}
