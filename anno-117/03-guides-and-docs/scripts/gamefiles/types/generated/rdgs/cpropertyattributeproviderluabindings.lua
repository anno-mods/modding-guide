---@meta rdgs.CPropertyAttributeProvider
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyAttributeProvider
---@field PopulationToWorkforceFactor number		
---@field WorkforceOutput number		
---@field PopulationLevel integer		
local CPropertyAttributeProvider = {}
---@param self rdgs.CPropertyAttributeProvider
---@param attributeType datasets.NeedAttributeType
---@return number
function CPropertyAttributeProvider.GetAttributeValue(self, attributeType ) end
---@param self rdgs.CPropertyAttributeProvider
---@param attributeType datasets.NeedAttributeType
---@return number
function CPropertyAttributeProvider.GetAttributeValueFromCityStatus(self, attributeType ) end
---@param self rdgs.CPropertyAttributeProvider
---@param attributeType datasets.NeedAttributeType
---@return number
function CPropertyAttributeProvider.GetAttributeValueFromIncidentDifficulty(self, attributeType ) end
---returns the attribute value excluding buffs
---@param self rdgs.CPropertyAttributeProvider
---@param attributeType datasets.NeedAttributeType
---@return number
function CPropertyAttributeProvider.GetBaseValueForAttribute(self, attributeType ) end
---returns the attribute value excluding buffs, city status and incident values
---@param self rdgs.CPropertyAttributeProvider
---@param attributeType datasets.NeedAttributeType
---@return number
function CPropertyAttributeProvider.GetStaticBaseValueForAttribute(self, attributeType ) end
---@param self rdgs.CPropertyAttributeProvider
---@param attributeType datasets.NeedAttributeType
---@return boolean
function CPropertyAttributeProvider.CanProvideAttributes(self, attributeType ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyAttributeProvider.isValid() end

return CPropertyAttributeProvider
