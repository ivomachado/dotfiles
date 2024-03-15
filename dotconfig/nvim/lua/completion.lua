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
    local completed_item = complete_info.items[complete_info.selected + 1]
    vim.inspect(completed_item)
    if completed_item.kind == 'Function' or completed_item.kind == 'Method' then
        local startPos, _ = string.find(completed_item.abbr, "%(%)")
        if startPos then
            completion = completion..'()'
        else
            completion = completion..require('mini.pairs').open('()', '')
        end
    end
    return completion
end

Completion.process_items = function(items, base)
    local res =  require('mini.completion').default_process_items(items, base)
    -- res = vim.iter(res):map(function(item)
    --     return item
    -- end):totable()
    -- CmpItem = res
    return res
end

_Completion = Completion

return Completion
