local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- internal 은 꽉 채우면서, imac은 +12번 size_up 으로 안정적인 비율을 만드는 환상의 col/row size
config.initial_cols = 170
config.initial_rows = 44

-- wezterm 블러 처리
config.window_background_opacity = 0.6
config.macos_window_background_blur = 15

-- 위에 테두리 사라짐
--config.window_decorations = "RESIZE"

-- tab_bar 스타일
config.enable_tab_bar = false

-- color scheme
config.color_scheme = "AdventureTime"

-- 한글을 이쁘게 커버하지 못하는 문제(글리프?) 해결을 위해 fallback(다른 커버 폰트) 설정
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Noto Sans CJK KR",
	"Apple Color Emoji",
})
config.font_size = 14

-- (추가) 광폭 문자 처리 관련 옵션
-- East Asian Ambiguous 폭을 2칸으로 볼지 결정
config.treat_east_asian_ambiguous_width_as_wide = true

-- 이 옵션으로 네모 박스 글리프가 셀을 침범하는 것 제어
-- Allways or Never 개인 취향
config.allow_square_glyphs_to_overflow_width = "Never"

config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#2b2042",
			fg_color = "orange",
			intensity = "Normal",
			underline = "None",
		},
		inactive_tab = {
			bg_color = "#1b1031",
			fg_color = "#808080",
		},
		inactive_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "green",
			italic = true,
		},
	},
}

return config
