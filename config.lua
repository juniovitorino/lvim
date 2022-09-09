lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "Omni"
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "svelte",
  "ruby",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.plugins = {
  { "avneesh0612/react-nextjs-snippets" },
  { 'getomni/neovim' },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      local opts = {
        -- char = "▏",
        filetype_exclude = {
          "alpha",
          "help",
          "terminal",
          "dashboard",
          "lspinfo",
          "lsp-installer",
          "mason",
        },
        buftype_exclude = { "terminal" },
        bufname_exclude = { "config.lua" },

        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        -- use_treesitter = false,
      }

      require("indent_blankline").setup(opts)
    end
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "wakatime/vim-wakatime"
  },
  {
    "tpope/vim-rails",
    cmd = {
      "Eview",
      "Econtroller",
      "Emodel",
      "Smodel",
      "Sview",
      "Scontroller",
      "Vmodel",
      "Vview",
      "Vcontroller",
      "Tmodel",
      "Tview",
      "Tcontroller",
      "Rails",
      "Generate",
      "Runner",
      "Extract"
    }
  },
}

require("luasnip.loaders.from_vscode").lazy_load()

vim.o.cmdheight = 1

lvim.builtin.bufferline.active = false
lvim.builtin.bufferline.options = {
  custom_areas = {
    left = function()
      return {
        { text = '    ', guifg = '#8fff6d' },
      }
    end,
    right = function()
      local result = {}
      local seve = vim.diagnostic.severity
      local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
      local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
      local info = #vim.diagnostic.get(0, { severity = seve.INFO })
      local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

      if error ~= 0 then
        table.insert(result, { text = "  " .. error, guifg = "#EC5241" })
      end

      if warning ~= 0 then
        table.insert(result, { text = "  " .. warning, guifg = "#EFB839" })
      end

      if hint ~= 0 then
        table.insert(result, { text = "  " .. hint, guifg = "#A3BA5E" })
      end

      if info ~= 0 then
        table.insert(result, { text = "  " .. info, guifg = "#7EA9A7" })
      end
      return result
    end,
  },
}

-- Tailwind @ errors
require('lspconfig').cssls.setup({
  settings = {
    css = {
      lint = {
        unknownAtRules = 'ignore',
      },
    },
  },
})

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    custom = { "^.git$" },
  },
})
