%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>

typedef struct{
    int v;
    int pow;
}T;

/*
注意，针对非终结符L，设计了两个综合属性 L.v 和 L.pow
非终结符 B 使用一个即可，即B.v

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
