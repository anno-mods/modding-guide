---@meta rdgs.CShortcutManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CShortcutManager
---@field CurrentPreset integer		
local CShortcutManager = {}
ShortcutManager = CShortcutManager
---Returns a special localized string that can be used to display shortcuts in infotips
---@param self rdgs.CShortcutManager
---@param identifier string
---@return string
function CShortcutManager.GetShortcutTooltip(self, identifier ) end
---Returns a special localized string that can be used to display shortcuts in infotips
---@param self rdgs.CShortcutManager
---@param mouseButtonType datasets.MouseButtonType
---@return string
function CShortcutManager.GetShortcutTooltipMouse(self, mouseButtonType ) end
---Returns true if the shortcut with the given identifier can be displayed in infotips
---@param self rdgs.CShortcutManager
---@param identifier string
---@return boolean
function CShortcutManager.HasShortcutTooltip(self, identifier ) end
---@return boolean returns true if weak pointer holds a valid reference
function CShortcutManager.isValid() end

return CShortcutManager
