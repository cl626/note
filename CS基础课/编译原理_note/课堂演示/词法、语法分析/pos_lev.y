%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>
   
typedef struct{
  int pos;
  int lev;
}T;

#define YYSTYPE T

%}


%%
Start : N  L {printf("\n\n");}
      ;
N     : {$$.pos = 1; $$.lev = 0;}
      ;
L : S {$$.pos = $1.pos;}
  | L ',' M  S {$$.pos = $4.pos;}
  ;
M : {$$.pos = ($-1).pos + 1;$$.lev = ($-2).lev;}
  ;
S : '(' K L ')' {$$.pos = $3.pos + 1;}
  | 'a' {
         printf(" a pos@ %3d : lev@ %3d\n", ($0).pos,($0).lev); 
         $$.pos = ($0).pos + 1;
        }
K : {$$.pos = ($-1).pos + 1;$$.lev = ($-1).lev+1;}
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
