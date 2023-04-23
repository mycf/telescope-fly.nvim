local async_static_finder = require("telescope.finders.async_static_finder")

-- 定义一个自定义的Telescope查找器
local pickers = require("telescope.pickers")
local sorters = require("telescope.pickers")
local entry_display = require("telescope.pickers.entry_display")
local function getFlypy()
	return vim.json.decode(
		vim.fn.join(
			vim.fn.readfile(vim.fs.dirname(require("debug").getinfo(1, "S").source:sub(2)) .. "/flypy_n.json"),
			"\n"
		)
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
			sorter = require("telescope.sorters").get_fzy_sorter(),
		})
		:find()
end

-- 将自定义的Telescope选择器映射到快捷键
-- vim.keymap.set("n", "<Leader>fl", lua_selector, { noremap = true, silent = true })
