#include<stdio.h>
#include <stdlib.h>
#include <string.h>
#include"syntax.tab.h"
#include"symbol_table.h"
#include"IR.h"

extern FILE* yyin;
FILE* global_stream;
#include"syntax_tree.h"
#include"objectcode.h"


/*
typedef struct Syntax_Leaf
{
	char* name;
	int lineno;
	int type;
		
	int childrennum;
	struct Syntax_Leaf* children[7];
	struct Syntax_Leaf* father;
	char content[32];
}Syntax_Leaf;
Syntax_Leaf* Syntax_Root;
*/

Syntax_Leaf* Syntax_Leaf_New(char* Name, int LineNo, int Type)
{
	Syntax_Leaf* leaf = (Syntax_Leaf*)malloc(sizeof(Syntax_Leaf));
	memset(leaf, 0, sizeof(Syntax_Leaf));
	
	leaf->name = Name;
	leaf->lineno = LineNo;
	leaf->type = Type;
	
	return leaf;
}
	

void Syntax_Tree_Print(Syntax_Leaf* root)
{
	if(root == NULL)
		return;
	int i = 0, j = 0;
	static int indentation = 0;
	while(j < indentation)
	{
		printf("  ");
		j++;
	}
	
	if(root->type == ID_ || root->type == TYPE_ || root->type == INT_ || root->type == FLOAT_)
		printf("%s: %s\n", root->name, root->content);
	else if(root->type == LEX_)
		printf("%s\n", root->name);
	else
		printf("%s (%d)\n", root->name, root->lineno);
	
	
	//if(root->type == ID_ || root->type == TYPE_ || root->type == INT_ || root->type == FLOAT_)
		//printf("%s (%d): %s", root->name, root->lineno, root->content);
	//else
		//printf("%s (%d)", root->name, root->lineno);
	//if(strcmp(root->name, "ExtDefList") == 0)
		//printf("father is %s, name: %s, number: %d\n", root->father, root->name, root->childrennum);
	
	//printf("children: %d\n", root->childrennum);
	
	indentation++;
	while(i < root->childrennum)
	{
		if(root->children[i] == NULL)
		{
			i++;
			continue;
		}
		//printf(	"i = %d, num = %d\n", i, root->childrennum);
		//if(strcmp(root->children[i]->name, "ExtDefList") == 0)
			//printf("father is %s, i = %d, name: %s, number: %d\n", root->name, i, root->children[i]->name, root->childrennum);
		//if(strcmp(root->name, "Program") == 0)
			//printf("father is %s, i = %d, name: %s, number: %d\n", root->name, i, root->children[i]->name, root->childrennum);
		//if(strcmp(root->children[i]->name, "ExtDefList")==0)
			//printf("I'm printing ExtDefList, I'm %s, i = %d, num = %d\n", root->name, i, root->childrennum);
		
		Syntax_Tree_Print(root->children[i++]);
	}
	indentation--;
	//if(strcmp(root->name, "Program") == 0)
		//printf("This should be the end.\n");
}

void Syntax_Tree_Free(Syntax_Leaf* root)
{
	int i = 0;
	while(root->children[i] != NULL)
	{
		
		Syntax_Tree_Free(root->children[i++]);
	}
	free(root);
}

int main(int argc, char** argv)
{
	if (argc <=1) return 1;
	FILE* f = fopen(argv[1], "r");
	if(!f)
	{
		perror(argv[1]);
		return 1;
	}
	yyrestart(f);
	int rec = yyparse();
	//printf("return = %d\n", rec);
	if(tree_error != 1)
	{	
		Syntax_Tree_Print(Syntax_Root);
		
		AddReadWrite(symbol_table);
		SymbolTable_Create(Syntax_Root);
		SymbolTable_Print(symbol_table, 1);
		
		InterCodes IRtable = translate_Program(Syntax_Root, symbol_table);
		IRtablePrint(stdout, IRtable);
		
		if(argc > 3)
		{
			global_stream = stdout;
			GenerateObjectCode(IRtable);
		}
		
		if(argc <= 2)
		{
			Syntax_Tree_Free(Syntax_Root);
			return 1;
		}
		
		FILE* f = fopen(argv[2], "w");
		if(!f)
		{
			perror(argv[2]);
			return 1;
		}
		else
		{
			global_stream = f;
			GenerateObjectCode(IRtable);
		}
		if(argc <= 3)
		{
			Syntax_Tree_Free(Syntax_Root);
			return 0;
		}
		
		FILE* f2 = fopen(argv[3], "w");
		if(!f2)
		{
			global_stream = stdout;
		}
		else
		{
			global_stream  = f2;
			GenerateObjectCode(IRtable);
		}
		
		Syntax_Tree_Free(Syntax_Root);
	}
	return 0;
}
