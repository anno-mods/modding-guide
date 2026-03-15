---@meta rdgs.CAssetDataHelper
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAssetDataHelper
---@field FirstPartyServiceName string		
---@field FirstPartySubscriptionServiceName string		
---@field FirstPartyIcon string		
---@field UbisoftIconHtml string		
local CAssetDataHelper = {}
ToolOneDataHelper = CAssetDataHelper
GetProductFromNeed = CAssetDataHelper
GetNeedCategoryFromNeed = CAssetDataHelper
IsValidNeed = CAssetDataHelper
IsHumanParticipant = CAssetDataHelper
IsSecondPartyParticipant = CAssetDataHelper
IsThirdPartyParticipant = CAssetDataHelper
IsVirtualParticipant = CAssetDataHelper
IsPirateParticipant = CAssetDataHelper
IsTraderParticipant = CAssetDataHelper
IsEmperorRepresentativeParticipant = CAssetDataHelper
IsEmperorParticipant = CAssetDataHelper
FuelDuration = CAssetDataHelper
IsFuelProduct = CAssetDataHelper
---@param self rdgs.CAssetDataHelper
---@param originalText rdsdk.TextId
---@param replacementText rdsdk.TextId
function CAssetDataHelper.AddDynamicTextOveride(self, originalText , replacementText ) end
---@param needGUID rdgs.NeedGUID
---@return rdgs.ProductGUID
function CAssetDataHelper.GetProductFromNeed(needGUID ) end
---@param needGUID rdgs.NeedGUID
---@return integer
function CAssetDataHelper.GetNeedCategoryFromNeed(needGUID ) end
---@param needGUIDInt integer
---@return boolean
function CAssetDataHelper.IsValidNeed(needGUIDInt ) end
---@param self rdgs.CAssetDataHelper
---@param productGUIDInt integer
---@return integer
function CAssetDataHelper.GetNeedByProduct(self, productGUIDInt ) end
---@param self rdgs.CAssetDataHelper
---@param cityStatusGUID integer
---@return integer
function CAssetDataHelper.GetCityStatusLevel(self, cityStatusGUID ) end
---Returns true if the given guid belongs to a building that can equip items
---@param self rdgs.CAssetDataHelper
---@param buildingGUID integer
---@return boolean
function CAssetDataHelper.CanBuildingEquipItems(self, buildingGUID ) end
---@param self rdgs.CAssetDataHelper
---@param guid integer
---@return number
function CAssetDataHelper.GetShipModuleUpgradeBaseHealth(self, guid ) end
---@param self rdgs.CAssetDataHelper
---@param guid integer
---@return integer
function CAssetDataHelper.GetShipModuleUpgradeSelfHeal(self, guid ) end
---@param self rdgs.CAssetDataHelper
---@param guid integer
---@return integer
function CAssetDataHelper.GetShipModuleUpgradeBaseSpeed(self, guid ) end
---Get GUID of the trigger that unlocks the given GUID. Returns INVALID_GUID if no trigger found.
---@param self rdgs.CAssetDataHelper
---@param guid integer
---@return integer
function CAssetDataHelper.GetUnlockTriggerGUIDForAsset(self, guid ) end
---@param participantGUID rdgs.ParticipantGUID
---@return boolean
function CAssetDataHelper.IsHumanParticipant(participantGUID ) end
---@param participantGUID rdgs.ParticipantGUID
---@return boolean
function CAssetDataHelper.IsSecondPartyParticipant(participantGUID ) end
---@param participantGUID rdgs.ParticipantGUID
---@return boolean
function CAssetDataHelper.IsThirdPartyParticipant(participantGUID ) end
---@param participantGUID rdgs.ParticipantGUID
---@return boolean
function CAssetDataHelper.IsVirtualParticipant(participantGUID ) end
---@param participantGUID rdgs.ParticipantGUID
---@return boolean
function CAssetDataHelper.IsPirateParticipant(participantGUID ) end
---@param participantGUID rdgs.ParticipantGUID
---@return boolean
function CAssetDataHelper.IsTraderParticipant(participantGUID ) end
---@param participantGUID rdgs.ParticipantGUID
---@return boolean
function CAssetDataHelper.IsEmperorRepresentativeParticipant(participantGUID ) end
---@param participantGUID rdgs.ParticipantGUID
---@return boolean
function CAssetDataHelper.IsEmperorParticipant(participantGUID ) end
---@param self rdgs.CAssetDataHelper
---@param actionGUID integer
---@return integer
function CAssetDataHelper.GetDiplomacyBreakAction(self, actionGUID ) end
---@param self rdgs.CAssetDataHelper
---@param actionGUID integer
---@param index integer
---@return integer
function CAssetDataHelper.GetSubActionOfDiplomacyAction(self, actionGUID , index ) end
---Returns all the output products or production chains from factories that are buffed by the factory effect of the given patron
---@param self rdgs.CAssetDataHelper
---@param patronGuid integer
---@return integer[]
function CAssetDataHelper.GetProductsBuffedByFactoryEffect(self, patronGuid ) end
---@param guid integer
---@return boolean
function CAssetDataHelper.IsFuelProduct(guid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAssetDataHelper.isValid() end

return CAssetDataHelper
