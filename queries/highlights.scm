; comments

(line_comment) @comment.line
(block_comment) @comment.block

; variables, types, constants

(param
  name: (identifier) @variable)

(struct_member
  name: (_) @property
  )




(type_specifier
    (template_elaborated_ident (template_elaborated_ident_part (identifier) @type)) .)

; imports (MEW extension)
(template_elaborated_ident (template_elaborated_ident_part (identifier) @module)* . (_))

(item_import name: ((identifier) @function) (#match? @function "^[a-z]"))
(item_import name: ((identifier) (#is? function)) rename: (item_import_rename ((identifier) @function)))

(item_import name: ((identifier) @module) (#match? @type "^[A-Z][a-z_A-Z0-9]*$"))
(item_import name: ((identifier) (#is? module)) rename: (item_import_rename ((identifier) @module)))

(item_import name: ((identifier) @constant) (#match? @constant "^[A-Z_][A-Z0-9_]*$"))
(item_import name: ((identifier) (#is? constant)) rename: (item_import_rename ((identifier) @constant)))




; templates

; (template_list (template_arg_expression))


(variable_decl ; this is var<storage> et.al
  (template_list
    (_ (template_elaborated_ident (template_elaborated_ident_part name: (identifier)))))  @keyword.storage.modifier)

; attributes

(attribute
  (identifier) @attribute) @attribute

(attribute
  name: (identifier) @attr-name
  arguments: (argument_list
    (template_elaborated_ident (template_elaborated_ident_part (identifier)).) @variable.builtin)
  (#eq? @attr-name "builtin"))



; import paths
(template_elaborated_ident
	(template_elaborated_ident_part name: ((identifier) @module))*
      (template_elaborated_ident_part)
)

; declarations
(struct_decl name: ((identifier) @type))
(module_decl name: ((identifier) @module))

; keywords

[
  "if"
  "else"
  "loop"
  "for"
  "while"
  "switch"
  "case"
  "default"
  "break"
  "continue"
  "continuing"
  "return"
  "discard"
  "with"
] @keyword

[
  "import"
  "as"
] @keyword

[
  "module"
  "var"
  "let"
  "const"
  "fn"
  "struct"
  "alias"
  "extend"
] @keyword


; expressions

[
  "-" "!" "~" "*" "&" ; unary
  "^" "|" "/" "%" "+" (shift_left) (shift_right) ; binary
  (less_than) (greater_than) (less_than_equal) (greater_than_equal) "==" "!=" ; relational
  "+=" "-=" "*=" "/=" "%=" "|=" "^=" "++" "--" "=" ; assign
  "->" ; return
] @operator

; functions

(function_decl
    name: (identifier)  @function)

(func_call_statement
    (template_elaborated_ident (_)* (template_elaborated_ident_part name: ((identifier) @function)). )
    (argument_list)*
   )

(call_expression
    (template_elaborated_ident (_)* (template_elaborated_ident_part name: ((identifier) @function)). ))


; punctuation

[ "(" ")" "[" "]" "{" "}"] @punctuation.bracket

(.((less_than) @punctuation.bracket) (template_list) ((greater_than) @punctuation.bracket).)

[ "," "." (double_colon) (single_colon) ";" ] @punctuation.delimiter

((bool_literal) @boolean)
[(int_literal) (hex_int_literal) (float_literal)] @number
