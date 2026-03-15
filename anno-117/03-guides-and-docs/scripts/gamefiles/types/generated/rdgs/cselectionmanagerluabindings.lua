---@meta rdgs.CSelectionManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSelectionManager
---@field Picked rdgs.CGameObject		
---@field Objects rdgs.CGameObject[]		Returns the list of selected objects
---@field Object rdgs.CGameObject		Returns a selected object from the list of selected objects. If there are multiple objects in the list it is undefined which will be returned.
local CSelectionManager = {}
Selection = CSelectionManager
---@param self rdgs.CSelectionManager
---@param enable boolean
function CSelectionManager.SetEnableDebugDrawPicking(self, enable ) end
---true enabled picking and select objects. Disabling clears the selection as well
---@param self rdgs.CSelectionManager
---@param value boolean
function CSelectionManager.SetEnablePicking(self, value ) end
---Clears the current selection of objects.
---@param self rdgs.CSelectionManager
function CSelectionManager.ClearSelection(self) end
---selects the next ruin
---@param self rdgs.CSelectionManager
function CSelectionManager.SelectNextRuin(self) end
---select any building with the specific GUID
---@param self rdgs.CSelectionManager
function CSelectionManager.SelectIslandKontor(self) end
---Clear selection and add gameobject to selection
---@param self rdgs.CSelectionManager
---@param gameObjectID rdgs.GameObjectID
function CSelectionManager.SelectByID(self, gameObjectID ) end
---add gameobject to current selection
---@param self rdgs.CSelectionManager
---@param gameObjectID rdgs.GameObjectID
function CSelectionManager.AddToSelectionByID(self, gameObjectID ) end
---@param self rdgs.CSelectionManager
---@param all boolean
---@param forceUpgradePath datasets.RomanizationType
function CSelectionManager.UpgradeSelected(self, all , forceUpgradePath ) end
---@param self rdgs.CSelectionManager
function CSelectionManager.DestructSelected(self) end
---@param self rdgs.CSelectionManager
function CSelectionManager.TogglePauseForBuildingsOfSelectedType(self) end
---@param self rdgs.CSelectionManager
function CSelectionManager.ChangeParticipantOfSelected(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CSelectionManager.isValid() end

return CSelectionManager
