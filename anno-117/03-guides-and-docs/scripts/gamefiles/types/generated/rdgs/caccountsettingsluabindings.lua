---@meta rdgs.CAccountSettings
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAccountSettings
---@field DefaultTutorialLevel datasets.TutorialLevel		
local CAccountSettings = {}
AccountSettings = CAccountSettings
---@param self rdgs.CAccountSettings
---@param value integer
function CAccountSettings.SetAutoSaveInterval(self, value ) end
---@param self rdgs.CAccountSettings
---@param value datasets.UiScaling
function CAccountSettings.SetFixedUiScaling(self, value ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAccountSettings.isValid() end

return CAccountSettings
