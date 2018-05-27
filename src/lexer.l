%x IN_COMMENT 

%{
    #include "parser.tab.h"
    extern int line_number;

    void yyerror(char const *s) {
      fprintf(stderr, "line %d: %s\n", line_number, s);
    }
 
    extern char* yytext;
%}
%option noyywrap    

%%

<INITIAL>"/*"         {BEGIN(IN_COMMENT);}
<IN_COMMENT>"*/"      {BEGIN(INITIAL);}
<IN_COMMENT>[^*\n]+   ;
<IN_COMMENT>"*"       ;
<IN_COMMENT>\n        {line_number++;}
<IN_COMMENT><<EOF>>   {
                        printf("UNTERMINATED COMMENT AT line %d!", line_number);
                        yyterminate();
                      }

"if"                        return IF;
"else"                      return ELSE;
"int"                       return INT;
"return"                    return RETURN;
"void"                      return VOID;
"while"                     return WHILE;
"+"                         return PLUS;
"-"                         return MINUS;
"*"                         return MULTIPLY;
"/"                         return DIVIDE;
"<="                        return LESS_OR_EQUAL;
"<"                         return LESS_THAN;                     
">="                        return GREATER_OR_EQUAL;
">"                         return GREATER_THAN;
"=="                        return EQUALS;
"!="                        return NOT_EQUALS;
"="                         return ASSIGNMENT;
";"                         return EOL;
","                         return COMMA;
"{"                         return LEFT_PARANTHESIS;
"}"                         return RIGHT_PARANTHESIS;
"("                         return LEFT_BRACKET;
")"                         return RIGHT_BRACKET;
"["                         return LEFT_SQR_BRACKET;
"]"                         return RIGHT_SQR_BRACKET;
[a-zA-Z][a-zA-Z]*           return ID;
[0-9][0-9]*                 return NUM;
[ \t\r]+                    ;
[\n]                        {line_number++;}
[a-zA-Z0-9]+                yyerror("Identifier must consist only alphabetical characters!");
[*][/]                      yyerror("not initialized comment!");
.                           yyerror("Error in Syntax!");


