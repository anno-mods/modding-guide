---@meta rdgs.CAreaTakeoverManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaTakeoverManager
local CAreaTakeoverManager = {}
AreaTakeoverManager = CAreaTakeoverManager
OpenTakeoverDecisionUI = CAreaTakeoverManager
IsAreaStillVassalized = CAreaTakeoverManager
---@param self rdgs.CAreaTakeoverManager
---@param factionGUID integer
---@param participant rdgs.ParticipantGUID
---@return boolean
function CAreaTakeoverManager.CanDonate(self, factionGUID , participant ) end
---@param self rdgs.CAreaTakeoverManager
---@param factionGuid integer
---@param participant rdgs.ParticipantGUID
---@return boolean
function CAreaTakeoverManager.ProtectionTreatyFaction(self, factionGuid , participant ) end
---@param self rdgs.CAreaTakeoverManager
---@param firstParticipant rdgs.ParticipantGUID
---@param secondParticipant rdgs.ParticipantGUID
---@return boolean
function CAreaTakeoverManager.ProtectionTreatyOwner(self, firstParticipant , secondParticipant ) end
---@param self rdgs.CAreaTakeoverManager
---@param sourceParticipant rdgs.ParticipantGUID
---@return rdtime
function CAreaTakeoverManager.DonationCooldown(self, sourceParticipant ) end
---@param self rdgs.CAreaTakeoverManager
---@param participant rdgs.ParticipantGUID
---@return boolean
function CAreaTakeoverManager.HasSuperMajority(self, participant ) end
---@param self rdgs.CAreaTakeoverManager
---@param factionGUID integer
---@param participant rdgs.ParticipantGUID
---@return boolean
function CAreaTakeoverManager.IsFactionOwned(self, factionGUID , participant ) end
---@param areaID rdgs.AreaID
---@param winner rdgs.ParticipantGUID
function CAreaTakeoverManager.OpenTakeoverDecisionUI(areaID , winner ) end
---@param participant rdgs.ParticipantGUID
---@param areaID rdgs.AreaID
---@return boolean
function CAreaTakeoverManager.IsAreaStillVassalized(participant , areaID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaTakeoverManager.isValid() end

return CAreaTakeoverManager
