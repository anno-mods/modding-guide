---@meta rdgs.CAreaAssemblyManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaAssemblyManager
local CAreaAssemblyManager = {}
AreaAssemblyManager = CAreaAssemblyManager
---@param self rdgs.CAreaAssemblyManager
---@param factionGUID integer
---@param participant rdgs.ParticipantGUID
---@return boolean
function CAreaAssemblyManager.CanDonate(self, factionGUID , participant ) end
---@param self rdgs.CAreaAssemblyManager
---@param factionGuid integer
---@param participant rdgs.ParticipantGUID
---@return boolean
function CAreaAssemblyManager.ProtectionTreatyFaction(self, factionGuid , participant ) end
---@param self rdgs.CAreaAssemblyManager
---@param firstParticipant rdgs.ParticipantGUID
---@param secondParticipant rdgs.ParticipantGUID
---@return boolean
function CAreaAssemblyManager.ProtectionTreatyOwner(self, firstParticipant , secondParticipant ) end
---@param self rdgs.CAreaAssemblyManager
---@param sourceParticipant rdgs.ParticipantGUID
---@return rdtime
function CAreaAssemblyManager.DonationCooldown(self, sourceParticipant ) end
---@param self rdgs.CAreaAssemblyManager
---@param participant rdgs.ParticipantGUID
---@return boolean
function CAreaAssemblyManager.HasSuperMajority(self, participant ) end
---@param self rdgs.CAreaAssemblyManager
---@param factionGUID integer
---@param participant rdgs.ParticipantGUID
---@return boolean
function CAreaAssemblyManager.IsFactionOwned(self, factionGUID , participant ) end

return CAreaAssemblyManager
