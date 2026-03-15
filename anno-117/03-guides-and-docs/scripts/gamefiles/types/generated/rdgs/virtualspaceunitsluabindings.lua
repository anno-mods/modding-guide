---@meta rdgs.VirtualSpaceUnits
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceUnits
local VirtualSpaceUnits = {}
Static.GetUnitType = VirtualSpaceUnits
Static.GetUnitDescription = VirtualSpaceUnits
Static.GetCurrentHealth = VirtualSpaceUnits
Static.GetCurrentMaximumHealth = VirtualSpaceUnits
Static.GetMaximumHealth = VirtualSpaceUnits
Static.GetMaximumHealth = VirtualSpaceUnits
Static.GetCurrentHeadcount = VirtualSpaceUnits
Static.GetMaximumHeadcount = VirtualSpaceUnits
Static.GetMaximumHeadcount = VirtualSpaceUnits
Static.GetMaximumHeadcount = VirtualSpaceUnits
Static.GetCurrentMorale = VirtualSpaceUnits
Static.GetCurrentMaximumMorale = VirtualSpaceUnits
Static.GetMaximumMorale = VirtualSpaceUnits
Static.GetMaximumMorale = VirtualSpaceUnits
Static.GetBaseSpeed = VirtualSpaceUnits
Static.GetBuffSpeed = VirtualSpaceUnits
Static.IsAffectedByWind = VirtualSpaceUnits
Static.GetFavorableWindSpeed = VirtualSpaceUnits
Static.GetFavorableWindSpeed = VirtualSpaceUnits
Static.GetUnfavorableWindSpeed = VirtualSpaceUnits
Static.GetUnfavorableWindSpeed = VirtualSpaceUnits
Static.GetConstructionTime = VirtualSpaceUnits
Static.GetTotalDefense = VirtualSpaceUnits
Static.GetTotalDefense = VirtualSpaceUnits
Static.GetBaseDefense = VirtualSpaceUnits
Static.GetBaseDefense = VirtualSpaceUnits
Static.GetShieldDefense = VirtualSpaceUnits
Static.GetShieldDefense = VirtualSpaceUnits
Static.GetArmorDefense = VirtualSpaceUnits
Static.GetArmorDefense = VirtualSpaceUnits
Static.HasMeleeAttack = VirtualSpaceUnits
Static.HasMeleeAttack = VirtualSpaceUnits
Static.GetMeleeAttackPerks = VirtualSpaceUnits
Static.GetMeleeAttackPerks = VirtualSpaceUnits
Static.GetMeleeAttackOffense = VirtualSpaceUnits
Static.GetMeleeAttackOffense = VirtualSpaceUnits
Static.HasRangedAttack = VirtualSpaceUnits
Static.HasRangedAttack = VirtualSpaceUnits
Static.HasRangedAttack = VirtualSpaceUnits
Static.GetRangedAttackPerks = VirtualSpaceUnits
Static.GetRangedAttackPerks = VirtualSpaceUnits
Static.GetRangedAttackPerks = VirtualSpaceUnits
Static.GetRangedAttackOffense = VirtualSpaceUnits
Static.GetRangedAttackOffense = VirtualSpaceUnits
Static.GetRangedAttackOffense = VirtualSpaceUnits
Static.GetRangedAttackOffense = VirtualSpaceUnits
Static.GetRangedAttackRange = VirtualSpaceUnits
Static.GetRangedAttackRange = VirtualSpaceUnits
Static.GetRangedAttackRange = VirtualSpaceUnits
Static.GetRangedAttackRange = VirtualSpaceUnits
Static.GetRangedAttackAccuracy = VirtualSpaceUnits
Static.GetRangedAttackAccuracy = VirtualSpaceUnits
Static.GetRangedAttackAccuracy = VirtualSpaceUnits
Static.GetRangedAttackAccuracy = VirtualSpaceUnits
Static.GetRangedAttackCooldown = VirtualSpaceUnits
Static.GetRangedAttackCooldown = VirtualSpaceUnits
Static.GetRangedAttackCooldown = VirtualSpaceUnits
Static.GetRangedAttackCooldown = VirtualSpaceUnits
Static.GetRangedAttackFirerate = VirtualSpaceUnits
Static.GetRangedAttackFirerate = VirtualSpaceUnits
Static.GetRangedAttackFirerate = VirtualSpaceUnits
Static.GetRangedAttackFirerate = VirtualSpaceUnits
Static.IsEntangled = VirtualSpaceUnits
Static.IsInCombat = VirtualSpaceUnits
Static.GetStanceName = VirtualSpaceUnits
Static.GetIsStationary = VirtualSpaceUnits
Static.GetIsLandUnit = VirtualSpaceUnits
Static.GetIsNavalUnit = VirtualSpaceUnits
Static.IsUnitEncamped = VirtualSpaceUnits
Static.GetUnitUIStateText = VirtualSpaceUnits
Static.GetUnitUIStateIcon = VirtualSpaceUnits
Static.IsUnderAttack = VirtualSpaceUnits
Static.GetUnitFromUnitOrCamp = VirtualSpaceUnits
Static.GetLandUnitCategoryName = VirtualSpaceUnits
---Returns the type of a unit as stated in the text property of the unit asset.
---@param guid integer
---@return string
function VirtualSpaceUnits.GetUnitType(guid ) end
---Returns the description of a unit.
---@param guid integer
---@return string
function VirtualSpaceUnits.GetUnitDescription(guid ) end
---Returns the current health of a unit.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetCurrentHealth(gameObject ) end
---Returns the current maxium health of a unit.\nFor land units, this is the amount of health as if every living element was full health.\nFor all other units and objects, this is the maximum health it can have
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetCurrentMaximumHealth(gameObject ) end
---Returns the maximum health of a unit, based on its configured base health and the base health of its detached elements.
---@param guid integer
---@return integer
function VirtualSpaceUnits.GetMaximumHealth(guid ) end
---Returns the maximum health of a unit, based on what the given object thinks its current maximum health is.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetMaximumHealth(gameObject ) end
---Returns the current head count of a unit.\nFor land units, this is the amount of living elements it currently has. \nFor ships, this is the amount of elements that are currently spawned by modules.\nFor towers, this is the amount of elements the tower has preconfigured.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetCurrentHeadcount(gameObject ) end
---Returns the maximum/initial head count of a unit or ship module.\nFor land units, this is the amount of elements the land unit has when it spawns.\nFor ship modules, this returns the amount of elements the ship module can spawn.\nFor ships and towers, this returns the amount of preconfigured elements, excluding elements spawned by ship modules. 
---@param guid integer
---@param modularShipRefGUID integer
---@return integer
function VirtualSpaceUnits.GetMaximumHeadcount(guid , modularShipRefGUID ) end
---Returns the maximum/initial head count of a unit or ship module.\nFor land units, this is the amount of elements the land unit has when it spawns.\nFor ship modules, this returns the amount of elements the ship module can spawn.\nFor ships and towers, this returns the amount of preconfigured elements, excluding elements spawned by ship modules. 
---@param guid integer
---@return integer
function VirtualSpaceUnits.GetMaximumHeadcount(guid ) end
---Returns the maximum/initial head count of a unit or ship module.\nFor land units, this is the amount of elements the land unit has when it spawns.\nFor ships, this returns the amount of elements that have been spawned by all of their modules.\nFor towers, this returns the amount of preconfigured elements. 
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetMaximumHeadcount(gameObject ) end
---Returns the current morale of a unit.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetCurrentMorale(gameObject ) end
---Returns the current maximum morale of a unit.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetCurrentMaximumMorale(gameObject ) end
---Returns the maximum morale of a unit.
---@param guid integer
---@return integer
function VirtualSpaceUnits.GetMaximumMorale(guid ) end
---Returns the maximum morale of a unit
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetMaximumMorale(gameObject ) end
---Returns the base speed of a unit in u/s. Base speed means that we do not consider buffs, wind, cargo, or any other dynamic factors.
---@param guid integer
---@return number
function VirtualSpaceUnits.GetBaseSpeed(guid ) end
---Returns the base speed of a unit in u/s. Considers base speed and active buffs.
---@param gameObject rdgs.CGameObject
---@return number
function VirtualSpaceUnits.GetBuffSpeed(gameObject ) end
---Returns whether the selected object is affected by wind
---@param gameObject rdgs.CGameObject
---@return boolean
function VirtualSpaceUnits.IsAffectedByWind(gameObject ) end
---Returns the current favorable wind speed of a unit in u/s. Considers base speed, active buffs and wind factors.\nFor towers, ships and ship modules, 0 is returned.
---@param gameObject rdgs.CGameObject
---@return number
function VirtualSpaceUnits.GetFavorableWindSpeed(gameObject ) end
---Returns the current favorable wind speed of a ship configuration in u/s. Considers base speed, configured buffs and wind factors.
---@param shipModuleConfiguration rdgs.CShipModuleConfiguration
---@return number
function VirtualSpaceUnits.GetFavorableWindSpeed(shipModuleConfiguration ) end
---@param gameObject rdgs.CGameObject
---@return number
function VirtualSpaceUnits.GetUnfavorableWindSpeed(gameObject ) end
---Returns the current unfavorable wind speed of a ship configuration in u/s. Considers base speed, configured buffs and wind factors.\nFor towers, ships and ship modules, 0 is returned.
---@param shipModuleConfiguration rdgs.CShipModuleConfiguration
---@return number
function VirtualSpaceUnits.GetUnfavorableWindSpeed(shipModuleConfiguration ) end
---Returns the construction time including the configured module times
---@param shipModuleConfiguration rdgs.CShipModuleConfiguration
---@return rdtime
function VirtualSpaceUnits.GetConstructionTime(shipModuleConfiguration ) end
---Returns the total defense of the element of a unit.
---@param guid integer
---@return integer
function VirtualSpaceUnits.GetTotalDefense(guid ) end
---Returns the total defense of the element of a unit.\nFor towers, ships and ship modules, 0 is returned.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetTotalDefense(gameObject ) end
---Returns the base defense of the element of a unit.
---@param guid integer
---@return integer
function VirtualSpaceUnits.GetBaseDefense(guid ) end
---Returns the base defense of the element of a unit.\nFor towers, ships and ship modules, 0 is returned.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetBaseDefense(gameObject ) end
---Returns the shield defense of the element of a unit.
---@param guid integer
---@return integer
function VirtualSpaceUnits.GetShieldDefense(guid ) end
---Returns the shield defense of the element of a unit.\nFor towers, ships and ship modules, 0 is returned.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetShieldDefense(gameObject ) end
---Returns the armor defense of the element of a unit.
---@param guid integer
---@return integer
function VirtualSpaceUnits.GetArmorDefense(guid ) end
---Returns the armor defense of the element of a unit.\nFor towers, ships and ship modules, 0 is returned.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetArmorDefense(gameObject ) end
---Returns whether the given land unit has a melee attack.
---@param guid integer
---@return boolean
function VirtualSpaceUnits.HasMeleeAttack(guid ) end
---Returns whether the given land unit has a melee attack.
---@param gameObject rdgs.CGameObject
---@return boolean
function VirtualSpaceUnits.HasMeleeAttack(gameObject ) end
---Returns the perks of the melee attack of the given unit.
---@param gameObject rdgs.CGameObject
---@return units.AttackTypePerkInfo[]
function VirtualSpaceUnits.GetMeleeAttackPerks(gameObject ) end
---Returns the perks of the melee attack of the given unit or ship module.
---@param guid integer
---@return units.AttackTypePerkInfo[]
function VirtualSpaceUnits.GetMeleeAttackPerks(guid ) end
---Returns the offense value of the melee attack of the given unit.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetMeleeAttackOffense(gameObject ) end
---Returns the offense value of the melee attack of the given unit or ship module.
---@param guid integer
---@return integer
function VirtualSpaceUnits.GetMeleeAttackOffense(guid ) end
---Returns whether the given unit or ship module has a ranged attack.\nFor land units and towers, the answer depends on the preconfigured elements.\nFor ships, no answer is given.\nFor ship modules, the answer depends on the elements that come with the ship module
---@param guid integer
---@param modularShipRefGUID integer
---@return boolean
function VirtualSpaceUnits.HasRangedAttack(guid , modularShipRefGUID ) end
---Returns whether the given unit or ship module has a ranged attack.\nFor land units and towers, the answer depends on the preconfigured elements.\nFor ships, no answer is given.\nFor ship modules, the answer depends on the elements that come with the ship module
---@param guid integer
---@return boolean
function VirtualSpaceUnits.HasRangedAttack(guid ) end
---Returns whether the given unit currently has a ranged attack.
---@param gameObject rdgs.CGameObject
---@return boolean
function VirtualSpaceUnits.HasRangedAttack(gameObject ) end
---Returns the perks of the ranged attack of the given unit.
---@param gameObject rdgs.CGameObject
---@return units.AttackTypePerkInfo[]
function VirtualSpaceUnits.GetRangedAttackPerks(gameObject ) end
---Returns the perks of the ranged attack of the given unit or ship module.\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@param modularShipRefGUID integer
---@return units.AttackTypePerkInfo[]
function VirtualSpaceUnits.GetRangedAttackPerks(guid , modularShipRefGUID ) end
---Returns the perks of the ranged attack of the given unit or ship module.\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@return units.AttackTypePerkInfo[]
function VirtualSpaceUnits.GetRangedAttackPerks(guid ) end
---Returns the offense value of the ranged attack of the given unit.\nIf a ship module guid is given, returns the current offense value of the ranged attack of that ship module.
---@param gameObject rdgs.CGameObject
---@param shipModuleGUID integer
---@return integer
function VirtualSpaceUnits.GetRangedAttackOffense(gameObject , shipModuleGUID ) end
---Returns the offense value of the ranged attack of the given unit.\nIf a ship module guid is given, returns the current offense value of the ranged attack of that ship module.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetRangedAttackOffense(gameObject ) end
---Returns the offense value of the ranged attack of the given unit or ship module.\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@param modularShipRefGUID integer
---@return integer
function VirtualSpaceUnits.GetRangedAttackOffense(guid , modularShipRefGUID ) end
---Returns the offense value of the ranged attack of the given unit or ship module.\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@return integer
function VirtualSpaceUnits.GetRangedAttackOffense(guid ) end
---Returns the border-to-border range of the ranged attack of the given unit in world units (1u = 4m).\nIf a ship module guid is given, returns the current range of the ranged attack of the given module instead.
---@param gameObject rdgs.CGameObject
---@param shipModuleGUID integer
---@return number
function VirtualSpaceUnits.GetRangedAttackRange(gameObject , shipModuleGUID ) end
---Returns the border-to-border range of the ranged attack of the given unit in world units (1u = 4m).\nIf a ship module guid is given, returns the current range of the ranged attack of the given module instead.
---@param gameObject rdgs.CGameObject
---@return number
function VirtualSpaceUnits.GetRangedAttackRange(gameObject ) end
---Returns the border-to-border range of the ranged attack of the given unit or ship module in world units (1u = 4m).\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@param modularShipRefGUID integer
---@return number
function VirtualSpaceUnits.GetRangedAttackRange(guid , modularShipRefGUID ) end
---Returns the border-to-border range of the ranged attack of the given unit or ship module in world units (1u = 4m).\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@return number
function VirtualSpaceUnits.GetRangedAttackRange(guid ) end
---Returns the accuracy value [0;100] of the ranged attack of the given unit.\nIf a ship module guid is given, returns the current accuracy of the ranged attack of the given module instead.
---@param gameObject rdgs.CGameObject
---@param shipModuleGUID integer
---@return integer
function VirtualSpaceUnits.GetRangedAttackAccuracy(gameObject , shipModuleGUID ) end
---Returns the accuracy value [0;100] of the ranged attack of the given unit.\nIf a ship module guid is given, returns the current accuracy of the ranged attack of the given module instead.
---@param gameObject rdgs.CGameObject
---@return integer
function VirtualSpaceUnits.GetRangedAttackAccuracy(gameObject ) end
---Returns the accuracy value [0;100] of the ranged attack of the given unit or ship module.\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@param modularShipRefGUID integer
---@return integer
function VirtualSpaceUnits.GetRangedAttackAccuracy(guid , modularShipRefGUID ) end
---Returns the accuracy value [0;100] of the ranged attack of the given unit or ship module.\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@return integer
function VirtualSpaceUnits.GetRangedAttackAccuracy(guid ) end
---Returns the cooldown between two attacks of the ranged attack of the given unit.\nIf a ship module guid is given, returns the current cooldown of the ranged attack of the given module instead.
---@param gameObject rdgs.CGameObject
---@param shipModuleGUID integer
---@return rdtime
function VirtualSpaceUnits.GetRangedAttackCooldown(gameObject , shipModuleGUID ) end
---Returns the cooldown between two attacks of the ranged attack of the given unit.\nIf a ship module guid is given, returns the current cooldown of the ranged attack of the given module instead.
---@param gameObject rdgs.CGameObject
---@return rdtime
function VirtualSpaceUnits.GetRangedAttackCooldown(gameObject ) end
---Returns the cooldown between two attacks of the ranged attack of the given unit or ship module.\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@param modularShipRefGUID integer
---@return rdtime
function VirtualSpaceUnits.GetRangedAttackCooldown(guid , modularShipRefGUID ) end
---Returns the cooldown between two attacks of the ranged attack of the given unit or ship module.\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@return rdtime
function VirtualSpaceUnits.GetRangedAttackCooldown(guid ) end
---Returns the amount of attacks per minute of the ranged attack of the given unit.\nIf a ship module guid is given, returns the current amount of attacks per minute of the ranged attack of the given module instead.
---@param gameObject rdgs.CGameObject
---@param shipModuleGUID integer
---@return number
function VirtualSpaceUnits.GetRangedAttackFirerate(gameObject , shipModuleGUID ) end
---Returns the amount of attacks per minute of the ranged attack of the given unit.\nIf a ship module guid is given, returns the current amount of attacks per minute of the ranged attack of the given module instead.
---@param gameObject rdgs.CGameObject
---@return number
function VirtualSpaceUnits.GetRangedAttackFirerate(gameObject ) end
---Returns the amount of attacks per minute of the ranged attack of the given unit or ship module.\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@param modularShipRefGUID integer
---@return number
function VirtualSpaceUnits.GetRangedAttackFirerate(guid , modularShipRefGUID ) end
---Returns the amount of attacks per minute of the ranged attack of the given unit or ship module.\nFor ships, no answer is given, for ship modules \\param modularShipRefGUID has to be set
---@param guid integer
---@return number
function VirtualSpaceUnits.GetRangedAttackFirerate(guid ) end
---Returns whether the given land unit currently is entangled.
---@param gameObject rdgs.CGameObject
---@return boolean
function VirtualSpaceUnits.IsEntangled(gameObject ) end
---Returns whether the given unit currently is in combat.
---@param gameObject rdgs.CGameObject
---@return boolean
function VirtualSpaceUnits.IsInCombat(gameObject ) end
---@param stanceIndex integer
---@return string
function VirtualSpaceUnits.GetStanceName(stanceIndex ) end
---@param guid integer
---@return boolean
function VirtualSpaceUnits.GetIsStationary(guid ) end
---@param guid integer
---@return boolean
function VirtualSpaceUnits.GetIsLandUnit(guid ) end
---@param guid integer
---@return boolean
function VirtualSpaceUnits.GetIsNavalUnit(guid ) end
---@param gameObject rdgs.CGameObject
---@return boolean
function VirtualSpaceUnits.IsUnitEncamped(gameObject ) end
---@param gameObject rdgs.CGameObject
---@return string
function VirtualSpaceUnits.GetUnitUIStateText(gameObject ) end
---@param gameObject rdgs.CGameObject
---@return string
function VirtualSpaceUnits.GetUnitUIStateIcon(gameObject ) end
---@param gameObject rdgs.CGameObject
---@return boolean
function VirtualSpaceUnits.IsUnderAttack(gameObject ) end
---@param gameObject rdgs.CGameObject
---@return rdgs.CGameObject
function VirtualSpaceUnits.GetUnitFromUnitOrCamp(gameObject ) end
---@param guid integer
---@return rdsdk.TextId
function VirtualSpaceUnits.GetLandUnitCategoryName(guid ) end

return VirtualSpaceUnits
