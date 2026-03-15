---@meta rdgs.CMetaGameObjectManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaGameObjectManager
local CMetaGameObjectManager = {}
MetaObjects = CMetaGameObjectManager
---@param self rdgs.CMetaGameObjectManager
---@param id rdgs.GameObjectID
---@return rdgs.CGameObject
function CMetaGameObjectManager.GetSessionGameObject(self, id ) end
---this method returns an object with the given objectID\nthis should not be used ingame it\'s mainly intended for \ntextsources as the strict typedef is problematic there
---@param self rdgs.CMetaGameObjectManager
---@param objectID integer
---@return rdgs.CMetaGameObject
function CMetaGameObjectManager.GetObject(self, objectID ) end
---@param self rdgs.CMetaGameObjectManager
---@param gameObjectID rdgs.GameObjectID
function CMetaGameObjectManager.CheatLookAtObject(self, gameObjectID ) end
---@param self rdgs.CMetaGameObjectManager
---@param sessionObjectID integer
function CMetaGameObjectManager.LookAtObject(self, sessionObjectID ) end
---@param self rdgs.CMetaGameObjectManager
---@param sessionGUID integer
---@param x number
---@param y number
---@param z number
function CMetaGameObjectManager.CheatLookAtPosition(self, sessionGUID , x , y , z ) end
---@param self rdgs.CMetaGameObjectManager
---@param sessionGUID integer
function CMetaGameObjectManager.CheatLookAtSession(self, sessionGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaGameObjectManager.isValid() end

return CMetaGameObjectManager
