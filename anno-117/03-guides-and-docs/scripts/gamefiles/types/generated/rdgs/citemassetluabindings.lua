---@meta rdgs.CItemAsset
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CItemAsset
---@field Guid integer		
---@field Icon string		
---@field Text string		
---@field IsItem boolean		
---@field HasEffect boolean		
---@field ItemOrBuffEffectTargetsFormatted string		
---@field AdditionalOutputCount integer		
---@field AdditionalOutputProductsFormatted string		
---@field InputAmountUpgradeCount integer		
---@field ReplaceInputOldInputsFormatted string		
---@field ReplaceInputNewInputsFormatted string		
---@field ReplaceInputCount integer		
---@field GoodConsumptionCount integer		
---@field GoodConsumptionAllProvidedNeedsFormatted string		
---@field HasMultipleSameGoodConsumption boolean		
---@field GoodConsumptionIncreasedCount integer		
---@field PirateFlagActive boolean		
---@field WhiteFlagActive boolean		
---@field ProjectileInnerDamage number		
---@field ProjectileOuterDamageRadius number		
---@field UsedProjectile integer		
---@field AddAssemblyOptionsCount integer		
---@field AddAssemblyOptionsFormatted string		
---@field ReplaceAssemblyOptionsCount integer		
---@field ReplaceAssemblyOptionsNewFormatted string		
---@field GoodGenerationProbability integer		
---@field GoodGenerationPoolFormatted string		
---@field EnablesSelfHealDuringCombat boolean		
---@field ResolverUnitCount integer		
---@field ResolverResolveSpeedInPercent integer		
---@field ResolverRepairSpeedInPercent integer		
---@field AddedFertility integer		
---@field AreaTolerance number		
---@field IslandStorageIncrease integer		
---@field IslandWorkforceIncreaseCount integer		
---@field AdditionalSlotAmount integer		
---@field ItemRarity datasets.Rarity		
---@field ItemRarityText string		
---@field ItemRarityIcon string		
---@field ItemRarityColor integer		
---@field IsItemRarityQuest boolean		
---@field IsFluffItem boolean		
---@field ItemNiche datasets.ItemNiche		
---@field ItemNicheText string		
---@field ItemNicheIcon string		
---@field Allocation datasets.ItemAllocation		
---@field AllocationText string		
---@field AllocationIcon string		
---@field ProductivityIncrease integer		
---@field WorforceDecrease number		
---@field PierLoadingSpeedIncrease number		
---@field IsMetaItem boolean		
---@field BoostHintText string		
---@field ItemOrigin datasets.ItemOrigin		
local CItemAsset = {}
ItemAssetData = CItemAsset
---@see CAsset parent class
---@param guid integer
---@return rdgs.CAsset
function CItemAsset.AssetData(guid ) end
---@param guid integer
---@return rdgs.CItemAsset
function CItemAsset.ItemAssetData(guid ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return integer
function CItemAsset.GetAdditionalOutputAmount(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return integer
function CItemAsset.GetAdditionalOutputProduct(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return integer
function CItemAsset.GetAdditionalOutputCycle(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return boolean
function CItemAsset.GetAdditionalOutputForceProductSameAsFactoryOutput(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return integer
function CItemAsset.GetInputAmountUpgradeAmount(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return integer
function CItemAsset.GetInputAmountUpgradeProduct(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return integer
function CItemAsset.GetReplaceInputOldInput(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return integer
function CItemAsset.GetReplaceInputNewInput(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return integer
function CItemAsset.GetGoodConsumptionProvidedNeed(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return number
function CItemAsset.GetGoodConsumptionAmountInPercent(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return number
function CItemAsset.GetGoodConsumptionAmountProvidedInPercent(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return integer
function CItemAsset.GetGoodConsumptionIncreasedNeed(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return number
function CItemAsset.GetGoodConsumptionIncreasedAmountInPercent(self, index ) end
---@param self rdgs.CItemAsset
---@param index integer
---@return integer
function CItemAsset.GetIslandWorkforceIncrease(self, index ) end

return CItemAsset
