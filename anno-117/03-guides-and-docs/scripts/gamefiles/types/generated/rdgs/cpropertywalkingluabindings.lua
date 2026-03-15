---@meta rdgs.CPropertyWalking
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyWalking
---@field BaseSpeedWithUpgrades number		Returns the speed of the ship including all current upgrades, excluding wind, cargo & damage factors.
---@field BaseSpeedWithUpgrades_MaxWindSlowdown number		Returns the speed of the ship including all current upgrades with maximum wind opposing to the ship
---@field BaseSpeedWithUpgrades_MaxWindSpeedup number		Returns the speed of the ship including all current upgrades with maximum wind in favor of the ship
---@field BaseSpeedWithStaticSpeedFactors number		Returns the speed of the ship including all factors excluding wind (upgrades, cargo, damage)
---@field BaseSpeedWithStaticSpeedFactors_MaxWindSlowdown number		Returns the speed of the ship including all factors excluding wind (upgrades, cargo, damage) with maximum wind opposing to the ship
---@field BaseSpeedWithStaticSpeedFactors_MaxWindSpeedup number		Returns the speed of the ship including all factors excluding wind (upgrades, cargo, damage) with maximum wind in favor of the ship
---@field AffectedByWind boolean		Returns whether the vehicle is affected by wind
---@field SessionTransferSpeedFactor number		Returns the speed factor that is applied during a session transfer
local CPropertyWalking = {}
GetBaseSpeed = CPropertyWalking
GetBaseSpeed_MaxWindSlowdown = CPropertyWalking
GetBaseSpeed_MaxWindSpeedup = CPropertyWalking
GetSessionTransferSpeedFactorForGUID = CPropertyWalking
---walks the unit to the target (or close to if not reachable)
---@param self rdgs.CPropertyWalking
---@param target rdmath.Vector3|table|number[]
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CPropertyWalking.WaitGoto(self, target ) end
---@param self rdgs.CPropertyWalking
---@param target rdmath.Vector3|table|number[]
---@param endDir number
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CPropertyWalking.WaitGoto(self, target , endDir ) end
---@param self rdgs.CPropertyWalking
function CPropertyWalking.UnsetIdleTickCount(self) end
---Returns true if an object is currently moving
---@param self rdgs.CPropertyWalking
---@param queryUnitState boolean
---@return boolean
function CPropertyWalking.IsMoving(self, queryUnitState ) end
---@param self rdgs.CPropertyWalking
---@param isMovingDefinition rdgs.IsMovingDefinition
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CPropertyWalking.WaitGoto(self, isMovingDefinition ) end
---@param self rdgs.CPropertyWalking
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CPropertyWalking.WaitGoto(self) end
---Returns the speed of the ship, excluding all upgrades, wind, cargo & damage factors.
---@param guid integer
---@return number
function CPropertyWalking.GetBaseSpeed(guid ) end
---Returns the speed of the ship including maximum wind opposing to the ship, excluding all upgrades, cargo & damage factors.
---@param guid integer
---@return number
function CPropertyWalking.GetBaseSpeed_MaxWindSlowdown(guid ) end
---Returns the speed of the ship including maximum wind in favour of the ship, excluding all upgrades, cargo & damage factors.
---@param guid integer
---@return number
function CPropertyWalking.GetBaseSpeed_MaxWindSpeedup(guid ) end
---@param guid integer
---@return number
function CPropertyWalking.GetSessionTransferSpeedFactorForGUID(guid ) end

return CPropertyWalking
