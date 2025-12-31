return -- add any tools you want to have installed below
{
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "rust-analyzer",
    },
  },
  opt = function(_, opts)
    vim.list_extend(opts.ensure_installed, {})
  end,
}
