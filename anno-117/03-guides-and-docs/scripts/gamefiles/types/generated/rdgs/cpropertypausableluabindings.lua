---@meta rdgs.CPropertyPausable
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyPausable
---@field IsPaused boolean		
---@field IsPausedByMissingStreet boolean		
---@field IsPausedByAttack boolean		
local CPropertyPausable = {}
---@param self rdgs.CPropertyPausable
function CPropertyPausable.TogglePause(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyPausable.isValid() end

return CPropertyPausable
