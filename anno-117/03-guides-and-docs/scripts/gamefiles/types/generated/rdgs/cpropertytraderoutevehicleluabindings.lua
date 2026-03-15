---@meta rdgs.CPropertyTradeRouteVehicle
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyTradeRouteVehicle
---@field IsAssignedOnTradeRoute boolean		Returns true if this ship is assigned to a trade route
---@field RouteName string		Returns the name of the current route. Empty when no route assigned
---@field IsPaused boolean		Returns true if this ship is currently paused on the route
---@field OnRegularRoute boolean		Returns true when the vehicle is on a regular trade route
---@field LoadingSpeedFactor number		Returns the factor that multiplies the loading speed (item)
local CPropertyTradeRouteVehicle = {}
GetLoadingSpeedFactorForGUID = CPropertyTradeRouteVehicle
---@param guid integer
---@return number
function CPropertyTradeRouteVehicle.GetLoadingSpeedFactorForGUID(guid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyTradeRouteVehicle.isValid() end

return CPropertyTradeRouteVehicle
