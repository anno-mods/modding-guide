---@meta rdgs.CConditionVariableManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionVariableManager
local CConditionVariableManager = {}
Variables = CConditionVariableManager
---@param self rdgs.CConditionVariableManager
---@param L rdgs.lua_State
---@return integer
function CConditionVariableManager.GetVariable(self, L ) end
---@param self rdgs.CConditionVariableManager
---@param L rdgs.lua_State
---@return integer
function CConditionVariableManager.GetVariableForParticipant(self, L ) end
---@param self rdgs.CConditionVariableManager
---@param L rdgs.lua_State
---@return integer
function CConditionVariableManager.GetVariableOfComponent(self, L ) end
---@param self rdgs.CConditionVariableManager
---@param varName string
---@param accessorComponent quest.ComponentID
---@return boolean
function CConditionVariableManager.DoesVariableExist(self, varName , accessorComponent ) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionVariableManager.isValid() end

return CConditionVariableManager
