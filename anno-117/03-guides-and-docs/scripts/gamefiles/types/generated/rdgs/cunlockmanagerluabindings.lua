---@meta rdgs.CUnlockManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CUnlockManager
local CUnlockManager = {}
Unlock = CUnlockManager
---Makes a GUID available for use
---@param self rdgs.CUnlockManager
---@param guid integer
function CUnlockManager.Unlock(self, guid ) end
---@param self rdgs.CUnlockManager
---@param guid integer
function CUnlockManager.UnlockNet(self, guid ) end
---Returns true if this GUID is available for use
---@param self rdgs.CUnlockManager
---@param guid integer
---@return boolean
function CUnlockManager.IsUnlocked(self, guid ) end
---Makes a GUID unavailable for use
---@param self rdgs.CUnlockManager
---@param guid integer
function CUnlockManager.RelockNet(self, guid ) end
---@param self rdgs.CUnlockManager
---@param guid integer
function CUnlockManager.Relock(self, guid ) end
---Returns true if this GUID is visible or unlocked
---@param self rdgs.CUnlockManager
---@param guid integer
---@return boolean
function CUnlockManager.IsVisible(self, guid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CUnlockManager.isValid() end

return CUnlockManager
