return {
  {
    "kkoomen/vim-doge",
    -- 플러그인 설치 후 자동으로 바이너리 설치 (최초 1회 실행)
    build = ":call doge#install()",
    -- 특정 명령어 사용 시에만 로드되도록 지연 로딩(Lazy Load) 설정
    cmd = { "DogeGenerate", "DogeCreateDocStandard" },
    -- 특정 키를 누를 때 플러그인 로드 및 실행
    ft = { "python", "javascript", "typescript", "cpp", "c", "rust", "go", "java" },
    keys = {
      { "<leader>cD", "<cmd>DogeGenerate<cr>", desc = "Document Generation (Doge)" },
    },
    config = function()
      -- Vimscript 전역 변수 설정을 통해 doge 옵션 제어
      -- 기본 매핑 비활성화 (커스텀 매핑 사용 시)
      vim.g.doge_enable_mappings = 0

      -- 언어별 문서 표준 설정 (예: Python은 numpy 스타일)
      vim.g.doge_doc_standard_python = "numpy"
      vim.g.doge_doc_standard_javascript = "jsdoc"

      -- 주석 생성 후 항목 간 이동 키 설정 (기본은 <Tab>, <S-Tab>)
      vim.g.doge_mapping_comment_jump_forward = "<Tab>"
      vim.g.doge_mapping_comment_jump_backward = "<S-Tab>"
    end,
  },
}
