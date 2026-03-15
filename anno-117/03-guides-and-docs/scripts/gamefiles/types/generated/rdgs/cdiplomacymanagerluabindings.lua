---@meta rdgs.CDiplomacyManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDiplomacyManager
---@field ReputationCostMakePeaceDeclineWinner integer		
---@field ReputationCostMakePeaceDeclineLoser integer		
local CDiplomacyManager = {}
Diplomacy = CDiplomacyManager
---@param self rdgs.CDiplomacyManager
---@param participant rdgs.ParticipantGUID
---@param otherParticipant rdgs.ParticipantGUID
---@return rdgs.CDiplomacyRelation
function CDiplomacyManager.GetRelationIfModified(self, participant , otherParticipant ) end
---@param self rdgs.CDiplomacyManager
---@param value boolean
function CDiplomacyManager.SetWarDeclarationAllowed(self, value ) end
---@param self rdgs.CDiplomacyManager
---@param participant rdgs.ParticipantGUID
---@param otherParticipant rdgs.ParticipantGUID
---@return boolean
function CDiplomacyManager.CanJoinForces(self, participant , otherParticipant ) end
---@param self rdgs.CDiplomacyManager
---@param participant rdgs.ParticipantGUID
---@return rdgs.ParticipantGUID[]
function CDiplomacyManager.GetAllies(self, participant ) end
---@param self rdgs.CDiplomacyManager
---@param participant rdgs.ParticipantGUID
---@return rdgs.ParticipantGUID[]
function CDiplomacyManager.GetNonAllies(self, participant ) end
---@param self rdgs.CDiplomacyManager
---@param participant rdgs.ParticipantGUID
---@return rdgs.ParticipantGUID[]
function CDiplomacyManager.GetDefensiveAllies(self, participant ) end
---TextSources
---@param self rdgs.CDiplomacyManager
---@param actionGUID integer
---@return rdsdk.TextId
function CDiplomacyManager.GetActionName(self, actionGUID ) end
---@param self rdgs.CDiplomacyManager
---@param actionGUID integer
---@return rdsdk.TextId
function CDiplomacyManager.GetActionDescription(self, actionGUID ) end
---@param self rdgs.CDiplomacyManager
---@param actionGUID integer
---@return boolean
function CDiplomacyManager.IsBreakAction(self, actionGUID ) end
---@param self rdgs.CDiplomacyManager
---@param actionGUID integer
---@return boolean
function CDiplomacyManager.IsRenewAction(self, actionGUID ) end
---@param self rdgs.CDiplomacyManager
---@param actionGUID integer
---@return boolean
function CDiplomacyManager.IsAllianceAction(self, actionGUID ) end
---@param self rdgs.CDiplomacyManager
---@param actionGUID integer
---@return boolean
function CDiplomacyManager.IsAllianceOrDefensivePactAction(self, actionGUID ) end
---@param self rdgs.CDiplomacyManager
---@param initiatorGUID integer
---@param evaluatorGUID integer
---@return integer
function CDiplomacyManager.GetReputationGainJoinWarAccept(self, initiatorGUID , evaluatorGUID ) end
---@param self rdgs.CDiplomacyManager
---@param initiatorGUID integer
---@param evaluatorGUID integer
---@return integer
function CDiplomacyManager.GetReputationCostJoinWarDecline(self, initiatorGUID , evaluatorGUID ) end
---@param self rdgs.CDiplomacyManager
---@param initatorGUID integer
---@param evaluatorGUID integer
---@return integer
function CDiplomacyManager.GetReputationCostAcceptWhitePeace(self, initatorGUID , evaluatorGUID ) end
---@param self rdgs.CDiplomacyManager
---@param actionGUID integer
---@return rdsdk.TextId
function CDiplomacyManager.GetLeadToStateOrSubstateName(self, actionGUID ) end
---@param self rdgs.CDiplomacyManager
function CDiplomacyManager.CheatTotalWar(self) end
---@param self rdgs.CDiplomacyManager
function CDiplomacyManager.CheatTotalAlliance(self) end
---@param self rdgs.CDiplomacyManager
function CDiplomacyManager.CheatTotalPeace(self) end
---@param self rdgs.CDiplomacyManager
function CDiplomacyManager.CheatTotalTrade(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CDiplomacyManager.isValid() end

return CDiplomacyManager
