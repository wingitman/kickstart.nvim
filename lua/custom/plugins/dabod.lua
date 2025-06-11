return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    {
      'kristijanhusak/vim-dadbod-completion',
      cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
      },
      keys = {
        { '<leader>D', '<cmd>DBUIToggle<CR>', desc = 'Toggle DBUI' },
      },
      dependencies = { 'vim-dadbod' },
      ft = sql_ft,
      init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.dbs = {
          dev = 'sqlserver://LAPTOP-GFE6QDBU',
        }
        vim.api.nvim_create_autocmd('FileType', {
          pattern = sql_ft,
          callback = function()
            if LazyVim ~= nil and LazyVim.has_extra 'coding.nvim-cmp' then
              local cmp = require 'cmp'

              -- global sources
              ---@param source cmp.SourceConfig
              local sources = vim.tbl_map(function(source)
                return { name = source.name }
              end, cmp.get_config().sources)

              -- add vim-dadbod-completion source
              table.insert(sources, { name = 'vim-dadbod-completion' })

              -- update sources for the current buffer
              cmp.setup.buffer { sources = sources }
            end
          end,
        })
      end,
    },
  },
}
