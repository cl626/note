%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>
   
   typedef  struct {
   	int val; /* value for binary  */
   	int len; /* len   for binary  */
   } Sym ;
   #define YYSTYPE  Sym
%}

%%

S    : L '.' L { printf(" the value is %f\n",$1.val + ($3.val+0.0) / (1 << $3.len));}
     | L { printf(" the value is %d\n",$1.val;}
     ;
L    : L  B {
             $$.val = $1.val * 2 + $2.val;
             $$.len = $1.len + 1;
            }
     | B { $$.val = $1.val; $$.len = 1;}    
     ;
B    : '0' {$$.val = 0;$$.len = 1;}
     | '1' {$$.val = 1;$$.len = 1;}
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
