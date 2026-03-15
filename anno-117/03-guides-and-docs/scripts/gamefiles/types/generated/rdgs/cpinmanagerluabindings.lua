---@meta rdgs.CPinManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPinManager
local CPinManager = {}
Pins = CPinManager
---Stores depending on the state of the game either the current selection or the current buildmode in the given pin
---@param self rdgs.CPinManager
---@param pinIndex integer
function CPinManager.StoreGamecontextToConstructionMenuPin(self, pinIndex ) end
---Use / toggle construction menu pin on given pinIndex
---@param self rdgs.CPinManager
---@param pinIndex integer
function CPinManager.UseConstructionMenuPin(self, pinIndex ) end
---Adds any object in the given pin to the selection
---@param self rdgs.CPinManager
---@param pinIndex integer
function CPinManager.AddToSelection(self, pinIndex ) end
---Returns index of the construction menu pin that contains the given object. Returns -1 if the object is not in any pin
---@param self rdgs.CPinManager
---@param id rdgs.GameObjectID
---@return integer
function CPinManager.GetConstructionMenuPinIndexForObject(self, id ) end
---Returns the stored selection of the given pin. Returns an empty list if a building is stored in this pin
---@param self rdgs.CPinManager
---@param pinIndex integer
---@return rdgs.CGameObject[]
function CPinManager.GetSelectionInConstructionMenuPin(self, pinIndex ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPinManager.isValid() end

return CPinManager
