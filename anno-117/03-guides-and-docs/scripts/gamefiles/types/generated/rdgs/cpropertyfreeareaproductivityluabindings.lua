---@meta rdgs.CPropertyFreeAreaProductivity
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyFreeAreaProductivity
---@field Productivity number		
---@field UsableTileCount integer		
---@field NeededTileCount integer		
local CPropertyFreeAreaProductivity = {}
IsFreeAreaBuilding = CPropertyFreeAreaProductivity
GetFreeAreaType = CPropertyFreeAreaProductivity
---@param guid integer
---@return boolean
function CPropertyFreeAreaProductivity.IsFreeAreaBuilding(guid ) end
---@param guid integer
---@return datasets.FreeAreaType
function CPropertyFreeAreaProductivity.GetFreeAreaType(guid ) end
---@param self rdgs.CPropertyFreeAreaProductivity
function CPropertyFreeAreaProductivity.ToggleGridDebugDraw(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyFreeAreaProductivity.isValid() end

return CPropertyFreeAreaProductivity
