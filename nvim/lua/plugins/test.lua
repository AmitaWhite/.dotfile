return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "rcasia/neotest-java", -- Java 어댑터 추가
    },
    opts = {
      adapters = {
        ["neotest-java"] = {},
      },
    },
  },
}
