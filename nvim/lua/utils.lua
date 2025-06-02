local U = {}

U.capitalize = function(str)
  return str:gsub("^%l", string.upper)
end

U.has_value = function(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

U.get_relative_path = function(path)
  local vim_runtime = vim.fn.stdpath("config")
  local relative_path = path:gsub(vim_runtime .. "/lua/", "")
  relative_path = relative_path:gsub("/", "."):gsub(".lua", "")
  return relative_path
end

U.loaddir = function(path, ignore_list)
  local l = vim.api.nvim_get_runtime_file(path, true)

  local out = {}
  for _, name in ipairs(l) do
    name = U.get_relative_path(name)
    if U.has_value(ignore_list or {}, name) ~= true then
      out[name] = require(name)
    end
  end

  return out
end

return U
