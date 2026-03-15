---@meta rdgs.CGamepadActionManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGamepadActionManager
local CGamepadActionManager = {}
GamepadActionManager = CGamepadActionManager
---Returns a html code that is displayable in infotips to show the buttons for the given gamepad action
---@param self rdgs.CGamepadActionManager
---@param gamepadActionIdentifer string
---@return string
function CGamepadActionManager.GetGamepadActionTooltip(self, gamepadActionIdentifer ) end
---Returns a HTML code that is displayable in infotips to show the buttons for the given specific gamepad button
---@param self rdgs.CGamepadActionManager
---@param gamepadButtonType string
---@return string
function CGamepadActionManager.GetGamepadButtonTooltip(self, gamepadButtonType ) end
---@return boolean returns true if weak pointer holds a valid reference
function CGamepadActionManager.isValid() end

return CGamepadActionManager
