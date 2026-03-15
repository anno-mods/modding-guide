---@meta rdgs.CAIMetaShipHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAIMetaShipHandler
local CAIMetaShipHandler = {}
---@param self rdgs.CAIMetaShipHandler
---@param id integer
function CAIMetaShipHandler.SkipRequest(self, id ) end
---@param self rdgs.CAIMetaShipHandler
---@param purpose integer
---@param shipMetaObjID integer
function CAIMetaShipHandler.ReleaseShip(self, purpose , shipMetaObjID ) end
---@param self rdgs.CAIMetaShipHandler
---@param id integer
function CAIMetaShipHandler.ToggleShipLog(self, id ) end
---@param self rdgs.CAIMetaShipHandler
---@param id rdgs.AIShipRequestID
function CAIMetaShipHandler.FulfillRequest(self, id ) end

return CAIMetaShipHandler
