lexer grammar GraphqlLexer;

@header {
// @formatter:off
package com.arakelian.graphql.parser;
}

channels { 
	WHITESPACE_CHANNEL
}

//
// Token
//

BooleanValue: 'true' | 'false';

FRAGMENT : 'fragment';
QUERY : 'query';
MUTATION : 'mutation';
SCHEMA : 'schema';
SCALAR : 'scalar';
TYPE : 'type';
INTERFACE : 'interface';
IMPLEMENTS : 'implements';
ENUM : 'enum';
UNION : 'union';
INPUT : 'input';
EXTEND : 'extend';
DIRECTIVE : 'directive';
ON : 'on'; // must come before NAME
NAME : [_A-Za-z][_0-9A-Za-z]*;

IntValue : Sign? IntegerPart;

FloatValue : Sign? IntegerPart ('.' Digit*)? ExponentPart?;

Sign : '-';

IntegerPart : '0' | NonZeroDigit | NonZeroDigit Digit+;

NonZeroDigit: '1'.. '9';

ExponentPart : ('e'|'E') Sign? Digit+;

Digit : '0'..'9';

StringValue: '"' (~(["\\\n\r\u2028\u2029])|EscapedChar)* '"';

fragment EscapedChar :   '\\' (["\\/bfnrt] | Unicode) ;

fragment Unicode : 'u' Hex Hex Hex Hex;

fragment Hex : [0-9a-fA-F];

Ignored: (Whitespace|Comma|LineTerminator) -> channel(WHITESPACE_CHANNEL);

fragment LineTerminator: [\n\r\u2028\u2029];

fragment Whitespace : [\t\u000b\f\u0020\u00a0];

fragment Comma : ',';

LPAREN : '(';
RPAREN : ')';
COLON : ':';
DOLLAR : '$';
EQUALS : '=';
LBRACE : '{';
RBRACE : '}';
SPREAD : '...';
LBRACKET : '[';
RBRACKET : ']';
AT : '@';
VERTICAL_BAR : '|';
EXCLAMATION : '!';

// lowest priority
Comments: Comment -> channel(WHITESPACE_CHANNEL);
 
fragment Comment: '#' ~[\n\r\u2028\u2029]*;
