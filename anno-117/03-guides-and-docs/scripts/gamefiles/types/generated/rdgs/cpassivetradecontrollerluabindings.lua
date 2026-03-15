---@meta rdgs.CPassiveTradeController
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPassiveTradeController
---@field Offers rdgs.CPassiveTradeOffer[]		
---@field BuyOffers rdgs.CTradeOfferInfo[]		Fills the given vector with all goods this trader buys currently
---@field TradeHistory rdgs.CPassiveTradeHistory		Returns the trade history
local CPassiveTradeController = {}
IsPassiveTradeFeatureEnabled = CPassiveTradeController
---Returns the global price when passive trader buys items or goods
---@param self rdgs.CPassiveTradeController
---@param guid integer
---@return integer
function CPassiveTradeController.GetBuyPrice(self, guid ) end
---Returns the global price when passive trader sells items or goods.If shipID is given, price reducing items will be considered
---@param self rdgs.CPassiveTradeController
---@param guid integer
---@param shipID rdgs.GameObjectID
---@return integer
function CPassiveTradeController.GetSellPrice(self, guid , shipID ) end
---Returns the global price when passive trader sells items or goods.If shipID is given, price reducing items will be considered
---@param self rdgs.CPassiveTradeController
---@param guid integer
---@return integer
function CPassiveTradeController.GetSellPrice(self, guid ) end
---Returns the required volcano barter good amount for a single product
---@param self rdgs.CPassiveTradeController
---@param productGuid integer
---@param shipId rdgs.GameObjectID
---@return integer
function CPassiveTradeController.GetRequiredBarterGoodAmount(self, productGuid , shipId ) end
---Returns the required volcano barter good amount for a single product
---@param self rdgs.CPassiveTradeController
---@param productGuid integer
---@return integer
function CPassiveTradeController.GetRequiredBarterGoodAmount(self, productGuid ) end
---Returns the passive trade offer for the good with the given guid, \nIf it does not exist, it will check if the good is unlocked and if there is a offer for all unlocked goods and return that
---@param self rdgs.CPassiveTradeController
---@param guid integer
---@return rdgs.CPassiveTradeOffer
function CPassiveTradeController.GetOfferOrBulkOffer(self, guid ) end
---Returns true if for the given guid a offer exists or a bulk offer exists
---@param self rdgs.CPassiveTradeController
---@param guid integer
---@return boolean
function CPassiveTradeController.HasOfferOrBulkOffer(self, guid ) end
---Returns true if there is a buy offer for the given product or a bulk buy offer
---@param self rdgs.CPassiveTradeController
---@param guid integer
---@return boolean
function CPassiveTradeController.IsGoodBought(self, guid ) end
---Returns true if there is a sell offer for the given product or bulk sell offer
---@param self rdgs.CPassiveTradeController
---@param guid integer
---@return boolean
function CPassiveTradeController.IsGoodSold(self, guid ) end
---Fills the given vector with all goods this trader sells currently to the asking participant. If a shipID is given, item (specialists) for price reduction will be considered
---@param self rdgs.CPassiveTradeController
---@param shipID rdgs.GameObjectID
---@return rdgs.CTradeOfferInfo[]
function CPassiveTradeController.SellOffers(self, shipID ) end
---Fills the given vector with all goods this trader sells currently to the asking participant. If a shipID is given, item (specialists) for price reduction will be considered
---@param self rdgs.CPassiveTradeController
---@return rdgs.CTradeOfferInfo[]
function CPassiveTradeController.SellOffers(self) end
---Returns the configured minimum stock for the given product. rdsdk::None if there is nothing configured
---@param self rdgs.CPassiveTradeController
---@param guid integer
---@return integer|nil
function CPassiveTradeController.GetMinimumStockForProductOrBulk(self, guid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPassiveTradeController.isValid() end

return CPassiveTradeController
