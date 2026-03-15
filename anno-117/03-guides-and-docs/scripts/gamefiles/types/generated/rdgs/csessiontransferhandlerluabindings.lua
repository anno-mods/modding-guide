---@meta rdgs.CSessionTransferHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSessionTransferHandler
local CSessionTransferHandler = {}
---Returns true if an object with the given id is waiting for it\'s transfer
---@param self rdgs.CSessionTransferHandler
---@param objectID rdgs.MetaGameObjectID
---@return boolean
function CSessionTransferHandler.IsTransfering(self, objectID ) end
---Returns the time left until the transfer is fulfilled
---@param self rdgs.CSessionTransferHandler
---@param objectID rdgs.MetaGameObjectID
---@return rdtime
function CSessionTransferHandler.GetTransferTimeLeft(self, objectID ) end
---Returns the guid of the target session of the given object
---@param self rdgs.CSessionTransferHandler
---@param objectID rdgs.MetaGameObjectID
---@return integer
function CSessionTransferHandler.GetTargetSession(self, objectID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CSessionTransferHandler.isValid() end

return CSessionTransferHandler
