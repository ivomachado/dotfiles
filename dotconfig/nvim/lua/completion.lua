local Completion = {}
Completion.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
        local has_item_selected = vim.fn.complete_info()['selected'] ~= -1
        if has_item_selected then
            return Completion.confirm_completion()
        end
    end
    return require('mini.pairs').cr()
end

Completion.confirm_completion = function()
    local completion = vim.api.nvim_replace_termcodes('<C-y>', true, true, true)
    local complete_info = vim.fn.complete_info()
    if complete_info.selected ~= -1 then
        local completed_item = complete_info.items[complete_info.selected + 1]
        if completed_item.kind == 'Function' or completed_item.kind == 'Method' then
            local startPos, _ = string.find(completed_item.abbr, "%(%)")
            if startPos then
                completion = completion..'()'
            else
                completion = completion..require('mini.pairs').open('()', '')
            end
        end
    end
    return completion
end

_Completion = Completion

return Completion
