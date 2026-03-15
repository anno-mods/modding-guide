---@meta rdgs.CEnvironmentManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CEnvironmentManager
---@field OverwriteLightDirection boolean		
---@field SunDirection rdmath.Vector3		
---@field MoonDirection rdmath.Vector3		
local CEnvironmentManager = {}
Environment = CEnvironmentManager
---@param self rdgs.CEnvironmentManager
---@param ambientName string
---@return boolean
function CEnvironmentManager.SetGlobalAmbient(self, ambientName ) end
---@param self rdgs.CEnvironmentManager
function CEnvironmentManager.SetGlobalAmbientToDefault(self) end
---@param self rdgs.CEnvironmentManager
---@param northAmbientName string
function CEnvironmentManager.SetNorthAmbient(self, northAmbientName ) end
---@param self rdgs.CEnvironmentManager
---@param southAmbientName string
function CEnvironmentManager.SetSouthAmbient(self, southAmbientName ) end
---@param self rdgs.CEnvironmentManager
function CEnvironmentManager.ReloadAmbientSettings(self) end
---@param self rdgs.CEnvironmentManager
---@param enable boolean
function CEnvironmentManager.SetEnableGrassGeneration(self, enable ) end
---@param self rdgs.CEnvironmentManager
---@param pFileName string
function CEnvironmentManager.SetWeatherMap(self, pFileName ) end
---@param self rdgs.CEnvironmentManager
---@param enable boolean
function CEnvironmentManager.SetEnablePathtracing(self, enable ) end
---@param self rdgs.CEnvironmentManager
---@param azimuth number
---@param elevation number
function CEnvironmentManager.SetSunDirection(self, azimuth , elevation ) end
---@param self rdgs.CEnvironmentManager
---@param azimuth number
---@param elevation number
function CEnvironmentManager.SetMoonDirection(self, azimuth , elevation ) end
---@return boolean returns true if weak pointer holds a valid reference
function CEnvironmentManager.isValid() end

return CEnvironmentManager
