---@meta rdgs.CAreaReligionManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaReligionManager
---@field ActivePatronGuid integer		
---@field Devotion integer		
local CAreaReligionManager = {}
AreaReligion = CAreaReligionManager
---@param self rdgs.CAreaReligionManager
---@param patronGuid integer
function CAreaReligionManager.SetPatronNet(self, patronGuid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaReligionManager.isValid() end

return CAreaReligionManager
