; Scopes

[
  (translation_unit)
  (global_member)
  (module_with_template_parameters)
  (module_body)
  (switch_body)
  (compound_statement)
] @local.scope


(param
  name: (identifier) @local.definition)
(template_parameter identifier: (optionally_typed_ident name: ((identifier) @local.definition)))
(optional_template_parameter (optionally_typed_ident name: ((identifier) @local.definition)))

(struct_decl name: (identifier) @local.definition)
(module_decl name: (identifier) @local.definition)
(item_import_rename ((identifier) @local.definition))
(item_import name: ((identifier) @local.definition) !rename)


; First template_elaborated_ident is a reference
(template_elaborated_ident ((template_elaborated_ident_part name: ((identifier) @local.reference)). (_)*))
; First import in a root_import_path is a reference
(root_import_path path: ((template_elaborated_ident_part name: ((identifier) @local.reference))). (_)*)
