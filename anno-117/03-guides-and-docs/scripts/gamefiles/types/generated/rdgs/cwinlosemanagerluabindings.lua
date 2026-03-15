---@meta rdgs.CWinLoseManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CWinLoseManager
---@field BankruptcyTimerForCurrentParticipant rdtime		Returns the time until bankruptcy for the current player
local CWinLoseManager = {}
WinLose = CWinLoseManager
---@param self rdgs.CWinLoseManager
---@param type rdgs.WinLoseType
function CWinLoseManager.DefeatCurrentPlayer(self, type ) end
---@param self rdgs.CWinLoseManager
function CWinLoseManager.DefeatCurrentPlayer(self) end
---@param self rdgs.CWinLoseManager
---@param participantGUID integer
function CWinLoseManager.DefeatPlayer(self, participantGUID ) end
---@param self rdgs.CWinLoseManager
function CWinLoseManager.LoseCurrentPlayer(self) end
---@param self rdgs.CWinLoseManager
function CWinLoseManager.WinCurrentPlayer(self) end
---@param self rdgs.CWinLoseManager
function CWinLoseManager.CheatScenarioFinished(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CWinLoseManager.isValid() end

return CWinLoseManager
