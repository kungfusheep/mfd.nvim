-- lualine theme for mfd-stealth colorscheme
-- near-black bg (#0D1410), muted sage fg (#7A9A7A)
return {
  normal = {
    a = { fg = '#0D1410', bg = '#7A9A7A', gui = 'bold' },
    b = { fg = '#9ABB9A', bg = '#1A2A1A' },
    c = { fg = '#7A9A7A', bg = '#101810' },
  },
  insert = {
    a = { fg = '#0D1410', bg = '#9ABB9A', gui = 'bold' },
    b = { fg = '#9ABB9A', bg = '#1A2A1A' },
    c = { fg = '#7A9A7A', bg = '#101810' },
  },
  visual = {
    a = { fg = '#0D1410', bg = '#557755', gui = 'bold' },
    b = { fg = '#9ABB9A', bg = '#1A2A1A' },
    c = { fg = '#7A9A7A', bg = '#101810' },
  },
  replace = {
    a = { fg = '#0D1410', bg = '#8A7A6A', gui = 'bold' },
    b = { fg = '#9ABB9A', bg = '#1A2A1A' },
    c = { fg = '#7A9A7A', bg = '#101810' },
  },
  command = {
    a = { fg = '#0D1410', bg = '#7A9A7A', gui = 'bold' },
    b = { fg = '#9ABB9A', bg = '#1A2A1A' },
    c = { fg = '#7A9A7A', bg = '#101810' },
  },
  inactive = {
    a = { fg = '#253828', bg = '#101810' },
    b = { fg = '#253828', bg = '#101810' },
    c = { fg = '#253828', bg = '#101810' },
  },
}
