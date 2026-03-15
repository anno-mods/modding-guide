---@meta rdgs.CGameObject
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGameObject
---@field AttributeProvider rdgs.CPropertyAttributeProvider		
---@field Building rdgs.CPropertyBuilding		
---@field Collectable rdgs.CPropertyCollectable		
---@field DelayedConstruction rdgs.CPropertyDelayedConstruction		
---@field Distribution rdgs.CPropertyDistribution		
---@field Dying rdgs.CPropertyDying		
---@field Factory rdgs.CPropertyFactory7		
---@field Motor rdgs.CPropertyMotorizable		
---@field Mesh rdgs.CPropertyMesh		
---@field Nameable rdgs.CPropertyNameable		
---@field FreeArea rdgs.CPropertyFreeAreaProductivity		
---@field Pausable rdgs.CPropertyPausable		
---@field Repair rdgs.CPropertyRepairCrane		
---@field Residence rdgs.CPropertyResidence7		
---@field River rdgs.CPropertyRiver		
---@field Monument rdgs.CPropertyMonument		
---@field MonumentEventBuilding rdgs.CPropertyMonumentEventBuilding		
---@field Pirate rdgs.CPropertyPirate		
---@field Warehouse rdgs.CPropertyWarehouse		
---@field Buffable rdgs.CPropertyBuffable		
---@field IncidentResolver rdgs.CPropertyIncidentResolver		
---@field ItemContainer rdgs.CPropertyItemContainer		
---@field ModuleOwner rdgs.CPropertyModuleOwner		
---@field Recruitment rdgs.CPropertyRecruitment		
---@field Pier rdgs.CPropertyLoadingPier		
---@field TradeRouteVehicle rdgs.CPropertyTradeRouteVehicle		
---@field Trader rdgs.CPropertyTrader		
---@field ItemCrafter rdgs.CPropertyItemCrafter		
---@field Lifetime rdgs.CPropertyLifetime		
---@field Maintenance rdgs.CPropertyMaintenance		
---@field Sellable rdgs.CPropertySellable		
---@field Infectable rdgs.CPropertyIncidentInfectable		
---@field Logistic rdgs.CPropertyLogisticNode		
---@field IrrigationSouce rdgs.CPropertyIrrigationSource		
---@field AqueductConsumer rdgs.CPropertyAqueductConsumer		
---@field Unit rdgs.CPropertyUnit		
---@field ShipModuleOwner rdgs.CPropertyShipModuleOwner		
---@field Health rdgs.CPropertyHealth		
---@field Villa rdgs.CPropertyVilla		
---@field Romanization rdgs.CPropertyRomanization		
---@field Note rdgs.CPropertyNote		
---@field IsMonument boolean		
---@field IsResidence boolean		
---@field IsWarehouse boolean		Returns true if this object is a warehouse. A kontor is not considered as a warehouse.
---@field IsKontor boolean		Returns true if this object is a kontor
---@field HasVariations boolean		
---@field ID rdgs.GameObjectID		Returns the object id.
---@field GUID integer		Returns the GUID of the object.
---@field Static rdgs.CAsset		
---@field Direction number		Get current rotation around y-axis (@see m_Direction)
---@field Position rdmath.Vector3		get the visual position (i.e. when ON_TERRAIN is set, y is the absolute height)
---@field Position2D rdmath.Vector2		
---@field MetaObjectID rdgs.MetaGameObjectID		returns the MetaGameObjectID of the linked meta gameobject. The gameobject needs the \'PropertyMetaPersistant\' for this.
---@field IsBlueprint boolean		
---@field Upgradability rdgs.CUpgradabilityChecker		Returns the upgradability for the default target if set
---@field Downgradability rdgs.CUpgradabilityChecker		
---@field RegionalUpgradability rdgs.CUpgradabilityChecker		
---@field Renovatability rdgs.CRenovatabilityChecker		
---@field Visible boolean		returns true, if rendering is enabled and false otherwise. 
---@field Owner rdgs.ParticipantGUID		
---@field IsOwnedByCurrentParticipant boolean		
---@field SessionGuid integer		
---@field Area rdgs.CConstructionArea		
---@field AreaManager rdgs.CAreaManager		
---@field IsCultureMainBuilding boolean		checks the combination of AssetDataCulture, AssetDataStreetActivation and AssetDataModuleOwner
---@field IsThreatened boolean		checks construction restriction by enemy military
local CGameObject = {}
GetGameObject = CGameObject
---@param gameObjectID integer
---@return rdgs.CGameObject
function CGameObject.GetGameObject(gameObjectID ) end
---@param self rdgs.CGameObject
---@param posX number
---@param posY number
---@param posZ number
function CGameObject.Move(self, posX , posY , posZ ) end
---the confirmation popup has already been confirmed if needed
---@param self rdgs.CGameObject
---@param destructOptions integer
function CGameObject.DestructConfirmedNet(self, destructOptions ) end
---the confirmation popup has already been confirmed if needed
---@param self rdgs.CGameObject
function CGameObject.DestructConfirmedNet(self) end
---Cheat cycle through skins
---@param self rdgs.CGameObject
---@param dir integer
---@param trackSkinChange boolean
function CGameObject.CycleSkins(self, dir , trackSkinChange ) end
---Cheat cycle through skins
---@param self rdgs.CGameObject
---@param dir integer
function CGameObject.CycleSkins(self, dir ) end
---Changes the skin to the new index if the skin is unlocked
---@param self rdgs.CGameObject
---@param newSkinIndex integer
---@param trackSkinChange boolean
---@param ignoreUnlock boolean
function CGameObject.ChangeSkin(self, newSkinIndex , trackSkinChange , ignoreUnlock ) end
---Changes the skin to the new index if the skin is unlocked
---@param self rdgs.CGameObject
---@param newSkinIndex integer
---@param trackSkinChange boolean
function CGameObject.ChangeSkin(self, newSkinIndex , trackSkinChange ) end
---Changes the skin to the new index if the skin is unlocked
---@param self rdgs.CGameObject
---@param newSkinIndex integer
function CGameObject.ChangeSkin(self, newSkinIndex ) end
---@param self rdgs.CGameObject
---@param unused boolean
---@param mainBuildingOnly boolean
---@param all boolean
---@param showUpgradeCostsNotification boolean
---@param playUpgradeSound boolean
---@param targetGUID integer
function CGameObject.Upgrade(self, unused , mainBuildingOnly , all , showUpgradeCostsNotification , playUpgradeSound , targetGUID ) end
---@param self rdgs.CGameObject
---@param playDowngradeSound boolean
function CGameObject.Downgrade(self, playDowngradeSound ) end
---Returns the upgradability for the given target guid if valid
---@param self rdgs.CGameObject
---@param targetGUID integer
---@return rdgs.CUpgradabilityChecker
function CGameObject.GetUpgradability(self, targetGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameObject.isValid() end

return CGameObject
