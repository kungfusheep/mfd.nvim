# mfd.nvim

Monotone colorschemes for Neovim. Aesthetic inspiration from [U.S. Graphics Company](https://usgraphics.com) — thanks for the beautiful work.

Ten variants, from phosphor CRTs to night vision.

> [!TIP]
> **New:**  
> `mfd-blackout` true black, ultra-low contrast for late night use.  
> `bright_comments` option increases comment visibility for all themes.


## Themes

### mfd / mfd-dark
Olive sage.

![mfd](screenshots/mfd.png)
![mfd-dark](screenshots/mfd-dark.png)

### mfd-stealth
Green phosphor.

![mfd-stealth](screenshots/mfd-stealth.png)

### mfd-amber
Amber phosphor.

![mfd-amber](screenshots/mfd-amber.png)

### mfd-mono
White phosphor.

![mfd-mono](screenshots/mfd-mono.png)

### mfd-scarlet
Deep red.

![mfd-scarlet](screenshots/mfd-scarlet.png)

### mfd-paper
High contrast terminal.

![mfd-paper](screenshots/mfd-paper.png)

### mfd-hud
Heads-up display.

![mfd-hud](screenshots/mfd-hud.png)

### mfd-nvg
Night vision goggles.

![mfd-nvg](screenshots/mfd-nvg.png)

### mfd-blackout
Covert lighting conditions.

![mfd-blackout](screenshots/mfd-blackout.png)

## Installation

```lua
-- lazy.nvim
{
  'kungfusheep/mfd.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd('colorscheme mfd-stealth')
  end,
}
```

## Approach

Syntax differentiation through text decoration, not colour:

- **Bold** — keywords, functions
- *Italic* — strings, comments, parameters
- <ins>Underline</ins> — types, structures

Lualine themes are included for each variant.

## Cursor sync

Each theme defines per-mode cursor highlights (`CursorNormal`, `CursorInsert`, `CursorVisual`, `CursorReplace`, `CursorCommand`). To sync these to your terminal cursor via OSC 12 (works with Ghostty, kitty, etc.):

```lua
{
  'kungfusheep/mfd.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd('colorscheme mfd-stealth')

    vim.opt.guicursor = {
      "n:block-CursorNormal",
      "v:block-CursorVisual",
      "i:block-CursorInsert",
      "r-cr:block-CursorReplace",
      "c:block-CursorCommand",
    }

    require('mfd').enable_cursor_sync()
  end,
}
```

## Options

Call `setup()` before setting the colorscheme:

```lua
require('mfd').setup({
  bright_comments = true, -- increase comment visibility (default: false)
})
```

## License

Apache 2.0 [LICENSE](LICENSE)


