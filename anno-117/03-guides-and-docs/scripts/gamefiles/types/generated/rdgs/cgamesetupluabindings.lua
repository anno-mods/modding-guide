---@meta rdgs.CGameSetup
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGameSetup
---@field IsActive boolean		
---@field IsCampaignEnabled boolean		
---@field TutorialLevel datasets.TutorialLevel		
---@field IsScenarioEnabled boolean		
---@field InternalLoadAsScenarioSelection boolean		
---@field AreFriendsAllowedToJoin boolean		
---@field HostHasSaveGame boolean		
---@field GameSeed integer		
---@field DifficultyLevel datasets.CorporationDifficulty		
---@field DifficultyCategoryMapType integer		
---@field HasPersistentCoopCreator boolean		
---@field PersistentCoopCanCreateState datasets.PersistentCoopCanCreateState		
local CGameSetup = {}
---@param self rdgs.CGameSetup
---@param value boolean
function CGameSetup.SetEnableCampaign(self, value ) end
---@param self rdgs.CGameSetup
---@param value boolean
function CGameSetup.SetEnableScenario(self, value ) end
---@param self rdgs.CGameSetup
---@param value boolean
function CGameSetup.SetInternalLoadAsScenarioSelection(self, value ) end
---@param self rdgs.CGameSetup
---@param value boolean
function CGameSetup.SetAllowFriendsToJoin(self, value ) end
---@param self rdgs.CGameSetup
---@param value boolean
function CGameSetup.SetHostHasSaveGame(self, value ) end
---@param self rdgs.CGameSetup
---@param difficultyPreset integer
function CGameSetup.ResetDifficultyPreset(self, difficultyPreset ) end
---@param self rdgs.CGameSetup
function CGameSetup.ResetSecondParties(self) end
---@param self rdgs.CGameSetup
---@param category datasets.DifficultyCategory
---@param value integer
function CGameSetup.SetDifficultyCategoryValue(self, category , value ) end
---@param self rdgs.CGameSetup
---@param category datasets.DifficultyCategory
---@return integer
function CGameSetup.GetDifficultyCategoryValue(self, category ) end
---@param self rdgs.CGameSetup
---@param pirate rdgs.ParticipantGUID
---@param value datasets.DCPiratesDormancy
function CGameSetup.SetPirateDormancyDifficultyUI(self, pirate , value ) end
---@param self rdgs.CGameSetup
---@param participant rdgs.ParticipantGUID
---@return datasets.DCPiratesDormancy
function CGameSetup.GetPirateDormancyDifficultyUI(self, participant ) end
---this differs from the non UI version in a way, that defeated will still return dormant
---@param self rdgs.CGameSetup
---@param pirate rdgs.ParticipantGUID
---@param value datasets.DCPiratesRaids
function CGameSetup.SetPirateRaidDifficulty(self, pirate , value ) end
---@param self rdgs.CGameSetup
---@param participant rdgs.ParticipantGUID
---@return datasets.DCPiratesRaids
function CGameSetup.GetPirateRaidDifficulty(self, participant ) end
---@param self rdgs.CGameSetup
---@param pirate rdgs.ParticipantGUID
---@param value datasets.DCPiratesWarFleetSize
function CGameSetup.SetPirateWarFleetDifficulty(self, pirate , value ) end
---@param self rdgs.CGameSetup
---@param participant rdgs.ParticipantGUID
---@return datasets.DCPiratesWarFleetSize
function CGameSetup.GetPirateWarFleetDifficulty(self, participant ) end
---@param self rdgs.CGameSetup
---@param pirate rdgs.ParticipantGUID
---@param value datasets.DCPiratesPatrols
function CGameSetup.SetPiratePatrolsDifficulty(self, pirate , value ) end
---@param self rdgs.CGameSetup
---@param participant rdgs.ParticipantGUID
---@return datasets.DCPiratesPatrols
function CGameSetup.GetPiratePatrolsDifficulty(self, participant ) end
---@param self rdgs.CGameSetup
---@param participant rdgs.ParticipantGUID
---@param value datasets.DCPiratesWarThreats
function CGameSetup.SetPirateWarThreatsDifficulty(self, participant , value ) end
---@param self rdgs.CGameSetup
---@param participant rdgs.ParticipantGUID
---@return datasets.DCPiratesWarThreats
function CGameSetup.GetPirateWarThreatsDifficulty(self, participant ) end
---@param self rdgs.CGameSetup
---@param value boolean
function CGameSetup.SetDifficultyFixed(self, value ) end
---@param self rdgs.CGameSetup
---@param slot datasets.MPSlot
---@return rdgs.CGameSetupSlot
function CGameSetup.GetSetupSlot(self, slot ) end
---@param self rdgs.CGameSetup
---@param participant rdgs.ParticipantGUID
---@return rdgs.CGameSetupSlot
function CGameSetup.GetSetupSlot(self, participant ) end
---@param self rdgs.CGameSetup
---@param participant rdgs.ParticipantGUID
---@return boolean
function CGameSetup.IsParticipantDefeated(self, participant ) end
---@param self rdgs.CGameSetup
---@param participant rdgs.ParticipantGUID
---@return boolean
function CGameSetup.IsInSetup(self, participant ) end
---@param self rdgs.CGameSetup
---@param participant rdgs.ParticipantGUID
---@return rdgs.CGameSetupPeer[]
function CGameSetup.GetParticipantPeers(self, participant ) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameSetup.isValid() end

return CGameSetup
