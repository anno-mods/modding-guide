---@meta rdgs.CUnitCollisionTestHelper
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CUnitCollisionTestHelper
local CUnitCollisionTestHelper = {}
---@param self rdgs.CUnitCollisionTestHelper
---@param testType integer
---@param angleDeltaID integer
---@param offsetID integer
---@param testAngleID integer
function CUnitCollisionTestHelper.StartTest(self, testType , angleDeltaID , offsetID , testAngleID ) end
---@param self rdgs.CUnitCollisionTestHelper
---@param testType integer
---@param angleDeltaID integer
---@param offsetID integer
function CUnitCollisionTestHelper.StartTest(self, testType , angleDeltaID , offsetID ) end
---@param self rdgs.CUnitCollisionTestHelper
---@param testType integer
---@param angleDeltaID integer
function CUnitCollisionTestHelper.StartTest(self, testType , angleDeltaID ) end
---@param self rdgs.CUnitCollisionTestHelper
function CUnitCollisionTestHelper.ClearUnits(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CUnitCollisionTestHelper.isValid() end

return CUnitCollisionTestHelper
