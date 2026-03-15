---@meta rdgs.CBuildModeManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CBuildModeManager
---@field Costs rdgs.CBuildCost		Returns the cost for the current build.
---@field Payback rdgs.CBuildCost		Returns the payback for the current move (destroyed buildings).
---@field MaintenanceCosts rdgs.CBuildCost		Returns the expected maintenance cost for the current build.
---@field BuildMode rdgs.CBuildModeObject		
---@field CurrentBuildMode integer		
---@field IsDefaultMode boolean		
---@field IsMeshGraphMode boolean		
---@field HasMeshGraphBuildProblem boolean		
---@field MeshGraphBuildProblemText rdsdk.TextId		
---@field IsTreeMode boolean		
---@field HasPipetteBuildings boolean		
---@field PipetteBuildingsCount integer		
---@field GridDrawer rdgs.CBuildModeGridDrawer		
---@field PreviewBuffList rdgs.CTextSourceListValue[]		
local CBuildModeManager = {}
BuildMode = CBuildModeManager
---@param self rdgs.CBuildModeManager
---@param enable boolean
function CBuildModeManager.MeshGraphNetworkPreview(self, enable ) end
---@param self rdgs.CBuildModeManager
---@param enable boolean
function CBuildModeManager.MeshGraphNetworkPreviewEndlessLag(self, enable ) end
---Starts a new build mode or replaces the current build mode.
---@param self rdgs.CBuildModeManager
---@param buildingGUID integer
---@param buildAsModule boolean
function CBuildModeManager.SetBuildMode(self, buildingGUID , buildAsModule ) end
---@param self rdgs.CBuildModeManager
---@param buildingGUID integer
---@param buildAsModule boolean
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CBuildModeManager.SetBuildModeScript(self, buildingGUID , buildAsModule ) end
---@param self rdgs.CBuildModeManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CBuildModeManager.SetBuildModeScript(self) end
---@param self rdgs.CBuildModeManager
---@param rotateDirection rdsdk.RotateDirection
function CBuildModeManager.ChangeDirection(self, rotateDirection ) end
---@param self rdgs.CBuildModeManager
---@param direction rdsdk.Direction8
function CBuildModeManager.SetDirection(self, direction ) end
---@param self rdgs.CBuildModeManager
function CBuildModeManager.ToggleBlueprintMode(self) end
---@param self rdgs.CBuildModeManager
---@param eventButton integer
---@param eventType integer
---@param cursorTerrainPos rdmath.Vector3|table|number[]
---@param direction rdsdk.Direction8
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CBuildModeManager.ProcessMouseEvent(self, eventButton , eventType , cursorTerrainPos , direction ) end
---@param self rdgs.CBuildModeManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CBuildModeManager.ProcessMouseEvent(self) end
---@param self rdgs.CBuildModeManager
---@param value boolean
function CBuildModeManager.CheatSetScriptingBuildModeActive(self, value ) end
---@param self rdgs.CBuildModeManager
---@param guid integer
---@param ignoreRadiusEffects boolean
---@param ignoreStreetEffects boolean
---@return rdgs.CTextSourceListValue[]
function CBuildModeManager.GetNeedAttributeBoostsRadius(self, guid , ignoreRadiusEffects , ignoreStreetEffects ) end
---@param self rdgs.CBuildModeManager
function CBuildModeManager.ToggleAllowedRotations(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CBuildModeManager.isValid() end

return CBuildModeManager
