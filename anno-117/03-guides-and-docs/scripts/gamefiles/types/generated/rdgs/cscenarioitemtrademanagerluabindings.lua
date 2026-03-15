---@meta rdgs.CScenarioItemTradeManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CScenarioItemTradeManager
local CScenarioItemTradeManager = {}
ScenarioItemTrade = CScenarioItemTradeManager
---@param self rdgs.CScenarioItemTradeManager
function CScenarioItemTradeManager.SpawnItemTraderAtSelection(self) end
---@param self rdgs.CScenarioItemTradeManager
---@param areaID rdgs.AreaID
function CScenarioItemTradeManager.ConfirmItemTransfer(self, areaID ) end
---@param self rdgs.CScenarioItemTradeManager
---@param areaID rdgs.AreaID
function CScenarioItemTradeManager.CancelItemTransfer(self, areaID ) end

return CScenarioItemTradeManager
