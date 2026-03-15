---@meta rdgs.CDiplomacyRansom
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDiplomacyRansom
---@field Amount integer		
local CDiplomacyRansom = {}
DiplomacyRansom = CDiplomacyRansom
---@param actionGuid integer
---@param sender rdgs.ParticipantGUID
---@param receiver rdgs.ParticipantGUID
---@return rdgs.CDiplomacyRansom
function CDiplomacyRansom.DiplomacyRansom(actionGuid , sender , receiver ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDiplomacyRansom.isValid() end

return CDiplomacyRansom
