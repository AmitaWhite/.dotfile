return {
  "folke/snacks.nvim",
  opts = {
    styles = {
      notification_history = {
        wo = { wrap = true },
      },
    },
    image = {
      enabled = true,
    },
    -- 들여쓰기 가이드 끔. ghostty 가 반투명 + blur 라 글자 뒤에 그리는 게 적을수록 또렷하다.
    -- (helix 도 indent-guides 가 기본 꺼짐) 켜고 싶으면 enabled = true, 임시 토글은 <leader>ug.
    -- 참고: indent(흐린 세로선) · scope(현재 블록 강조) · animate(그려지는 애니메이션) 이 각각 별개 설정이라
    -- 애니메이션만 끄려면 indent = { animate = { enabled = false } } 로 하면 된다.
    indent = {
      enabled = false,
    },
  },
}
