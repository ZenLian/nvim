-- TODO: split plugins into seperate files
local M = {}
local palette = require('edgeme.palette')

-- terminal colors
vim.g.terminal_color_0  = vim.o.background == 'dark' and palette.bg0 or palette.fg
vim.g.terminal_color_1  = palette.red
vim.g.terminal_color_2  = palette.green
vim.g.terminal_color_3  = palette.yellow
vim.g.terminal_color_4  = palette.blue
vim.g.terminal_color_5  = palette.purple
vim.g.terminal_color_6  = palette.cyan
vim.g.terminal_color_7  = palette.white
vim.g.terminal_color_8  = palette.black
vim.g.terminal_color_9  = palette.red
vim.g.terminal_color_10 = palette.green
vim.g.terminal_color_11 = palette.yellow
vim.g.terminal_color_12 = palette.blue
vim.g.terminal_color_13 = palette.purple
vim.g.terminal_color_14 = palette.cyan
vim.g.terminal_color_15 = vim.o.background == 'dark' and palette.fg or palette.bg0

-- predefined highlighting groups
M.base = {
    Fg     = { fg = palette.fg },
    Grey   = { fg = palette.grey },
    Red    = { fg = palette.red },
    Yellow = { fg = palette.yellow },
    Green  = { fg = palette.green },
    Cyan   = { fg = palette.cyan },
    Blue   = { fg = palette.blue },
    Purple = { fg = palette.purple },

    Bold = { style = "bold" },
    Italic = { style = "italic" },
    Underline = { style = "underline" },

    -- TODO: config.enable_italic
    RedItalic    = { fg = palette.red, bg = palette.none, style = 'italic' },
    YellowItalic = { fg = palette.yellow, bg = palette.none, style = 'italic' },
    GreenItalic  = { fg = palette.green, bg = palette.none, style = 'italic' },
    CyanItalic   = { fg = palette.cyan, bg = palette.none, style = 'italic' },
    BlueItalic   = { fg = palette.blue, bg = palette.none, style = 'italic' },
    PurpleItalic = { fg = palette.purple, bg = palette.none, style = 'italic' },

    RedSign    = { fg = palette.red },
    YellowSign = { fg = palette.yellow },
    GreenSign  = { fg = palette.green },
    CyanSign   = { fg = palette.cyan },
    BlueSign   = { fg = palette.blue },
    PurpleSign = { fg = palette.purple },

    -- TODO: if config.diagnostic_text_highlight
    ErrorText   = { fg = palette.none, bg = palette.diff_red, style = 'undercurl', sp = palette.red },
    WarningText = { fg = palette.none, bg = palette.diff_yellow, 'undercurl', sp = palette.yellow },
    InfoText    = { fg = palette.none, bg = palette.diff_blue, 'undercurl', sp = palette.blue },
    HintText    = { fg = palette.none, bg = palette.diff_green, 'undercurl', sp = palette.green },

    -- TODO: if config.diagnostic_line_highlight
    -- ErrorLine = { fg = palette.none, bg = palette.diff_red },
    -- WarningLine = { fg = palette.none, bg = palette.diff_yellow },
    -- InfoLine = { fg = palette.none, bg = palette.diff_blue },
    -- HintLine = { fg = palette.none, bg = palette.diff_green },
    ErrorLine   = {},
    WarningLine = {},
    InfoLine    = {},
    HintLine    = {},

    -- TODO: if config.diagnostic_virtual_text != 'grey'
    VirtualTextWarning = { link = 'Yellow' },
    VirtualTextError   = { link = 'Red' },
    VirtualTextInfo    = { link = 'Blue' },
    VirtualTextHint    = { link = 'Green' },

    ErrorFloat   = { fg = palette.red, bg = palette.bg2 },
    WarningFloat = { fg = palette.yellow, bg = palette.bg2 },
    InfoFloat    = { fg = palette.blue, bg = palette.bg2 },
    HintFloat    = { fg = palette.green, bg = palette.bg2 },

    CurrentWord = { fg = palette.none, bg = palette.bg2 },
}

