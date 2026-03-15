---@meta rdgs.CMetaPropertyDiplomacy
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaPropertyDiplomacy
---@field SelectedAllies rdgs.ParticipantGUID[]		
---@field PowerStatistics rdgs.PowerStatistics		
---@field PowerStatisticsForMeAndSelectedAllies rdgs.PowerStatistics		
---@field EconomyLevelForMeAndSelectedAllies integer		
local CMetaPropertyDiplomacy = {}
---@param self rdgs.CMetaPropertyDiplomacy
---@param actionGUID integer
---@param otherParticipant rdgs.ParticipantGUID
---@param reason datasets.DiplomacyActionBlockReason
---@return boolean
function CMetaPropertyDiplomacy.IsDiplomacyActionBlockedByReason(self, actionGUID , otherParticipant , reason ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param actionGuid integer
---@param otherParticipant rdgs.ParticipantGUID
---@return rdtime
function CMetaPropertyDiplomacy.GetDiplomacyActionCountdown(self, actionGuid , otherParticipant ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param actionGuid integer
---@param otherParticipant rdgs.ParticipantGUID
---@return rdtime
function CMetaPropertyDiplomacy.GetDiplomacyActionCooldown(self, actionGuid , otherParticipant ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param actionGUID integer
---@param otherParticipant rdgs.ParticipantGUID
---@return rdtime
function CMetaPropertyDiplomacy.GetRenewalTime(self, actionGUID , otherParticipant ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param actionGUID integer
---@param otherParticipant rdgs.ParticipantGUID
---@return integer
function CMetaPropertyDiplomacy.GetDiplomacyActionMoneyCost(self, actionGUID , otherParticipant ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param actionGUID integer
---@param otherParticipant rdgs.ParticipantGUID
---@return integer
function CMetaPropertyDiplomacy.GetDiplomacyActionReputationCost(self, actionGUID , otherParticipant ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param actionGUID integer
---@param defender rdgs.ParticipantGUID
---@return boolean
function CMetaPropertyDiplomacy.WouldMakeRebellionPossible(self, actionGUID , defender ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param actionGUID integer
---@param defender rdgs.ParticipantGUID
---@return boolean
function CMetaPropertyDiplomacy.WouldMakeConsulPossible(self, actionGUID , defender ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param actionGUID integer
---@param defender rdgs.ParticipantGUID
---@return boolean
function CMetaPropertyDiplomacy.WouldLoseConsulStatus(self, actionGUID , defender ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param actionGUID integer
---@param defender rdgs.ParticipantGUID
---@return boolean
function CMetaPropertyDiplomacy.WouldLoseProConsulStatus(self, actionGUID , defender ) end
---@param self rdgs.CMetaPropertyDiplomacy
function CMetaPropertyDiplomacy.ResetAllActionCooldownsNet(self) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param allyParticipant rdgs.ParticipantGUID
---@param warEnemyParticipant rdgs.ParticipantGUID
---@return boolean
function CMetaPropertyDiplomacy.CanAskAllyToJoinWar(self, allyParticipant , warEnemyParticipant ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param selectedWarType integer
---@param defenderParticipant rdgs.ParticipantGUID
---@return boolean
function CMetaPropertyDiplomacy.IsInvalidPirateWarDeclaration(self, selectedWarType , defenderParticipant ) end
---@param self rdgs.CMetaPropertyDiplomacy
---@param targetParticipant rdgs.ParticipantGUID
---@return rdgs.CDiplomacyImpactHandler
function CMetaPropertyDiplomacy.Impacts(self, targetParticipant ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaPropertyDiplomacy.isValid() end

return CMetaPropertyDiplomacy
