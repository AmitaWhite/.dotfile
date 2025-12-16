return -- add any tools you want to have installed below
{
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
    },
  },
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, { "rust-analyzer", "ruff", "flake8", "pyright" })
  end,
}
