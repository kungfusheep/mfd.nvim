-- lualine theme for mfd-paper colorscheme
-- cream/green-gray bg (#BBC5B7), dark forest fg (#002611)
return {
  normal = {
    a = { fg = '#BBC5B7', bg = '#002611', gui = 'bold' },
    b = { fg = '#002611', bg = '#A5B2A2' },
    c = { fg = '#002611', bg = '#B0BAB0' },
  },
  insert = {
    a = { fg = '#BBC5B7', bg = '#001008', gui = 'bold' },
    b = { fg = '#002611', bg = '#A5B2A2' },
    c = { fg = '#002611', bg = '#B0BAB0' },
  },
  visual = {
    a = { fg = '#001008', bg = '#95A592', gui = 'bold' },
    b = { fg = '#002611', bg = '#A5B2A2' },
    c = { fg = '#002611', bg = '#B0BAB0' },
  },
  replace = {
    a = { fg = '#BBC5B7', bg = '#1A3620', gui = 'bold' },
    b = { fg = '#002611', bg = '#A5B2A2' },
    c = { fg = '#002611', bg = '#B0BAB0' },
  },
  command = {
    a = { fg = '#BBC5B7', bg = '#002611', gui = 'bold' },
    b = { fg = '#002611', bg = '#A5B2A2' },
    c = { fg = '#002611', bg = '#B0BAB0' },
  },
  inactive = {
    a = { fg = '#8A9A88', bg = '#B0BAB0' },
    b = { fg = '#8A9A88', bg = '#B0BAB0' },
    c = { fg = '#8A9A88', bg = '#B0BAB0' },
  },
}