-- builtin highlighting groups
M.builtin = {
    ColorColumn      = { fg = palette.none, bg = palette.bg1 },
    Conceal          = { fg = palette.grey_dim },
    Cursor           = { style = 'reverse' },
    lCursor          = { link = 'Cursor' },
    CursorIM         = { link = 'Cursor' },
    CursorColumn     = { fg = palette.none, bg = palette.bg1 },
    CursorLine       = { fg = palette.none, bg = palette.bg1 },
    Directory        = { fg = palette.green },
    DiffAdd          = { bg = palette.diff_green },
    DiffChange       = { bg = palette.diff_blue },
    DiffDelete       = { bg = palette.diff_red },
    DiffText         = { fg = palette.none, bg = palette.blue },
    EndOfBuffer      = { fg = palette.bg0 },
    TermCursor       = { link = 'Cursor' },
    -- TermCursorNC = { link = 'Cursor' }, -- cursor in an unfocused terminal
    ErrorMsg         = { fg = palette.red, style = 'bold,underline' },
    VertSplit        = { fg = palette.black }, -- Column separating vertically split windows
    -- WinSeparator = {} -- separators between window splits
    Folded           = { fg = palette.grey, bg = palette.bg1 },
    FoldColumn       = { fg = palette.grey_dim },
    SignColumn       = { fg = palette.fg },
    IncSearch        = { fg = palette.bg0, bg = palette.bg_blue },
    Substitute       = { fg = palette.bg0, bg = palette.yellow },
    LineNr           = { fg = palette.grey_dim, bg = palette.none },
    -- LineNrAbove = {}
    -- LineNrBelow = {}
    CursorLineNr     = { fg = palette.grey, bg = palette.none },
    -- CursorLineSign -- Like SignColumn when 'cursorline' is set for the cursor line.
    -- CursorLineFold -- Like FoldColumn when 'cursorline' is set for the cursor line.
    MatchParen       = { fg = palette.none, bg = palette.bg4 },
    ModeMsg          = { fg = palette.fg, bg = palette.none, style = 'bold' },
    -- MsgArea -- Area for messages and cmdline
    -- MsgSeparator -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg          = { fg = palette.blue, bg = palette.none, style = 'bold' },
    NonText          = { fg = palette.bg4, bg = palette.none },
    Normal           = { fg = palette.fg, bg = palette.bg0 },
    NormalFloat      = { fg = palette.fg, bg = palette.bg2 },
    -- NormalNC = { fg = palette.fg, bg = palette.bg0 },
    FloatBorder      = { fg = palette.bg2, bg = palette.bg2 },
    Pmenu            = { fg = palette.fg, bg = palette.bg2 },
    PmenuSel         = { fg = palette.bg0, bg = palette.bg_blue },
    PmenuSbar        = { fg = palette.none, bg = palette.bg2 },
    PmenuThumb       = { fg = palette.none, bg = palette.bg_grey },
    Question         = { fg = palette.yellow, bg = palette.none },
    QuickFixLine     = { fg = palette.purple, bg = palette.none, 'bold' },
    Search           = { fg = palette.bg0, bg = palette.bg_green },
    SpecialKey       = { fg = palette.bg4, bg = palette.none },
    SpellBad         = { fg = palette.red, bg = palette.none, style = 'undercurl', sp = palette.red },
    SpellCap         = { fg = palette.yellow, bg = palette.none, style = 'undercurl', sp = palette.yellow },
    SpellLocal       = { fg = palette.blue, bg = palette.none, style = 'undercurl', sp = palette.blue },
    SpellRare        = { fg = palette.purple, bg = palette.none, style = 'undercurl', sp = palette.purple },
    StatusLine       = { fg = palette.fg, bg = palette.bg2 },
    StatusLineNC     = { fg = palette.grey, bg = palette.bg1 },
    StatusLineTermNC = { fg = palette.grey, bg = palette.bg1 },
    TabLine          = { fg = palette.fg, bg = palette.bg4 },
    TabLineFill      = { fg = palette.grey, bg = palette.bg1 },
    TabLineSel       = { fg = palette.bg0, bg = palette.bg_purple },
    Title            = { fg = palette.purple, bg = palette.none, style = 'bold' },
    Visual           = { fg = palette.none, bg = palette.bg3 },
    VisualNOS        = { fg = palette.none, bg = palette.bg3, style = 'underline' },
    WarningMsg       = { fg = palette.yellow, bg = palette.none, style = 'bold' },
    Whitespace       = { fg = palette.bg4, bg = palette.none },

    -- Terminal = { fg = palette.fg, bg = palette.bg0 }, -- TODO: what's this?
}

