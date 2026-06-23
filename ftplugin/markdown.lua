local function follow_md_link()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1

  local path
  local s = 0
  while true do
    local ms, me, p = line:find('%[.-%]%((.-)%)', s + 1)
    if not ms then break end
    if col >= ms and col <= me then
      path = p
      break
    end
    s = me
  end

  if not path then
    vim.lsp.buf.definition()
    return
  end

  path = path:gsub('#.*', '')
  if path == '' then return end

  local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')
  vim.cmd('edit ' .. vim.fn.fnameescape(dir .. '/' .. path))
end

vim.keymap.set('n', 'gd', follow_md_link, { buffer = true, desc = 'Follow markdown link' })
