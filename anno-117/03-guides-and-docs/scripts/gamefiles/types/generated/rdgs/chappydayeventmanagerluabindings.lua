---@meta rdgs.CHappyDayEventManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CHappyDayEventManager
---@field TimeNotification number		
local CHappyDayEventManager = {}
HappyDayEventManager = CHappyDayEventManager
---Cheat Function for testing special Day messages...
---@param self rdgs.CHappyDayEventManager
---@param day integer
---@param month integer
---@param year integer
function CHappyDayEventManager.TriggerHappyDay(self, day , month , year ) end
---@param self rdgs.CHappyDayEventManager
---@param timeString string
function CHappyDayEventManager.UnixTriggerHappyDay(self, timeString ) end
---@return boolean returns true if weak pointer holds a valid reference
function CHappyDayEventManager.isValid() end

return CHappyDayEventManager
