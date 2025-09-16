local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

-- Filename → class name
local function filename(_, snip)
   local name = vim.fn.expand("%:t:r")
   return name:gsub("^%l", string.upper)
end

-- Expand only if file is empty
local function buffer_empty()
   return vim.api.nvim_buf_line_count(0) == 1
      and vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == ""
end

return {
   -- print
   s("sout", fmt("System.out.println({});", { i(1) })),

   -- main method
   s(
      "main",
      fmt(
         [[
    public static void main(String[] args) {{
        {}
    }}
  ]],
         { i(1) }
      )
   ),

   -- class (only on empty buffer)
   s(
      "class",
      fmt(
         [[
    public class {} {{
        public static void main(String[] args) {{
            {}
        }}
    }}
  ]],
         { f(filename, {}), i(1) }
      ),
      { condition = buffer_empty }
   ),

   -- for loop (indexed)
   s(
      "fori",
      fmt(
         [[
    for (int {} = 0; {} < {}; {}++) {{
        {}
    }}
  ]],
         { i(1, "i"), rep(1), i(2, "n"), rep(1), i(3) }
      )
   ),

   -- for-each loop
   s(
      "fore",
      fmt(
         [[
    for ({} {} : {}) {{
        {}
    }}
  ]],
         { i(1, "Type"), i(2, "item"), i(3, "collection"), i(4) }
      )
   ),

   -- if-else
   s(
      "ife",
      fmt(
         [[
    if ({}) {{
        {}
    }} else {{
        {}
    }}
  ]],
         { i(1), i(2), i(3) }
      )
   ),

   -- try-catch
   s(
      "tryc",
      fmt(
         [[
    try {{
        {}
    }} catch ({} {}) {{
        {}
    }}
  ]],
         { i(1), i(2, "Exception"), i(3, "e"), i(4) }
      )
   ),

   -- method definition
   s(
      "mthd",
      fmt(
         [[
    public {} {}({}) {{
        {}
    }}
  ]],
         { i(1, "void"), i(2, "methodName"), i(3), i(4) }
      )
   ),

   -- constructor
   s(
      "ctor",
      fmt(
         [[
    public {}({}) {{
        {}
    }}
  ]],
         { f(filename, {}), i(1), i(2) }
      )
   ),
}
