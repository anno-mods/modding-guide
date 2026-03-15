---@meta rdgs.CDiplomacyImpactHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDiplomacyImpactHandler
---@field ActiveImpacts rdgs.CDiplomacyImpact[]		Combines \"ActiveImpacts\" and \"ActiveDecayingImpacts\" into one vector
---@field DecayAmount integer		
---@field DecayInterval rdtime		
local CDiplomacyImpactHandler = {}
---@param self rdgs.CDiplomacyImpactHandler
---@param actionGUID integer
---@return integer
function CDiplomacyImpactHandler.GetTendencyValue(self, actionGUID ) end
---@param self rdgs.CDiplomacyImpactHandler
---@param action datasets.DiplomacyAction
---@return rdgs.RelationTendency[]
function CDiplomacyImpactHandler.GetTendencyValueForAllAllies(self, action ) end
---@param self rdgs.CDiplomacyImpactHandler
---@param actionGUID integer
---@return rdgs.CDiplomacyImpact[]
function CDiplomacyImpactHandler.ActiveBasicMoodImpacts(self, actionGUID ) end
---@param self rdgs.CDiplomacyImpactHandler
---@param actionGUID integer
---@param limit integer
---@return rdgs.CDiplomacyImpact[]
function CDiplomacyImpactHandler.ActivePositiveImpacts(self, actionGUID , limit ) end
---@param self rdgs.CDiplomacyImpactHandler
---@param actionGUID integer
---@return rdgs.CDiplomacyImpact[]
function CDiplomacyImpactHandler.ActivePositiveImpacts(self, actionGUID ) end
---@param self rdgs.CDiplomacyImpactHandler
---@param actionGUID integer
---@param limit integer
---@return rdgs.CDiplomacyImpact[]
function CDiplomacyImpactHandler.ActiveNegativeImpacts(self, actionGUID , limit ) end
---@param self rdgs.CDiplomacyImpactHandler
---@param actionGUID integer
---@return rdgs.CDiplomacyImpact[]
function CDiplomacyImpactHandler.ActiveNegativeImpacts(self, actionGUID ) end
---@param self rdgs.CDiplomacyImpactHandler
---@param reasonGUID integer
---@return rdgs.CCondition|nil[]
function CDiplomacyImpactHandler.GetLinkedPlayerCounterConditionsForReason(self, reasonGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDiplomacyImpactHandler.isValid() end

return CDiplomacyImpactHandler
