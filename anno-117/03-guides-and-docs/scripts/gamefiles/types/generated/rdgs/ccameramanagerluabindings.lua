---@meta rdgs.CCameraManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CCameraManager
local CCameraManager = {}
SessionCamera = CCameraManager
---Saves current camera state to a slot from 0 - 9
---@param self rdgs.CCameraManager
---@param slot integer
function CCameraManager.SaveCameraView(self, slot ) end
---Restores a previously stored camera state from a slot from 0 - 9
---@param self rdgs.CCameraManager
---@param slot integer
function CCameraManager.LoadCameraView(self, slot ) end
---helper methods for Textsource to look at a certain worldPosition
---@param self rdgs.CCameraManager
---@param x number
---@param y number
---@param z number
function CCameraManager.ToWorldPos(self, x , y , z ) end
---helper methods for Textsource to look at a certain worldPosition \nthe y coordinate will be the terrain height.
---@param self rdgs.CCameraManager
---@param x number
---@param z number
function CCameraManager.ToWorldPos(self, x , z ) end
---this is not the best as it uses call in thread to ensure it\'s called
---@param self rdgs.CCameraManager
---@param objectID integer
function CCameraManager.CheatToGameObject(self, objectID ) end
---@param self rdgs.CCameraManager
---@param gameObject rdgs.CGameObject
function CCameraManager.TryStartFollowObject(self, gameObject ) end
---@param self rdgs.CCameraManager
function CCameraManager.RotateAxisAligned(self) end
---@param self rdgs.CCameraManager
---@param zoomPreset integer
function CCameraManager.SetGameCameraToZoom(self, zoomPreset ) end
---@param self rdgs.CCameraManager
---@param view rd3d.ViewDesc
function CCameraManager.SetView(self, view ) end
---rotates the camera to default (north) rotation
---@param self rdgs.CCameraManager
function CCameraManager.SetDefaultRotation(self) end
---@param self rdgs.CCameraManager
---@param nearClip number
function CCameraManager.SetGameCameraNearClip(self, nearClip ) end
---use to switch current camera control
---@param self rdgs.CCameraManager
---@param newControlType rdgs.CameraControlType
function CCameraManager.SwitchControl(self, newControlType ) end
---Get set debug look at x pos (used by debug info page)
---@param self rdgs.CCameraManager
---@param val number
function CCameraManager.SetDebugLookAtPosX(self, val ) end
---Get set debug look at z pos (used by debug info page)
---@param self rdgs.CCameraManager
---@param val number
function CCameraManager.SetDebugLookAtPosZ(self, val ) end
---@param self rdgs.CCameraManager
---@param cameraShakeConfigGuid integer
---@param shakeOrigin rdmath.Vector3|table|number[]|nil
function CCameraManager.StartCameraShakeFromConfig(self, cameraShakeConfigGuid , shakeOrigin ) end
---@param self rdgs.CCameraManager
---@param cameraShakeConfigGuid integer
function CCameraManager.StartCameraShakeFromConfig(self, cameraShakeConfigGuid ) end
---@param self rdgs.CCameraManager
---@param minIntensity number
---@param maxIntensity number
---@param easingType datasets.EasingType
---@param duration rdtime
---@param directionUpFactor number
---@param shakeOrigin rdmath.Vector3|table|number[]|nil
---@param maxOriginDistance number|nil
---@param originEasingType datasets.EasingType|nil
function CCameraManager.StartCameraShake(self, minIntensity , maxIntensity , easingType , duration , directionUpFactor , shakeOrigin , maxOriginDistance , originEasingType ) end
---@param self rdgs.CCameraManager
---@param minIntensity number
---@param maxIntensity number
---@param easingType datasets.EasingType
---@param duration rdtime
---@param directionUpFactor number
---@param shakeOrigin rdmath.Vector3|table|number[]|nil
---@param maxOriginDistance number|nil
function CCameraManager.StartCameraShake(self, minIntensity , maxIntensity , easingType , duration , directionUpFactor , shakeOrigin , maxOriginDistance ) end
---@param self rdgs.CCameraManager
---@param minIntensity number
---@param maxIntensity number
---@param easingType datasets.EasingType
---@param duration rdtime
---@param directionUpFactor number
---@param shakeOrigin rdmath.Vector3|table|number[]|nil
function CCameraManager.StartCameraShake(self, minIntensity , maxIntensity , easingType , duration , directionUpFactor , shakeOrigin ) end
---@param self rdgs.CCameraManager
---@param minIntensity number
---@param maxIntensity number
---@param easingType datasets.EasingType
---@param duration rdtime
---@param directionUpFactor number
function CCameraManager.StartCameraShake(self, minIntensity , maxIntensity , easingType , duration , directionUpFactor ) end
---@param self rdgs.CCameraManager
function CCameraManager.StopCameraShakes(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CCameraManager.isValid() end

return CCameraManager
