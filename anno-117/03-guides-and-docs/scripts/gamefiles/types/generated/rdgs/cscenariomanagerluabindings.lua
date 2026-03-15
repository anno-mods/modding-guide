---@meta rdgs.CScenarioManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CScenarioManager
---@field ScenarioGUID integer		
local CScenarioManager = {}
Scenarios = CScenarioManager
---@param self rdgs.CScenarioManager
---@param scenarioGUID integer
---@return rdsdk.TextId
function CScenarioManager.GetScenarioName(self, scenarioGUID ) end
---@param self rdgs.CScenarioManager
---@param scenarioGUID integer
function CScenarioManager.ResetBadges(self, scenarioGUID ) end
---@param self rdgs.CScenarioManager
function CScenarioManager.ResetLastSeenPromotion(self) end
---@param self rdgs.CScenarioManager
function CScenarioManager.SaveAccount(self) end
---Resets all permanent scenario progress, e.g. milestones
---@param self rdgs.CScenarioManager
function CScenarioManager.ResetScenario(self) end
---Whether the given medal id is achieved at all in the active scenario. 0 = bronze, 1 = silver, 2 = gold
---@param self rdgs.CScenarioManager
---@param medalID integer
---@return boolean
function CScenarioManager.GetMedalAchievedAtAll(self, medalID ) end
---Whether the given medal id is achieved in the current run in the active scenario. 0 = bronze, 1 = silver, 2 = gold
---@param self rdgs.CScenarioManager
---@param medalID integer
---@return boolean
function CScenarioManager.GetMedalAchievedThisRun(self, medalID ) end
---Whether the given medal id is achieved for the first time in the active scenario. 0 = bronze, 1 = silver, 2 = gold
---@param self rdgs.CScenarioManager
---@param medalID integer
---@return boolean
function CScenarioManager.GetMedalAchievedFirstTimeThisRun(self, medalID ) end
---Whether the given badge id is achieved at all in the active scenario. 0 = first badge, 1 = second badge, ...
---@param self rdgs.CScenarioManager
---@param badgeID integer
---@return boolean
function CScenarioManager.GetBadgeAchievedAtAll(self, badgeID ) end
---Whether the given badge id is achieved in the current run in the active scenario. 0 = first badge, 1 = second badge, ...
---@param self rdgs.CScenarioManager
---@param badgeID integer
---@return boolean
function CScenarioManager.GetBadgeAchievedThisRun(self, badgeID ) end
---Whether the given badge id is achieved for the first time  in the active scenario. 0 = first badge, 1 = second badge, ...
---@param self rdgs.CScenarioManager
---@param badgeID integer
---@return boolean
function CScenarioManager.GetBadgeAchievedFirstTimeThisRun(self, badgeID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CScenarioManager.isValid() end

return CScenarioManager
