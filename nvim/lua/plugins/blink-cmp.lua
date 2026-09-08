-- cmp 는 completion(자동완성) 기능
-- 메뉴 / 문서 / signature 창 테두리는 vim.o.winborder ("rounded") 를 자동으로 따라감
-- (blink.cmp 는 border = nil 이면 nvim 0.11+ 의 winborder 를 사용, config/options.lua 참고)
return {
  "saghen/blink.cmp",
  opts = {},
}
