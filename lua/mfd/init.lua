-- MFD: Multi-Function Display colorscheme for Neovim
-- Monotone themes using text decoration for syntax highlighting

local M = {}

M.config = {
	bright_comments = false, -- back-compat - resolves to accessibility_contrast 4 if true
	no_italic = false,
	accessibility_contrast = 0,
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
		cursor = "#848F72",
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
		cursor = "#253525",
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
		bg = "#02B582",
		fg = "#004F3A",
		dim = "#009A70",
		bright = "#01694A",
		subtle = "#01694A",
		visual = "#01694A",
		cursor = "#01A878",
		border = "#01694A",
		float_bg = "#02B582",
	},
	["mfd-gbl-dark"] = {
		bg = "#004F3A",
		fg = "#02B582",
		dim = "#01694A",
		bright = "#009A70",
		subtle = "#01694A",
		visual = "#008560",
		cursor = "#005A44",
		border = "#009A70",
		float_bg = "#004F3A",
	},
	["mfd-lumon"] = {
		bg = "#0A1520",
		fg = "#5AC8D8",
		glow = "#78DDE8",
		dim = "#1A3848",
		bright = "#A0F0FF",
		subtle = "#143040",
		visual = "#122838",
		cursor = "#0E1E2C",
		border = "#1A3848",
		float_bg = "#0C1822",
	},
	["mfd-nerv"] = {
		bg = "#1A0A02",
		fg = "#EE8822",
		dim = "#6B3510",
		bright = "#FFAA44",
		subtle = "#4A2008",
		visual = "#2A1208",
		cursor = "#221005",
		border = "#4A2008",
		float_bg = "#180A02",
	},
}

-- color math for accessibility contrast
local function hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber(hex:sub(1, 2), 16) / 255,
		tonumber(hex:sub(3, 4), 16) / 255,
		tonumber(hex:sub(5, 6), 16) / 255
end

local function rgb_to_hex(r, g, b)
	return string.format("#%02X%02X%02X",
		math.max(0, math.min(255, math.floor(r * 255 + 0.5))),
		math.max(0, math.min(255, math.floor(g * 255 + 0.5))),
		math.max(0, math.min(255, math.floor(b * 255 + 0.5))))
end

local function rgb_to_hsv(r, g, b)
	local max_c = math.max(r, g, b)
	local min_c = math.min(r, g, b)
	local delta = max_c - min_c
	local h, s, v = 0, 0, max_c
	if max_c > 0 then s = delta / max_c end
	if delta > 0 then
		if max_c == r then h = ((g - b) / delta) % 6
		elseif max_c == g then h = (b - r) / delta + 2
		else h = (r - g) / delta + 4 end
		h = h / 6
	end
	return h, s, v
end

local function hsv_to_rgb(h, s, v)
	if s == 0 then return v, v, v end
	local i = math.floor(h * 6)
	local f = h * 6 - i
	local p = v * (1 - s)
	local q = v * (1 - f * s)
	local t = v * (1 - (1 - f) * s)
	i = i % 6
	if i == 0 then return v, t, p
	elseif i == 1 then return q, v, p
	elseif i == 2 then return p, v, t
	elseif i == 3 then return p, q, v
	elseif i == 4 then return t, p, v
	else return v, p, q end
end

local function srgb_linearize(c)
	if c <= 0.04045 then return c / 12.92 end
	return ((c + 0.055) / 1.055) ^ 2.4
end

local function relative_luminance(r, g, b)
	return 0.2126 * srgb_linearize(r) + 0.7152 * srgb_linearize(g) + 0.0722 * srgb_linearize(b)
end

local function contrast_ratio(hex1, hex2)
	local r1, g1, b1 = hex_to_rgb(hex1)
	local r2, g2, b2 = hex_to_rgb(hex2)
	local l1 = relative_luminance(r1, g1, b1)
	local l2 = relative_luminance(r2, g2, b2)
	local lighter = math.max(l1, l2)
	local darker = math.min(l1, l2)
	return (lighter + 0.05) / (darker + 0.05)
end

