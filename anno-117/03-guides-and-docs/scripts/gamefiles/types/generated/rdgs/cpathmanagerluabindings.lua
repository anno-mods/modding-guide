---@meta rdgs.CPathManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPathManager
local CPathManager = {}
Path = CPathManager
---@param self rdgs.CPathManager
---@param command integer
function CPathManager.SetDebugCommand(self, command ) end
---@param self rdgs.CPathManager
---@param option integer
function CPathManager.ToggleDebugOption(self, option ) end
---@param self rdgs.CPathManager
---@param layer integer
function CPathManager.SetDebugLayer(self, layer ) end
---@param self rdgs.CPathManager
---@param percent integer
function CPathManager.SetDebugMilitaryCollisionCirclePercentage(self, percent ) end
---@param self rdgs.CPathManager
---@param paramIndex integer
---@param paramValue number
function CPathManager.SetQuickBalanceParam(self, paramIndex , paramValue ) end
---@param self rdgs.CPathManager
---@param loop integer
function CPathManager.WaterPerfTest(self, loop ) end
---@param self rdgs.CPathManager
---@param loop integer
function CPathManager.DirtyRectPerfTest(self, loop ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPathManager.isValid() end

return CPathManager
