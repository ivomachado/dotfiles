local capabilities = vim.lsp.protocol.make_client_capabilities()

local wk = require("which-key")

local generic_on_attach = function(_, bufnr)
    wk.register({
        ["gd"] = { vim.lsp.buf.definition, "Go To Definition" },
        ["gi"] = { "<cmd>FzfLua lsp_implementations<CR>", "Go to Implementation" },
        ["gr"] = { "<cmd>FzfLua lsp_references<CR>", "View References" },
        ["K"] = { vim.lsp.buf.hover, "Hover" },
        ["<F2>"] = { vim.lsp.buf.rename, "Rename Symbol" },
        ["<leader>."] = { vim.lsp.buf.code_action, "Code Action" },
    }, {buffer = bufnr})

    -- vim.cmd[[ sign define DiagnosticSignError text=E texthl=DiagnosticSignError linehl= numhl= ]]
    -- vim.cmd[[ sign define DiagnosticSignWarn text=W texthl=DiagnosticSignWarn linehl= numhl= ]]
    -- vim.cmd[[ sign define DiagnosticSignInfo text=I texthl=DiagnosticSignInfo linehl= numhl= ]]
    vim.cmd [[ sign define DiagnosticSignHint text=󰌵 texthl=DiagnosticSignHint linehl= numhl= ]]
end

local clangd_on_attach = function(first_parameter, bufnr)
    generic_on_attach(first_parameter, bufnr)
    wk.register({
        ["gs"] = { "<cmd>ClangdSwitchSourceHeader<CR>", "Switch C++ Source and Header" },
    }, {buffer = bufnr})
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
            single_file_support = true,
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
                "jsconfig.json", ".git"),
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
    end,
    ["rust_analyzer"] = function()
        require("lspconfig").rust_analyzer.setup{
            on_attach = generic_on_attach,
            capabilities = capabilities,
            settings = {
                ['rust-analyzer'] = {
                    check = {
                        command = "clippy"
                    }
                }
            }
        }
    end,
}
