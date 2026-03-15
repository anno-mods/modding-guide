---@meta rdgs.CAreaMoneyManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaMoneyManager
---@field TotalMoneyIncome number		returns the total balance of this island
---@field LandTax integer		returns the land tax for this island (only depends on island size) for the areaOwner.
local CAreaMoneyManager = {}
---@return boolean returns true if weak pointer holds a valid reference
function CAreaMoneyManager.isValid() end

return CAreaMoneyManager
