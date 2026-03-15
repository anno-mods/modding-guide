---@meta rdgs.CStatisticsHistoryData
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CStatisticsHistoryData
local CStatisticsHistoryData = {}
---Returns a string that contains the time since that is passed since the given snapshot
---@param self rdgs.CStatisticsHistoryData
---@param snapshotIndex integer
---@return string
function CStatisticsHistoryData.GetTimeSinceSnapshot(self, snapshotIndex ) end
---Returns the population amount for the given population at the given snapshot index (0 = oldest)
---@param self rdgs.CStatisticsHistoryData
---@param snapshotIndex integer
---@param populationGuid integer
---@return integer
function CStatisticsHistoryData.GetPopulationAmount(self, snapshotIndex , populationGuid ) end
---Returns the product amount for the given product at the given snapshot index (0 = oldest)
---@param self rdgs.CStatisticsHistoryData
---@param snapshotIndex integer
---@param productGuid integer
---@return integer
function CStatisticsHistoryData.GetProductAmount(self, snapshotIndex , productGuid ) end
---Returns the product generation for the given product at the given snapshot index (0 = oldest)
---@param self rdgs.CStatisticsHistoryData
---@param snapshotIndex integer
---@param productGuid integer
---@return integer
function CStatisticsHistoryData.GetProductGeneration(self, snapshotIndex , productGuid ) end
---Returns the product consumption for the given product at the given snapshot index (0 = oldest)
---@param self rdgs.CStatisticsHistoryData
---@param snapshotIndex integer
---@param productGuid integer
---@return integer
function CStatisticsHistoryData.GetProductConsumption(self, snapshotIndex , productGuid ) end

return CStatisticsHistoryData