-- common syntax groups
-- see :h group-name
M.syntax = {
    Comment = { fg = palette.grey, style = 'italic' },

    Constant  = { fg = palette.yellow },
    String    = { fg = palette.green },
    Boolean   = { fg = palette.green },
    Character = { fg = palette.green },
    Number    = { fg = palette.green },
    Float     = { fg = palette.green },

    Identifier = { fg = palette.cyan },
    Function   = { fg = palette.blue },

    Statement   = { fg = palette.purple },
    Conditional = { fg = palette.purple },
    Repeat      = { fg = palette.purple },
    Label       = { fg = palette.yellow },
    Operator    = { fg = palette.purple },
    Keyword     = { fg = palette.purple },
    Exception   = { fg = palette.purple },

    PreProc   = { fg = palette.purple },
    Include   = { fg = palette.purple },
    Define    = { fg = palette.purple },
    Macro     = { fg = palette.yellow },
    PreCondit = { fg = palette.purple },

    Type         = { fg = palette.red },
    StorageClass = { fg = palette.red },
    Structure    = { fg = palette.red },
    Typedef      = { fg = palette.purple },

    Special        = { fg = palette.yellow },
    SpecialChar    = { fg = palette.yellow },
    Tag            = { fg = palette.yellow },
    Delimiter      = { fg = palette.fg },
    SpecialComment = { fg = palette.grey, style = 'italic' },
    Debug          = { fg = palette.yellow },

    Underlined = { fg = palette.none, style = 'underline' },

    Ignore = { fg = palette.grey },

    Error = { fg = palette.red },

    Todo = { fg = palette.red, style = 'italic' },
}


-- see :h lsp-highlight
M.lsp = {
    LspReferenceText            = { link = 'CurrentWord' },
    LspReferenceRead            = { link = 'CurrentWord' },
    LspReferenceWrite           = { link = 'CurrentWord' },
    -- LspCodeLens -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator -- Used to color the separator between two or more code lens.
    -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.
    LspSignatureActiveParameter = { link = 'Blue' },
}

-- see :h diagnostic-highlights
M.diagnostic = {
    DiagnosticError            = { link = 'ErrorText' },
    DiagnosticWarn             = { link = 'WarningText' },
    DiagnosticInfo             = { link = 'InfoText' },
    DiagnosticHint             = { link = 'HintText' },
    DiagnosticFloatingError    = { link = 'ErrorFloat' },
    DiagnosticFloatingWarn     = { link = 'WarningFloat' },
    DiagnosticFloatingInfo     = { link = 'InfoFloat' },
    DiagnosticFloatingHint     = { link = 'HintFloat' },
    DiagnosticVirtualTextError = { link = 'VirtualTextError' },
    DiagnosticVirtualTextWarn  = { link = 'VirtualTextWarning' },
    DiagnosticVirtualTextInfo  = { link = 'VirtualTextInfo' },
    DiagnosticVirtualTextHint  = { link = 'VirtualTextHint' },
    DiagnosticUnderlineError   = { link = 'ErrorText' },
    DiagnosticUnderlineWarn    = { link = 'WarningText' },
    DiagnosticUnderlineInfo    = { link = 'InfoText' },
    DiagnosticUnderlineHint    = { link = 'HintText' },
    DiagnosticSignError        = { link = 'RedSign' },
    DiagnosticSignWarn         = { link = 'YellowSign' },
    DiagnosticSignInfo         = { link = 'BlueSign' },
    DiagnosticSignHint         = { link = 'GreenSign' },
}

--
-- language specific
--

