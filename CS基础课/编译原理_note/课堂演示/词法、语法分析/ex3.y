%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>
   #include "typex.h"
   #define YYSTYPE  Sym
   
   
%}

%token	number

%left '+' '-'

%left '*' '/'

%right UMINUS

%%

Lines : Lines Expr '\n'{ if ( $2.TYPE == INT ) printf(" the INT expr value is %d\n", $2.i);
			 else printf(" The value is %lf\n", $2.d);
		       }
      | Lines '\n'
      |  /* empty production */
      | error '\n' { printf("\n Error! Input again!\n"); 
      		    /* when error occurs, skip to newline */ 
     		    yyerrok;
       		   }
      ;

Expr : Expr '+' Expr { if ( ($1.TYPE == INT) && ( $3.TYPE == INT ) ) {
			 $$.TYPE = INT; $$.i = $1.i + $3.i; 
		       }
		       else {
		         $$.TYPE = FLOAT;
			 
			 if ( $1.TYPE == INT ) $1.d = (double) $1.i;
                         if ( $3.TYPE == INT ) $3.d = (double) $3.i;
			 
			 $$.d = $1.d + $3.d; 
		       }
		     } 
     | Expr '-' Expr { if ( ($1.TYPE == INT) && ( $3.TYPE == INT ) ) {
			 $$.TYPE = INT; $$.i = $1.i - $3.i; 
		       }
		       else {
                         
			 $$.TYPE = FLOAT;
			 
			 if ( $1.TYPE == INT ) $1.d = (double) $1.i;
                         if ( $3.TYPE == INT ) $3.d = (double) $3.i;

		         $$.d = $1.d - $3.d; 
		       }
		     }
     | Expr '*' Expr { if ( ($1.TYPE == INT) && ( $3.TYPE == INT ) ) {
			 $$.TYPE = INT; $$.i = $1.i * $3.i; 
		       }
		       else {
		         $$.TYPE = FLOAT; 
			 
			 if ( $1.TYPE == INT ) $1.d = (double) $1.i;
                         if ( $3.TYPE == INT ) $3.d = (double) $3.i;

			 $$.d = $1.d * $3.d; 
		       }
		     }
     | Expr '/' Expr { if ( ($1.TYPE == INT) && ( $3.TYPE == INT ) ) {
     		         if ( $3.i==0) {
     			   printf("divided by ZERO\n");
     			   exit(1);
     			 } 
     		         $$.TYPE = INT; $$.i = $1.i / $3.i; 
		       }
		       else {
		         if ( $3.d==0.0) {
     			   printf("divided by ZERO\n");
     			   exit(1);
     			 }
		         $$.TYPE = FLOAT; 
  		         
			 if ( $1.TYPE == INT ) $1.d = (double) $1.i;
                         if ( $3.TYPE == INT ) $3.d = (double) $3.i;

			 $$.d = $1.d / $3.d; 
		       }
		     }
     | '(' Expr ')' { $$ = $2; }
     | '-' Expr %prec UMINUS { 
				$$.TYPE  = $2.TYPE;
				if ( $2.TYPE == INT ) $$.i = - $2.i;
				else $$.d = - $2.d;
			     }
     | number
     ;

%%

int main()
{
   printf("Press Ctrl-D to exit\n");
   return yyparse();
}

void yyerror(char *s)
{
   printf("%s\n", s ); 
}

