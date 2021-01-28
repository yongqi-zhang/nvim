local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer = require("packer")
local use = packer.use
packer.init(
  {
    git = {
      clone_timeout = nil
    }
  }
)

return packer.startup(
  function()
    -- plugins manger
    use "wbthomason/packer.nvim"
    -- 标签页 状态栏
    use "kyazdani42/nvim-web-devicons"
    use {
      "akinsho/nvim-bufferline.lua",
      config = require("plugin-config.bufferline")
    }
    use {"glepnir/galaxyline.nvim", config = require("eviline")}

    -- 开屏
    use {
      "glepnir/dashboard-nvim",
      config = require("plugin-config.dashboard")
    }

    -- 操作视觉增强
    use {"Shougo/context_filetype.vim"}
    use {"rhysd/accelerated-jk"}
    use {"tomtom/tcomment_vim"}
    use {"hrsh7th/vim-eft"}
    use {"psliwka/vim-smoothie", event = {"BufReadPre *", "BufNewFile *"}}
    use "kana/vim-operator-user"
    use {"rhysd/vim-operator-surround"}
    use {
      "skywind3000/asyncrun.vim",
      config = function()
        vim.g.asyncrun_open = 6
        vim.g.asyncrun_mode = "term"
      end
    }
    use {"skywind3000/asynctasks.vim"}
    use {"skywind3000/vim-terminal-help"}
    use {
      "glepnir/indent-guides.nvim",
      event = {"BufReadPre *", "BufNewFile *"},
      config = function()
        require("indent_guides").setup {
          even_colors = {fg = "NONE", bg = "#23272e"},
          odd_colors = {fg = "NONE", bg = "#23272e"}
        }
      end
    }
    use {
      "itchyny/vim-cursorword",
      event = {"BufReadPre *", "BufNewFile *"},
      config = require("plugin-config.vim-cursorword")
    }

    -- 颜色荧光笔
    use {
      "norcalli/nvim-colorizer.lua",
      config = require("plugin-config.nvim-colorizer"),
      ft = {
        "html",
        "css",
        "sass",
        "scss",
        "vim",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "lua"
      }
    }

    -- fuzzyfind 模糊搜索
    use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = {
        {"nvim-lua/popup.nvim"},
        {"nvim-lua/plenary.nvim"}
      },
      config = require("plugin-config.telescope")
    }

    -- 高亮
    use {
      "glepnir/zephyr-nvim",
      config = require("plugin-config.zephyr")
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        {"nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter"}
      },
      config = require("plugin-config.treesitter")
    }

    -- 文件管理
    use {
      "kyazdani42/nvim-tree.lua",
      config = require("plugin-config.nvim-tree")
    }

    -- 补全
    use {
      "neovim/nvim-lspconfig",
      {
        "glepnir/lspsaga.nvim",
        config = function()
          require "lspsaga".init_lsp_saga()
        end
      }
    }
    use {
      "nvim-lua/completion-nvim",
      event = {"BufReadPre *", "BufNewFile *"},
      config = function()
        vim.cmd [[autocmd BufReadPre,BufNewFile * lua require'completion'.on_attach()]]
      end,
      requires = {
        {"aca/completion-tabnine", event = "InsertCharPre *", run = "version=3.1.9 ./install.sh"},
        {"hrsh7th/vim-vsnip", event = "InsertCharPre *"},
        {"hrsh7th/vim-vsnip-integ", event = "InsertCharPre *"}
      }
    }

    -- git
    use {
      "mhinz/vim-signify",
      event = {"BufReadPre *", "BufNewFile *"},
      config = require("plugin-config.vim-signify")
    }

    -- use {"jiangmiao/auto-pairs", event = {"BufReadPre *", "BufNewFile *"}}
    use {
      "Raimondi/delimitMate",
      event = {"BufReadPre *", "BufNewFile *"},
      config = function()
        vim.g.delimitMate_expand_cr = 0
        vim.g.delimitMate_expand_space = 1
        vim.g.delimitMate_smart_quotes = 1
        vim.g.delimitMate_expand_inside_quotes = 0
        vim.api.nvim_command([[au FileType xml,html,phtml,php,xhtml,js let b:delimitMate_matchpairs = "(:),[:],{:}"]])
      end
    }

    use {
      "mhartington/formatter.nvim",
      cmd = "Format",
      config = require("plugin-config.formatter")
    }

    -- Tag 展示插件，目前主要使用lsp提供，CTAG也依然好用
    use {
      "liuchengxu/vista.vim",
      config = require("plugin-config.vista")
    }

    -- lang Prettier 用来格式化js ts文件，formatter 配置为默认使用项目下
    -- Prettier,这个是全局的
    use {"prettier/vim-prettier", run = "yarn install", cmd = "Prettier"}

    -- editorconfig
    -- 编辑器配置，个大编辑器都有实现或者有插件，用来统一项目的编辑格式，比如锁进等文件规范
    use "editorconfig/editorconfig-vim"

    -- 同步预览MD文件 :MarkdownPreview
    use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}
    -- emmei插件 使用 ,, 触发补全，
    use {
      "mattn/emmet-vim",
      config = require("plugin-config.emmet")
    }
    -- HTML tag 自动补全
    use {
      "alvan/vim-closetag",
      config = require("plugin-config.closetag")
    }
  end
)
