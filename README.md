# 小鹤查形

```

    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
    end,
    dependencies = {
      {
        "mycf/telescope-fly.nvim",
        cmd = "Telescope",
        config = function()
          local telescope = require "telescope"
          telescope.load_extension "fly"
        end,
    keys = {
      { "[[", desc = "Prev Reference" },
    },
      },
    },
```

## 数据来源于
- [zerovip/flypy_things](https://github.com/mycf/telescope-fly.nvim)
