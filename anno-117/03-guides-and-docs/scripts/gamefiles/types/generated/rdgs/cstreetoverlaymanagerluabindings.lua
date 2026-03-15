---@meta rdgs.CStreetOverlayManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CStreetOverlayManager
local CStreetOverlayManager = {}
StreetOverlay = CStreetOverlayManager
---@param self rdgs.CStreetOverlayManager
function CStreetOverlayManager.ToggleInfoLayerVisibility(self) end
---@param self rdgs.CStreetOverlayManager
---@param overlayIndex integer
function CStreetOverlayManager.ToggleEnableStatus(self, overlayIndex ) end
---@return boolean returns true if weak pointer holds a valid reference
function CStreetOverlayManager.isValid() end

return CStreetOverlayManager
