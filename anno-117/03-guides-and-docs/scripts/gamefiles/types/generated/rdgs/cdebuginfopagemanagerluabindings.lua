---@meta rdgs.CDebugInfoPageManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDebugInfoPageManager
local CDebugInfoPageManager = {}
DebugInfo = CDebugInfoPageManager
---@param self rdgs.CDebugInfoPageManager
---@param eventScopeId integer
---@param imWidgetId integer
function CDebugInfoPageManager.OnClickEvent(self, eventScopeId , imWidgetId ) end
---@param self rdgs.CDebugInfoPageManager
---@param eventScopeId integer
---@param imWidgetId integer
---@param value number
function CDebugInfoPageManager.OnValueEventFloat(self, eventScopeId , imWidgetId , value ) end
---@param self rdgs.CDebugInfoPageManager
---@param eventScopeId integer
---@param imWidgetId integer
---@param value number
function CDebugInfoPageManager.OnValueEventInt(self, eventScopeId , imWidgetId , value ) end
---@param self rdgs.CDebugInfoPageManager
---@param eventScopeId integer
---@param imWidgetId integer
---@param value string
function CDebugInfoPageManager.OnValueEventString(self, eventScopeId , imWidgetId , value ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDebugInfoPageManager.isValid() end

return CDebugInfoPageManager
