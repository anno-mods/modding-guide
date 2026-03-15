---@meta rdgs.CMetaGameManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaGameManager
local CMetaGameManager = {}
MetaGame = CMetaGameManager
---Loads a game session, or creates it new.
---@param self rdgs.CMetaGameManager
---@param sessionGUID integer
function CMetaGameManager.LoadGameSession(self, sessionGUID ) end
---@param self rdgs.CMetaGameManager
---@param guid integer
---@return number
function CMetaGameManager.GetLoadingProgress(self, guid ) end
---@param self rdgs.CMetaGameManager
---@param peer integer
---@return integer
function CMetaGameManager.GetActiveSessionGUIDOfPeerInt(self, peer ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaGameManager.isValid() end

return CMetaGameManager
