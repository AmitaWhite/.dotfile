return {
  {
    -- 색상 미리보기
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        mode = "virtualtext", -- 'background'(배경), 'foreground'(글자색), 'virtualtext'(가상 텍스트)
      },
    },
  },
}
