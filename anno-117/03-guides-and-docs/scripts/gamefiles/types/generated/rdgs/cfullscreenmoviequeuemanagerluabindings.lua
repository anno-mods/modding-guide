---@meta rdgs.CFullscreenMovieQueueManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CFullscreenMovieQueueManager
local CFullscreenMovieQueueManager = {}
FullscreenMovieQueueManager = CFullscreenMovieQueueManager
---returns true, if a movie with given Id is neither enqueued nor currently running.
---@param self rdgs.CFullscreenMovieQueueManager
---@param id rdgs.FullscreenMovieID
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CFullscreenMovieQueueManager.EnqueueCameraSequence(self, id ) end
---Enqueues a new video to the queue
---@param self rdgs.CFullscreenMovieQueueManager
---@param movieGUID integer
---@return rdgs.FullscreenMovieID
function CFullscreenMovieQueueManager.EnqueueMovieGUID(self, movieGUID ) end
---Enqueues a new camera sequence to the queue. CAUTION: Relies on the processing session scope!
---@param self rdgs.CFullscreenMovieQueueManager
---@param cameraSequenceGUID integer
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CFullscreenMovieQueueManager.EnqueueCameraSequence(self, cameraSequenceGUID ) end
---@param self rdgs.CFullscreenMovieQueueManager
---@param sequenceID rdgs.CameraSequenceID
---@param targetIslandID rdgs.IslandID
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CFullscreenMovieQueueManager.EnqueueCameraSequence(self, sequenceID , targetIslandID ) end
---@param self rdgs.CFullscreenMovieQueueManager
---@param sequenceID rdgs.CameraSequenceID
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CFullscreenMovieQueueManager.EnqueueCameraSequence(self, sequenceID ) end
---@param self rdgs.CFullscreenMovieQueueManager
---@param sequenceID rdgs.CameraSequenceID
---@param islandLabel string
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CFullscreenMovieQueueManager.EnqueueCameraSequence(self, sequenceID , islandLabel ) end
---@param self rdgs.CFullscreenMovieQueueManager
---@param cameraSequenceGUID integer
---@param targetIslandID rdgs.IslandID
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CFullscreenMovieQueueManager.EnqueueCameraSequence(self, cameraSequenceGUID , targetIslandID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CFullscreenMovieQueueManager.isValid() end

return CFullscreenMovieQueueManager
