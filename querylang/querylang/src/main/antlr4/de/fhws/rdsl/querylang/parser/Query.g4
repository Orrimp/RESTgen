grammar Query;
 
// Parser Rules

expressions : expression (';' expression)*;
expression: term ('||' term)* ;
term: factor ('&&' factor)* ;
factor: call | parens ;
call: path ('(' args? ')')? ;
path: ID ('.' ID)* ;
parens : '(' expression ')';
args: arg (',' arg)*;
arg: (INT | FLOAT | TRUE | FALSE | NULL | QUOTED_STRING | expression);
 
fragment DIGIT : '0'..'9' ;
INT : DIGIT+;
FLOAT : DIGIT+ '.' DIGIT* | '.' DIGIT+;
TRUE: ('true'|'TRUE');
FALSE: ('false'|'FALSE');
NULL: ('null'|'NULL');
ID : ('a'..'z'|'1'..'2'|'A'..'Z')+ ;
fragment ESCAPED_QUOTE : '\\"' | '\\\\';
QUOTED_STRING :   '"' ( ESCAPED_QUOTE | ~('\n'|'\r') )*? '"';
WHITESPACE : ( '\t' | ' ' | '\r' | '\n'| '\u000C' )+ -> skip ;