(identifier) @variable               ; default priority 110

((identifier) @constant
 (#match? @constant "^[A-Z][A-Z\\d_]*$"))

"break" @keyword
"case" @keyword
"const" @keyword
"continue" @keyword
"default" @keyword
"do" @keyword
"else" @keyword
"enum" @keyword
"extern" @keyword
"for" @keyword
"if" @keyword
"inline" @keyword
"return" @keyword
"sizeof" @keyword
"static" @keyword
"struct" @keyword
"switch" @keyword
"typedef" @keyword
"union" @keyword
"volatile" @keyword
"while" @keyword

"#define" @keyword
"#elif" @keyword
"#else" @keyword
"#endif" @keyword
"#if" @keyword
"#ifdef" @keyword
"#ifndef" @keyword
"#include" @keyword
(preproc_directive) @keyword

"--" @operator
"-" @operator
"-=" @operator
"->" @operator
"=" @operator
"!=" @operator
"*" @operator
"&" @operator
"&&" @operator
"+" @operator
"++" @operator
"+=" @operator
"<" @operator
"==" @operator
">" @operator
"||" @operator

"." @delimiter
";" @delimiter

(string_literal) @string
(system_lib_string) @string

(null) @constant
(number_literal) @number
(char_literal) @number

(field_identifier) @property
(statement_identifier) @label
(type_identifier) @type
(primitive_type) @type
(sized_type_specifier) @type

(call_expression
  function: (identifier) @function)
(call_expression
  function: (field_expression
    field: (field_identifier) @function))
(function_declarator
  declarator: (identifier) @function)
(preproc_function_def
  name: (identifier) @function.special)

(comment) @comment

; Custom todo finder for // todo
((comment) @todo
 (#match? @todo "// todo"))

((comment) @comment.info (#match? @comment.info "// info"))

; Find comments starting with // * 
((comment) @comment-asterisk (#match? @comment-asterisk "// \\*"))

; Find comments starting with // -
((comment) @comment-minus (#match? @comment-minus "// \\-"))

; Custom pointer variable matcher
(("*" @ptr.star) (identifier) @ptr.name)

((identifier) @pointer (#match? @pointer "^p[A-Z_]"))

;; Capture the function name in function declarations
(function_definition
  declarator: (function_declarator
    declarator: (identifier) @function.name))

;; Capture the function body (the code block inside the function)
(function_definition
  body: (compound_statement) @function.body)
