---@meta rdgs.CGameObjectManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGameObjectManager
local CGameObjectManager = {}
Objects = CGameObjectManager
---@param self rdgs.CGameObjectManager
---@param param integer
function CGameObjectManager.SetSelectedAreaID(self, param ) end
---Returns the object with the specified id or nullptr if it does not exist
---@param self rdgs.CGameObjectManager
---@param objectID integer
---@return rdgs.CGameObject
function CGameObjectManager.GetObject(self, objectID ) end
---@param self rdgs.CGameObjectManager
---@param objectID integer
---@return rdgs.CGameObject
function CGameObjectManager.GetObjectAnyState(self, objectID ) end
---Returns an object that has the given label assigned
---@param self rdgs.CGameObjectManager
---@param label string
---@return rdgs.CGameObject
function CGameObjectManager.GetObjectByName(self, label ) end
---Debug
---@param self rdgs.CGameObjectManager
---@param objectIDStr string
function CGameObjectManager.SetDebugObject(self, objectIDStr ) end
---@param self rdgs.CGameObjectManager
---@param objectGUID integer
function CGameObjectManager.SetDebugObjectGUID(self, objectGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameObjectManager.isValid() end

return CGameObjectManager
