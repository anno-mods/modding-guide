---@meta rdgs.CGameRuntimeSettings
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGameRuntimeSettings
local CGameRuntimeSettings = {}
RuntimeSettings = CGameRuntimeSettings
---Runtime Feature Toggles to manipulate the game to fit different version requirements
---@param self rdgs.CGameRuntimeSettings
---@param button datasets.TitleButton
function CGameRuntimeSettings.HideTitleButton(self, button ) end
---@param self rdgs.CGameRuntimeSettings
---@param button datasets.PauseMenuButton
function CGameRuntimeSettings.HidePauseMenuButton(self, button ) end
---@param self rdgs.CGameRuntimeSettings
---@param stateName string
function CGameRuntimeSettings.BlockUIState(self, stateName ) end
---@param self rdgs.CGameRuntimeSettings
---@param value boolean
function CGameRuntimeSettings.SetTriggerOutroOnUnload(self, value ) end
---@param self rdgs.CGameRuntimeSettings
---@param value boolean
function CGameRuntimeSettings.SetSpawnMaxFeedbackUnits(self, value ) end
---@param self rdgs.CGameRuntimeSettings
---@param value boolean
function CGameRuntimeSettings.HideMovieCaptureDistractions(self, value ) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameRuntimeSettings.isValid() end

return CGameRuntimeSettings
