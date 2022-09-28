%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>
   
   #define YYSTYPE  double
%}

%token	number

%left '+' '-'

%left '*' '/'

%right UMINUS

%%

Lines : Lines Expr '\n'{ printf(" the value is %f\n", $2);}
      | Lines '\n'
      |  /* empty production */
      | error '\n' { printf("\n Error! Input again!\n"); 
      		    /* when error occurs, skip to newline */ 
     		    yyerrok;
       		   }
      ;

Expr : Expr '+' Expr { $$ = $1 + $3; } 
     | Expr '-' Expr { $$ = $1 - $3; }
     | Expr '*' Expr { $$ = $1 * $3; }
     | Expr '/' Expr { if ( $3==0) {
     			   printf("divided by ZERO\n");
     			   exit(1);
     			 } else  $$ = $1 / $3; 
     		     }
     | '(' Expr ')' { $$ = $2; }
     | '-' Expr %prec UMINUS { $$ = - $2; }
     | number
     ;

%%

int yylex()
{
   int c;
   while ( ( c=getchar() ) == ' ' ) ;
   if ( isdigit(c) ) {
   	ungetc( c, stdin );
   	scanf("%lf", &yylval); // value for token
   	return number;
   }
   return c;
}

int main()
{
   printf("Press Ctrl-D to exit\n");
   return yyparse();
}

void yyerror(char *s)
{
   printf("%s\n", s ); 
}

int yywrap()
{ return 1; }        		    