---@meta rdgs.CToolOneTextHelper
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CToolOneTextHelper
---@field MainBuildingOutput rdgs.CAsset		
---@field DowngradePaybackSelected rdgs.CBuildCost		
---@field NeedAttributeCount integer		
---@field EmperorRepresentativeLighthouses rdgs.CTextSourceListValue[]		Returns a list of all lighthouses from traders that are emperor representatives and the player entered that session already
local CToolOneTextHelper = {}
ToolOneHelper = CToolOneTextHelper
GetProductFromChain = CToolOneTextHelper
GetNeedAttributeValueByProduct = CToolOneTextHelper
GetNeedAttributesCountByProduct = CToolOneTextHelper
GetNeedAttributeValueByNeed = CToolOneTextHelper
GetNeedSupplyByProduct = CToolOneTextHelper
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.IsDLCOwned(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.IsDLCActive(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.HasInfoDescription(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return string
function CToolOneTextHelper.GetInfoDescription(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return rdgs.CAsset
function CToolOneTextHelper.GetProductCategory(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return string
function CToolOneTextHelper.GetBuildingCategory(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return string
function CToolOneTextHelper.GetConstructionCategoryDescription(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return string
function CToolOneTextHelper.GetSkinCategoryDescription(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.IsTree(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.IsSlotObject(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@param slotType datasets.SlotType
---@return boolean
function CToolOneTextHelper.HasSlotType(self, guid , slotType ) end
---Returns a list of regions GUIDs in which this product can be produced (requires to be configured in T1)
---@param self rdgs.CToolOneTextHelper
---@param productGUID integer
---@return rdgs.CTextSourceListValue[]
function CToolOneTextHelper.GetProductionRegionListForProduct(self, productGUID ) end
---Returns all Buffs part of an effect
---@param self rdgs.CToolOneTextHelper
---@param effectGuid integer
---@return integer[]
function CToolOneTextHelper.GetEffectBuffs(self, effectGuid ) end
---@param self rdgs.CToolOneTextHelper
---@param effectGuid integer
---@return integer[]
function CToolOneTextHelper.GetBoostedEffectBuffs(self, effectGuid ) end
---@param self rdgs.CToolOneTextHelper
---@param buffGuid integer
---@return rdgs.CTextSourceListValue[]
function CToolOneTextHelper.GetMetaBuffs(self, buffGuid ) end
---@param self rdgs.CToolOneTextHelper
---@param buffGUID integer
---@return integer[]
function CToolOneTextHelper.GetBlockedBuffs(self, buffGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return string
function CToolOneTextHelper.GetItemExclusiveGroup(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.GetItemHasExclusiveGroup(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.GetItemIsSpecialist(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param buffGUID integer
---@return string
function CToolOneTextHelper.GetBuffCategoryName(self, buffGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param buffGUID integer
---@return datasets.BuffCategory
function CToolOneTextHelper.GetBuffCategory(self, buffGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param buffGUID integer
---@return string
function CToolOneTextHelper.GetBuffCategoryIcon(self, buffGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return string
function CToolOneTextHelper.GetItemActionDescription(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.HasItemActionDescription(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return rdtime
function CToolOneTextHelper.GetItemCooldown(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return rdtime
function CToolOneTextHelper.GetItemDuration(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return rdtime
function CToolOneTextHelper.GetBarrageDuration(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.GetItemIsDestroyedAfterCooldown(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.GetItemHasCharges(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return integer
function CToolOneTextHelper.GetItemActiveEffect(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.ItemIsActive(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param effectOrEffectContainerGUID integer
---@return integer[]
function CToolOneTextHelper.GetItemEffectTargets(self, effectOrEffectContainerGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return rdgs.CAsset
function CToolOneTextHelper.GetBuildingOutput(self, guid ) end
---BuildCosts
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return rdgs.CBuildCost
function CToolOneTextHelper.GetBuildCost(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return rdgs.CBuildCost
function CToolOneTextHelper.GetBuildCostSelected(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.IsMeshGraphWithFixedCostsPerEdge(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return rdgs.CTextSourceUnlockDataEntry[]
function CToolOneTextHelper.UnlockRequirements(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return integer
function CToolOneTextHelper.GetSlotAmount(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return integer
function CToolOneTextHelper.GetSocketAmount(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return integer
function CToolOneTextHelper.GetHitpoints(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param shipguid integer
---@return integer
function CToolOneTextHelper.GetShipMaintenance(self, shipguid ) end
---@param self rdgs.CToolOneTextHelper
---@param populationGUID integer
---@return integer
function CToolOneTextHelper.GetMaxPopulationNeededForUnlocks(self, populationGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param itemGUID integer
---@return integer
function CToolOneTextHelper.GetItemTradePrice(self, itemGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param productGUID integer
---@return integer
function CToolOneTextHelper.GetProductBasePrice(self, productGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param effectGUID integer
---@return integer
function CToolOneTextHelper.GetItemGUIDFromEffectOrEffectContainer(self, effectGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param effectGUID integer
---@return integer
function CToolOneTextHelper.GetForwardedEffectGuidOrSelf(self, effectGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param id rdgs.CGameObject
---@return integer[]
function CToolOneTextHelper.GetOutgoingAttributeEffects(self, id ) end
---@param self rdgs.CToolOneTextHelper
---@param effectGUID integer
---@return boolean
function CToolOneTextHelper.IsForwardingEffect(self, effectGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param moduleGuid integer
---@return boolean
function CToolOneTextHelper.IsMainModule(self, moduleGuid ) end
---@param self rdgs.CToolOneTextHelper
---@param moduleGuid integer
---@return boolean
function CToolOneTextHelper.IsAnyModule(self, moduleGuid ) end
---@param self rdgs.CToolOneTextHelper
---@param moduleGuid integer
---@return boolean
function CToolOneTextHelper.IsVillaModule(self, moduleGuid ) end
---Irrigation
---@param self rdgs.CToolOneTextHelper
---@param buildingGUID integer
---@return boolean
function CToolOneTextHelper.RequiresIrrigation(self, buildingGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param buildingGUID integer
---@return boolean
function CToolOneTextHelper.IsBoostedByIrrigation(self, buildingGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param buildingGUID integer
---@return boolean
function CToolOneTextHelper.IsMarshBuilding(self, buildingGUID ) end
---Object Skins
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return string
function CToolOneTextHelper.GetSkinName(self, guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return string
function CToolOneTextHelper.GetSkinDescription(self, guid ) end
---Need Attributes #OptionalNeedsPrototype 
---@param self rdgs.CToolOneTextHelper
---@param needAttributeTypeInt integer
---@return string
function CToolOneTextHelper.GetNeedAttributeName(self, needAttributeTypeInt ) end
---@param self rdgs.CToolOneTextHelper
---@param needAttributeTypeInt integer
---@return string
function CToolOneTextHelper.GetNeedAttributeIcon(self, needAttributeTypeInt ) end
---@param self rdgs.CToolOneTextHelper
---@param needAttributeTypeInt integer
---@return string
function CToolOneTextHelper.GetNeedAttributeDescription(self, needAttributeTypeInt ) end
---@param self rdgs.CToolOneTextHelper
---@param needAttributeTypeInt integer
---@return string
function CToolOneTextHelper.GetNeedAttributeCalculationText(self, needAttributeTypeInt ) end
---@param self rdgs.CToolOneTextHelper
---@param needCategoryTypeInt integer
---@return string
function CToolOneTextHelper.GetNeedCategoryName(self, needCategoryTypeInt ) end
---@param self rdgs.CToolOneTextHelper
---@param needCategoryTypeInt integer
---@return string
function CToolOneTextHelper.GetNeedCategoryIcon(self, needCategoryTypeInt ) end
---@param self rdgs.CToolOneTextHelper
---@param effectGuid integer
---@param needAttributeTypeInt integer
---@return integer
function CToolOneTextHelper.GetNeedAttributeEffectBuff(self, effectGuid , needAttributeTypeInt ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return boolean
function CToolOneTextHelper.IsProductionChain(self, guid ) end
---Returns the produced product from the endbuilding of the chain or the public service building\nReturns INVALID_GUID if the guid is not a chain, production building or public building
---@param guid integer
---@return integer
function CToolOneTextHelper.GetProductFromChain(guid ) end
---@param self rdgs.CToolOneTextHelper
---@param guid integer
---@return integer[]
function CToolOneTextHelper.GetProductsInProductionChain(self, guid ) end
---@param productGuid integer
---@param needAttributeTypeInt integer
---@return number
function CToolOneTextHelper.GetNeedAttributeValueByProduct(productGuid , needAttributeTypeInt ) end
---returns the count of attributes where the value is != 0
---@param productGuid integer
---@return integer
function CToolOneTextHelper.GetNeedAttributesCountByProduct(productGuid ) end
---@param needGuid integer
---@param needAttributeTypeInt integer
---@return number
function CToolOneTextHelper.GetNeedAttributeValueByNeed(needGuid , needAttributeTypeInt ) end
---@param productGuid integer
---@return number
function CToolOneTextHelper.GetNeedSupplyByProduct(productGuid ) end
---@param self rdgs.CToolOneTextHelper
---@param buildingGUID integer
---@return boolean
function CToolOneTextHelper.IsMonument(self, buildingGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param shipGUID integer
---@return boolean
function CToolOneTextHelper.IsShip(self, shipGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param buildingGUID integer
---@return boolean
function CToolOneTextHelper.IsVilla(self, buildingGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param sessionGuid integer
---@return integer
function CToolOneTextHelper.GetWorldmapSessionImage(self, sessionGuid ) end
---@param self rdgs.CToolOneTextHelper
---@param sessionGuid integer
---@return rdsdk.TextId
function CToolOneTextHelper.GetWorldmapSessionDescription(self, sessionGuid ) end
---Modular Ships
---@param self rdgs.CToolOneTextHelper
---@param assetGUID integer
---@return boolean
function CToolOneTextHelper.IsShipModuleConfiguration(self, assetGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param shipConfigurationID integer
---@return rdgs.CShipModuleConfiguration
function CToolOneTextHelper.GetShipModuleConfiguration(self, shipConfigurationID ) end
---@param self rdgs.CToolOneTextHelper
---@param assetGUID integer
---@return rdgs.CShipModuleConfiguration
function CToolOneTextHelper.CreateShipModuleConfiguration(self, assetGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param effectGUID integer
---@return datasets.Scope
function CToolOneTextHelper.GetEffectScope(self, effectGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param effectGUID integer
---@return string
function CToolOneTextHelper.GetEffectScopeText(self, effectGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param effectGUID integer
---@return string
function CToolOneTextHelper.GetEffectScopeIcon(self, effectGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param poolGUID integer
---@return integer
function CToolOneTextHelper.GetFirstEntryFromPool(self, poolGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param state datasets.DiplomacyState
---@return integer
function CToolOneTextHelper.GetDiplomacyStateIcon(self, state ) end
---@param self rdgs.CToolOneTextHelper
---@param state datasets.DiplomacyState
---@return rdsdk.TextId
function CToolOneTextHelper.GetDiplomacyStateName(self, state ) end
---@param self rdgs.CToolOneTextHelper
---@param actionGUID integer
---@return datasets.DiplomacyState
function CToolOneTextHelper.GetMinimumNeededStateForDiplomacyAction(self, actionGUID ) end
---Returns the time reduction of an incident by the given counter measure
---@param self rdgs.CToolOneTextHelper
---@param counterMeasureGUID integer
---@return rdtime
function CToolOneTextHelper.GetIncidentCounterMeasureTimeReduction(self, counterMeasureGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param productGUID integer
---@return integer[]
function CToolOneTextHelper.GetPopulationFromWorkforceThatProduces(self, productGUID ) end
---@param self rdgs.CToolOneTextHelper
---@param populationGUID integer
---@return integer
function CToolOneTextHelper.GetRegionGUIDFromPopulationGUID(self, populationGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CToolOneTextHelper.isValid() end

return CToolOneTextHelper
