---@meta rdgs.VirtualSpaceReputation
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceReputation
local VirtualSpaceReputation = {}
Static.GetSpecialStateName = VirtualSpaceReputation
Static.GetReputationZoneName = VirtualSpaceReputation
Static.GetSpecialStateIcon = VirtualSpaceReputation
Static.GetReputationZoneIcon = VirtualSpaceReputation
Static.GetEffects = VirtualSpaceReputation
Static.GetUnlockAssets = VirtualSpaceReputation
Static.GetSpecialStateDescriptions = VirtualSpaceReputation
Static.IsRefOidSpecialState = VirtualSpaceReputation
Static.EmperorRebellionLoyalistBonus = VirtualSpaceReputation
Static.ReputationAfterConsulTitleLoss = VirtualSpaceReputation
Static.ReputationAfterProConsulTitleLoss = VirtualSpaceReputation
Static.ReputationAfterEmperorChangeForLoyalists = VirtualSpaceReputation
Static.ReputationAfterEmperorChangeForRebels = VirtualSpaceReputation
Static.ReputationAfterEmperorChangeForNeutrals = VirtualSpaceReputation
Static.GetReputationCostAnnihilatingOpponent = VirtualSpaceReputation
Static.GetWouldLooseConsulState = VirtualSpaceReputation
Static.GetWouldMakeRebellionPossible = VirtualSpaceReputation
Static.GetWouldMakeConsulPossible = VirtualSpaceReputation
Static.GetWouldLooseProConsulState = VirtualSpaceReputation
Static.CurrentReputation = VirtualSpaceReputation
Static.ReputationZoneOrSpecialStateIndex = VirtualSpaceReputation
Static.ReputationZoneOrSpecialStateType = VirtualSpaceReputation
Static.IsCurrentParticipantRebelling = VirtualSpaceReputation
Static.IsCurrentParticipantConsul = VirtualSpaceReputation
Static.IsCurrentParticipantProConsul = VirtualSpaceReputation
Static.OpenReputationOverview = VirtualSpaceReputation
---Couple of textsources for the reputation overview screen. The parameters are datasetType 0 for reputation zone and datasetType 1 for special state
---@param datasetType integer
---@param datasetIndex integer
---@return rdsdk.TextId
function VirtualSpaceReputation.GetSpecialStateName(datasetType , datasetIndex ) end
---@param datasetType integer
---@param datasetIndex integer
---@return rdsdk.TextId
function VirtualSpaceReputation.GetReputationZoneName(datasetType , datasetIndex ) end
---@param datasetType integer
---@param datasetIndex integer
---@return integer
function VirtualSpaceReputation.GetSpecialStateIcon(datasetType , datasetIndex ) end
---@param datasetType integer
---@param datasetIndex integer
---@return integer
function VirtualSpaceReputation.GetReputationZoneIcon(datasetType , datasetIndex ) end
---@param datasetType integer
---@param datasetIndex integer
---@return integer[]
function VirtualSpaceReputation.GetEffects(datasetType , datasetIndex ) end
---@param datasetType integer
---@param datasetIndex integer
---@return integer[]
function VirtualSpaceReputation.GetUnlockAssets(datasetType , datasetIndex ) end
---@param datasetType integer
---@param datasetIndex integer
---@return rdgs.CTextSourceListValue[]
function VirtualSpaceReputation.GetSpecialStateDescriptions(datasetType , datasetIndex ) end
---@param datasetType integer
---@return boolean
function VirtualSpaceReputation.IsRefOidSpecialState(datasetType ) end
---@param currentRelation rdgs.CDiplomacyRelation
---@return integer
function VirtualSpaceReputation.GetReputationCostAnnihilatingOpponent(currentRelation ) end
---Returns true if the participant would loose the consul state by applying the reputation delta
---@param participant rdgs.ParticipantGUID
---@param reputationDelta integer
---@return boolean
function VirtualSpaceReputation.GetWouldLooseConsulState(participant , reputationDelta ) end
---Returns true if the participant would be able to start a rebellion after applying the reputation delta
---@param participant rdgs.ParticipantGUID
---@param reputationDelta integer
---@return boolean
function VirtualSpaceReputation.GetWouldMakeRebellionPossible(participant , reputationDelta ) end
---Returns true if the participant would be offered a consul title after applying the reputation delta
---@param participant rdgs.ParticipantGUID
---@param reputationDelta integer
---@return boolean
function VirtualSpaceReputation.GetWouldMakeConsulPossible(participant , reputationDelta ) end
---Returns true if the participant would loose the pro consul state by applying the reputation delta
---@param participant rdgs.ParticipantGUID
---@param reputationDelta integer
---@return boolean
function VirtualSpaceReputation.GetWouldLooseProConsulState(participant , reputationDelta ) end
---Opens the diplomacy menu with the reputation overview screen open
function VirtualSpaceReputation.OpenReputationOverview() end

return VirtualSpaceReputation
