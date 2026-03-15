---@meta rdgs.CTargetManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CTargetManager
---@field IsBlueprint boolean		
---@field DestructionPayback rdgs.CBuildCost		
---@field DestructionCosts rdgs.CBuildCost		
---@field UpgradeCosts rdgs.CBuildCost		
local CTargetManager = {}
Target = CTargetManager
---Starts the \\param targetMode if currently allowed
---@param self rdgs.CTargetManager
---@param targetMode datasets.TargetMode
---@return boolean
function CTargetManager.StartTargetMode(self, targetMode ) end
---@param self rdgs.CTargetManager
---@param targetMode datasets.TargetMode
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CTargetManager.StartTargetModeScript(self, targetMode ) end
---@param self rdgs.CTargetManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CTargetManager.StartTargetModeScript(self) end
---Starts or stops the target mode with the given \\param targetModeGUID if currently allowed
---@param self rdgs.CTargetManager
---@param targetModeGUID integer
function CTargetManager.ToggleTargetMode(self, targetModeGUID ) end
---Fakes an button event for automated tests
---@param self rdgs.CTargetManager
---@param buttonTypeLua integer
---@param buttonEventLua integer
---@param targetPosWorld rdmath.Vector3|table|number[]
---@param isEnqueueActive boolean
---@param isToggleModeActive boolean
---@param isControlModeActive boolean
---@param isMatchTargetDisabled boolean
---@param isDragActive boolean
---@param dragStartPosWorld rdmath.Vector3|table|number[]
---@param targetModeItemIdLua integer
---@param targetModeItemOwnerIdLua integer
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CTargetManager.ExecuteTargetEvent(self, buttonTypeLua , buttonEventLua , targetPosWorld , isEnqueueActive , isToggleModeActive , isControlModeActive , isMatchTargetDisabled , isDragActive , dragStartPosWorld , targetModeItemIdLua , targetModeItemOwnerIdLua ) end
---@param self rdgs.CTargetManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CTargetManager.ExecuteTargetEvent(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CTargetManager.isValid() end

return CTargetManager
