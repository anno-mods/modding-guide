---@meta rdgs.CDecisionComponent
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDecisionComponent
---@field GUID integer		Returns the component GUID
local CDecisionComponent = {}
GetDecisionOutcomeMaterial = CDecisionComponent
HasNonMetaDecisionOutcomeMaterial = CDecisionComponent
GetDecisionOutcomeIncidentCountermeasure = CDecisionComponent
GetDecisionOutcomeEffectStarted = CDecisionComponent
HasDecisionOutcomeEffectLocationInfos = CDecisionComponent
GetDecisionOutcomeEffectLocationInfo = CDecisionComponent
---@see CQuestComponent parent class
---@return boolean returns true if weak pointer holds a valid reference
function CDecisionComponent.isValid() end
---Checks if the decision option with the given index is unlocked and can be taken by the player
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@return boolean
function CDecisionComponent.IsDecisionOptionUnlocked(self, optionIndex ) end
---Returns a vector of goods needed to pay to select this option, can be nullptr if there are no costs
---@param self rdgs.CDecisionComponent
---@param usePreviousDecision boolean
---@param optionIndex integer
---@return rdgs.DemandedGoodEx[]
function CDecisionComponent.GetDecisionOptionCost(self, usePreviousDecision , optionIndex ) end
---Returns a float value [0, 1] describing the chance of taking the success output of this option (e.g. 0.65f = 65% chance on success)
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@return number
function CDecisionComponent.GetDecisionOptionSuccessChance(self, optionIndex ) end
---Returns true if the given option has a challenge configured
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@return boolean
function CDecisionComponent.HasChallenge(self, optionIndex ) end
---Returns true if the given option has the given DecisionChallenge Type set for its challenge
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@param type datasets.DecisionChallengeType
---@return boolean
function CDecisionComponent.CheckDCType(self, optionIndex , type ) end
---Returns needed value for the Challenge to be at 100%
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@return number
function CDecisionComponent.GetDCCheckValue(self, optionIndex ) end
---Returns curent value for the Challenge 
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@return number
function CDecisionComponent.GetDCCurrentValue(self, optionIndex ) end
---Returns a TextSourceObject by a given key, can be nullptr if key does not exist
---@param self rdgs.CDecisionComponent
---@param key string
---@return rdgs.CTextSourceObjectWrapper
function CDecisionComponent.GetContextByKey(self, key ) end
---@param self rdgs.CDecisionComponent
---@param key string
---@return boolean
function CDecisionComponent.HasContextByKey(self, key ) end
---Returns true if this decision option cannot fail
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@return boolean
function CDecisionComponent.IsDecisionOptionSuccessGuaranteed(self, optionIndex ) end
---Returns a text describing why this option is locked. Is empty if the option is not locked
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@return string
function CDecisionComponent.GetDecisionOptionLockedReasonText(self, optionIndex ) end
---Returns true if this option has an additional outcome text configured 
---@param self rdgs.CDecisionComponent
---@param usePreviousDecision boolean
---@param optionIndex integer
---@return boolean
function CDecisionComponent.HasAdditionalOutcomeText(self, usePreviousDecision , optionIndex ) end
---Returns a text for additional outcomes of this decision or the previous one
---@param self rdgs.CDecisionComponent
---@param usePreviousDecision boolean
---@param optionIndex integer
---@return string
function CDecisionComponent.GetDecisionOptionAdditionalOutcomeText(self, usePreviousDecision , optionIndex ) end
---Returns a the reputation delta which will happen if this option is taken (for this participant) \nIt will already look up the follow up decision if this will trigger a reputation change
---@param self rdgs.CDecisionComponent
---@param usePreviousDecision boolean
---@param optionIndex integer
---@param followUpDecision integer
---@return integer
function CDecisionComponent.GetDecisionOptionReputationChange(self, usePreviousDecision , optionIndex , followUpDecision ) end
---@param self rdgs.CDecisionComponent
---@param usePreviousDecision boolean
---@param optionIndex integer
---@return integer
function CDecisionComponent.GetDecisionOptionReputationChangeByTrait(self, usePreviousDecision , optionIndex ) end
---Returns true if this decision option has setup a emperor trait
---@param self rdgs.CDecisionComponent
---@param usePreviousDecision boolean
---@param optionIndex integer
---@return boolean
function CDecisionComponent.HasDecisionOptionEmperorTrait(self, usePreviousDecision , optionIndex ) end
---Returns true if taking this decision option will lead to be on min reputation amount
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@param followUpDecision integer
---@return boolean
function CDecisionComponent.WillReputationChangeLeadToRebellion(self, optionIndex , followUpDecision ) end
---Returns true if taking this decision option will lead to be below the money bankruptcy threshold
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@return boolean
function CDecisionComponent.WillMoneyCostLeadToBankruptcy(self, optionIndex ) end
---Returns a decision component id of the follow up decision after a given decision option
---@param self rdgs.CDecisionComponent
---@param optionIndex integer
---@param success boolean
---@return integer
function CDecisionComponent.GetFollowUpDecision(self, optionIndex , success ) end
---Returns a vector of goods/items/money the player receives if this decision gets active
---@param decisionGuid integer
---@param accessorID quest.ComponentID
---@return rdgs.DemandedGoodEx[]
function CDecisionComponent.GetDecisionOutcomeMaterial(decisionGuid , accessorID ) end
---Returns true if the outcome materials are items ore goods
---@param decisionGuid integer
---@param accessorID quest.ComponentID
---@return boolean
function CDecisionComponent.HasNonMetaDecisionOutcomeMaterial(decisionGuid , accessorID ) end
---Returns a location name where the goods will most likely be added
---@param self rdgs.CDecisionComponent
---@param decisionGuid integer
---@return string
function CDecisionComponent.GetDecisionOutcomeMaterialLocation(self, decisionGuid ) end
---Returns a guid of a countermeasure for incidents when this decision gets active
---@param decisionGuid integer
---@return integer
function CDecisionComponent.GetDecisionOutcomeIncidentCountermeasure(decisionGuid ) end
---Returns a list of guids of any effects which will be started when this decision gets active
---@param decisionGuid integer
---@return integer[]
function CDecisionComponent.GetDecisionOutcomeEffectStarted(decisionGuid ) end
---Returns true if this decision will start a effect on a specific location
---@param decisionGuid integer
---@param effectActionIndex integer
---@return boolean
function CDecisionComponent.HasDecisionOutcomeEffectLocationInfos(decisionGuid , effectActionIndex ) end
---Returns the name of the location if this decision will start a effect on a specific location
---@param decisionGuid integer
---@param accessorID quest.ComponentID
---@param effectActionIndex integer
---@return string
function CDecisionComponent.GetDecisionOutcomeEffectLocationInfo(decisionGuid , accessorID , effectActionIndex ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDecisionComponent.isValid() end

return CDecisionComponent
