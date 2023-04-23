# 小鹤查形
![Preview](https://i.imgur.com/TTTja6t.gif)

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
      {'<leader>fl', '<cmd>Telescope fly<cr>', mode = 'n', desc = '小鹤查形'}
    },
      },
    },
```

## 数据来源于
- [zerovip/flypy_things](https://github.com/mycf/telescope-fly.nvim)
