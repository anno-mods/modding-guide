---@meta rdgs.CAreaObjectManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaObjectManager
---@field ObjectLists rdgs.CFilteredObjectLists		
local CAreaObjectManager = {}
SetEnableObjectGroup = CAreaObjectManager
---@param self rdgs.CAreaObjectManager
function CAreaObjectManager.SaveBuildingCountSnapshot(self) end
---@param self rdgs.CAreaObjectManager
function CAreaObjectManager.DebugSkipDelayedDeletionTimes(self) end
---@param areaID integer
---@param objectGroupName string
---@param setEnableObjectGroup boolean
function CAreaObjectManager.SetEnableObjectGroup(areaID , objectGroupName , setEnableObjectGroup ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaObjectManager.isValid() end

return CAreaObjectManager
