---@meta rdgs.CDifficultyHelper
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDifficultyHelper
---@field CanPirateSettingBeChangedInUI boolean		
local CDifficultyHelper = {}
DifficultyHelper = CDifficultyHelper
---@param self rdgs.CDifficultyHelper
---@param pirate rdgs.ParticipantGUID
---@param value datasets.DCPiratesDormancy
function CDifficultyHelper.SetPirateDormancy(self, pirate , value ) end
---@param self rdgs.CDifficultyHelper
---@param pirate rdgs.ParticipantGUID
---@return datasets.DCPiratesDormancy
function CDifficultyHelper.GetPirateDormancy(self, pirate ) end
---@param self rdgs.CDifficultyHelper
---@param pirate rdgs.ParticipantGUID
---@param value datasets.DCPiratesWarFleetSize
function CDifficultyHelper.SetPirateWarFleetSize(self, pirate , value ) end
---@param self rdgs.CDifficultyHelper
---@param pirate rdgs.ParticipantGUID
---@return datasets.DCPiratesWarFleetSize
function CDifficultyHelper.GetPirateWarFleetSize(self, pirate ) end
---@param self rdgs.CDifficultyHelper
---@param pirate rdgs.ParticipantGUID
---@param value datasets.DCPiratesPatrols
function CDifficultyHelper.SetPiratePatrols(self, pirate , value ) end
---@param self rdgs.CDifficultyHelper
---@param pirate rdgs.ParticipantGUID
---@return datasets.DCPiratesPatrols
function CDifficultyHelper.GetPiratePatrols(self, pirate ) end
---@param self rdgs.CDifficultyHelper
---@param pirate rdgs.ParticipantGUID
---@param value datasets.DCPiratesRaids
function CDifficultyHelper.SetPirateRaids(self, pirate , value ) end
---@param self rdgs.CDifficultyHelper
---@param pirate rdgs.ParticipantGUID
---@return datasets.DCPiratesRaids
function CDifficultyHelper.GetPirateRaids(self, pirate ) end

return CDifficultyHelper
