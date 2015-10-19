/* scanner for a toy Pascal-like language */

%{
/* need this for the call to atof() below */
#include <math.h>
%}

digit           [0-9]
int             {digit}+
id              [A-Za-z][A-Za-z0-9]*
real            {int}"."{int}([eE][+-]?{int})?

%%

{int}            printf( "An integer: %s (%d)\n", yytext, atoi( yytext ) );

{real}           printf( "A real: %s (%g)\n", yytext, atof( yytext ) );

if|then|begin|end|procedure|function        {
                     printf( "A keyword: %s\n", yytext );
                 }

{id}             printf( "An identifier: %s\n", yytext );

"+"|"-"|"*"|"/"  printf( "An operator: %s\n", yytext );

"{"[^}\n]*"}"    /* eat up one-line comments */

[ \t\n]+         /* eat up whitespace */

.                printf( "Unrecognized character: %s\n", yytext );

%%

main( int argc, char **argv )
{
    ++argv, --argc;     /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;

    yylex();
}