M.markdown = {
    markdownH1                   = { fg = palette.purple, style = 'bold' },
    markdownH2                   = { fg = palette.red, style = 'bold' },
    markdownH3                   = { fg = palette.blue, style = 'bold' },
    markdownH4                   = { fg = palette.yellow, style = 'bold' },
    markdownH5                   = { fg = palette.green, style = 'bold' },
    markdownH6                   = { fg = palette.cyan, style = 'bold' },
    markdownUrl                  = { fg = palette.green, style = 'underline' },
    markdownItalic               = { 'Italic' },
    markdownBold                 = { 'Bold' },
    markdownItalicDelimiter      = { fg = palette.grey, style = 'italic' },
    markdownCode                 = { link = 'Green' },
    markdownCodeBlock            = { link = 'Green' },
    markdownCodeDelimiter        = { link = 'Green' },
    markdownBlockquote           = { link = 'Grey' },
    markdownListMarker           = { link = 'Red' },
    markdownOrdepurpleListMarker = { link = 'Red' },
    markdownRule                 = { link = 'Yellow' },
    markdownHeadingRule          = { link = 'Grey' },
    markdownUrlDelimiter         = { link = 'Grey' },
    markdownLinkDelimiter        = { link = 'Grey' },
    markdownLinkTextDelimiter    = { link = 'Grey' },
    markdownHeadingDelimiter     = { link = 'Grey' },
    markdownLinkText             = { link = 'Purple' },
    markdownUrlTitleDelimiter    = { link = 'Blue' },
    markdownIdDeclaration        = { link = 'markdownLinkText' },
    markdownBoldDelimiter        = { link = 'Grey' },
    markdownId                   = { link = 'Green' },
}

M.help = {
    helpNote = { fg = palette.yellow, bg = palette.none, style = 'bold' },
    helpHeadline = { fg = palette.purple, bg = palette.none, style = 'bold' },
    helpHeader = { fg = palette.blue, bg = palette.none, style = 'bold' },
    helpURL = { fg = palette.blue, bg = palette.none, style = 'underline' },
    helpHyperTextEntry = { fg = palette.red, bg = palette.none, style = 'bold' },
    helpHyperTextJump = { 'Red' },
    helpCommand = { 'Cyan' },
    helpExample = { 'Green' },
    helpSpecial = { 'Yellow' },
    helpSectionDelim = { 'Grey' },
}

--
-- plugins
--

