---@meta rdgs.CAIUnitManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAIUnitManager
local CAIUnitManager = {}
AiUnit = CAIUnitManager
---@param self rdgs.CAIUnitManager
---@param command integer
function CAIUnitManager.SetDebugCommand(self, command ) end
---@param self rdgs.CAIUnitManager
---@param participantGUID rdgs.ParticipantGUID
function CAIUnitManager.SetDebugParticipant(self, participantGUID ) end
---@param self rdgs.CAIUnitManager
---@param option integer
function CAIUnitManager.ToggleDebugOption(self, option ) end
---@param self rdgs.CAIUnitManager
---@param guid integer
function CAIUnitManager.SetDebugAddShipGUID(self, guid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAIUnitManager.isValid() end

return CAIUnitManager
