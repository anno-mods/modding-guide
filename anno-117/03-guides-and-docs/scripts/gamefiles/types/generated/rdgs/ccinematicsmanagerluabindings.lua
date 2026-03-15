---@meta rdgs.CCinematicsManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CCinematicsManager
local CCinematicsManager = {}
Cinematics = CCinematicsManager
---@param self rdgs.CCinematicsManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CCinematicsManager.PlayClip(self) end
---@param self rdgs.CCinematicsManager
---@param index integer
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CCinematicsManager.PlayClip(self, index ) end
---@param self rdgs.CCinematicsManager
function CCinematicsManager.Pause(self) end
---@param self rdgs.CCinematicsManager
function CCinematicsManager.Stop(self) end
---@param self rdgs.CCinematicsManager
---@param filepath std.filesystem.path
---@return boolean
function CCinematicsManager.Load(self, filepath ) end
---@param self rdgs.CCinematicsManager
---@param filepath std.filesystem.path
---@return boolean
function CCinematicsManager.Save(self, filepath ) end
---@return boolean returns true if weak pointer holds a valid reference
function CCinematicsManager.isValid() end

return CCinematicsManager
