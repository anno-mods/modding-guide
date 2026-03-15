---@meta rdgs.CSessionCooldownManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSessionCooldownManager
---@field MonumentEventRemainingCooldown rdtime		returns the remaining cooldown for the local player
---@field MonumentEventBlocked boolean		returns true if an event is planned/started for the local player on a different island than the current
---@field MonumentEventAreaName string		returns the name of the island where an event is planned/started for the local player
local CSessionCooldownManager = {}
Cooldown = CSessionCooldownManager
---@return boolean returns true if weak pointer holds a valid reference
function CSessionCooldownManager.isValid() end

return CSessionCooldownManager
