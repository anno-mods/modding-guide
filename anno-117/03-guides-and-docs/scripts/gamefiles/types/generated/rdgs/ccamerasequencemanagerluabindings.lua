---@meta rdgs.CCameraSequenceManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CCameraSequenceManager
local CCameraSequenceManager = {}
CameraSequenceManager = CCameraSequenceManager
---Will setup and trigger a T9-configured camera sequence.\nThis is also used in the retail version, but can\'t be renamed, as it is probably used by a lot of people
---@param self rdgs.CCameraSequenceManager
---@param cameraSequenceConfigGUID integer
function CCameraSequenceManager.CheatStartCameraSequence(self, cameraSequenceConfigGUID ) end
---start a camera sequence immediately
---@param self rdgs.CCameraSequenceManager
---@param islandID rdgs.IslandID
---@param ID rdgs.CameraSequenceID
---@param paused boolean
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CCameraSequenceManager.RunCameraSequence(self, islandID , ID , paused ) end
---returns true, if no sequence is paused or playing
---@param self rdgs.CCameraSequenceManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CCameraSequenceManager.RunCameraSequence(self) end
---a sequence with autoresume activated can be waited for until it starts
---@param self rdgs.CCameraSequenceManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CCameraSequenceManager.WaitForAutoResume(self) end
---@param self rdgs.CCameraSequenceManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CCameraSequenceManager.WaitForAutoResume(self) end
---Ends camera Sequence
---@param self rdgs.CCameraSequenceManager
function CCameraSequenceManager.StopCurrentSequence(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CCameraSequenceManager.isValid() end

return CCameraSequenceManager
