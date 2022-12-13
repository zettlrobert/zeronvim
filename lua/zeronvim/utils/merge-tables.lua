-- Merge two tables
local function mergeTables(firstTable, secondTable)
  for k,v in pairs(secondTable) do firstTable[k] = v end
  local returnTable = firstTable
  return returnTable
end

return mergeTables
