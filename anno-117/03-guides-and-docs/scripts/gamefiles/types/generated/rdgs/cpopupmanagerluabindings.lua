---@meta rdgs.CPopupManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPopupManager
---@field RefGUID integer		gets the context GUID for the current popup
local CPopupManager = {}
Popup = CPopupManager
---@param self rdgs.CPopupManager
---@param buttonID integer
function CPopupManager.ClosePopup(self, buttonID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPopupManager.isValid() end

return CPopupManager
