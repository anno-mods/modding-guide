---@meta rdgs.CAreaLandCombatManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaLandCombatManager
---@field BalancingTest rdgs.CCombatBalancingTestHelper		
local CAreaLandCombatManager = {}
LandCombat = CAreaLandCombatManager
---@param self rdgs.CAreaLandCombatManager
---@param selectSpawnedUnit boolean
function CAreaLandCombatManager.SpawnUnitAtMouse(self, selectSpawnedUnit ) end
---@param self rdgs.CAreaLandCombatManager
---@param positionString string
function CAreaLandCombatManager.SpawnUnitAtInput(self, positionString ) end
---@param self rdgs.CAreaLandCombatManager
---@param combatUnitID rdgs.CombatUnitID
function CAreaLandCombatManager.SelectUnit(self, combatUnitID ) end
---@param self rdgs.CAreaLandCombatManager
function CAreaLandCombatManager.MoveUnitToMouse(self) end
---@param self rdgs.CAreaLandCombatManager
function CAreaLandCombatManager.SelectDebugSoldierAtMouse(self) end
---@param self rdgs.CAreaLandCombatManager
function CAreaLandCombatManager.RepeatLastMove(self) end
---@param self rdgs.CAreaLandCombatManager
function CAreaLandCombatManager.CleanUpFlowFieldsOfSelectedUnit(self) end
---@param self rdgs.CAreaLandCombatManager
---@param positionString string
function CAreaLandCombatManager.MoveUnitToInput(self, positionString ) end
---@param self rdgs.CAreaLandCombatManager
---@param targetUnitID integer
function CAreaLandCombatManager.MoveAttackWithSelectedUnit(self, targetUnitID ) end
---@param self rdgs.CAreaLandCombatManager
function CAreaLandCombatManager.MoveAttackRandomWithSelectedUnit(self) end
---@param self rdgs.CAreaLandCombatManager
function CAreaLandCombatManager.DestroySelectedUnit(self) end
---@param self rdgs.CAreaLandCombatManager
---@param unitID integer
function CAreaLandCombatManager.DestroyUnit(self, unitID ) end
---@param self rdgs.CAreaLandCombatManager
function CAreaLandCombatManager.DestroyAllUnits(self) end
---@param self rdgs.CAreaLandCombatManager
---@param amount integer
function CAreaLandCombatManager.SpawnStagedMovement(self, amount ) end
---@param self rdgs.CAreaLandCombatManager
---@param amount integer
function CAreaLandCombatManager.SpawnStagedFights(self, amount ) end
---@param self rdgs.CAreaLandCombatManager
function CAreaLandCombatManager.SpawnStagedProfileFight(self) end
---@param self rdgs.CAreaLandCombatManager
function CAreaLandCombatManager.ClearStagedUnits(self) end
---@param self rdgs.CAreaLandCombatManager
---@param unitID rdgs.CombatUnitID
---@return boolean
function CAreaLandCombatManager.IsUnitMoving(self, unitID ) end
---@param self rdgs.CAreaLandCombatManager
---@param unitID rdgs.CombatUnitID
---@return boolean
function CAreaLandCombatManager.IsUnitFighting(self, unitID ) end
---@param self rdgs.CAreaLandCombatManager
---@param unitID rdgs.CombatUnitID
---@param targetPosition rdmath.Vector3|table|number[]
---@param heightOffset number
function CAreaLandCombatManager.UnitLaunchProjectile(self, unitID , targetPosition , heightOffset ) end
---@param self rdgs.CAreaLandCombatManager
---@param unitID rdgs.CombatUnitID
---@param position rdmath.Vector3|table|number[]
---@return boolean
function CAreaLandCombatManager.MoveUnit(self, unitID , position ) end
---@param self rdgs.CAreaLandCombatManager
---@param unitID rdgs.CombatUnitID
---@param targetUnitID rdgs.CombatUnitID
function CAreaLandCombatManager.MoveUnitAttack(self, unitID , targetUnitID ) end
---@param self rdgs.CAreaLandCombatManager
---@param includeVideoOnlyUnits boolean
function CAreaLandCombatManager.SpawnAtAllUnitMarkers(self, includeVideoOnlyUnits ) end
---@param self rdgs.CAreaLandCombatManager
---@param label string
---@param includeVideoOnlyUnits boolean
function CAreaLandCombatManager.SpawnUnitAtMarker(self, label , includeVideoOnlyUnits ) end
---@param self rdgs.CAreaLandCombatManager
function CAreaLandCombatManager.DestroyLabeledUnits(self) end

return CAreaLandCombatManager
