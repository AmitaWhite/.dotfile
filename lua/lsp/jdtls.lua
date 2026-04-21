return {
  {
    "mfussenegger/nvim-jdtls",

    opts = function(_, opts)
      -- lombok 추가
      -- Extras 를 통해 lang.java 했다면 일반적으로 아래 경로에 있음
      local lombok_path = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar")

      opts.jdtls = opts.jdtls or {}
      opts.jdtls.extraArgs = opts.jdtls.extraArgs or {}
      table.insert(opts.jdtls.extraArgs, "--jvm-arg=-javaagent:" .. lombok_path)
    end,
  },
}
