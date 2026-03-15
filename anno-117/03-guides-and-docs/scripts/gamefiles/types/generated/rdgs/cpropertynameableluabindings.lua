---@meta rdgs.CPropertyNameable
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyNameable
---@field Name string		Returns the VehicleName
local CPropertyNameable = {}
---Set the Name (if empty it will be generated)
---@param self rdgs.CPropertyNameable
---@param name string
function CPropertyNameable.SetName(self, name ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyNameable.isValid() end

return CPropertyNameable
