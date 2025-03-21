return {
  settings = {
    tailwindCSS = {
      classAttributes = { ":class", "class", "className" },
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "(?:enter|leave)(?:From|To)?=\\s*(?:\"|')([^(?:\"|')]*)" },
          { "cn\\(([^)]*)\\)", "'([^']*)'" },
          { ":class?=\\s*(?:\"|'|{`)([^(?:\"|'|`})]*)" },
        },
      },
    },
  },
}
