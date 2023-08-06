-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- client.server_capabilities.semanticTokensProvider = nil
    local wk = require("which-key")

    wk.register({
        ["gd"] = { "<cmd>Telescope lsp_definitions<CR>", "Go To Definition" },
        ["gs"] = { "<cmd>ClangdSwitchSourceHeader<CR>", "Switch C++ Source and Header" },
        ["gi"] = { "<cmd>Telescope lsp_implementations<CR>", "Go to Implementatino" },
        ["gr"] = { "<cmd>Telescope lsp_references<CR>", "View References" },
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
        ["<F2>"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
        ["<leader>."] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    })

    wk.register({
        ["<C-k>"] = {
            "<cmd>lua vim.lsp.buf.signature_help()<CR>",
            "Signature Help",
        },
    }, { mode = {"i", "n"} })
end

require("mason").setup()
require("mason-lspconfig").setup(
{
    ensure_installed = {
        'clangd', 'cmake', 'html', 'lemminx', 'rust_analyzer',
        'svelte', 'tsserver', 'pylsp',
    },
    automatic_installation = true,
    completion = {
        keyword_length = 3,
        autocomplete = false,
    },
})
require("mason-lspconfig").setup_handlers{
    function (server_name)
        require("lspconfig")[server_name].setup{
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end,
    ["clangd"] = function ()
        local root_dir = require('lspconfig').util.root_pattern('compile_commands.json')
        require('lint').linters_by_ft = {
            cpp = {'cppcheck',}
        }
        if (not root_dir) then
            cppcheck_linter = require('lint').linters.cppcheck
            cppcheck_linter.args = {
                '--enable-all',
                '--project='..root_dir()..'/compile_commands',
            }
        end
        require("clangd_extensions").setup({
            extensions = {
                inlay_hints = {
                    only_current_line = true,
                },
            },
            server = {
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = require('lspconfig').util.root_pattern('compile_commands.json'),
                flags = {
                    debounce_text_changes = 150,
                }
            }
        })
    end
}
require("mason-nvim-dap").setup({
    automatic_setup = true,
    ensure_installed = {'cppdbg'},
    handlers = {}
})
