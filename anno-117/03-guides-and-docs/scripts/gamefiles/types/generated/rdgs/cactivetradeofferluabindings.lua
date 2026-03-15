---@meta rdgs.CActiveTradeOffer
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CActiveTradeOffer
---@field IsActiveTradeActive boolean		Returns true if the current player currently does an active trade
---@field TraderPassiveTrade rdgs.CPassiveTradeController		Returns the passive trade controller of the interacting trader
---@field TradeParticipant rdgs.ParticipantGUID		Returns the participant this offer belongs to
---@field KontorTrader rdgs.CPropertyTrader		Returns the trader property of the participant who owns the kontor. Might be null if we trade with a second party
local CActiveTradeOffer = {}
---@param self rdgs.CActiveTradeOffer
---@param guid integer
---@return integer
function CActiveTradeOffer.GetBuyPriceForSingleGood(self, guid ) end
---@param self rdgs.CActiveTradeOffer
---@param guid integer
---@return integer
function CActiveTradeOffer.GetSellPriceForSingleGood(self, guid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CActiveTradeOffer.isValid() end

return CActiveTradeOffer
