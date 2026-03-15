---@meta rdgs.CPropertyShipyard
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyShipyard
---@field CurrentConstructionGUID integer		Current Selected Construction Data
---@field Progress number		
---@field RemainingRelativeTime rdtime		
local CPropertyShipyard = {}
---@param self rdgs.CPropertyShipyard
---@param guid integer
---@return boolean
function CPropertyShipyard.GetIsCurrentConstructionGUID(self, guid ) end
---@param self rdgs.CPropertyShipyard
---@param guid integer
---@return rdtime
function CPropertyShipyard.GetConstructionTime(self, guid ) end
---@param self rdgs.CPropertyShipyard
---@param guid integer
---@return rdgs.CBuildCost
function CPropertyShipyard.GetBuildCostForLandUnit(self, guid ) end
---@param self rdgs.CPropertyShipyard
function CPropertyShipyard.CheatSkipRemainingTime(self) end

return CPropertyShipyard
