---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
      --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
      tsserver = function()
        -- disable tsserver
        return true
      end,
      ts_ls = function()
        -- disable tsserver
        return true
      end,
      vtsls = function(_, opts)
        -- Disable detect is Deno project, use denols instead
        -- if vim.lsp.config.denols and vim.lsp.config.vtsls then
        --   ---@param server string
        --   local resolve = function(server)
        --     local markers, root_dir = vim.lsp.config[server].root_markers, vim.lsp.config[server].root_dir
        --     vim.lsp.config(server, {
        --       root_dir = function(bufnr, on_dir)
        --         local is_deno = vim.fs.root(bufnr, { "deno.jsonc" }) ~= nil
        --         if is_deno == (server == "denols") then
        --           if root_dir then
        --             return root_dir(bufnr, on_dir)
        --           elseif type(markers) == "table" then
        --             local root = vim.fs.root(bufnr, markers)
        --             return root and on_dir(root)
        --           end
        --         end
        --       end,
        --     })
        --   end
        --   resolve("denols")
        --   resolve("vtsls")
        -- end

        LazyVim.lsp.on_attach(function(client, buffer)
          client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
            ---@type string, string, lsp.Range
            local action, uri, range = unpack(command.arguments)

            local function move(newf)
              client:request("workspace/executeCommand", {
                command = command.command,
                arguments = { action, uri, range, newf },
              })
            end

            local fname = vim.uri_to_fname(uri)
            client:request("workspace/executeCommand", {
              command = "typescript.tsserverRequest",
              arguments = {
                "getMoveToRefactoringFileSuggestions",
                {
                  file = fname,
                  startLine = range.start.line + 1,
                  startOffset = range.start.character + 1,
                  endLine = range["end"].line + 1,
                  endOffset = range["end"].character + 1,
                },
              },
            }, function(_, result)
              ---@type string[]
              local files = result.body.files
              table.insert(files, 1, "Enter new path...")
              vim.ui.select(files, {
                prompt = "Select move destination:",
                format_item = function(f)
                  return vim.fn.fnamemodify(f, ":~:.")
                end,
              }, function(f)
                if f and f:find("^Enter new path") then
                  vim.ui.input({
                    prompt = "Enter move destination:",
                    default = vim.fn.fnamemodify(fname, ":h") .. "/",
                    completion = "file",
                  }, function(newf)
                    return newf and move(newf)
                  end)
                elseif f then
                  move(f)
                end
              end)
            end)
          end
        end, "vtsls")
        -- copy typescript settings to javascript
        opts.settings.javascript =
          vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
      end,
    },
  },
}
