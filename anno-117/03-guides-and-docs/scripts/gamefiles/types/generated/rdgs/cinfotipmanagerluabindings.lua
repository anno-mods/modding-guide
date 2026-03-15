---@meta rdgs.CInfoTipManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CInfoTipManager
---@field RefGuid integer		Returns the last valid Reference Guid of a widget. The reference guid still exists after the mouse leaves this widget.
---@field RefOid rdgs.GameObjectID		Returns the last valid Reference Object ID of a widget. The reference guid still exists after the mouse leaves this widget.
---@field IsRefOidSet boolean		
---@field RefOidAsBool boolean		Hack: RefOid can be used as a bool in special cases
---@field RefTextId rdsdk.TextId		
---@field IsContextEmpty boolean		
local CInfoTipManager = {}
InfoTip = CInfoTipManager
---@param self rdgs.CInfoTipManager
---@param sceneName string
---@return boolean
function CInfoTipManager.CheckInfoTipSource(self, sceneName ) end
---@param self rdgs.CInfoTipManager
---@param name string
---@return rdgs.CInfoTipContextValue
function CInfoTipManager.GetContextValue(self, name ) end
---@param self rdgs.CInfoTipManager
---@param name string
---@return boolean
function CInfoTipManager.IsContextValueSet(self, name ) end
---@param self rdgs.CInfoTipManager
function CInfoTipManager.ToggleLockCurrentInfoTip(self) end
---@param self rdgs.CInfoTipManager
function CInfoTipManager.ToggleShowInfoTipOwner(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CInfoTipManager.isValid() end

return CInfoTipManager
