-- Frutiger Aero keeps editing surfaces transparent so Alacritty's blurred glass remains visible.
local c = {
  bg = "#06233A",
  float = "#0B3B5A",
  selection = "#15557A",
  cursorline = "#0D3B57",
  border = "#24718F",
  fg = "#EAFBFF",
  muted = "#8FB7C7",
  aqua = "#A8F7FF",
  cyan = "#6DE8F5",
  blue = "#78CCFF",
  green = "#9CFFC3",
  yellow = "#FFF0A6",
  red = "#FF92A0",
  magenta = "#E0BAFF",
}

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "frutiger-aero"

local highlights = {
  Normal = { fg = c.fg, bg = "NONE" },
  NormalNC = { fg = c.fg, bg = "NONE" },
  NeoTreeNormal = { fg = c.fg, bg = "NONE" },
  NeoTreeNormalNC = { fg = c.fg, bg = "NONE" },
  NeoTreeEndOfBuffer = { fg = c.bg, bg = "NONE" },
  NeoTreeWinSeparator = { fg = c.border, bg = "NONE" },
  NormalFloat = { fg = c.fg, bg = c.float },
  FloatBorder = { fg = c.aqua, bg = c.float },
  FloatTitle = { fg = c.aqua, bg = c.float, bold = true },
  Cursor = { fg = c.bg, bg = c.aqua },
  CursorLine = { bg = c.cursorline },
  CursorColumn = { bg = c.cursorline },
  ColorColumn = { bg = c.cursorline },
  LineNr = { fg = c.muted, bg = "NONE" },
  CursorLineNr = { fg = c.aqua, bg = c.cursorline, bold = true },
  SignColumn = { bg = "NONE" },
  FoldColumn = { fg = c.muted, bg = "NONE" },
  VertSplit = { fg = c.border, bg = "NONE" },
  WinSeparator = { fg = c.border, bg = "NONE" },
  StatusLine = { fg = c.fg, bg = "NONE" },
  StatusLineNC = { fg = c.muted, bg = "NONE" },
  TabLine = { fg = c.muted, bg = "NONE" },
  TabLineSel = { fg = c.bg, bg = c.aqua, bold = true },
  Pmenu = { fg = c.fg, bg = c.float },
  PmenuSel = { fg = c.bg, bg = c.aqua, bold = true },
  PmenuSbar = { bg = c.selection },
  PmenuThumb = { bg = c.aqua },
  Visual = { bg = c.selection },
  Search = { fg = c.bg, bg = c.yellow, bold = true },
  IncSearch = { fg = c.bg, bg = c.green, bold = true },
  CurSearch = { fg = c.bg, bg = c.green, bold = true },
  MatchParen = { fg = c.aqua, bg = c.selection, bold = true },
  Directory = { fg = c.blue, bold = true },
  Title = { fg = c.aqua, bold = true },
  Question = { fg = c.green, bold = true },
  ErrorMsg = { fg = c.red, bold = true },
  WarningMsg = { fg = c.yellow, bold = true },
  MoreMsg = { fg = c.green },
  NonText = { fg = c.border },
  Whitespace = { fg = c.border },
  Comment = { fg = c.muted, italic = true },
  Constant = { fg = c.cyan },
  String = { fg = c.green },
  Character = { fg = c.green },
  Number = { fg = c.magenta },
  Boolean = { fg = c.magenta },
  Identifier = { fg = c.blue },
  Function = { fg = c.aqua, bold = true },
  Statement = { fg = c.blue, bold = true },
  Keyword = { fg = c.blue, bold = true },
  Conditional = { fg = c.cyan, bold = true },
  Repeat = { fg = c.cyan, bold = true },
  Operator = { fg = c.aqua },
  Type = { fg = c.yellow, bold = true },
  Special = { fg = c.cyan },
  PreProc = { fg = c.magenta },
  Todo = { fg = c.bg, bg = c.yellow, bold = true },
  Underlined = { fg = c.blue, underline = true },
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticInfo = { fg = c.blue },
  DiagnosticHint = { fg = c.cyan },
  DiagnosticOk = { fg = c.green },
  DiffAdd = { fg = c.green, bg = "#0B3D43" },
  DiffChange = { fg = c.blue, bg = "#0A3A55" },
  DiffDelete = { fg = c.red, bg = "#452F42" },
  GitSignsAdd = { fg = c.green },
  GitSignsChange = { fg = c.blue },
  GitSignsDelete = { fg = c.red },
  TelescopeNormal = { fg = c.fg, bg = c.float },
  TelescopeBorder = { fg = c.aqua, bg = c.float },
  TelescopeSelection = { fg = c.fg, bg = c.selection, bold = true },
  LazyNormal = { fg = c.fg, bg = c.float },
  WhichKey = { fg = c.aqua },
  WhichKeyGroup = { fg = c.blue },
  WhichKeyDesc = { fg = c.fg },
  ["@comment"] = { link = "Comment" },
  ["@string"] = { link = "String" },
  ["@function"] = { link = "Function" },
  ["@function.call"] = { fg = c.aqua },
  ["@keyword"] = { link = "Keyword" },
  ["@type"] = { link = "Type" },
  ["@variable"] = { fg = c.fg },
  ["@property"] = { fg = c.blue },
  ["@punctuation.bracket"] = { fg = c.muted },
}

for group, spec in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, spec)
end

vim.g.terminal_color_0 = c.bg
vim.g.terminal_color_1 = c.red
vim.g.terminal_color_2 = c.green
vim.g.terminal_color_3 = c.yellow
vim.g.terminal_color_4 = c.blue
vim.g.terminal_color_5 = c.magenta
vim.g.terminal_color_6 = c.cyan
vim.g.terminal_color_7 = c.fg
vim.g.terminal_color_8 = c.border
vim.g.terminal_color_9 = c.red
vim.g.terminal_color_10 = c.green
vim.g.terminal_color_11 = c.yellow
vim.g.terminal_color_12 = c.aqua
vim.g.terminal_color_13 = c.magenta
vim.g.terminal_color_14 = c.aqua
vim.g.terminal_color_15 = "#FFFFFF"
