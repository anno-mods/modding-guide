---@meta rdgs.CGameSetupManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGameSetupManager
---@field InitStartGame boolean		
---@field CurrentGameSetup rdgs.CGameSetup		\"Current\" Setup is the one that is used for the currently running game
---@field RelevantGameSetup rdgs.CGameSetup		#GameSetupRework Remove this or replace with UI editable version
---@field IsMultiPlayerGame boolean		true if any other player is connected (doesn\'t matter if coop or versus)\nCAUTION: If a player is defeated but still connected ( #defeatedHumanPeers ) this method returns false.\nperhaps you are looking for COnlineManager::CurrentGameNeedsToBeSynced ?
---@field CanPirateDifficultyBeChanged boolean		
---@field CanTutorialLevelBeChanged boolean		
---@field CanGameSeedBeChanged boolean		
local CGameSetupManager = {}
GameSetup = CGameSetupManager
---load a pre-configured game setup
---@param self rdgs.CGameSetupManager
---@param gameSetupGUID integer
---@param preserveSlots boolean
---@return boolean
function CGameSetupManager.LoadGameSetup(self, gameSetupGUID , preserveSlots ) end
---start a new session by loading a savegame from a profile (referenced by name displayed to player)
---@param self rdgs.CGameSetupManager
---@param profileDisplayName string
---@param savegameName string
---@return boolean
function CGameSetupManager.LoadSavegame(self, profileDisplayName , savegameName ) end
---@param self rdgs.CGameSetupManager
function CGameSetupManager.InitExternalGameStartConfig(self) end
---@param self rdgs.CGameSetupManager
---@param sessionGUID integer
function CGameSetupManager.ScriptOverrideMaps(self, sessionGUID ) end
---just set some (debug-)defaults for the player profile
---@param self rdgs.CGameSetupManager
function CGameSetupManager.SetDefaultProfileCreationData(self) end
---set the profile attributes for the player profile
---@param self rdgs.CGameSetupManager
---@param name string
---@param colorGUID integer
---@param portraitGUID integer
---@param logoGUID integer
function CGameSetupManager.SetProfileCreationData(self, name , colorGUID , portraitGUID , logoGUID ) end
---@param self rdgs.CGameSetupManager
---@param category datasets.DifficultyCategory
---@return boolean
function CGameSetupManager.GetCanDifficultyCategoryBeChanged(self, category ) end
---all except dormancy
---@param self rdgs.CGameSetupManager
---@param pirateParticipantGUID integer
---@return boolean
function CGameSetupManager.GetCanPirateDormancyDifficultyBeChanged(self, pirateParticipantGUID ) end
---@param self rdgs.CGameSetupManager
---@param setupGUID integer
function CGameSetupManager.SetFixedGameSetup(self, setupGUID ) end
---@param self rdgs.CGameSetupManager
---@param value boolean
function CGameSetupManager.SetFixedGameSetupCustomizationAllowed(self, value ) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameSetupManager.isValid() end

return CGameSetupManager
