---@meta rdgs.VirtualSpaceTrade
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceTrade
local VirtualSpaceTrade = {}
Static.GetThirdPartyBuyPrice = VirtualSpaceTrade
Static.GetThirdPartySellPrice = VirtualSpaceTrade
---Returns the buy price for a third party for the given good/item.
---@param guid integer
---@param traderGUID integer
---@return integer
function VirtualSpaceTrade.GetThirdPartyBuyPrice(guid , traderGUID ) end
---Returns the sell price for a third party for the given good/item.
---@param guid integer
---@param traderGUID integer
---@return integer
function VirtualSpaceTrade.GetThirdPartySellPrice(guid , traderGUID ) end

return VirtualSpaceTrade
