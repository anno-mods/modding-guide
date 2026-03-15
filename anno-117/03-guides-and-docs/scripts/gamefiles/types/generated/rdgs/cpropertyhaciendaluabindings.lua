---@meta rdgs.CPropertyHacienda
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyHacienda
---@field NextRadiusRequirement integer		
local CPropertyHacienda = {}
---@param self rdgs.CPropertyHacienda
---@param GUID integer
---@return boolean
function CPropertyHacienda.IsPolicyUnlocked(self, GUID ) end
---@param self rdgs.CPropertyHacienda
---@param GUID integer
---@return integer
function CPropertyHacienda.RequiredAttractivenessForPolicy(self, GUID ) end

return CPropertyHacienda
