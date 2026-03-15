---@meta rdgs.CSessionUnitManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSessionUnitManager
---@field BalancingTest rdgs.CUnitBalancingTestHelper		
---@field CollisionTest rdgs.CUnitCollisionTestHelper		
local CSessionUnitManager = {}
SessionUnit = CSessionUnitManager
---@param self rdgs.CSessionUnitManager
---@param unitGUID integer
function CSessionUnitManager.SetDebugSpawnUnitGUID(self, unitGUID ) end
---@param self rdgs.CSessionUnitManager
function CSessionUnitManager.SpawnDebugUnit(self) end
---@param self rdgs.CSessionUnitManager
function CSessionUnitManager.SpotlightElementAtMouse(self) end
---@param self rdgs.CSessionUnitManager
function CSessionUnitManager.DebugCalculateFillSpaceFormation(self) end
---@param self rdgs.CSessionUnitManager
---@param value boolean
function CSessionUnitManager.SetCelebrateOnDesert(self, value ) end
---@param self rdgs.CSessionUnitManager
function CSessionUnitManager.SpawnDebugProjectile(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CSessionUnitManager.isValid() end

return CSessionUnitManager
