---@meta rdgs.CCorporationStats
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CCorporationStats
local CCorporationStats = {}
---Used by the TextSources, calls GetCounter()
---@param self rdgs.CCorporationStats
---@param counterValueType integer
---@param playerCounter integer
---@param context integer
---@param counterScope integer
---@param scopeContext integer
---@return integer
function CCorporationStats.GetCounter(self, counterValueType , playerCounter , context , counterScope , scopeContext ) end
---Used by the TextSources, calls GetCounter()
---@param self rdgs.CCorporationStats
---@param counterValueType integer
---@param playerCounter integer
---@param context integer
---@param counterScope integer
---@return integer
function CCorporationStats.GetCounter(self, counterValueType , playerCounter , context , counterScope ) end
---@return boolean returns true if weak pointer holds a valid reference
function CCorporationStats.isValid() end

return CCorporationStats
