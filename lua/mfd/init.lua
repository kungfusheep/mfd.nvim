-- MFD: Multi-Function Display colorscheme for Neovim
-- Monotone themes using text decoration for syntax highlighting

local M = {}

M.config = {
	bright_comments = false,
}

function M.setup(opts)
	M.config = vim.tbl_extend("force", M.config, opts or {})
end

-- Color palettes for each variant
M.palettes = {
	mfd = {
		bg = "#7A8B69",
		fg = "#1E2D1E",
		dim = "#4A5B3A",
		bright = "#0D1D0D",
		subtle = "#8A9B70",
		visual = "#6A7B59",
		cursor = "#6A7B59",
		border = "#5A6B4A",
		float_bg = "#5A6B4A",
	},
	["mfd-dark"] = {
		bg = "#1E2D1E",
		fg = "#8A9B70",
		dim = "#3A4A3A",
		bright = "#A0B180",
		subtle = "#2E3E2E",
		visual = "#2A3D2A",
		cursor = "#2A3D2A",
		border = "#3A4B2A",
		float_bg = "#253525",
	},
	["mfd-stealth"] = {
		bg = "#0D1410",
		fg = "#7A9A7A",
		dim = "#253828",
		bright = "#9ABB9A",
		subtle = "#2A3A2A",
		visual = "#1A2A1A",
		cursor = "#151F18",
		border = "#2A3A2A",
		float_bg = "#101810",
	},
	["mfd-amber"] = {
		bg = "#0F0C08",
		fg = "#CC9944",
		dim = "#382818",
		bright = "#FFBB55",
		subtle = "#4A3820",
		visual = "#2A1C10",
		cursor = "#1A1408",
		border = "#3A2810",
		float_bg = "#141008",
	},
	["mfd-mono"] = {
		bg = "#08080C",
		fg = "#D0D0D8",
		dim = "#282830",
		bright = "#F0F0FF",
		subtle = "#383840",
		visual = "#1A1A22",
		cursor = "#101014",
		border = "#2A2A32",
		float_bg = "#0C0C10",
	},
	["mfd-scarlet"] = {
		bg = "#0C0404",
		fg = "#CC5545",
		dim = "#3A1812",
		bright = "#DD6655",
		subtle = "#2A100A",
		visual = "#1A0808",
		cursor = "#140606",
		border = "#2A100A",
		float_bg = "#100505",
	},
	["mfd-paper"] = {
		bg = "#BBC5B7",
		fg = "#002611",
		dim = "#8A9A88",
		bright = "#001008",
		subtle = "#A5B2A2",
		visual = "#A0B0A0",
		cursor = "#B0BAB0",
		border = "#95A592",
		float_bg = "#C5CFC2",
	},
	["mfd-hud"] = {
		bg = "#060C06",
		fg = "#55BB55",
		dim = "#1A3018",
		bright = "#77DD77",
		subtle = "#1A2A18",
		visual = "#0A1A0A",
		cursor = "#081208",
		border = "#1A3018",
		float_bg = "#081008",
	},
	["mfd-nvg"] = {
		bg = "#162014",
		fg = "#78B858",
		dim = "#4A7A3A",
		bright = "#90D868",
		subtle = "#2E4822",
		visual = "#1E3018",
		cursor = "#1A2816",
		border = "#3A5C2E",
		float_bg = "#182416",
	},
	["mfd-gbl-light"] = {
		bg = "#00C286",
		fg = "#00553C",
		dim = "#009A70",
		bright = "#00553C",
		subtle = "#00A573",
		visual = "#00A573",
		cursor = "#00A573",
		border = "#00714C",
		float_bg = "#00A573",
	},
	["mfd-gbl-dark"] = {
		bg = "#004F3A",
		fg = "#02B582",
		dim = "#01694A",
		bright = "#009A70",
		subtle = "#009A70",
		visual = "#01694A",
		cursor = "#01694A",
		border = "#009A70",
		float_bg = "#004F3A",
	},
}

-- Get palette for current or specified colorscheme
function M.get_palette(scheme)
	scheme = scheme or vim.g.colors_name or "mfd"
	return M.palettes[scheme] or M.palettes.mfd
end

-- Check if current colorscheme is an MFD variant
function M.is_mfd()
	local scheme = vim.g.colors_name or ""
	return scheme:match("^mfd") ~= nil
end

-- sync terminal cursor color on mode changes via OSC 12
function M.enable_cursor_sync()
	local mode_hl = {
		n = "CursorNormal",
		i = "CursorInsert",
		v = "CursorVisual",
		V = "CursorVisual",
		["\22"] = "CursorVisual",
		R = "CursorReplace",
		c = "CursorCommand",
	}

	local function osc(seq)
		if vim.env.TMUX then
			io.write("\027Ptmux;\027" .. seq .. "\027\\")
		else
			io.write(seq)
		end
	end

	local function sync()
		local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
		local hl = vim.api.nvim_get_hl(0, { name = mode_hl[mode] or "CursorNormal" })
		if hl.bg then
			osc(string.format("\027]12;#%06x\007", hl.bg))
		end
	end

	local group = vim.api.nvim_create_augroup("MfdCursorSync", { clear = true })

	vim.api.nvim_create_autocmd("ModeChanged", {
		group = group,
		pattern = "*",
		callback = sync,
	})

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		pattern = "mfd*",
		callback = sync,
	})

	-- reset cursor color when leaving nvim
	vim.api.nvim_create_autocmd("VimLeavePre", {
		group = group,
		callback = function()
			osc("\027]112\007")
		end,
	})

	sync()
end

-- override icon colors for monotone consistency
function M.override_icons(fg)
	local function apply()
		-- mini.icons
		for _, color in ipairs({ "Blue", "Cyan", "Green", "Grey", "Orange", "Purple", "Red", "Yellow", "Azure" }) do
			vim.api.nvim_set_hl(0, "MiniIcons" .. color, { fg = fg })
		end

		-- nvim-tree
		vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = fg })
		vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderIcon", { fg = fg })
		vim.api.nvim_set_hl(0, "NvimTreeClosedFolderIcon", { fg = fg })
		vim.api.nvim_set_hl(0, "NvimTreeFileIcon", { fg = fg })
		vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = fg })
		vim.api.nvim_set_hl(0, "NvimTreeImageFile", { fg = fg })
		vim.api.nvim_set_hl(0, "NvimTreeSymlink", { fg = fg })

		-- nvim-web-devicons
		local ok, devicons = pcall(require, "nvim-web-devicons")
		if ok then
			devicons.set_default_icon("", fg, 0)
			for key, icon in pairs(devicons.get_icons()) do
				pcall(devicons.set_icon, {
					[key] = { icon = icon.icon, color = fg, name = icon.name },
				})
			end
		end
	end

	-- run now and deferred for load order
	apply()
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			vim.schedule(apply)
		end,
	})
end

return M
