-- 시스템 색상 스킴 확인 함수를 파일 상단에 정의
local U = {}
function U.get_system_colorscheme_style()
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

return U