local function lerp_hsv(hex1, hex2, t)
	local r1, g1, b1 = hex_to_rgb(hex1)
	local r2, g2, b2 = hex_to_rgb(hex2)
	local h1, s1, v1 = rgb_to_hsv(r1, g1, b1)
	local h2, s2, v2 = rgb_to_hsv(r2, g2, b2)
	local r, g, b = hsv_to_rgb(
		h1 + (h2 - h1) * t,
		s1 + (s2 - s1) * t,
		v1 + (v2 - v1) * t)
	return rgb_to_hex(r, g, b)
end

-- find the color with same hue+sat that hits target contrast against all bg surfaces.
-- returns the original color unchanged if it already meets the target.
local function find_target_color(src_hex, bg_surfaces, target, direction)
	if #bg_surfaces == 0 then return src_hex, true end

	local meets_all = true
	for _, bg in ipairs(bg_surfaces) do
		if contrast_ratio(src_hex, bg) < target then
			meets_all = false
			break
		end
	end
	if meets_all then return src_hex, true end

	local r, g, b = hex_to_rgb(src_hex)
	local h, s, v = rgb_to_hsv(r, g, b)

	-- check if max possible brightness/darkness can reach target
	local extreme_v = direction == "lighter" and 1.0 or 0.0
	local er, eg, eb = hsv_to_rgb(h, s, extreme_v)
	local extreme_hex = rgb_to_hex(er, eg, eb)
	local can_reach = true
	for _, bg in ipairs(bg_surfaces) do
		if contrast_ratio(extreme_hex, bg) < target then
			can_reach = false
			break
		end
	end
	if not can_reach then return extreme_hex, false end

	-- binary search for the exact value
	local lo, hi
	if direction == "lighter" then lo, hi = v, 1.0
	else lo, hi = 0.0, v end

	for _ = 1, 50 do
		local mid = (lo + hi) / 2
		local mr, mg, mb = hsv_to_rgb(h, s, mid)
		local mid_hex = rgb_to_hex(mr, mg, mb)
		local ok = true
		for _, bg in ipairs(bg_surfaces) do
			if contrast_ratio(mid_hex, bg) < target then
				ok = false
				break
			end
		end
		if direction == "lighter" then
			if ok then hi = mid else lo = mid end
		else
			if ok then lo = mid else hi = mid end
		end
	end

	local fr, fg_, fb = hsv_to_rgb(h, s, (lo + hi) / 2)
	return rgb_to_hex(fr, fg_, fb), true
end

-- darken (dark themes) or lighten (light themes) a bg just enough for fg to hit target
local function adjust_bg(fg_hex, bg_hex, target, is_light)
	if contrast_ratio(fg_hex, bg_hex) >= target then return bg_hex end
	local r, g, b = hex_to_rgb(bg_hex)
	local h, s, v = rgb_to_hsv(r, g, b)
	local lo, hi
	if is_light then lo, hi = v, 1.0 else lo, hi = 0.0, v end
	for _ = 1, 50 do
		local mid = (lo + hi) / 2
		local mr, mg, mb = hsv_to_rgb(h, s, mid)
		local mid_hex = rgb_to_hex(mr, mg, mb)
		if contrast_ratio(fg_hex, mid_hex) >= target then
			if is_light then hi = mid else lo = mid end
		else
			if is_light then lo = mid else hi = mid end
		end
	end
	-- take the side that guaranteed meets the target
	local final_v = is_light and hi or lo
	local fr, fg_, fb = hsv_to_rgb(h, s, final_v)
	local result = rgb_to_hex(fr, fg_, fb)
	if contrast_ratio(fg_hex, result) >= target then return result end
	return is_light and "#FFFFFF" or "#000000"
end

