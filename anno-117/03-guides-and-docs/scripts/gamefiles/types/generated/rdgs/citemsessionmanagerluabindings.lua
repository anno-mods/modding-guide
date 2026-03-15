---@meta rdgs.CItemSessionManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CItemSessionManager
---@field DraggedItemGUID integer		
local CItemSessionManager = {}
Item = CItemSessionManager
---@param self rdgs.CItemSessionManager
---@param guid integer
function CItemSessionManager.CheatItem(self, guid ) end
---@param self rdgs.CItemSessionManager
function CItemSessionManager.CheatAllItems(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CItemSessionManager.isValid() end

return CItemSessionManager
