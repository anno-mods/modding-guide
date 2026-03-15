---@meta rdgs.CSoundManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSoundManager
local CSoundManager = {}
Sound = CSoundManager
---Use for camera sequences to play global sound effects.
---@param self rdgs.CSoundManager
---@param soundGUID integer
---@return integer
function CSoundManager.PlayCameraSoundEffect(self, soundGUID ) end
---Use for camera sequences to stop global sound effects started with playCamera.
---@param self rdgs.CSoundManager
---@param soundGUID integer
---@return boolean
function CSoundManager.StopCameraSoundEffect(self, soundGUID ) end
---@param self rdgs.CSoundManager
function CSoundManager.ToggleProfiling(self) end
---@param self rdgs.CSoundManager
function CSoundManager.ToggleAdvancedDebug(self) end
---@param self rdgs.CSoundManager
function CSoundManager.ToggleGlobalPersistentEvents(self) end
---@param self rdgs.CSoundManager
---@param flag integer
function CSoundManager.ToggleDebugFlag(self, flag ) end
---@param self rdgs.CSoundManager
---@param string string
function CSoundManager.SetDebugEmitterFilter(self, string ) end
---@param self rdgs.CSoundManager
function CSoundManager.ResetDebugEmitterFilter(self) end
---@param self rdgs.CSoundManager
---@param guid integer
function CSoundManager.CheatPlaySound(self, guid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CSoundManager.isValid() end

return CSoundManager
