-- Lualine theme for Alabaster
-- Supports both light and dark modes based on vim.o.background

local colors = {
  light = {
    bg = "#F7F7F7",
    fg = "#000000",
    comment = "#9DA39A",
    replace = "#9DA39A",
    string = "#448C27",
    constant = "#7A3E9D",
    entity = "#325CC0",
    line_highlight = "#F0F0F0",
    statusline_bg = "#DDDDDD",
    statusline_fg = "#474747",
    warning = "#CB9000",
    info = "#0083B2",
  },
  dark = {
    bg = "#0E1415",
    fg = "#CECECE",
    comment = "#6B7678",
    replace = "#6B7678",
    string = "#91B362",
    constant = "#B77FDB",
    entity = "#6199D9",
    line_highlight = "#1A1F20",
    statusline_bg = "#1A1F20",
    statusline_fg = "#999999",
    warning = "#D9B76C",
    info = "#5AAEBD",
  },
}

local function get_colors()
  if vim.o.background == "dark" then
    return colors.dark
  end
  return colors.light
end

local function generate_theme()
  local c = get_colors()

  return {
    normal = {
      a = { fg = c.bg, bg = c.entity, gui = "bold" },
      b = { fg = c.fg, bg = c.statusline_bg },
      c = { fg = c.statusline_fg, bg = c.line_highlight },
    },
    insert = {
      a = { fg = c.bg, bg = c.string, gui = "bold" },
      b = { fg = c.fg, bg = c.statusline_bg },
      c = { fg = c.statusline_fg, bg = c.line_highlight },
    },
    visual = {
      a = { fg = c.bg, bg = c.constant, gui = "bold" },
      b = { fg = c.fg, bg = c.statusline_bg },
      c = { fg = c.statusline_fg, bg = c.line_highlight },
    },
    replace = {
      a = { fg = c.bg, bg = c.replace, gui = "bold" },
      b = { fg = c.fg, bg = c.statusline_bg },
      c = { fg = c.statusline_fg, bg = c.line_highlight },
    },
    command = {
      a = { fg = c.bg, bg = c.warning, gui = "bold" },
      b = { fg = c.fg, bg = c.statusline_bg },
      c = { fg = c.statusline_fg, bg = c.line_highlight },
    },
    inactive = {
      a = { fg = c.statusline_fg, bg = c.line_highlight },
      b = { fg = c.statusline_fg, bg = c.line_highlight },
      c = { fg = c.statusline_fg, bg = c.line_highlight },
    },
  }
end

return generate_theme()
