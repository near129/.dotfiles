return {
  settings = {
    rule = {
      {
        include = { 'pyproject.toml' },
        formatting = {
          indent_string = '    ', -- 4 spaces
        },
      },
    },
  },
}
