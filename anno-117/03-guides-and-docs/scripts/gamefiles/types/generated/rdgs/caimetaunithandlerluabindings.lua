---@meta rdgs.CAIMetaUnitHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAIMetaUnitHandler
local CAIMetaUnitHandler = {}
---@param self rdgs.CAIMetaUnitHandler
---@param id integer
function CAIMetaUnitHandler.SkipRequest(self, id ) end
---@param self rdgs.CAIMetaUnitHandler
---@param purpose integer
---@param shipMetaObjID integer
function CAIMetaUnitHandler.ReleaseShip(self, purpose , shipMetaObjID ) end
---@param self rdgs.CAIMetaUnitHandler
---@param id integer
function CAIMetaUnitHandler.ToggleShipLog(self, id ) end
---@param self rdgs.CAIMetaUnitHandler
---@param id rdgs.AIUnitRequestID
function CAIMetaUnitHandler.FulfillRequest(self, id ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAIMetaUnitHandler.isValid() end

return CAIMetaUnitHandler
