---@meta rdgs.CPropertyCollectable
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyCollectable
---@field CanBeCollected boolean		Tells if the object can be collected currently
---@field IsTargetStorageFull boolean		True if for any given product nothing can be transferred because the target storage (= selected object or area) has no more capacity left
---@field IsTargetStoragePartiallyFull boolean		True if for any given product only part of it can be transferred to the target storage (= selected object or area)
---@field GoodsAddedToStorage rdgs.CTextSourceListValue[]		Returns a list of all goods that would be added to the storage
---@field GoodsNotAddedToStorage rdgs.CTextSourceListValue[]		Returns a list of all goods that cannot be added to the storage
---@field Goods rdgs.CTextSourceListValue[]		Returns a list of all goods
---@field CanBeDropped boolean		Tells if the object can be dropped currently
local CPropertyCollectable = {}
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyCollectable.isValid() end

return CPropertyCollectable
