%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>

typedef struct{
    int v;
    int pow;
}T;

/*
ע�⣬��Է��ս��L������������ۺ����� L.v �� L.pow
���ս�� B ʹ��һ�����ɣ���B.v

*/

#define YYSTYPE T

%}


%%

S    : L { printf(" the value is %d\n", $1.v);}
     ;
L    : B   L {
             $$.v   = ($1.v << $2.pow) + $2.v;
             $$.pow = $2.pow + 1;
             printf("$1.v = %d $2.pow = %d $2.v = %d\n",$1.v,$2.pow,$2.v);
             }
     | B    {$$.v = $1.v; $$.pow = 1;} 
     ;
B    : '0' {$$.v = 0; }
     | '1' {$$.v = 1; }
     ;
%%

int yylex()
{
   int c;
   while ( ( c=getchar() ) == ' ' ) ;
   if ( c=='\n' ) return 0; // return EOF -- $
   return c;
}

int main()
{
   return yyparse();
}

void yyerror(char *s)
{
   printf("%s\n", s ); 
}

int yywrap()
{ return 1; }        		    
