---@meta rdgs.CPropertyTrader
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyTrader
---@field RerollCosts rdgs.CBuildCost|nil		Returns the costs to reroll goods and items. Make sure participant scope is set before calling it
---@field ItemRerollPriceIncreaseForCurrentConfig integer		
---@field IsOfferingImprovedReputationPrices boolean		
---@field IsBarterTrader boolean		
local CPropertyTrader = {}
---produces next ship
---@param self rdgs.CPropertyTrader
function CPropertyTrader.ForceBuild(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyTrader.isValid() end

return CPropertyTrader
