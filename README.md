# alabaster.nvim

A port of the [Alabaster theme](https://github.com/tonsky/vscode-theme-alabaster) for Neovim. A light, minimal theme that highlights what matters.

## Philosophy

Alabaster is a minimal color scheme that only highlights:
- **Strings** (green)
- **Constants** (purple) - numbers, characters, symbols, booleans
- **Comments** (muted gray) - de-emphasized so code stays the focus
- **Global definitions** (blue) - function names, tags

Keywords like `if`, `else`, `function`, etc. are left unhighlighted as they're self-evident.

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'mcncl/alabaster.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('alabaster')
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'mcncl/alabaster.nvim',
  config = function()
    vim.cmd.colorscheme('alabaster')
  end
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'mcncl/alabaster.nvim'
```

### Using [vim.pack](https://neovim.io/doc/user/pack.html) (Neovim 0.12+)

```lua
vim.pack.add({
  { src = 'https://github.com/mcncl/alabaster.nvim' },
})
```

Then add to your `init.vim` or `init.lua`:

```vim
colorscheme alabaster
```

## Usage

For Neovim:

```lua
vim.cmd.colorscheme('alabaster')
```

Or in Vimscript:

```vim
colorscheme alabaster
```

## Configuration

You can customize the theme with optional settings:

```lua
require('alabaster').setup({
  style = nil,              -- "light", "dark", or nil for automatic selection
  transparent = false,      -- Enable transparent background
  italic_comments = false,  -- Enable italic comments
})

vim.cmd.colorscheme('alabaster')
```

With no explicit style, Alabaster uses the last style saved by `:Alabaster`,
then falls back to Neovim's `background` option. An invalid style reports an
error without changing the active theme.

Use a true-color terminal and enable `vim.opt.termguicolors = true` to display
the palette accurately.

### Dark Mode

```lua
require('alabaster').setup({
  style = "dark",
})

vim.cmd.colorscheme('alabaster')
```

Switch styles with `:Alabaster light`, `:Alabaster dark`, or `:Alabaster toggle`.
These commands save the choice to `stdpath('cache') .. '/alabaster'` for future
sessions. If the cache cannot be written, the style still changes for the current
session. An explicit `setup({ style = ... })` takes precedence at startup.

## Features

- Full Treesitter support
- LSP diagnostic colors
- Minimal, distraction-free highlighting
- Faithful port of the original VS Code theme

## Color Palette

- **Background**: `#F7F7F7`
- **Foreground**: `#000000`
- **Comments**: `#9DA39A` (muted gray)
- **Strings**: `#448C27` (green)
- **Constants**: `#7A3E9D` (purple)
- **Functions/Entities**: `#325CC0` (blue)
- **Punctuation**: `#777777` (gray)

## Tests

Run the regression checks from the repository root with Neovim 0.9+:

```sh
nvim --clean --headless -l tests/theme.lua
```

The checks use a temporary cache and do not change your saved style.

## Credits

Original theme by [Nikita Prokopov](https://github.com/tonsky)
