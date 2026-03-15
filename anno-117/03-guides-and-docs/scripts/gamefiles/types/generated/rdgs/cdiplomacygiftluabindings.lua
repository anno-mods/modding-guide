---@meta rdgs.CDiplomacyGift
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDiplomacyGift
---@field GiftSum integer		
local CDiplomacyGift = {}
DiplomacyGift = CDiplomacyGift
---@param actionGuid integer
---@param sender rdgs.ParticipantGUID
---@param receiver rdgs.ParticipantGUID
---@return rdgs.CDiplomacyGift
function CDiplomacyGift.DiplomacyGift(actionGuid , sender , receiver ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDiplomacyGift.isValid() end

return CDiplomacyGift
