return {
  -- 基础背景和前景
  background = "{{colors.surface.default.hex}}",
  foreground = "{{colors.on_surface.default.hex}}",

  -- 光标与行号
  cursor = "{{colors.primary.default.hex}}",
  cursor_fg = "{{colors.on_primary.default.hex}}",
  line_nr = "{{colors.outline.default.hex}}",
  visual = "{{colors.secondary_container.default.hex}}",

  -- 常用语法高亮色
  comment = "{{colors.outline_variant.default.hex}}",
  string = "{{colors.tertiary.default.hex}}",
  keyword = "{{colors.primary.default.hex}}",
  function_name = "{{colors.secondary.default.hex}}",
  constant = "{{colors.error.default.hex}}",

  -- UI 元素
  selection_bg = "{{colors.surface_variant.default.hex}}",
  border = "{{colors.outline.default.hex}}",

  -- Material Design 完整调色板 (备用)
  primary = "{{colors.primary.default.hex}}",
  secondary = "{{colors.secondary.default.hex}}",
  tertiary = "{{colors.tertiary.default.hex}}",
  error = "{{colors.error.default.hex}}",
  surface = "{{colors.surface.default.hex}}",
}
