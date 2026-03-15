---@meta rdgs.CAICheatHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAICheatHandler
local CAICheatHandler = {}
---@param self rdgs.CAICheatHandler
---@param command integer
function CAICheatHandler.SetDebugCommand(self, command ) end
---@param self rdgs.CAICheatHandler
---@param area integer
---@param role integer
function CAICheatHandler.ToggleIslandRole(self, area , role ) end
---@param self rdgs.CAICheatHandler
---@param participantGUID rdgs.ParticipantGUID
function CAICheatHandler.SetDebugParticipant(self, participantGUID ) end
---@param self rdgs.CAICheatHandler
---@param GUID integer
---@param useToggleLogic boolean
function CAICheatHandler.OverwriteNextConstructionRequest(self, GUID , useToggleLogic ) end
---@param self rdgs.CAICheatHandler
function CAICheatHandler.ResetQuickBuildFilter(self) end
---@param self rdgs.CAICheatHandler
---@param searchTerm string
function CAICheatHandler.SetQuickBuildFilter(self, searchTerm ) end
---@param self rdgs.CAICheatHandler
function CAICheatHandler.ResetSkins(self) end
---@param self rdgs.CAICheatHandler
---@param buildingGuid integer
---@param skinGuid integer
function CAICheatHandler.SetSkinGuid(self, buildingGuid , skinGuid ) end
---@param self rdgs.CAICheatHandler
---@param blockID integer
function CAICheatHandler.DestroyBlock(self, blockID ) end
---@param self rdgs.CAICheatHandler
---@param GUID integer
---@param useToggleLogic boolean
function CAICheatHandler.SetBuildUntil(self, GUID , useToggleLogic ) end
---@param self rdgs.CAICheatHandler
function CAICheatHandler.ResetBuildUntilFilter(self) end
---@param self rdgs.CAICheatHandler
---@param searchTerm string
function CAICheatHandler.SetBuildUntilFilter(self, searchTerm ) end
---@param self rdgs.CAICheatHandler
---@param GUID integer
---@param useToggleLogic boolean
function CAICheatHandler.FakeNoSpace(self, GUID , useToggleLogic ) end
---@param self rdgs.CAICheatHandler
function CAICheatHandler.ResetFakeNoSpaceFilter(self) end
---@param self rdgs.CAICheatHandler
---@param searchTerm string
function CAICheatHandler.SetFakeNoSpaceFilter(self, searchTerm ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAICheatHandler.isValid() end

return CAICheatHandler
