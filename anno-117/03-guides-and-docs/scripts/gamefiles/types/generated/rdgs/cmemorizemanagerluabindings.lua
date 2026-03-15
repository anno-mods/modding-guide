---@meta rdgs.CMemorizeManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMemorizeManager
local CMemorizeManager = {}
Memorize = CMemorizeManager
---queues a new memorize task with given time description. The returned Id can be used to check, if task is finished.
---@param self rdgs.CMemorizeManager
---@param island rdgs.CIsland
---@param memorizeBankFilename string
---@param overTimeDesc rdgs.ApplyMemorizeOverTimeDesc|nil
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CMemorizeManager.ApplyMemorization(self, island , memorizeBankFilename , overTimeDesc ) end
---returns finished state of given taskId.
---@param self rdgs.CMemorizeManager
---@param taskId integer
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CMemorizeManager.ApplyMemorization(self, taskId ) end
---see #queryMemorizedObjects
---@param self rdgs.CMemorizeManager
---@param finishDesc rdgs.ImmediatelyFinishApplyMemorization
function CMemorizeManager.FinishMemorization(self, finishDesc ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMemorizeManager.isValid() end

return CMemorizeManager
