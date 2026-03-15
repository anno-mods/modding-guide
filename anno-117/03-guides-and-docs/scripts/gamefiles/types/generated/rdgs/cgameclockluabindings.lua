---@meta rdgs.CGameClock
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGameClock
---@field CorporationTime rdtime		TODO: lua script does not support the CorporationTime strictTypeDef at the moment. Remove this function again once it works
---@field PlayTime rdtime		
---@field GameSpeed rdgs.GameSpeed		
local CGameClock = {}
GameClock = CGameClock
---enable to run game speed as slow as possible
---@param self rdgs.CGameClock
function CGameClock.ToggleAsSlowAsPossible(self) end
---Deprecated methods just calling the PauseManager versions; They only exist to satisfy legacy TextSources
---@param self rdgs.CGameClock
function CGameClock.IncreaseGameSpeed(self) end
---@param self rdgs.CGameClock
function CGameClock.DecreaseGameSpeed(self) end
---@param self rdgs.CGameClock
function CGameClock.SetGameSpeedToLegacySlowMo(self) end
---@param self rdgs.CGameClock
---@param gameSpeed rdgs.GameSpeed
function CGameClock.SetGameSpeed(self, gameSpeed ) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameClock.isValid() end

return CGameClock
