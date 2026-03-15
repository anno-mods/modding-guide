---@meta rdgs.CAIGlobalCheatHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAIGlobalCheatHandler
local CAIGlobalCheatHandler = {}
---@param self rdgs.CAIGlobalCheatHandler
---@param buildMode rdgs.CAI_DebugBuildMode
function CAIGlobalCheatHandler.SetDebugBuildMode(self, buildMode ) end
---@param self rdgs.CAIGlobalCheatHandler
---@param option rdgs.CAI_DebugOption
function CAIGlobalCheatHandler.ToggleDebugOption(self, option ) end
---@param self rdgs.CAIGlobalCheatHandler
function CAIGlobalCheatHandler.ToggleBenchmarkMode(self) end
---@param self rdgs.CAIGlobalCheatHandler
function CAIGlobalCheatHandler.EnableExtendedAsserts(self) end
---@param self rdgs.CAIGlobalCheatHandler
---@param markerIndex integer
function CAIGlobalCheatHandler.ToggleStatisticsMarker(self, markerIndex ) end
---@param self rdgs.CAIGlobalCheatHandler
---@param graphIndex integer
function CAIGlobalCheatHandler.ToggleStatisticsGraph(self, graphIndex ) end
---@param self rdgs.CAIGlobalCheatHandler
---@param flagIndex integer
function CAIGlobalCheatHandler.ToggleStatisticsFlag(self, flagIndex ) end
---@param self rdgs.CAIGlobalCheatHandler
function CAIGlobalCheatHandler.ToggleStatisticsLocal(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CAIGlobalCheatHandler.isValid() end

return CAIGlobalCheatHandler