-- Tree-Sitter syntax groups. Most link to corresponding
-- vim syntax groups (e.g. TSKeyword => Keyword) by default.
--
-- See :h nvim-treesitter-highlights
--
M.treesitter = {
    TSAttribute          = { "Yellow" }, -- Annotations that can be attached to the code to denote some kind of meta information. e.g. C++/Dart attributes.
    TSBoolean            = { "Green" },
    TSCharacter          = { "Green" },
    TSCharacterSpecial   = { "Yellow" }, -- Special characters.
    TSComment            = { "Comment" },
    TSConditional        = { "Conditional" },
    TSConstant           = { "RedItalic" }, -- Constants identifiers. These might not be semantically constant. E.g. uppercase variables in Python.
    TSConstBuiltin       = { "CyanItalic" }, -- Built-in constant values: `nil` in Lua.
    TSConstMacro         = { "CyanItalic" }, -- Constants defined by macros: `NULL` in C.
    TSConstructor        = { "Blue" }, -- Constructor calls and definitions: `{}` in Lua, and Java constructors.
    TSDebug              = { "Debug" }, -- Debugging statements.
    TSDefine             = { "Define" }, -- Preprocessor #define statements.
    TSError              = { "Error" }, -- Syntax/parser errors. This might highlight large sections of code while the user is typing still incomplete code, use a sensible highlight.
    TSException          = { "Exception" }, -- Exception related keywords: `try`, `except`, `finally` in Python.
    TSField              = { "Blue" }, -- Object and struct fields.
    TSFloat              = { "Number" }, -- Floating-point number literals.
    TSFunction           = { "Function" }, -- Function calls and definitions.
    TSFuncBuiltin        = { "Function" }, -- Built-in functions: `print` in Lua.
    TSFuncMacro          = { "Function" }, -- Macro defined functions (calls and definitions): each `macro_rules` in Rust.
    TSInclude            = { "Include" }, -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.
    TSKeyword            = { "Keyword" }, -- Keywords that don't fit into other categories.
    TSKeywordFunction    = { "Keyword" }, -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
    TSKeywordOperator    = { "Keyword" }, -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
    TSKeywordReturn      = { "Keyword" }, -- Keywords like `return` and `yield`.
    TSLabel              = { "Purple" }, -- GOTO labels: `label:` in C, and `::label::` in Lua.
    TSMethod             = { "Blue" }, -- Method calls and definitions.
    TSNamespace          = { "Yellow" }, -- Identifiers referring to modules and namespaces.
    -- TSNone               { } , -- No highlighting (sets all highlight arguments to `NONE`). this group is used to clear certain ranges, for example, string interpolations. Don't change the values of this highlight group.
    TSNumber             = { "Number" }, -- Numeric literals that don't fit into other categories.
    TSOperator           = { "Operator" }, -- Binary or unary operators: `+`, and also `->` and `*` in C.
    TSParameter          = { "RedItalic" }, -- Parameters of a function.
    TSParameterReference = { "RedItalic" }, -- References to parameters of a function.
    TSPreProc            = { "PreCondit" }, -- Preprocessor #if, #else, #endif, etc.
    TSProperty           = { "TSField" }, -- Same as `TSField`.
    TSPunctDelimiter     = { "Grey" }, -- Punctuation delimiters: Periods, commas, semicolons, etc.
    TSPunctBracket       = { "Grey" }, -- Brackets, braces, parentheses, etc.
    TSPunctSpecial       = { "Yellow" }, -- Special punctuation that doesn't fit into the previous categories.
    TSRepeat             = { "Keyword" }, -- Keywords related to loops: `for`, `while`, etc.
    TSStorageClass       = { "Keyword" }, -- Keywords that affect how a variable is stored: `static`, `comptime`, `extern`, etc.
    TSString             = { "String" }, -- String literals.
    TSStringRegex        = { "Yellow" }, -- Regular expression literals.
    TSStringEscape       = { "Yellow" }, -- Escape characters within a string: `\n`, `\t`, etc.
    TSStringSpecial      = { "String" }, -- Strings with special meaning that don't fit into the previous categories.
    TSSymbol             = { "Red" }, -- Identifiers referring to symbols or atoms.
    TSTag                = { "RedItalic" }, -- Tags like HTML tag names.
    TSTagAttribute       = { "Blue" }, -- HTML tag attributes.
    TSTagDelimiter       = { "Purple" }, -- Tag delimiters like `<` `>` `/`.
    TSText               = { "Green" }, -- Non-structured text. Like text in a markup language.
    TSStrong             = { "Bold" }, -- Text to be represented in bold.
    TSEmphasis           = { "Italic" }, -- Text to be represented with emphasis.
    TSUnderline          = { "Underline" }, -- Text to be represented with an underline.
    TSStrike             = { "Grey" }, -- Strikethrough text.
    TSTitle              = { "Purple" }, -- Text that is part of a title.
    TSLiteral            = { "Green" }, -- Literal or verbatim text.
    TSURI                = { fg = palette.green, style = "underline" }, -- URIs like hyperlinks or email addresses.
    TSMath               = { "Green" }, -- Math environments like LaTeX's `$ ... $`
    TSTextReference      = { "Grey" }, -- Footnotes, text references, citations, etc.
    -- TSEnvironment        { } , -- Text environments of markup languages.
    -- TSEnvironmentName    { } , -- Text/string indicating the type of text environment. Like the name of a `\begin` block in LaTeX.
    TSNote               = { fg = palette.bg0, bg = palette.blue, style = "bold" }, -- Text representation of an informational note.
    TSWarning            = { fg = palette.bg0, bg = palette.yellow, style = 'bold' }, -- Text representation of a warning note.
    TSDanger             = { fg = palette.bg0, bg = palette.red, style = 'bold' }, -- Text representation of a danger note.
    TSType               = { "Type" }, -- Type (and class) definitions and annotations.
    TSTypeBuiltin        = { "Yellow" }, -- Built-in types: `i32` in Rust.
    TSVariable           = { "RedItalic" }, -- Variable names that don't fit into other categories.
    TSVariableBuiltin    = { "CyanItalic" }, -- Variable names defined by the language: `this` or `self` in Javascript.
}

