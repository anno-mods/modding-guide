---@meta rdgs.CDaytimeManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDaytimeManager
---@field Daytime number		
---@field DaytimeString string		
---@field CurrentDaytimeAdvanceSetting integer		
local CDaytimeManager = {}
Daytime = CDaytimeManager
---@param self rdgs.CDaytimeManager
---@param newSetting integer
function CDaytimeManager.DaytimePreset(self, newSetting ) end
---@param self rdgs.CDaytimeManager
function CDaytimeManager.ToggleDaytimeAdvancing(self) end
---@param self rdgs.CDaytimeManager
function CDaytimeManager.StopDaytimeAdvancing(self) end
---@param self rdgs.CDaytimeManager
function CDaytimeManager.StartDaytimeAdvancing(self) end
---@param self rdgs.CDaytimeManager
---@param newSetting integer
function CDaytimeManager.DaytimeSetting(self, newSetting ) end
---@param self rdgs.CDaytimeManager
---@param newDaytime number
function CDaytimeManager.DaytimeSmooth(self, newDaytime ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDaytimeManager.isValid() end

return CDaytimeManager
