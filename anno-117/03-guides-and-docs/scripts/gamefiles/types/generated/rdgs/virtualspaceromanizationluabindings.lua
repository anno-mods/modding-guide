---@meta rdgs.VirtualSpaceRomanization
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceRomanization
local VirtualSpaceRomanization = {}
Static.GetRomanizationValue = VirtualSpaceRomanization
Static.GetRomanizationValueForPatron = VirtualSpaceRomanization
Static.GetRomanizationType = VirtualSpaceRomanization
Static.GetRomanizationTypeForPatron = VirtualSpaceRomanization
---@param guid integer
---@return integer
function VirtualSpaceRomanization.GetRomanizationValue(guid ) end
---@param guid integer
---@return number
function VirtualSpaceRomanization.GetRomanizationValueForPatron(guid ) end
---@param guid integer
---@return datasets.RomanizationType
function VirtualSpaceRomanization.GetRomanizationType(guid ) end
---@param guid integer
---@return datasets.RomanizationType
function VirtualSpaceRomanization.GetRomanizationTypeForPatron(guid ) end

return VirtualSpaceRomanization
