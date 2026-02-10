# mfd.nvim

Monotone colorschemes for Neovim. Aesthetic inspiration from [U.S. Graphics Company](https://usgraphics.com) — thanks for the beautiful work.

Fourteen variants, from phosphor CRTs to night vision.

> [!TIP]
> **New:**  
> `mfd-flir` 4 new thermal display schemes.  
> `mfd-blackout` true black, ultra-low contrast for late night use.  
> `bright_comments` option increases comment visibility for all themes.


## Themes

### MFD / MFD-DARK
Olive sage.

![MFD](screenshots/mfd.png)
![MFD-DARK](screenshots/mfd-dark.png)

### MFD-STEALTH
Green phosphor.

![MFD-STEALTH](screenshots/mfd-stealth.png)

### MFD-AMBER
Amber phosphor.

![MFD-AMBER](screenshots/mfd-amber.png)

### MFD-MONO
White phosphor.

![MFD-MONO](screenshots/mfd-mono.png)

### MFD-SCARLET
Deep red.

![MFD-SCARLET](screenshots/mfd-scarlet.png)

### MFD-PAPER
High contrast terminal.

![MFD-PAPER](screenshots/mfd-paper.png)

### MFD-HUD
Heads-up display.

![MFD-HUD](screenshots/mfd-hud.png)

### MFD-NVG
Night vision goggles.

![MFD-NVG](screenshots/mfd-nvg.png)

### MFD-BLACKOUT
Covert lighting conditions.

![MFD-BLACKOUT](screenshots/mfd-blackout.png)

### MFD-FLIR
White-hot thermal.

![MFD-FLIR](screenshots/mfd-flir.png)

### MFD-FLIR-BH
Black-hot thermal.

![MFD-FLIR-BH](screenshots/mfd-flir-bh.png)

### MFD-FLIR-RH
Red-hot thermal.

![MFD-FLIR-RH](screenshots/mfd-flir-rh.png)

### MFD-FLIR-FUSION
Thermal fusion.

![MFD-FLIR-FUSION](screenshots/mfd-flir-fusion.png)

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


