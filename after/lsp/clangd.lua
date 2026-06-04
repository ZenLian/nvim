vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local buf = ev.buf

    if client ~= nil and client.server_info.name == 'clangd' then
      vim.keymap.set(
        'n',
        '<leader>lo',
        '<cmd>LspClangdSwitchSourceHeader<cr>',
        { desc = 'Switch Source/Header (C/C++)', buf = buf }
      )
    end
  end,
})

return {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=never',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--fallback-style=llvm',
  },
}
