local capabilities = require('cmp_nvim_lsp').default_capabilities()

local wk = require("which-key")

local generic_on_attach = function(_, _)
    wk.register({
        ["gd"] = { "<cmd>Telescope lsp_definitions<CR>", "Go To Definition" },
        ["gs"] = { "<cmd>ClangdSwitchSourceHeader<CR>", "Switch C++ Source and Header" },
        ["gi"] = { "<cmd>Telescope lsp_implementations<CR>", "Go to Implementation" },
        ["gr"] = { "<cmd>Telescope lsp_references<CR>", "View References" },
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
        ["<F2>"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
        ["<leader>."] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    })

    -- vim.cmd[[ sign define DiagnosticSignError text=E texthl=DiagnosticSignError linehl= numhl= ]]
    -- vim.cmd[[ sign define DiagnosticSignWarn text=W texthl=DiagnosticSignWarn linehl= numhl= ]]
    -- vim.cmd[[ sign define DiagnosticSignInfo text=I texthl=DiagnosticSignInfo linehl= numhl= ]]
    vim.cmd [[ sign define DiagnosticSignHint text=󰌵 texthl=DiagnosticSignHint linehl= numhl= ]]
end

local clangd_on_attach = function(first_parameter, bufnr)
    local compile_commands = vim.fs.find("compile_commands.json", {
        upward = true,
        path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
    })

    if (compile_commands[1]) then
        local cppcheck_linter = require('lint').linters.cppcheck
        cppcheck_linter.args = {
            '--project='..compile_commands[1],
        }
    end

    generic_on_attach(first_parameter, bufnr)
    wk.register({
        ["gs"] = { "<cmd>ClangdSwitchSourceHeader<CR>", "Switch C++ Source and Header" },
    })
end

require("mason").setup()
require("mason-lspconfig").setup(
{
    ensure_installed = {},
    automatic_installation = true,
    completion = {
        keyword_length = 3,
        autocomplete = false,
    },
})
require("mason-lspconfig").setup_handlers{
    function (server_name)
        require("lspconfig")[server_name].setup{
            on_attach = generic_on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end,
    ["tsserver"] = function ()
        require("lspconfig").tsserver.setup{
            on_attach = generic_on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
            root_dir = require('lspconfig').util.root_pattern(
                "package.json",
                "tsconfig.json",
                "jsconfig.json", ".git")
            or vim.fn.getcwd(),
        }
    end,
    ["clangd"] = function ()
        local root_dir = require('lspconfig').util.root_pattern('compile_commands.json')
        require("clangd_extensions").setup({
            extensions = {
                inlay_hints = {
                    only_current_line = true,
                },
            },
        })
        require("lspconfig")['clangd'].setup{
            on_attach = clangd_on_attach,
            capabilities = capabilities,
            root_dir = root_dir,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end
}
