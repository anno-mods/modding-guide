---@meta rdgs.CEconomyStatisticManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CEconomyStatisticManager
---@field NumOfSelectedAreas integer		
---@field ProductionStatistic rdgs.CProductionStatistics		Returns the production statistic for the in the UI selected Area
---@field History rdgs.CStatisticsHistoryData		
local CEconomyStatisticManager = {}
EconomyStatistic = CEconomyStatisticManager
---@param self rdgs.CEconomyStatisticManager
---@param enableDebug boolean
function CEconomyStatisticManager.SetDebugEnabled(self, enableDebug ) end
---@param self rdgs.CEconomyStatisticManager
---@param sessionGUID integer
function CEconomyStatisticManager.SetDebugSessionGuid(self, sessionGUID ) end
---@param self rdgs.CEconomyStatisticManager
---@param areaID integer
function CEconomyStatisticManager.SetDebugAreaGuid(self, areaID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CEconomyStatisticManager.isValid() end

return CEconomyStatisticManager