M.telescope = {
    TelescopeNormal        = { fg = palette.fg, bg = palette.bg2 },
    -- TelescopeBorder = { 'Grey' },
    TelescopePromptPrefix  = { 'Purple' },
    TelescopePromptNormal  = { fg = palette.fg, bg = palette.bg1 },
    TelescopePromptBorder  = { fg = palette.bg1, bg = palette.bg1 },
    TelescopePromptTitle   = { fg = palette.grey },
    TelescopePromptCounter = { 'Grey' },
    TelescopeSelection     = { 'DiffAdd' },
    TelescopeMatching      = { fg = palette.green, bg = palette.none, style = 'bold' },
    TelescopeResultsBorder = { fg = palette.bg2, bg = palette.bg2 },
    TelescopeResultsTitle  = { fg = palette.grey },
    TelescopePreviewNormal = { fg = palette.fg, bg = palette.bg3 },
    TelescopePreviewBorder = { fg = palette.bg3, bg = palette.bg3 },
    TelescopePreviewTitle  = { fg = palette.grey },
}

-- kyazdani42/nvim-tree.lua
M.nvimTree = {
    NvimTreeSymlink = { 'Fg' },
    NvimTreeFolderName = { 'Green' },
    NvimTreeRootFolder = { 'Grey' },
    NvimTreeFolderIcon = { 'Blue' },
    NvimTreeEmptyFolderName = { 'Green' },
    NvimTreeOpenedFolderName = { 'Green' },
    NvimTreeExecFile = { 'Fg' },
    NvimTreeOpenedFile = { 'Fg' },
    NvimTreeSpecialFile = { 'Fg' },
    NvimTreeImageFile = { 'Fg' },
    NvimTreeMarkdownFile = { 'Fg' },
    NvimTreeIndentMarker = { 'Grey' },
    NvimTreeGitDirty = { 'Yellow' },
    NvimTreeGitStaged = { 'Blue' },
    NvimTreeGitMerge = { 'Cyan' },
    NvimTreeGitRenamed = { 'Purple' },
    NvimTreeGitNew = { 'Green' },
    NvimTreeGitDeleted = { 'Red' },
    NvimTreeLspDiagnosticsError = { 'RedSign' },
    NvimTreeLspDiagnosticsWarning = { 'YellowSign' },
    NvimTreeLspDiagnosticsInformation = { 'BlueSign' },
    NvimTreeLspDiagnosticsHint = { 'GreenSign' },
}

-- lewis6991/gitsigns.nvim
M.gitsigns = {
    GitSignsAdd = { link = 'GreenSign' },
    GitSignsChange = { link = 'BlueSign' },
    GitSignsDelete = { link = 'RedSign' },
    GitSignsAddNr = { link = 'Green' },
    GitSignsChangeNr = { link = 'Blue' },
    GitSignsDeleteNr = { link = 'Red' },
    GitSignsAddLn = { link = 'DiffAdd' },
    GitSignsChangeLn = { link = 'DiffChange' },
    GitSignsDeleteLn = { link = 'DiffDelete' },
    GitSignsCurrentLineBlame = { link = 'Grey' },
}

-- folke/which-key.nvim
M.whichkey = {
    WhichKey = { 'Red' },
    WhichKeySeperator = { 'Green' },
    WhichKeyGroup = { 'Purple' },
    WhichKeyDesc = { 'Blue' },
    -- WhichKeyFloat = { 'NormalFloat' },
    -- WhichKeyValue = { 'Comment' },
}

