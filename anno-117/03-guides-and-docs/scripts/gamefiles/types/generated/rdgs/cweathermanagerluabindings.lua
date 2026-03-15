---@meta rdgs.CWeatherManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CWeatherManager
local CWeatherManager = {}
Weather = CWeatherManager
---@param self rdgs.CWeatherManager
---@param presetType integer
---@param forceEffectType integer
function CWeatherManager.ForcePreset(self, presetType , forceEffectType ) end
---@param self rdgs.CWeatherManager
function CWeatherManager.ChangeWind(self) end
---Toggles debug rendering of wind-speedups for ships
---@param self rdgs.CWeatherManager
function CWeatherManager.ToggleWindRender(self) end
---Toggle Africa Heat Effect with a cheat
---@param self rdgs.CWeatherManager
function CWeatherManager.ToggleMirageEffect(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CWeatherManager.isValid() end

return CWeatherManager
