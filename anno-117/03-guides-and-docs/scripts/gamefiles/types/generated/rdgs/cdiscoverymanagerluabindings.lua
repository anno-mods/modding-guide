---@meta rdgs.CDiscoveryManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDiscoveryManager
local CDiscoveryManager = {}
Discovery = CDiscoveryManager
HideUndiscoverVisuals = CDiscoveryManager
---@param self rdgs.CDiscoveryManager
---@param command integer
function CDiscoveryManager.SetDebugCommand(self, command ) end
---@param self rdgs.CDiscoveryManager
---@param option integer
function CDiscoveryManager.ToggleDebugOption(self, option ) end
---Discovers the whole map for the current player
---@param self rdgs.CDiscoveryManager
function CDiscoveryManager.ShowAll(self) end
---Hides the whole map for the current player
---@param self rdgs.CDiscoveryManager
function CDiscoveryManager.HideAll(self) end
---Discovers a specific player
---@param self rdgs.CDiscoveryManager
---@param participantGuid integer
function CDiscoveryManager.ShowParticipant(self, participantGuid ) end
---@param hide boolean
function CDiscoveryManager.HideUndiscoverVisuals(hide ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDiscoveryManager.isValid() end

return CDiscoveryManager
