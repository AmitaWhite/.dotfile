-- 시스템 색상 스킴(다크/라이트) 감지 유틸
-- 반환값은 tokyonight style: 라이트 = "day", 다크 = "moon"
local U = {}

local function run(cmd)
  local handle = io.popen(cmd .. " 2>/dev/null")
  if not handle then
    return nil
  end
  local out = handle:read("*a") or ""
  handle:close()
  return (out:gsub("%s+", ""))
end

function U.get_system_colorscheme_style()
  if vim.fn.has("mac") == 1 then
    -- macOS: 라이트 모드면 이 키가 없어서 빈 문자열, 다크면 "Dark"
    local mode = run("defaults read -g AppleInterfaceStyle")
    return mode == "Dark" and "moon" or "day"
  end

  -- Linux (GNOME): gsettings
  local color_scheme = run("gsettings get org.gnome.desktop.interface color-scheme")
  if color_scheme == "'prefer-light'" or color_scheme == "prefer-light" then
    return "day"
  end
  return "moon"
end

return U
