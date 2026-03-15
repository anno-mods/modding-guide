---@meta rdgs.CPropertySellable
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertySellable
---@field OnSale boolean		if a ship is on sale it becomes an infolayer on top of it and\ncan be bought by any of the allowedBuyers.
---@field AffordableByCurrentParticipant boolean		
---@field CurrentParticipantBuyPrice rdgs.CBuildCost		
---@field SellPrice rdgs.CBuildCost		
---@field IsConfiguredToBeSellableToTrader boolean		returns if the ship is generally allowed to be sold to trader as defined in config
---@field CanBeSoldToTrader boolean		returns if the ship is generally allowed to be sold to trader and does not contain any items that would prevent it.
---@field CanCurrentlyBeSoldToTrader boolean		returns if the ship can currently be sold to the trader (includes distance to harbor)
local CPropertySellable = {}
---@param self rdgs.CPropertySellable
---@param sale boolean
function CPropertySellable.SetOnSale(self, sale ) end
---@param self rdgs.CPropertySellable
function CPropertySellable.CheatBuy(self) end
---@param self rdgs.CPropertySellable
---@param buyParticipantGUID rdgs.ParticipantGUID
function CPropertySellable.BuyNet(self, buyParticipantGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertySellable.isValid() end

return CPropertySellable
