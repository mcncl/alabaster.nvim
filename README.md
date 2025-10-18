# alabaster.nvim

A port of the [Alabaster theme](https://github.com/tonsky/vscode-theme-alabaster) for Neovim. A light, minimal theme that highlights what matters.

## Philosophy

Alabaster is a minimal color scheme that only highlights:
- **Strings** (green)
- **Constants** (purple) - numbers, characters, symbols, booleans
- **Comments** (red) - prominently displayed, not dimmed
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

### Using [pack](https://neovim.io/doc/user/pack.html)

```vim
{
  src = 'mcncl/alabaster.nvim',
}
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
  transparent = false,      -- Enable transparent background
  italic_comments = false,  -- Enable italic comments
})

vim.cmd.colorscheme('alabaster')
```

## Features

- Full Treesitter support
- LSP diagnostic colors
- Minimal, distraction-free highlighting
- Faithful port of the original VS Code theme

## Color Palette

- **Background**: `#F7F7F7`
- **Foreground**: `#000000`
- **Comments**: `#AA3731` (red)
- **Strings**: `#448C27` (green)
- **Constants**: `#7A3E9D` (purple)
- **Functions/Entities**: `#325CC0` (blue)
- **Punctuation**: `#777777` (gray)

## Credits

Original theme by [Nikita Prokopov](https://github.com/tonsky)
