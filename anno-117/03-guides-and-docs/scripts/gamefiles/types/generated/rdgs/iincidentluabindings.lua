---@meta rdgs.IIncident
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.IIncident
---@field AppliedCounterMeasures rdgs.CTextSourceListValue[]		
---@field ActiveEscalationEffects integer[]		
---@field AppliedCounterMeasureEffects integer[]		
---@field InitialEscalationDuration rdtime		
---@field ElapsedEscalationDuration rdtime		\"ForDisplay\" means, the value is being ceiled to have no rounding errors when displaying it together with \"GetRemainingEscalationDurationForDisplay\"
---@field RemainingEscalationDuration rdtime		\"ForDisplay\" means, the value is being floored to have no rounding errors when displaying it together with \"GetElapsedEscalationDurationForDisplay\"
local IIncident = {}
---@return boolean returns true if weak pointer holds a valid reference
function IIncident.isValid() end

return IIncident
