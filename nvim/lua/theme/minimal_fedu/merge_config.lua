local function mergeHlConfig(configlist)
  local M = {}

  for _, cfg in pairs(configlist) do
    for _, n in ipairs(cfg) do
      n[1] = cfg.prefix .. n[1]
      M[#M + 1] = n
    end
  end

  return M
end

return mergeHlConfig
