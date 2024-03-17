local capabilities = vim.lsp.protocol.make_client_capabilities()

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
    capabilities,
    flags = {
        debounce_text_changes = 150,
    }
}

lspconfig.rust_analyzer.setup {
    capabilities,
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy"
            }
        }
    }
}

lspconfig['lua_ls'].setup({})
