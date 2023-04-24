local async_static_finder = require("telescope.finders.async_static_finder")

-- 定义一个自定义的Telescope查找器
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local entry_display = require("telescope.pickers.entry_display")
local function getFlypy()
	return vim.json.decode(
		vim.fn.join(vim.fn.readfile(vim.fs.dirname(debug.getinfo(1, "S").source:sub(2)) .. "/flypy_n.json"), "\n")
	)
end

local yu_maker = function()
	local displayer = entry_display.create({
		separator = "▏",
		items = {
			{ width = 0.1 },
			{ width = 14 },
			{ width = 14 },
			{ remaining = true },
		},
	})

	local make_display = function(entry)
		return displayer({
			{ entry.value.character, "TelescopeResultsIdentifier" },
			"编码" .. " " .. entry.value.fly_code,
			"首末" .. " " .. entry.value.first_py .. "  " .. entry.value.last_py,
			"拆分" .. " " .. entry.value.order,
		})
	end

	return function(entry)
		return {
			name = entry.character,
			value = entry,
			ordinal = entry.character,
			display = make_display,
		}
	end
end
local fly_finder = function(opts, _)
	opts = opts or {}
	return async_static_finder({
		results = getFlypy(),
		entry_maker = yu_maker(opts),
	})
end
return function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "小鹤查形",
			finder = fly_finder(opts),
			sorter = sorters.Sorter:new({
				scoring_function = function(_, prompt, _, entry)
					if #prompt == 0 then
						return 1
					end
					return prompt:find(entry.name) or -1
				end,
			}),
		})
		:find()
end
