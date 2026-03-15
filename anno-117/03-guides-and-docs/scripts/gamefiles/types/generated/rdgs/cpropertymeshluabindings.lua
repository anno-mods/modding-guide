---@meta rdgs.CPropertyMesh
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyMesh
local CPropertyMesh = {}
ToggleEnable = CPropertyMesh
function CPropertyMesh.ToggleEnable() end
---shows or hides the mesh
---@param self rdgs.CPropertyMesh
---@param isVisible boolean
function CPropertyMesh.SetVisible(self, isVisible ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyMesh.isValid() end

return CPropertyMesh
