
-- Make tab accept a completion option, like in IntelliJ
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.accept_completion()', { expr = true, noremap = true })
function _G.accept_completion()
  if vim.fn.pumvisible() == 1 then
    return vim.api.nvim_replace_termcodes('<C-y>', true, true, true)
  else
    return vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
  end
end

-- Configure the completion options
vim.o.completeopt = 'menu,menuone,noselect'

-- Make sure autocomplete is active for lsp setups
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion = {
  completionItem = {
    snippetSupport = true,
  }
}

-- Function that runs when LSP attaches to buffer
local on_attach = function(client, bufnr)

  -- IMPORTANT: make sure treesitter highlight groups are not overridden by lsp highlight groups!
  client.server_capabilities.semanticTokensProvider = false

  -- Ensure omnifunc is set to enable autocomplete suggestions from the LSP
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
  
  -- Check every character before typing, and if it's `.` then open autocomplete popup
  vim.api.nvim_create_autocmd("InsertCharPre", {
    pattern = "*",
    callback = function()
      local char = vim.v.char
        vim.defer_fn(function()
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-o>", true, true, true), "")
        end, 0)
    end,
  })
  
end

-- RUST LSP SETUP
require'lspconfig'.rust_analyzer.setup({
   capabilities=capabilities,
   on_attach=on_attach,
   cmd = {"rust-analyzer"},
   filetypes = {"rust"},
   settings = {
      ["rust-analyzer"] = {
         cargo = {
            allFeatures = true,
         },
      },
   },
})

local project_root = vim.fn.getcwd()  -- Get the current working directory
local cuda_home = vim.loop.os_getenv("CUDA_HOME") or "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v12.3"

-- C LSP SETUP
require'lspconfig'.clangd.setup({
   capabilities=capabilities,
   on_attach=on_attach,
   cmd = {"clangd"},
   filetypes = {"c", "h", "cpp", "cuda"},
   settings = {},
   init_options = {
	   fallbackFlags = { -- Find include directories etc. to help lsp
		"-I" .. project_root .. "/include",
		"-I" .. cuda_home .. "/include",
		"-x", "cuda",
		"--cuda-path=" .. cuda_home,
		"--cuda-gpu-arch=sm_86"
	   }
   }
})

-- LUA LSP SETUP
require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
}