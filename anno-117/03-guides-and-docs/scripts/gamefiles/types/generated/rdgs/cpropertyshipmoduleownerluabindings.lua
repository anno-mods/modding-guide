---@meta rdgs.CPropertyShipModuleOwner
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyShipModuleOwner
---@field InstalledShipModuleGUIDs integer[]		
local CPropertyShipModuleOwner = {}
---@param self rdgs.CPropertyShipModuleOwner
---@param shipModuleGuid integer
function CPropertyShipModuleOwner.CheatAddShipModule(self, shipModuleGuid ) end
---@param self rdgs.CPropertyShipModuleOwner
---@param shipModuleGuid integer
function CPropertyShipModuleOwner.CheatTryRemoveShipModule(self, shipModuleGuid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyShipModuleOwner.isValid() end

return CPropertyShipModuleOwner
