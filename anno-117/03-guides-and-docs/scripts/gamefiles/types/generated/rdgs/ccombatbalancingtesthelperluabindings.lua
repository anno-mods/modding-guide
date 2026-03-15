---@meta rdgs.CCombatBalancingTestHelper
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CCombatBalancingTestHelper
---@field IsTestStillRunning boolean		
local CCombatBalancingTestHelper = {}
---@param self rdgs.CCombatBalancingTestHelper
function CCombatBalancingTestHelper.EndTest(self) end
---@param self rdgs.CCombatBalancingTestHelper
function CCombatBalancingTestHelper.FinishTestRound(self) end
---@param self rdgs.CCombatBalancingTestHelper
---@param posX number
---@param posZ number
---@param owner integer
---@param unitGuid integer
---@return rdgs.CombatUnitID
function CCombatBalancingTestHelper.SpawnUnit(self, posX , posZ , owner , unitGuid ) end
---@param self rdgs.CCombatBalancingTestHelper
---@param unitIndex integer
---@param posX number
---@param posZ number
function CCombatBalancingTestHelper.MoveUnit(self, unitIndex , posX , posZ ) end
---@param self rdgs.CCombatBalancingTestHelper
function CCombatBalancingTestHelper.ClearUnits(self) end

return CCombatBalancingTestHelper
