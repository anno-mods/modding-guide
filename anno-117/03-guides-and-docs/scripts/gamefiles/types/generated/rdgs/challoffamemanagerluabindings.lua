---@meta rdgs.CHallOfFameManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CHallOfFameManager
---@field CardOrder std.size_t[]		
---@field CardCount std.size_t		
local CHallOfFameManager = {}
HallOfFame = CHallOfFameManager
---@param self rdgs.CHallOfFameManager
---@param offerId string
---@param spaceId string
---@param revision integer
---@param multiplier integer
function CHallOfFameManager.ApplyOffer(self, offerId , spaceId , revision , multiplier ) end
---@param self rdgs.CHallOfFameManager
---@param offerId string
---@param spaceId string
---@param revision integer
function CHallOfFameManager.ApplyOffer(self, offerId , spaceId , revision ) end
---@param self rdgs.CHallOfFameManager
---@param amount integer
function CHallOfFameManager.CheatCurrency(self, amount ) end
---@param self rdgs.CHallOfFameManager
function CHallOfFameManager.DeleteInventory(self) end
---@param self rdgs.CHallOfFameManager
---@param cardId std.size_t
---@param tier integer
---@param seen boolean
function CHallOfFameManager.SetIsUnseen(self, cardId , tier , seen ) end
---@param self rdgs.CHallOfFameManager
---@param zoom integer
function CHallOfFameManager.SetZoom(self, zoom ) end
---@param self rdgs.CHallOfFameManager
---@param index integer
---@return std.size_t
function CHallOfFameManager.GetCardId(self, index ) end
---@return boolean returns true if weak pointer holds a valid reference
function CHallOfFameManager.isValid() end

return CHallOfFameManager
