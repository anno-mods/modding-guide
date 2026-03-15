---@meta rdgs.CBuildCostEntry
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CBuildCostEntry
---@field ProductGUID integer		
---@field Amount integer		
---@field Icon string		
---@field Name string		
---@field IsAffordable boolean		
---@field IsEnoughAvailable boolean		similar to IsAffordable, but this calculates if AvailableAmount = Amount (negative money should be marked as missing, but it is still affordable!)
---@field AvailableAmount integer		
local CBuildCostEntry = {}

return CBuildCostEntry
