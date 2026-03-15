---@meta rdgs.CPropertyUnit
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyUnit
---@field IsMilitaryUnit boolean		
local CPropertyUnit = {}
---@param self rdgs.CPropertyUnit
function CPropertyUnit.BufferRestartMovement(self) end
---@param self rdgs.CPropertyUnit
---@param sequenceEvent datasets.SequenceEvent
function CPropertyUnit.SetCheatForceSequenceEvent(self, sequenceEvent ) end
---@param self rdgs.CPropertyUnit
function CPropertyUnit.ResetCheatForceSequenceEvent(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyUnit.isValid() end

return CPropertyUnit
