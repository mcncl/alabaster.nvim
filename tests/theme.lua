-- Run from the repository root: nvim --clean --headless -l tests/theme.lua
local cache_root = vim.fn.tempname()
vim.env.XDG_CACHE_HOME = cache_root
vim.opt.runtimepath:prepend(vim.fn.getcwd())

local failures = 0
local function test(name, run)
  vim.g.colors_name = nil
  vim.fn.delete(cache_root, "rf")
  package.loaded.alabaster = nil
  local ok, err = pcall(run)
  if ok then
    print("PASS: " .. name)
  else
    failures = failures + 1
    print("FAIL: " .. name .. ": " .. tostring(err))
  end
end

local function hl(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

test("toggle follows the displayed style and persists it", function()
  vim.o.background = "dark"
  vim.cmd.colorscheme("alabaster")
  assert(vim.o.background == "dark")
  vim.cmd("Alabaster toggle")
  assert(vim.o.background == "light", "first toggle must switch dark to light")
  assert(vim.fn.readfile(vim.fn.stdpath("cache") .. "/alabaster")[1] == "light")
  vim.cmd("Alabaster toggle")
  assert(vim.o.background == "dark")
end)

test("cached style wins over background, explicit style wins over cache", function()
  vim.fn.mkdir(vim.fn.stdpath("cache"), "p")
  vim.fn.writefile({ "light" }, vim.fn.stdpath("cache") .. "/alabaster")
  vim.o.background = "dark"
  vim.cmd.colorscheme("alabaster")
  assert(vim.o.background == "light")
  require("alabaster").setup({ style = "dark" })
  assert(vim.o.background == "dark")
  assert(vim.g.colors_name == "alabaster")
end)

test("invalid style leaves the active theme and configuration unchanged", function()
  local theme = require("alabaster")
  theme.setup({ style = "dark" })
  local normal = hl("Normal")
  local ok = pcall(theme.setup, { style = "drak" })
  assert(not ok, "invalid style must report an error")
  assert(theme.config.style == "dark")
  assert(vim.deep_equal(normal, hl("Normal")))
end)

test("word diffs remain distinct from changed lines in both styles", function()
  for _, style in ipairs({ "light", "dark" }) do
    require("alabaster").setup({ style = style })
    assert(not vim.deep_equal(hl("DiffText"), hl("DiffChange")), style)
  end
end)

test("method calls stay neutral while definitions remain highlighted", function()
  for _, style in ipairs({ "light", "dark" }) do
    require("alabaster").setup({ style = style })
    assert(hl("@function.method.call").fg == hl("Normal").fg, style)
    local definition_fg = hl("@function.method").fg
    assert(definition_fg ~= nil and definition_fg == hl("Function").fg, style)
    assert(hl("@character").fg == hl("Constant").fg, style)
  end
end)

test("options survive colorscheme reloads and style switches", function()
  require("alabaster").setup({ style = "light", transparent = true, italic_comments = true })
  vim.cmd.colorscheme("alabaster")
  vim.cmd("Alabaster dark")
  assert(hl("Normal").bg == nil)
  assert(hl("NormalFloat").bg == nil)
  assert(hl("Comment").italic)
  assert(hl("@comment").italic)
end)

test("style switching still works when the cache directory is unavailable", function()
  require("alabaster").setup({ style = "light" })
  vim.fn.mkdir(cache_root, "p")
  vim.fn.writefile({ "not a directory" }, vim.fn.stdpath("cache"))
  vim.cmd("Alabaster dark")
  assert(vim.o.background == "dark")
  assert(hl("Normal").fg == tonumber(require("alabaster").colors.dark.fg:sub(2), 16))
end)

vim.fn.delete(cache_root, "rf")
vim.cmd(failures == 0 and "qa!" or "cquit")
