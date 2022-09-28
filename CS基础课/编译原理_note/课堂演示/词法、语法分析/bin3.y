%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>
   
/*
S-> M {L.i = M.s } L {S.a = L.s}
L-> {L1.i = L.i + 1} L1 {N.i = L.i} N {B.i = N.s} B { L.s = L1.s + B.s}
L-> {B.i = L.i } B {L.s = B.s}
B->0 {B.s = 0}
B->1 {B.s = 1 << B.i} 
M-> {M.s = 0}
N-> {N.s = N.i}
*/   
   
%}

%%

S    : M L { printf(" the binaray string value is %d\n", $2);}
     ;
M    : {$$ = 0;}
		 ;
L    : L N B {$$ = $1  + $3;}
     | B      
     ;
N    : {$$ = ($-1);}
     ;
B    : '0' {$$ = 0;}
     | '1' {$$ = 1 << ($0);}
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
