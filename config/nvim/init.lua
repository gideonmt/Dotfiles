require("config.options")
require("config.mappings")
require("config.autocmds")
require("config.utils")
require("config.lazy")

vim.api.nvim_create_user_command("ConvertTabs", function()
   vim.cmd([[%s/^\( \{2}\)\+/\=repeat(' ', len(submatch(0)) * 2)/g | noh]])
end, {})
