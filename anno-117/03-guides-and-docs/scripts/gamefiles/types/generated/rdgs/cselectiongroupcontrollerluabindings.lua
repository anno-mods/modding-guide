---@meta rdgs.CSelectionGroupController
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSelectionGroupController
local CSelectionGroupController = {}
---Stores the current selection under the given group id
---@param self rdgs.CSelectionGroupController
---@param groupID integer
function CSelectionGroupController.Store(self, groupID ) end
---Restores the selection of a given group id. If the selection was already selected, camera will jump to the group
---@param self rdgs.CSelectionGroupController
---@param groupID integer
function CSelectionGroupController.Restore(self, groupID ) end
---Adds the selection of the given group id with the currently selected group. if the currently selected group isn\'t stored, nothing happens
---@param self rdgs.CSelectionGroupController
---@param groupID integer
function CSelectionGroupController.AddToLast(self, groupID ) end
---Returns true if the given group not exists or is empty
---@param self rdgs.CSelectionGroupController
---@param groupID integer
---@return boolean
function CSelectionGroupController.IsEmpty(self, groupID ) end
---Returns the amount of objects in the given group
---@param self rdgs.CSelectionGroupController
---@param groupID integer
---@return integer
function CSelectionGroupController.GetGroupSize(self, groupID ) end
---Returns all ships of the given group as vector
---@param self rdgs.CSelectionGroupController
---@param groupID integer
---@return rdgs.CGameObject[]
function CSelectionGroupController.GetGroup(self, groupID ) end
---Returns all type of ships of the given group. Values gives the number of ships
---@param self rdgs.CSelectionGroupController
---@param groupID integer
---@return rdgs.CTextSourceListValue[]
function CSelectionGroupController.GetGroupSortedToType(self, groupID ) end
---Returns the ID of the group that contains the given object. Returns -1 if the object is not in any group
---@param self rdgs.CSelectionGroupController
---@param id rdgs.GameObjectID
---@return integer
function CSelectionGroupController.GetGroupID(self, id ) end

return CSelectionGroupController
