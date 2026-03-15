---@meta rdgs.CDecayingDiplomacyImpact
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDecayingDiplomacyImpact
---@field GUID integer		
---@field ReasonGUID integer		
---@field IconGUID integer		
---@field IsDecaying boolean		
---@field IsDecaying boolean		
local CDecayingDiplomacyImpact = {}
---@see CDiplomacyImpact parent class
---@param self rdgs.CDecayingDiplomacyImpact
---@param actionGUID integer
---@return integer
function CDecayingDiplomacyImpact.GetTendencyValue(self, actionGUID ) end
---@param self rdgs.CDecayingDiplomacyImpact
---@param actionGUID integer
---@return rdsdk.TextId
function CDecayingDiplomacyImpact.GetTextId(self, actionGUID ) end
---@param self rdgs.CDecayingDiplomacyImpact
---@param actionGUID integer
---@return rdsdk.TextId
function CDecayingDiplomacyImpact.GetHeaderTextId(self, actionGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDecayingDiplomacyImpact.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CDecayingDiplomacyImpact.isValid() end

return CDecayingDiplomacyImpact
