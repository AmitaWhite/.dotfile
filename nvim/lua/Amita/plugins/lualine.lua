local function get_system_colorscheme()
	local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme")
	if not handle then
		return "night"
	end
	local color_scheme = handle:read("*a"):gsub("%s+", "")
	handle:close()
	if color_scheme == "'prefer-light'" or color_scheme == "prefer-light" then
		return "day"
	else
		return "moon"
	end
end

-- tokyonight 테마 모듈을 로드하여 색상 팔레트 가져오기
local current_style = get_system_colorscheme()
local tn = require("tokyonight")
-- tokyonight setup 이전에 미리 style 설정 (colors 테이블을 가져오기 위함)
tn.setup({ style = current_style })

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local tn_colors = require("tokyonight.colors").setup({ style = current_style })

		--tokyonight 색상
		local tn_bg = tn_colors.bg
		local tn_fg = tn_colors.fg

		local colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			--fg = "#c3ccdc",
			--bg = "#112638",
			fg = tn_fg,
			bg = tn_bg,
			inactive_bg = tn_bg,
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = my_lualine_theme,
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
