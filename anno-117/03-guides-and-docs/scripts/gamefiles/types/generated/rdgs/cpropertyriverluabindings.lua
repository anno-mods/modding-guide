---@meta rdgs.CPropertyRiver
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyRiver
---@field ColorShallow rdmath.Vector3		Get / Set the water color
---@field ScatterColor rdmath.Vector3		Get / Set scatter color 
local CPropertyRiver = {}
---Starts to move the RiverLevel to the a new Offset
---@param self rdgs.CPropertyRiver
---@param newOffset number
---@param duration integer
function CPropertyRiver.MoveRiverLevel(self, newOffset , duration ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyRiver.isValid() end

return CPropertyRiver
