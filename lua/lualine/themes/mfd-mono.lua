-- lualine theme for mfd-mono colorscheme
-- near-black bg (#08080C), cool off-white fg (#D0D0D8)
return {
  normal = {
    a = { fg = '#08080C', bg = '#D0D0D8', gui = 'bold' },
    b = { fg = '#F0F0FF', bg = '#1A1A22' },
    c = { fg = '#D0D0D8', bg = '#0C0C10' },
  },
  insert = {
    a = { fg = '#08080C', bg = '#F0F0FF', gui = 'bold' },
    b = { fg = '#F0F0FF', bg = '#1A1A22' },
    c = { fg = '#D0D0D8', bg = '#0C0C10' },
  },
  visual = {
    a = { fg = '#08080C', bg = '#9898A0', gui = 'bold' },
    b = { fg = '#F0F0FF', bg = '#1A1A22' },
    c = { fg = '#D0D0D8', bg = '#0C0C10' },
  },
  replace = {
    a = { fg = '#08080C', bg = '#B0B0B8', gui = 'bold' },
    b = { fg = '#F0F0FF', bg = '#1A1A22' },
    c = { fg = '#D0D0D8', bg = '#0C0C10' },
  },
  command = {
    a = { fg = '#08080C', bg = '#D0D0D8', gui = 'bold' },
    b = { fg = '#F0F0FF', bg = '#1A1A22' },
    c = { fg = '#D0D0D8', bg = '#0C0C10' },
  },
  inactive = {
    a = { fg = '#282830', bg = '#0C0C10' },
    b = { fg = '#282830', bg = '#0C0C10' },
    c = { fg = '#282830', bg = '#0C0C10' },
  },
}
