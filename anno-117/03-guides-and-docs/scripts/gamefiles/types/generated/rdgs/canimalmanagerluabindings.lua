---@meta rdgs.CAnimalManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAnimalManager
local CAnimalManager = {}
Animals = CAnimalManager
---Cycles through debug modes
---@param self rdgs.CAnimalManager
---@param debugCommand integer
function CAnimalManager.SetDebugCommand(self, debugCommand ) end
---@param self rdgs.CAnimalManager
---@param option integer
function CAnimalManager.ToggleDebugOption(self, option ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAnimalManager.isValid() end

return CAnimalManager
