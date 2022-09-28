   typedef  struct {
   	int TYPE;
   	union {
   	   int i; /* value for int type */
   	   double d; /* value for float type */
   	};
   } Sym ;
   
   #define INT	    1
   #define FLOAT    0
   
