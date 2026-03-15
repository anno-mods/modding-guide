---@meta rdgs.CTradeRouteManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CTradeRouteManager
---@field TradeRoutesWithIssues rdgs.CSessionTradeRoute[]		Returns all routes with active issues
---@field UIEditRoute rdgs.CSessionTradeRoute		Gets the route which is currently edited in the UI
local CTradeRouteManager = {}
TradeRoute = CTradeRouteManager
---Returns a trade route with the given id
---@param self rdgs.CTradeRouteManager
---@param id rdgs.TradeRouteID
---@return rdgs.CSessionTradeRoute
function CTradeRouteManager.GetRoute(self, id ) end
---Opens the given route in the UI
---@param self rdgs.CTradeRouteManager
---@param routeID rdgs.TradeRouteID
function CTradeRouteManager.ShowRouteUI(self, routeID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CTradeRouteManager.isValid() end

return CTradeRouteManager
