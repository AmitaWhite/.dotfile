-- 함수 · 클래스 docstring 자동 생성
return {
  "kkoomen/vim-doge",
  -- 플러그인 설치 후 바이너리 설치 (최초 1회)
  build = ":call doge#install()",
  -- 해당 filetype 을 열 때 로드 (cmd 트리거는 ft 보다 늦게 오므로 불필요)
  ft = { "python", "javascript", "typescript", "cpp", "c", "rust", "go", "java" },
  keys = {
    { "<leader>cD", "<cmd>DogeGenerate<cr>", desc = "Document Generation (Doge)" },
  },
  -- vim-doge 는 vimscript 플러그인이라 plugin/doge.vim 이 로드되는 시점에 g:doge_* 를 읽는다.
  -- 그래서 config(로드 후)가 아니라 init(로드 전)에서 설정해야 한다.
  -- 특히 doge_enable_mappings = 0 을 config 에서 주면 이미 <leader>d 기본 매핑이 생성된 뒤라
  -- 무효가 되고, 그 <leader>d 가 LazyVim DAP 그룹(<leader>d*) 전체와 충돌한다.
  init = function()
    vim.g.doge_enable_mappings = 0
    -- 언어별 문서 표준
    vim.g.doge_doc_standard_python = "numpy"
    vim.g.doge_doc_standard_javascript = "jsdoc"
    vim.g.doge_doc_standard_java = "javadoc"
    -- 생성된 주석 항목 간 이동
    vim.g.doge_mapping_comment_jump_forward = "<Tab>"
    vim.g.doge_mapping_comment_jump_backward = "<S-Tab>"
  end,
}