-- compute accessible palette from base palette and contrast level (0-10).
-- returns a new table with adjusted colors, or the original palette at level 0.
function M.compute_accessible_colors(palette, level)
	if level == 0 then return palette end

	-- detect light theme: fg is darker than bg
	local fg_lum = relative_luminance(hex_to_rgb(palette.fg))
	local bg_lum = relative_luminance(hex_to_rgb(palette.bg))
	local is_light = fg_lum < bg_lum
	local direction = is_light and "darker" or "lighter"

	local bg_surfaces = { palette.bg, palette.float_bg, palette.cursor }
	local fg_keys = { "dim", "subtle", "border", "fg", "bright", "glow" }
	local bg_keys = { "bg", "cursor", "float_bg", "visual" }

	-- compute level 10 targets: exact color needed for 7.0 against all bg surfaces
	-- target 7.1 to absorb rounding in the binary search
	local targets = {}
	local all_reached = true
	for _, key in ipairs(fg_keys) do
		if palette[key] then
			local target_hex, reached = find_target_color(palette[key], bg_surfaces, 7.1, direction)
			targets[key] = target_hex
			if not reached then all_reached = false end
		end
	end

	-- interpolate between current and target based on level
	local t = level / 10.0
	local result = {}
	for k, v in pairs(palette) do
		result[k] = v
	end

	for _, key in ipairs(fg_keys) do
		if targets[key] then
			result[key] = lerp_hsv(palette[key], targets[key], t)
		end
	end

	-- on light themes, dim/subtle/border start lighter than fg and all go darker.
	-- they must not converge with fg, otherwise cursor blocks become invisible.
	-- ensure a minimum contrast of 1.2 between each and fg.
	if is_light and result.fg then
		local min_sep = 1.2
		for _, key in ipairs({"dim", "subtle", "border"}) do
			if result[key] and palette[key] then
				local orig_key_lum = relative_luminance(hex_to_rgb(palette[key]))
				local orig_fg_lum = relative_luminance(hex_to_rgb(palette.fg))
				if orig_key_lum > orig_fg_lum and contrast_ratio(result[key], result.fg) < min_sep then
					local r, g, b = hex_to_rgb(palette[key])
					local h, s, _ = rgb_to_hsv(r, g, b)
					local lo, hi_v = 0.0, 1.0
					for _ = 1, 50 do
						local mid = (lo + hi_v) / 2
						local mr, mg, mb = hsv_to_rgb(h, s, mid)
						local mid_hex = rgb_to_hex(mr, mg, mb)
						if contrast_ratio(mid_hex, result.fg) >= min_sep then
							hi_v = mid
						else
							lo = mid
						end
					end
					local dr, dg, db = hsv_to_rgb(h, s, hi_v)
					result[key] = rgb_to_hex(dr, dg, db)
				end
			end
		end
	end

	-- recheck whether all colors actually hit 7.0 after any capping
	if level == 10 then
		all_reached = true
		for _, key in ipairs(fg_keys) do
			if result[key] then
				for _, bg in ipairs(bg_surfaces) do
					if contrast_ratio(result[key], bg) < 7.0 then
						all_reached = false
						break
					end
				end
			end
			if not all_reached then break end
		end
	end

	-- at level 10 only: if fg can't reach AAA, adjust backgrounds.
	-- for light themes, cap the adjustment to avoid destroying the theme.
	if level == 10 and not all_reached then
		for _, bg_key in ipairs(bg_keys) do
			if result[bg_key] then
				local adjusted = result[bg_key]
				for _, fg_key in ipairs(fg_keys) do
					if result[fg_key] and contrast_ratio(result[fg_key], adjusted) < 7.0 then
						adjusted = adjust_bg(result[fg_key], adjusted, 7.0, is_light)
					end
				end
				-- on light themes with mid-range backgrounds (like mfd base), the
				-- adjustment can push bg to extremes. cap so bg doesn't shift more
				-- than 50% of its original luminance.
				if is_light and palette[bg_key] then
					local orig_lum = relative_luminance(hex_to_rgb(palette[bg_key]))
					local new_lum = relative_luminance(hex_to_rgb(adjusted))
					if math.abs(new_lum - orig_lum) > orig_lum * 0.5 then
						adjusted = palette[bg_key]
					end
				end
				result[bg_key] = adjusted
			end
		end
	end

	return result
end

-- resolve the effective accessibility_contrast level from config
function M.get_contrast_level()
	local c = M.config
	if c.accessibility_contrast > 0 then
		return c.accessibility_contrast
	end
	if c.bright_comments then
		return 4
	end
	return 0
end

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
