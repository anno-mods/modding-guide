---@meta rdgs.CSessionTradeRouteStationInfo
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSessionTradeRouteStationInfo
---@field IsCliffIsland boolean		Returns true if the station belongs to a cliff island
---@field StationBelongsToCurrentParticipant boolean		
---@field CurrentParticipantHasTradeRights boolean		
local CSessionTradeRouteStationInfo = {}
---Returns the info about a good trade with the given id
---@param self rdgs.CSessionTradeRouteStationInfo
---@param id integer
---@return rdgs.CSessionTradeRouteGoodInfo
function CSessionTradeRouteStationInfo.GetGood(self, id ) end
---Returns true if a GoodInfo object with the given id exists
---@param self rdgs.CSessionTradeRouteStationInfo
---@param id integer
---@return boolean
function CSessionTradeRouteStationInfo.HasGood(self, id ) end
---@return boolean returns true if weak pointer holds a valid reference
function CSessionTradeRouteStationInfo.isValid() end

return CSessionTradeRouteStationInfo
