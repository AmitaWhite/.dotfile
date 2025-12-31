--cmp 는 complementaion(자동완성) 기능
return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        -- 자동완성 목록 창 테두리
        menu = {
          border = "rounded", -- 'single', 'double', 'rounded', 'solid', 'shadow' 가능
        },
        -- 함수 설명 등 문서 창 테두리
        documentation = {
          window = {
            border = "rounded",
          },
        },
      },
      -- (선택 사항) 함수 매개변수 도움말(signature) 창 테두리
      signature = {
        window = {
          border = "rounded",
        },
      },
    },
  },
}
