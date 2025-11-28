local cmd = vim.api.nvim_create_user_command

-- Convert tabs to spaces
cmd("ConvertTabs", function()
   vim.cmd([[%s/^\( \{2}\)\+/\=repeat(' ', len(submatch(0)) * 2)/g | noh]])
end, {})

-- Markdown to PDF with Pandoc
cmd("MdPDF", function()
   local file = vim.fn.expand("%:p")
   local output = vim.fn.expand("%:p:r") .. ".pdf"
   local template = vim.fn.expand("~/.config/nvim/templates/pandoc.tex")
   
   -- Create template if it doesn't exist
   if vim.fn.filereadable(template) == 0 then
      local template_content = [[
\documentclass[12pt,a4paper]{article}
\usepackage{amsmath,amssymb}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage[margin=1in]{geometry}

\begin{document}
$body$
\end{document}
]]
      local f = io.open(template, "w")
      if f then
         f:write(template_content)
         f:close()
      end
   end
   
   local cmd = string.format(
      "pandoc '%s' -o '%s' --template='%s' --pdf-engine=pdflatex -V geometry:margin=1in",
      file, output, template
   )
   
   vim.fn.system(cmd)
   
   if vim.v.shell_error == 0 then
      vim.notify("PDF generated: " .. output, vim.log.levels.INFO)
      -- Open in Skim on first compile
      if vim.fn.executable("open") == 1 then
         vim.fn.system(string.format("open -a Skim '%s'", output))
      end
   else
      vim.notify("PDF generation failed", vim.log.levels.ERROR)
   end
end, {})

-- Quick build/make
cmd("Make", function()
   vim.cmd("make")
end, {})

-- Format buffer
cmd("Format", function()
   vim.lsp.buf.format({ async = true })
end, {})

-- Toggle diagnostics
local diagnostics_active = true
cmd("DiagnosticsToggle", function()
   diagnostics_active = not diagnostics_active
   if diagnostics_active then
      vim.diagnostic.enable()
      vim.notify("Diagnostics enabled", vim.log.levels.INFO)
   else
      vim.diagnostic.disable()
      vim.notify("Diagnostics disabled", vim.log.levels.INFO)
   end
end, {})

-- Utility function for printing lua tables
_G.P = function(v)
   print(vim.inspect(v))
   return v
end
