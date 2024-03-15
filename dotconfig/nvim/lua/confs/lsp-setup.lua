local capabilities = vim.lsp.protocol.make_client_capabilities()

local wk = require("which-key")

local on_attach = function(_, bufnr)
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

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    }
}
lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy"
            }
        }
    }
}

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
}
