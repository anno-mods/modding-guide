---@meta rdgs.CPropertyItemContainer
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyItemContainer
---@field StackLimit integer		
---@field Cargo rdgs.CTextSourceListValue[]		
---@field Sockets rdgs.CAsset[]		
---@field DraggedItemAlreadyEquipped boolean		
---@field DraggedItemAlreadyExclusive boolean		
---@field InteractingAreaID rdgs.AreaID		
---@field CanEquipItems boolean		Returns true if the given guid is an ItemContainer that has at least one item socket
local CPropertyItemContainer = {}
---@param self rdgs.CPropertyItemContainer
---@param slotIndex integer
---@return integer
function CPropertyItemContainer.GetStackGUID(self, slotIndex ) end
---@param self rdgs.CPropertyItemContainer
---@param slotIndex integer
---@return integer
function CPropertyItemContainer.GetStackSize(self, slotIndex ) end
---@param self rdgs.CPropertyItemContainer
---@param guid integer
---@param amount integer
function CPropertyItemContainer.CheatItemInSlot(self, guid , amount ) end
---@param self rdgs.CPropertyItemContainer
---@param index integer
function CPropertyItemContainer.ClearSlot(self, index ) end
---@param self rdgs.CPropertyItemContainer
---@param slotIndex integer
---@param targetSocketIndex integer
function CPropertyItemContainer.EquipSlot(self, slotIndex , targetSocketIndex ) end
---@param self rdgs.CPropertyItemContainer
---@param socketIndex integer
---@param targetSlotIndex integer
---@param forceUnequip boolean
function CPropertyItemContainer.UnequipSocket(self, socketIndex , targetSlotIndex , forceUnequip ) end
---@param self rdgs.CPropertyItemContainer
---@param socketIndex integer
---@param targetSlotIndex integer
function CPropertyItemContainer.UnequipSocket(self, socketIndex , targetSlotIndex ) end
---@param self rdgs.CPropertyItemContainer
---@param guid integer
---@param socketIndex integer
function CPropertyItemContainer.CheatItemInSocket(self, guid , socketIndex ) end
---@param self rdgs.CPropertyItemContainer
---@param socketIndex integer
function CPropertyItemContainer.ResetSocketState(self, socketIndex ) end
---@param self rdgs.CPropertyItemContainer
function CPropertyItemContainer.AcceptGeneratedItem(self) end
---@param self rdgs.CPropertyItemContainer
function CPropertyItemContainer.DenyGeneratedItem(self) end
---@param self rdgs.CPropertyItemContainer
---@param guid integer
---@param amount integer
---@param targetSlotIndex integer
---@return integer
function CPropertyItemContainer.AddProducts(self, guid , amount , targetSlotIndex ) end
---@param self rdgs.CPropertyItemContainer
---@param guid integer
---@param amount integer
---@return integer
function CPropertyItemContainer.AddProducts(self, guid , amount ) end
---RemoveStacks does not remove equipped meta items!
---@param self rdgs.CPropertyItemContainer
---@param guid integer
---@param amount integer
---@param destroyItems boolean
---@return integer
function CPropertyItemContainer.RemoveStacks(self, guid , amount , destroyItems ) end
---RemoveStacks does not remove equipped meta items!
---@param self rdgs.CPropertyItemContainer
---@param guid integer
---@param amount integer
---@return integer
function CPropertyItemContainer.RemoveStacks(self, guid , amount ) end
---@param self rdgs.CPropertyItemContainer
---@param sourceSlotIndex integer
---@param targetSlotIndex integer
---@param amount integer
---@return integer
function CPropertyItemContainer.MoveProducts(self, sourceSlotIndex , targetSlotIndex , amount ) end
---unequip all sockets and dump all slots
---@param self rdgs.CPropertyItemContainer
function CPropertyItemContainer.ClearContainers(self) end
---@param self rdgs.CPropertyItemContainer
---@param guid integer
---@return boolean
function CPropertyItemContainer.ItemAlreadyEquipped(self, guid ) end
---@param self rdgs.CPropertyItemContainer
---@param guid integer
---@return boolean
function CPropertyItemContainer.ItemAlreadyExclusive(self, guid ) end
---@param self rdgs.CPropertyItemContainer
---@param socketIndex integer
---@return boolean
function CPropertyItemContainer.IsItemSocketEnabled(self, socketIndex ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyItemContainer.isValid() end

return CPropertyItemContainer
