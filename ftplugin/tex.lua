vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.tex",
    callback = function()
        ---@diagnostic disable-next-line: undefined-field
        if (vim.uv or vim.loop).fs_stat("Makefile") ~= nil then
            vim.cmd("silent !make")
        else
            vim.notify("No Makefile found in the current directory", vim.log.levels.WARN)
        end
    end,
    desc = "Run make on .tex file save if Makefile exists",
})

