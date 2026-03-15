---@meta rdgs.INotification
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.INotification
local INotification = {}
---@param self rdgs.INotification
---@param key string
---@return rdgs.CTextSourceObjectWrapper
function INotification.GetValue(self, key ) end
---@return boolean returns true if weak pointer holds a valid reference
function INotification.isValid() end

return INotification
