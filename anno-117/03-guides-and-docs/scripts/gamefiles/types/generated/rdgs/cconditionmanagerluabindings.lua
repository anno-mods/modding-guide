---@meta rdgs.CConditionManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionManager
local CConditionManager = {}
Conditions = CConditionManager
---Shows a tree to visualize the given condition in the debug info page
---@param self rdgs.CConditionManager
---@param conditionAssetGUID integer
function CConditionManager.ShowDebugConditionTree(self, conditionAssetGUID ) end
---Shows a tree to visualize the given condition in the debug info page
---@param self rdgs.CConditionManager
---@param conditionAssetGUID integer
function CConditionManager.HideDebugConditionTree(self, conditionAssetGUID ) end
---Returns a pointer to the main condition registered for a key
---@param self rdgs.CConditionManager
---@param key string
---@return rdgs.CCondition|nil
function CConditionManager.GetCondition(self, key ) end
---Returns the current amount of the PlayerCounter of the Condition with the given Guid\n\\Subconditions can be accessed via the index argument
---@param self rdgs.CConditionManager
---@param guid integer
---@param index integer
---@return rdgs.StatsValue
function CConditionManager.GetCurrentConditionAmount(self, guid , index ) end
---Returns the desired amount of the PlayerCounter of the Condition with the given Guid\n\\Subconditions can be accessed via the index argument
---@param self rdgs.CConditionManager
---@param guid integer
---@param index integer
---@return rdgs.StatsValue
function CConditionManager.GetDesiredConditionAmount(self, guid , index ) end
---Returns the context of the PlayerCounter of the Condition with the given Guid\n\\Subconditions can be accessed via the index argument
---@param self rdgs.CConditionManager
---@param guid integer
---@param index integer
---@return rdgs.CAsset
function CConditionManager.GetConditionContext(self, guid , index ) end
---@param self rdgs.CConditionManager
---@param key string
---@return rdgs.AreaID
function CConditionManager.GetConditionQuestAreaID(self, key ) end
---for debugging a condition reference by key will be recursively satisfied
---@param self rdgs.CConditionManager
---@param key string
function CConditionManager.SatisfyTrigger(self, key ) end
---Registers a trigger defined in ToolOne including all subtriggers based on GUID and PropertyType. Extend here for more PropertyTypes!
---@param self rdgs.CConditionManager
---@param assetGUID integer
function CConditionManager.RegisterTriggerForCurrentParticipantNet(self, assetGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionManager.isValid() end

return CConditionManager
