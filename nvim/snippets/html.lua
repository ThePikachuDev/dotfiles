local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("html", {
  s("html5", {
    t({
      "<!DOCTYPE html>",
      "<html lang=\"en\">",
      "<head>",
      "    <meta charset=\"UTF-8\">",
      "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
      "    <title>Document</title>",
      "</head>",
      "<body>",
      "    ",
      "</body>",
      "</html>"
    })
  })
})

