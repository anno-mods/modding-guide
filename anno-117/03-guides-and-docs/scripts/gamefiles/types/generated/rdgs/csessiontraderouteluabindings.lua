---@meta rdgs.CSessionTradeRoute
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSessionTradeRoute
---@field Name string		Gets / Sets the name of the trade route
---@field NotEnoughStationsActive boolean		
---@field NoGoodsActive boolean		
---@field NoShipsActive boolean		
---@field AllShipsPausedActive boolean		
---@field ActiveErrorCount integer		Returns how many errors are currently active. If checkAllErrors are false, some errors are skipped that should not be displayed in the UI
local CSessionTradeRoute = {}
---Returns the route with the given id
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@return rdgs.CSessionTradeRouteStationInfo
function CSessionTradeRoute.GetStation(self, stationID ) end
---Returns the name of a lost ship with the given id. Empty string if there is none
---@param self rdgs.CSessionTradeRoute
---@param shipID rdgs.MetaGameObjectID
---@return string
function CSessionTradeRoute.GetLostShipName(self, shipID ) end
---@param self rdgs.CSessionTradeRoute
---@param errorType integer
---@return boolean
function CSessionTradeRoute.IsErrorActive(self, errorType ) end
---@param self rdgs.CSessionTradeRoute
---@param slotIndex integer
---@return boolean
function CSessionTradeRoute.NotEnoughSlotsErrorActive(self, slotIndex ) end
---@param self rdgs.CSessionTradeRoute
---@param shipID rdgs.MetaGameObjectID
---@return boolean
function CSessionTradeRoute.NotEnoughSlotsForShipsErrorActive(self, shipID ) end
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@return boolean
function CSessionTradeRoute.IslandUnderSiegeActive(self, stationID ) end
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@return boolean
function CSessionTradeRoute.NoValidPierActive(self, stationID ) end
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@return boolean
function CSessionTradeRoute.NoTradeRightsActive(self, stationID ) end
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@param goodID rdgs.GoodTradeID
---@return boolean
function CSessionTradeRoute.ConfiguredGoodNotTradedActive(self, stationID , goodID ) end
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@param goodID rdgs.GoodTradeID
---@return boolean
function CSessionTradeRoute.LoadedGoodNeverUnloadedActive(self, stationID , goodID ) end
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@param goodID rdgs.GoodTradeID
---@return boolean
function CSessionTradeRoute.UnloadedGoodNeverLoadedActive(self, stationID , goodID ) end
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@param goodID rdgs.GoodTradeID
---@return boolean
function CSessionTradeRoute.GoodsDontMatchActive(self, stationID , goodID ) end
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@param goodID rdgs.GoodTradeID
---@return boolean
function CSessionTradeRoute.StorageFullActive(self, stationID , goodID ) end
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@param goodID rdgs.GoodTradeID
---@return boolean
function CSessionTradeRoute.StorageEmptyActive(self, stationID , goodID ) end
---@param self rdgs.CSessionTradeRoute
---@param stationID rdgs.StationTradeID
---@return boolean
function CSessionTradeRoute.LongWaitingTimeActive(self, stationID ) end
---@param self rdgs.CSessionTradeRoute
---@param shipID rdgs.MetaGameObjectID
---@return boolean
function CSessionTradeRoute.MismatchingGoodActive(self, shipID ) end
---@param self rdgs.CSessionTradeRoute
---@param shipID rdgs.MetaGameObjectID
---@param goodGUID integer
---@return boolean
function CSessionTradeRoute.MismatchingGoodActiveForGood(self, shipID , goodGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CSessionTradeRoute.isValid() end

return CSessionTradeRoute
