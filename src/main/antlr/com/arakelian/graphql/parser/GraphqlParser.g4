parser grammar GraphqlParser;

@header {
// @formatter:off
package com.arakelian.graphql.parser;
}

options {tokenVocab = GraphqlLexer;}

//
// Document 
//

document : query | typeSystem;

query : queryDefinition+;

queryDefinition:
	operationDefinition |
	fragmentDefinition;

operationDefinition:
	selectionSet |
	operationType  name? variableDefinitions? directives? selectionSet;

operationType : MUTATION | QUERY;

variableDefinitions : '(' variableDefinition+ ')';

variableDefinition : variable ':' type defaultValue?;

variable : '$' name;

defaultValue : '=' value;


//
// Operations
//

selectionSet :  '{' selection+ '}';

selection : field | fragmentSpread | inlineFragment;

field : alias? name arguments? directives? selectionSet?;

alias : name ':';

arguments : '(' argument+ ')';

argument : name ':' valueWithVariable;


//
// Fragments
//

fragmentSpread : '...' fragmentName directives?;

inlineFragment : '...' typeCondition? directives? selectionSet;

fragmentDefinition : 'fragment' fragmentName typeCondition directives? selectionSet;

fragmentName :  name;

typeCondition : 'on' namedType;


//
// Value
//

name: NAME | FRAGMENT | QUERY | MUTATION | SCHEMA | SCALAR | TYPE | INTERFACE | IMPLEMENTS | ENUM | UNION | INPUT | EXTEND | DIRECTIVE;

value :
	IntValue |
	FloatValue |
	StringValue |
	BooleanValue |
	enumValue |
	arrayValue |
	objectValue;

valueWithVariable :
	variable |
	IntValue |
	FloatValue |
	StringValue |
	BooleanValue |
	enumValue |
	arrayValueWithVariable |
	objectValueWithVariable;


enumValue : name ;


//
// Array Value
//

arrayValue: '[' value* ']';

arrayValueWithVariable: '[' valueWithVariable* ']';


//
// Object Value
//

objectValue : '{' objectField* '}';

objectValueWithVariable : '{' objectFieldWithVariable* '}';

objectField : name ':' value;

objectFieldWithVariable : name ':' valueWithVariable;


//
// Directives
//

directives : directive+;

directive :'@' name arguments?;


//
// Types
//

type : namedType | listType | nonNullType;

namedType : name;

listType : '[' type ']';

nonNullType: namedType '!' | listType '!';


//
// Type System
//

typeSystem : typeSystemDefinition+;
	
typeSystemDefinition:
	schemaDefinition |
	typeDefinition |
	typeExtensionDefinition |
	directiveDefinition
;

schemaDefinition : SCHEMA directives? '{' operationTypeDefinition+ '}';

operationTypeDefinition : operationType ':' namedType;

typeDefinition:
	scalarTypeDefinition |
	objectTypeDefinition |
	interfaceTypeDefinition |
	unionTypeDefinition |
	enumTypeDefinition |
	inputObjectTypeDefinition;

scalarTypeDefinition : SCALAR name directives?;

objectTypeDefinition : TYPE name implementsInterfaces? directives? '{' fieldDefinition+ '}';

implementsInterfaces : IMPLEMENTS namedType+;

fieldDefinition : name argumentsDefinition? ':' type directives?;

argumentsDefinition : '(' inputValueDefinition+ ')';

inputValueDefinition : name ':' type defaultValue? directives?;

interfaceTypeDefinition : INTERFACE name directives? '{' fieldDefinition+ '}';

unionTypeDefinition : UNION name directives? '=' unionMembers;

unionMembers: namedType | unionMembers '|' namedType;

enumTypeDefinition : ENUM name directives? '{' enumValueDefinition+ '}';

enumValueDefinition : enumValue directives?;

inputObjectTypeDefinition : INPUT name directives? '{' inputValueDefinition+ '}';

typeExtensionDefinition : EXTEND objectTypeDefinition;

directiveDefinition : DIRECTIVE '@' name argumentsDefinition? 'on' directiveLocations;

directiveLocation : name;

directiveLocations : directiveLocation | directiveLocations '|' directiveLocation ;
