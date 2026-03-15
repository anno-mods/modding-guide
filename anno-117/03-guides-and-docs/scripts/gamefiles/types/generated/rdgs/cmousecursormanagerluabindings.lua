---@meta rdgs.CMouseCursorManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMouseCursorManager
local CMouseCursorManager = {}
MouseManager = CMouseCursorManager
---Returns a special localized string that can be used to display mouse actions in infotips. Identifier should be the T9 configured key for an action
---@param self rdgs.CMouseCursorManager
---@param identifier string
---@return string
function CMouseCursorManager.GetMouseActionTooltip(self, identifier ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMouseCursorManager.isValid() end

return CMouseCursorManager