-- p00f/nvim-ts-rainbow
M.rainbow = {
    rainbowcol1 = { 'Red' },
    rainbowcol2 = { 'Yellow' },
    rainbowcol3 = { 'Green' },
    rainbowcol4 = { 'Cyan' },
    rainbowcol5 = { 'Blue' },
    rainbowcol6 = { 'Purple' },
    rainbowcol7 = { 'Green' },
}

-- hrsh7th/nvim-cmp
M.cmp = {
    CmpItemAbbrMatch = { fg = palette.blue, bg = palette.none, style = 'bold' },
    CmpItemAbbrMatchFuzzy = { fg = palette.blue, bg = palette.none, style = 'bold' },
    CmpItemAbbr = { 'Fg' },
    CmpItemAbbrDeprecated = { 'Fg' },
    CmpItemMenu = { 'Fg' },
    CmpItemKind = { 'Purple' },
    CmpItemKindText = { 'Fg' },
    CmpItemKindMethod = { 'Blue' },
    CmpItemKindFunction = { 'Blue' },
    CmpItemKindConstructor = { 'Blue' },
    CmpItemKindField = { 'Blue' },
    CmpItemKindVariable = { 'Red' },
    CmpItemKindClass = { 'Yellow' },
    CmpItemKindInterface = { 'Yellow' },
    CmpItemKindModule = { 'Yellow' },
    CmpItemKindProperty = { 'Red' },
    CmpItemKindUnit = { 'Green' },
    CmpItemKindValue = { 'Green' },
    CmpItemKindEnum = { 'Yellow' },
    CmpItemKindKeyword = { 'Purple' },
    CmpItemKindSnippet = { 'Cyan' },
    CmpItemKindColor = { 'Cyan' },
    CmpItemKindFile = { 'Cyan' },
    CmpItemKindReference = { 'Cyan' },
    CmpItemKindFolder = { 'Cyan' },
    CmpItemKindEnumMember = { 'Green' },
    CmpItemKindConstant = { 'Red' },
    CmpItemKindStruct = { 'Yellow' },
    CmpItemKindEvent = { 'Purple' },
    CmpItemKindOperator = { 'Purple' },
    CmpItemKindTypeParameter = { 'Yellow' },
}

-- glepnir/lspsaga.nvim
M.lspsaga = {
    LspFloatWinBorder = { fg = palette.bg0, bg = palette.bg0 },
    LspSagaDiagnosticHeader = { fg = palette.yellow, bg = palette.none, style = 'bold' },
    LspSagaCodeActionTitle = { fg = palette.blue, bg = palette.none, style = 'bold' },
    DefinitionPreviewTitle = { fg = palette.purple, bg = palette.none, style = 'bold' },
    LspSagaDiagnosticBorder = { 'Yellow' },
    LspSagaDiagnosticTruncateLine = { 'Yellow' },
    LspSagaRenameBorder = { 'Blue' },
    LspSagaRenamePromptPrefix = { 'Purple' },
    LspSagaCodeActionBorder = { 'Blue' },
    LspSagaCodeActionTruncateLine = { 'Blue' },
    LspSagaCodeActionContent = { 'Green' },
    LspSagaHoverBorder = { 'Green' },
    LspSagaDocTruncateLine = { 'Green' },
    LspSagaSignatureHelpBorder = { 'Green' },
    LspSagaShTruncateLine = { 'Green' },
    LspSagaDefPreviewBorder = { 'Purple' },
    DefinitionIcon = { 'Purple' },
    LspLinesDiagBorder = { 'Cyan' },
    LineDiagTuncateLine = { 'Cyan' },
    LspSagaAutoPreview = { 'Blue' },
    LspSagaFinderSelection = { 'Fg' },
    DiagnosticWarning = { 'DiagnosticWarn' },
    DiagnosticInformation = { 'DiagnosticInfo' },
    ReferencesCount = { 'Grey' },
    DefinitionCount = { 'Grey' },
    TargetFileName = { 'Grey' },
}

--
-- folke/trouble.nvim
--
M.trouble = {
    TroubleText = { 'Fg' },
    TroubleSource = { 'Grey' },
    TroubleCode = { 'Grey' },
}

return M
