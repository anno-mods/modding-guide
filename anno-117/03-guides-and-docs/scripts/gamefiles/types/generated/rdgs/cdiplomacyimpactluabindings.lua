---@meta rdgs.CDiplomacyImpact
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDiplomacyImpact
---@field GUID integer		
---@field ReasonGUID integer		
---@field IconGUID integer		
---@field IsDecaying boolean		
---@field ShowLadderIcon boolean		
local CDiplomacyImpact = {}
---@param self rdgs.CDiplomacyImpact
---@param actionGUID integer
---@return integer
function CDiplomacyImpact.GetTendencyValue(self, actionGUID ) end
---@param self rdgs.CDiplomacyImpact
---@param actionGUID integer
---@return rdsdk.TextId
function CDiplomacyImpact.GetTextId(self, actionGUID ) end
---@param self rdgs.CDiplomacyImpact
---@param actionGUID integer
---@return rdsdk.TextId
function CDiplomacyImpact.GetHeaderTextId(self, actionGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDiplomacyImpact.isValid() end

return CDiplomacyImpact
