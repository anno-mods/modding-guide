---@meta rdgs.CSessionTransferManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSessionTransferManager
local CSessionTransferManager = {}
SessionTransfer = CSessionTransferManager
---Returns true if an object with the given id is waiting for it\'s transfer
---@param self rdgs.CSessionTransferManager
---@param objectID rdgs.MetaGameObjectID
---@return boolean
function CSessionTransferManager.IsTransfering(self, objectID ) end
---Returns the time left until the transfer is fulfilled
---@param self rdgs.CSessionTransferManager
---@param objectID rdgs.MetaGameObjectID
---@return rdtime
function CSessionTransferManager.GetTransferTimeLeft(self, objectID ) end
---Returns the guid of the target session of the given object
---@param self rdgs.CSessionTransferManager
---@param objectID rdgs.MetaGameObjectID
---@return integer
function CSessionTransferManager.GetTargetSession(self, objectID ) end

return CSessionTransferManager
