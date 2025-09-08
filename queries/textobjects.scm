(function_decl
  body: (_) @function.inside) @function.around

(struct_decl
  body: (_) @class.inside) @class.around

(function_decl
    parameters: ((_) @parameter.inside . ","? @parameter.around) @parameter.around
    (template_parameter ((_) @parameter.inside . ","? @parameter.around))*
  )

(argument_list
  ((_) @parameter.inside . ","? @parameter.around) @parameter.around)

(template_list
  ((_) @parameter.inside . ","? @parameter.around) @parameter.around)

[
  (line_comment)
  (block_comment)
] @comment.inside

(line_comment)+ @comment.around

(block_comment) @comment.around
