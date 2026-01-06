local M = {}

M.config = {
  style = "light",
  transparent = false,
  italic_comments = false,
}

M.colors = {
  light = {
    bg = "#F7F7F7",
    fg = "#000000",
    comment = "#AA3731",
    string = "#448C27",
    constant = "#7A3E9D",
    entity = "#325CC0",
    escape = "#777777",
    punctuation = "#777777",
    invalid_bg = "#F7E6E6",
    invalid_fg = "#660000",

    warning = "#CB9000",
    info = "#0083B2",
    hint = "#448C27",

    line_highlight = "#F0F0F0",
    selection = "#BFDBFE",
    selection_highlight = "#E3E3E3",
    cursor = "#007ACC",
    line_number = "#9DA39A",

    find_match = "#FFBC5D",
    find_match_highlight = "#FFE9C2",

    visual = "#BFDBFE",

    diff_add_bg = "#DDFFDD",
    diff_delete_bg = "#FFDDDD",
    diff_change_bg = "#DDDDFF",
    diff_text = "#434343",

    statusline_bg = "#DDDDDD",
    statusline_fg = "#474747",

    term_black = "#000000",
    term_red = "#AA3731",
    term_green = "#448C27",
    term_yellow = "#CB9000",
    term_blue = "#325CC0",
    term_magenta = "#7A3E9D",
    term_cyan = "#0083B2",
    term_white = "#BBBBBB",
    term_bright_black = "#777777",
    term_bright_red = "#F05050",
    term_bright_green = "#60CB00",
    term_bright_yellow = "#FFBC5D",
    term_bright_blue = "#007ACC",
    term_bright_magenta = "#E64CE6",
    term_bright_cyan = "#00AACB",
    term_bright_white = "#FFFFFF",
  },

  dark = {
    bg = "#0E1415",
    fg = "#CECECE",
    comment = "#D96468",
    string = "#91B362",
    constant = "#B77FDB",
    entity = "#6199D9",
    escape = "#999999",
    punctuation = "#999999",
    invalid_bg = "#3D2022",
    invalid_fg = "#D96468",

    warning = "#D9B76C",
    info = "#5AAEBD",
    hint = "#91B362",

    line_highlight = "#1A1F20",
    selection = "#1C3D5C",
    selection_highlight = "#2A2F30",
    cursor = "#6199D9",
    line_number = "#4A5759",

    find_match = "#5F4C00",
    find_match_highlight = "#3D3100",

    visual = "#1C3D5C",

    diff_add_bg = "#1D3124",
    diff_delete_bg = "#3D2022",
    diff_change_bg = "#1D2845",
    diff_text = "#CECECE",

    statusline_bg = "#1A1F20",
    statusline_fg = "#999999",

    term_black = "#000000",
    term_red = "#D96468",
    term_green = "#91B362",
    term_yellow = "#D9B76C",
    term_blue = "#6199D9",
    term_magenta = "#B77FDB",
    term_cyan = "#5AAEBD",
    term_white = "#CECECE",
    term_bright_black = "#666666",
    term_bright_red = "#F07178",
    term_bright_green = "#AAD94C",
    term_bright_yellow = "#FFD580",
    term_bright_blue = "#73B8FF",
    term_bright_magenta = "#D2A6FF",
    term_bright_cyan = "#7FD5E0",
    term_bright_white = "#FFFFFF",
  },
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "alabaster"

  local cfg = M.config
  local c = M.colors[cfg.style] or M.colors.light

  vim.o.background = cfg.style == "dark" and "dark" or "light"

  local bg = cfg.transparent and "NONE" or c.bg
  local comment_style = cfg.italic_comments and { fg = c.comment, italic = true } or { fg = c.comment }

  local highlights = {
    Normal = { fg = c.fg, bg = bg },
    NormalFloat = { fg = c.fg, bg = cfg.transparent and "NONE" or c.line_highlight },
    Comment = comment_style,

    Constant = { fg = c.constant },
    String = { fg = c.string },
    Character = { fg = c.constant },
    Number = { fg = c.constant },
    Boolean = { fg = c.constant },
    Float = { fg = c.constant },

    Identifier = { fg = c.fg },
    Function = { fg = c.entity },

    Statement = { fg = c.fg },
    Conditional = { fg = c.fg },
    Repeat = { fg = c.fg },
    Label = { fg = c.fg },
    Operator = { fg = c.fg },
    Keyword = { fg = c.fg },
    Exception = { fg = c.fg },

    PreProc = { fg = c.fg },
    Include = { fg = c.fg },
    Define = { fg = c.fg },
    Macro = { fg = c.fg },
    PreCondit = { fg = c.fg },

    Type = { fg = c.fg },
    StorageClass = { fg = c.fg },
    Structure = { fg = c.fg },
    Typedef = { fg = c.fg },

    Special = { fg = c.punctuation },
    SpecialChar = { fg = c.escape },
    Tag = { fg = c.entity },
    Delimiter = { fg = c.punctuation },
    SpecialComment = { fg = c.comment },
    Debug = { fg = c.comment },

    Underlined = { underline = true },
    Ignore = { fg = c.punctuation },
    Error = { fg = c.invalid_fg, bg = c.invalid_bg },
    Todo = { fg = c.comment },

    CursorLine = { bg = cfg.transparent and "NONE" or c.line_highlight },
    CursorLineNr = { fg = c.fg },
    LineNr = { fg = c.line_number },
    SignColumn = { bg = bg },

    Visual = { bg = c.visual },
    VisualNOS = { bg = c.visual },

    Pmenu = { fg = c.fg, bg = c.line_highlight },
    PmenuSel = { fg = c.fg, bg = c.selection_highlight },
    PmenuSbar = { bg = c.line_highlight },
    PmenuThumb = { bg = c.punctuation },

    StatusLine = { fg = c.statusline_fg, bg = c.statusline_bg },
    StatusLineNC = { fg = c.statusline_fg, bg = c.statusline_bg },

    Search = { bg = c.find_match },
    IncSearch = { bg = c.find_match },

    MatchParen = { bg = c.selection_highlight },

    -- Window & Split UI
    WinSeparator = { fg = c.line_number },
    VertSplit = { link = "WinSeparator" },
    WinBar = { fg = c.fg, bg = bg },
    WinBarNC = { fg = c.line_number, bg = bg },

    -- Floating Windows
    FloatBorder = { fg = c.line_number, bg = cfg.transparent and "NONE" or c.line_highlight },
    FloatTitle = { fg = c.fg, bg = cfg.transparent and "NONE" or c.line_highlight },

    -- Tab Line
    TabLine = { fg = c.line_number, bg = c.statusline_bg },
    TabLineFill = { bg = c.statusline_bg },
    TabLineSel = { fg = c.fg, bg = bg },

    -- Folding
    Folded = { fg = c.line_number, bg = c.line_highlight },
    FoldColumn = { fg = c.line_number, bg = bg },

    -- Messages & Command Line
    ErrorMsg = { fg = c.invalid_fg },
    WarningMsg = { fg = c.warning },
    ModeMsg = { fg = c.fg, bold = true },
    MoreMsg = { fg = c.string },
    Question = { fg = c.string },
    MsgArea = { fg = c.fg },

    -- Special Text
    NonText = { fg = c.line_number },
    EndOfBuffer = { fg = c.line_number },
    Whitespace = { fg = c.line_number },
    SpecialKey = { fg = c.line_number },
    Conceal = { fg = c.punctuation },

    -- Columns & Lines
    ColorColumn = { bg = c.line_highlight },
    CursorColumn = { bg = c.line_highlight },
    CursorLineFold = { fg = c.line_number, bg = c.line_highlight },
    CursorLineSign = { bg = c.line_highlight },

    -- Navigation & Selection
    Directory = { fg = c.entity },
    Title = { fg = c.entity, bold = true },
    WildMenu = { fg = c.fg, bg = c.selection },
    QuickFixLine = { bg = c.selection },

    -- Diff
    DiffAdd = { bg = c.diff_add_bg, fg = c.diff_text },
    DiffChange = { bg = c.diff_change_bg, fg = c.diff_text },
    DiffDelete = { bg = c.diff_delete_bg, fg = c.diff_text },
    DiffText = { bg = c.diff_change_bg, fg = c.diff_text },

    -- Spelling
    SpellBad = { undercurl = true, sp = c.invalid_fg },
    SpellCap = { undercurl = true, sp = c.entity },
    SpellRare = { undercurl = true, sp = c.constant },
    SpellLocal = { undercurl = true, sp = c.string },

    -- LSP Diagnostics
    DiagnosticError = { fg = c.invalid_fg },
    DiagnosticWarn = { fg = c.warning },
    DiagnosticInfo = { fg = c.info },
    DiagnosticHint = { fg = c.hint },

    DiagnosticVirtualTextError = { fg = c.invalid_fg, bg = c.invalid_bg },
    DiagnosticVirtualTextWarn = { fg = c.warning },
    DiagnosticVirtualTextInfo = { fg = c.info },
    DiagnosticVirtualTextHint = { fg = c.hint },

    DiagnosticUnderlineError = { undercurl = true, sp = c.invalid_fg },
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning },
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.info },
    DiagnosticUnderlineHint = { undercurl = true, sp = c.hint },

    DiagnosticSignError = { fg = c.invalid_fg },
    DiagnosticSignWarn = { fg = c.warning },
    DiagnosticSignInfo = { fg = c.info },
    DiagnosticSignHint = { fg = c.hint },

    DiagnosticFloatingError = { fg = c.invalid_fg },
    DiagnosticFloatingWarn = { fg = c.warning },
    DiagnosticFloatingInfo = { fg = c.info },
    DiagnosticFloatingHint = { fg = c.hint },

    -- LSP References
    LspReferenceText = { bg = c.selection_highlight },
    LspReferenceRead = { bg = c.selection_highlight },
    LspReferenceWrite = { bg = c.selection_highlight },

    -- LSP Codelens & Inlay Hints
    LspCodeLens = { fg = c.line_number },
    LspCodeLensSeparator = { fg = c.line_number },
    LspInlayHint = { fg = c.line_number, bg = c.line_highlight },

    -- Treesitter
    ["@comment"] = comment_style,
    ["@string"] = { link = "String" },
    ["@string.escape"] = { fg = c.escape },
    ["@string.regexp"] = { link = "String" },
    ["@number"] = { link = "Number" },
    ["@boolean"] = { link = "Boolean" },
    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { link = "Constant" },
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Function" },
    ["@function.macro"] = { link = "Function" },
    ["@keyword"] = { fg = c.fg },
    ["@keyword.function"] = { fg = c.fg },
    ["@keyword.operator"] = { fg = c.fg },
    ["@keyword.return"] = { fg = c.fg },
    ["@operator"] = { fg = c.fg },
    ["@punctuation.delimiter"] = { fg = c.punctuation },
    ["@punctuation.bracket"] = { fg = c.punctuation },
    ["@punctuation.special"] = { fg = c.punctuation },
    ["@variable"] = { fg = c.fg },
    ["@variable.builtin"] = { fg = c.fg },
    ["@type"] = { fg = c.fg },
    ["@type.builtin"] = { fg = c.fg },
    ["@tag"] = { fg = c.entity },
    ["@tag.attribute"] = { fg = c.fg },
    ["@tag.delimiter"] = { fg = c.punctuation },
    ["@symbol"] = { fg = c.constant },
    ["@symbol.clojure"] = { fg = c.constant },
    ["@keyword.clojure"] = { fg = c.constant },
    ["@namespace"] = { fg = c.entity },
    ["@function.call"] = { fg = c.fg },
    ["@method.call"] = { fg = c.fg },
    ["@type.definition"] = { fg = c.entity },
    ["@type.qualifier"] = { fg = c.fg },
    ["@variable.parameter"] = { fg = c.fg },
    ["@variable.member"] = { fg = c.fg },

    -- Treesitter (newer captures)
    ["@module"] = { fg = c.entity },
    ["@property"] = { fg = c.fg },
    ["@constructor"] = { fg = c.entity },
    ["@attribute"] = { fg = c.constant },
    ["@label"] = { fg = c.fg },
    ["@character.special"] = { fg = c.escape },
    ["@string.special"] = { fg = c.escape },
    ["@string.special.url"] = { fg = c.entity, underline = true },
    ["@string.special.path"] = { fg = c.string },

    -- Markup (markdown, docs, etc.)
    ["@markup.heading"] = { fg = c.entity, bold = true },
    ["@markup.heading.1"] = { fg = c.entity, bold = true },
    ["@markup.heading.2"] = { fg = c.entity, bold = true },
    ["@markup.heading.3"] = { fg = c.entity, bold = true },
    ["@markup.heading.4"] = { fg = c.entity, bold = true },
    ["@markup.heading.5"] = { fg = c.entity, bold = true },
    ["@markup.heading.6"] = { fg = c.entity, bold = true },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.quote"] = { fg = c.comment, italic = true },
    ["@markup.math"] = { fg = c.constant },
    ["@markup.link"] = { fg = c.entity, underline = true },
    ["@markup.link.label"] = { fg = c.entity },
    ["@markup.link.url"] = { fg = c.string, underline = true },
    ["@markup.raw"] = { fg = c.string },
    ["@markup.raw.block"] = { fg = c.string },
    ["@markup.list"] = { fg = c.punctuation },
    ["@markup.list.checked"] = { fg = c.string },
    ["@markup.list.unchecked"] = { fg = c.punctuation },

    -- LSP Semantic Tokens
    ["@lsp.type.class"] = { fg = c.entity },
    ["@lsp.type.decorator"] = { fg = c.constant },
    ["@lsp.type.enum"] = { fg = c.entity },
    ["@lsp.type.enumMember"] = { fg = c.constant },
    ["@lsp.type.function"] = { link = "Function" },
    ["@lsp.type.interface"] = { fg = c.entity },
    ["@lsp.type.macro"] = { link = "Function" },
    ["@lsp.type.method"] = { link = "Function" },
    ["@lsp.type.namespace"] = { fg = c.entity },
    ["@lsp.type.parameter"] = { fg = c.fg },
    ["@lsp.type.property"] = { fg = c.fg },
    ["@lsp.type.struct"] = { fg = c.entity },
    ["@lsp.type.type"] = { fg = c.fg },
    ["@lsp.type.typeParameter"] = { fg = c.entity },
    ["@lsp.type.variable"] = { fg = c.fg },
    ["@lsp.mod.deprecated"] = { strikethrough = true },
    ["@lsp.mod.readonly"] = { fg = c.constant },
    ["@lsp.mod.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },

    -- nvim-cmp
    CmpItemAbbr = { fg = c.fg },
    CmpItemAbbrDeprecated = { fg = c.punctuation, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.entity, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = c.entity },
    CmpItemKind = { fg = c.constant },
    CmpItemKindClass = { fg = c.entity },
    CmpItemKindColor = { fg = c.constant },
    CmpItemKindConstant = { fg = c.constant },
    CmpItemKindConstructor = { fg = c.entity },
    CmpItemKindEnum = { fg = c.entity },
    CmpItemKindEnumMember = { fg = c.constant },
    CmpItemKindEvent = { fg = c.entity },
    CmpItemKindField = { fg = c.fg },
    CmpItemKindFile = { fg = c.fg },
    CmpItemKindFolder = { fg = c.entity },
    CmpItemKindFunction = { fg = c.entity },
    CmpItemKindInterface = { fg = c.entity },
    CmpItemKindKeyword = { fg = c.fg },
    CmpItemKindMethod = { fg = c.entity },
    CmpItemKindModule = { fg = c.entity },
    CmpItemKindOperator = { fg = c.fg },
    CmpItemKindProperty = { fg = c.fg },
    CmpItemKindReference = { fg = c.fg },
    CmpItemKindSnippet = { fg = c.string },
    CmpItemKindStruct = { fg = c.entity },
    CmpItemKindText = { fg = c.fg },
    CmpItemKindTypeParameter = { fg = c.entity },
    CmpItemKindUnit = { fg = c.constant },
    CmpItemKindValue = { fg = c.constant },
    CmpItemKindVariable = { fg = c.fg },
    CmpItemMenu = { fg = c.punctuation },

    -- Telescope
    TelescopeBorder = { fg = c.line_number },
    TelescopeTitle = { fg = c.entity, bold = true },
    TelescopePromptBorder = { fg = c.line_number },
    TelescopePromptTitle = { fg = c.entity, bold = true },
    TelescopePromptPrefix = { fg = c.entity },
    TelescopePromptCounter = { fg = c.punctuation },
    TelescopeResultsBorder = { fg = c.line_number },
    TelescopeResultsTitle = { fg = c.entity, bold = true },
    TelescopePreviewBorder = { fg = c.line_number },
    TelescopePreviewTitle = { fg = c.entity, bold = true },
    TelescopeMatching = { fg = c.entity, bold = true },
    TelescopeSelection = { bg = c.selection_highlight },
    TelescopeSelectionCaret = { fg = c.entity, bg = c.selection_highlight },
    TelescopeMultiSelection = { bg = c.selection },
    TelescopeMultiIcon = { fg = c.entity },

    -- Gitsigns
    GitSignsAdd = { fg = c.string },
    GitSignsChange = { fg = c.info },
    GitSignsDelete = { fg = c.invalid_fg },
    GitSignsAddNr = { fg = c.string },
    GitSignsChangeNr = { fg = c.info },
    GitSignsDeleteNr = { fg = c.invalid_fg },
    GitSignsAddLn = { bg = c.diff_add_bg },
    GitSignsChangeLn = { bg = c.diff_change_bg },
    GitSignsDeleteLn = { bg = c.diff_delete_bg },
    GitSignsCurrentLineBlame = { fg = c.line_number },

    -- Indent Blankline
    IblIndent = { fg = c.line_highlight },
    IblScope = { fg = c.line_number },
    IndentBlanklineChar = { fg = c.line_highlight },
    IndentBlanklineContextChar = { fg = c.line_number },

    -- Neo-tree
    NeoTreeNormal = { fg = c.fg, bg = bg },
    NeoTreeNormalNC = { fg = c.fg, bg = bg },
    NeoTreeDirectoryName = { fg = c.entity },
    NeoTreeDirectoryIcon = { fg = c.entity },
    NeoTreeRootName = { fg = c.entity, bold = true },
    NeoTreeFileName = { fg = c.fg },
    NeoTreeFileIcon = { fg = c.fg },
    NeoTreeFileNameOpened = { fg = c.entity },
    NeoTreeIndentMarker = { fg = c.line_number },
    NeoTreeGitAdded = { fg = c.string },
    NeoTreeGitConflict = { fg = c.invalid_fg },
    NeoTreeGitDeleted = { fg = c.invalid_fg },
    NeoTreeGitIgnored = { fg = c.line_number },
    NeoTreeGitModified = { fg = c.info },
    NeoTreeGitUnstaged = { fg = c.warning },
    NeoTreeGitUntracked = { fg = c.punctuation },
    NeoTreeGitStaged = { fg = c.string },
    NeoTreeFloatBorder = { fg = c.line_number },
    NeoTreeFloatTitle = { fg = c.entity, bold = true },
    NeoTreeTitleBar = { fg = c.fg, bg = c.statusline_bg },
    NeoTreeCursorLine = { bg = c.line_highlight },
    NeoTreeDimText = { fg = c.line_number },
    NeoTreeDotfile = { fg = c.line_number },
    NeoTreeModified = { fg = c.warning },
    NeoTreeSymbolicLinkTarget = { fg = c.info, underline = true },

    -- Which-key
    WhichKey = { fg = c.entity },
    WhichKeyGroup = { fg = c.constant },
    WhichKeySeparator = { fg = c.punctuation },
    WhichKeyDesc = { fg = c.fg },
    WhichKeyValue = { fg = c.punctuation },
    WhichKeyFloat = { bg = c.line_highlight },
    WhichKeyBorder = { fg = c.line_number },

    -- Lazy.nvim
    LazyH1 = { fg = c.bg, bg = c.entity, bold = true },
    LazyH2 = { fg = c.entity, bold = true },
    LazyComment = { fg = c.comment },
    LazyNormal = { fg = c.fg, bg = bg },
    LazyCommit = { fg = c.punctuation },
    LazyCommitIssue = { fg = c.constant },
    LazyCommitType = { fg = c.entity },
    LazyCommitScope = { fg = c.fg },
    LazyDimmed = { fg = c.line_number },
    LazyProp = { fg = c.punctuation },
    LazyValue = { fg = c.string },
    LazyReasonCmd = { fg = c.warning },
    LazyReasonEvent = { fg = c.constant },
    LazyReasonFt = { fg = c.info },
    LazyReasonImport = { fg = c.fg },
    LazyReasonKeys = { fg = c.entity },
    LazyReasonPlugin = { fg = c.string },
    LazyReasonRequire = { fg = c.constant },
    LazyReasonRuntime = { fg = c.warning },
    LazyReasonSource = { fg = c.info },
    LazyReasonStart = { fg = c.string },
    LazySpecial = { fg = c.entity },
    LazyButton = { fg = c.fg, bg = c.statusline_bg },
    LazyButtonActive = { fg = c.bg, bg = c.entity, bold = true },
    LazyProgressDone = { fg = c.string },
    LazyProgressTodo = { fg = c.line_number },

    -- nvim-notify
    NotifyERRORBorder = { fg = c.invalid_fg },
    NotifyERRORIcon = { fg = c.invalid_fg },
    NotifyERRORTitle = { fg = c.invalid_fg },
    NotifyERRORBody = { fg = c.fg },
    NotifyWARNBorder = { fg = c.warning },
    NotifyWARNIcon = { fg = c.warning },
    NotifyWARNTitle = { fg = c.warning },
    NotifyWARNBody = { fg = c.fg },
    NotifyINFOBorder = { fg = c.info },
    NotifyINFOIcon = { fg = c.info },
    NotifyINFOTitle = { fg = c.info },
    NotifyINFOBody = { fg = c.fg },
    NotifyDEBUGBorder = { fg = c.punctuation },
    NotifyDEBUGIcon = { fg = c.punctuation },
    NotifyDEBUGTitle = { fg = c.punctuation },
    NotifyDEBUGBody = { fg = c.fg },
    NotifyTRACEBorder = { fg = c.constant },
    NotifyTRACEIcon = { fg = c.constant },
    NotifyTRACETitle = { fg = c.constant },
    NotifyTRACEBody = { fg = c.fg },
    NotifyBackground = { bg = bg },

    -- Noice
    NoiceCmdline = { fg = c.fg },
    NoiceCmdlineIcon = { fg = c.entity },
    NoiceCmdlineIconSearch = { fg = c.warning },
    NoiceCmdlinePopup = { fg = c.fg, bg = c.line_highlight },
    NoiceCmdlinePopupBorder = { fg = c.line_number },
    NoiceCmdlinePopupBorderSearch = { fg = c.warning },
    NoiceCmdlinePrompt = { fg = c.entity },
    NoiceConfirm = { fg = c.fg, bg = c.line_highlight },
    NoiceConfirmBorder = { fg = c.line_number },
    NoiceFormatConfirm = { fg = c.fg },
    NoiceFormatConfirmDefault = { fg = c.entity },
    NoiceMini = { fg = c.fg, bg = c.line_highlight },
    NoicePopup = { fg = c.fg, bg = c.line_highlight },
    NoicePopupBorder = { fg = c.line_number },
    NoicePopupmenu = { fg = c.fg, bg = c.line_highlight },
    NoicePopupmenuBorder = { fg = c.line_number },
    NoicePopupmenuMatch = { fg = c.entity, bold = true },
    NoicePopupmenuSelected = { bg = c.selection_highlight },
    NoiceScrollbar = { fg = c.punctuation },
    NoiceScrollbarThumb = { bg = c.punctuation },
    NoiceSplit = { fg = c.fg, bg = bg },
    NoiceSplitBorder = { fg = c.line_number },
    NoiceVirtualText = { fg = c.info },
  }

  for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
  end

  vim.g.terminal_color_0 = c.term_black
  vim.g.terminal_color_1 = c.term_red
  vim.g.terminal_color_2 = c.term_green
  vim.g.terminal_color_3 = c.term_yellow
  vim.g.terminal_color_4 = c.term_blue
  vim.g.terminal_color_5 = c.term_magenta
  vim.g.terminal_color_6 = c.term_cyan
  vim.g.terminal_color_7 = c.term_white
  vim.g.terminal_color_8 = c.term_bright_black
  vim.g.terminal_color_9 = c.term_bright_red
  vim.g.terminal_color_10 = c.term_bright_green
  vim.g.terminal_color_11 = c.term_bright_yellow
  vim.g.terminal_color_12 = c.term_bright_blue
  vim.g.terminal_color_13 = c.term_bright_magenta
  vim.g.terminal_color_14 = c.term_bright_cyan
  vim.g.terminal_color_15 = c.term_bright_white

  -- Create user command
  vim.api.nvim_create_user_command("Alabaster", function(opts)
    local arg = opts.args:lower()
    if arg == "dark" then
      M.config.style = "dark"
      M.setup(M.config)
    elseif arg == "light" then
      M.config.style = "light"
      M.setup(M.config)
    elseif arg == "toggle" then
      M.config.style = M.config.style == "dark" and "light" or "dark"
      M.setup(M.config)
    else
      print("Alabaster: usage - :Alabaster [dark|light|toggle]")
    end
  end, {
    nargs = 1,
    complete = function()
      return { "dark", "light", "toggle" }
    end,
  })
end

return M
