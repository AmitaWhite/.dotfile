local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- internal 은 꽉 채우면서, imac은 +12번 size_up 으로 안정적인 비율을 만드는 환상의 col/row size
config.initial_cols = 170
config.initial_rows = 44

-- wezterm 블러 처리
config.window_background_opacity = 0.6
config.macos_window_background_blur = 30

-- 위에 테두리 사라짐
config.window_decorations = "RESIZE"

-- tab_bar 스타일

-- color scheme
config.color_scheme = "AdventureTime"

config.font = wezterm.font({
	family = "JetBrains Mono",
})
config.font_size = 14

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
