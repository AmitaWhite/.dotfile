-- 시스템 색상 스킴 확인 함수를 파일 상단에 정의
local function get_system_colorscheme_style()
	-- gsettings 명령어를 실행하고 결과를 읽어옵니다.
	local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme")
	if not handle then
		return "night"
	end -- 기본값 'night'

	local color_scheme = handle:read("*a"):gsub("%s+", "") -- 공백 제거
	handle:close()

	-- 결과에 따라 'night' 또는 'day' 반환
	if color_scheme == "'prefer-light'" or color_scheme == "prefer-light" then
		return "day"
	else
		-- prefer-dark 또는 다른 알 수 없는 값이면 'night' 반환
		return "moon"
	end
end

-- 현재 시스템 스타일에 따라 동적으로 스타일 결정
local current_style = get_system_colorscheme_style()

return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("tokyonight").setup({
				style = current_style, -- 동적으로 결정된 스타일 적용
				transparent = true,
				on_highlights = function(hl, c) end,
				on_colors = function(colors) end,
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
			-- 주석 색상 변경 (밝고 진한 보라색)
			vim.api.nvim_set_hl(0, "Comment", { fg = "#B48EAD", italic = true })
		end,
	},
}
