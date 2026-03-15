---@meta rdgs.CRomanizationManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CRomanizationManager
---@field IsActive boolean		
---@field RomanizationPercentage number		
local CRomanizationManager = {}
Romanization = CRomanizationManager
---@param self rdgs.CRomanizationManager
---@param area rdgs.AreaID
---@return number
function CRomanizationManager.GetRomanizationPercentageForArea(self, area ) end
---@param self rdgs.CRomanizationManager
---@param area rdgs.AreaID
---@param type datasets.RomanizationType
---@return rdgs.CTextSourceListValue[]
function CRomanizationManager.GetRomanizationValuesPerGUID(self, area , type ) end
---@param self rdgs.CRomanizationManager
function CRomanizationManager.ToggleForcedUpgradeMode(self) end
---@param self rdgs.CRomanizationManager
---@param mode datasets.RomanizationType
function CRomanizationManager.SetForcedUpgradeMode(self, mode ) end
---@return boolean returns true if weak pointer holds a valid reference
function CRomanizationManager.isValid() end

return CRomanizationManager
