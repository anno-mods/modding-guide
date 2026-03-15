---@meta rdgs.CQuestManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CQuestManager
---@field CampaignHandlerMutable rdgs.CQuestCampaignHandler		
---@field TutorialHandler rdgs.CTutorialHandler		Returns the tutorial handler
local CQuestManager = {}
Quests = CQuestManager
---Starts a new story line with the given GUID for the currently active session
---@param self rdgs.CQuestManager
---@param storyLineGUID integer
function CQuestManager.CheatStartStoryLineForCurrentPlayerNet(self, storyLineGUID ) end
---Starts a new component with the given GUID for the currently active session
---@param self rdgs.CQuestManager
---@param componentGUID integer
function CQuestManager.CheatStartQuestComponentForCurrentPlayerNet(self, componentGUID ) end
---@param self rdgs.CQuestManager
function CQuestManager.ResetTutorialQuestsNet(self) end
---Sets the debug quest GUID for the debug page
---@param self rdgs.CQuestManager
---@param val integer
function CQuestManager.SetDebugQuestGUID(self, val ) end
---@param self rdgs.CQuestManager
---@param newDebugParticipantGUID rdgs.ParticipantGUID
function CQuestManager.SetDebugParticipant(self, newDebugParticipantGUID ) end
---Shortcut to call EnableQuestPoolNet from DebugInfoPage
---@param self rdgs.CQuestManager
---@param poolGUID integer
---@param enable boolean
function CQuestManager.EnableQuestPoolForCurrentPlayer(self, poolGUID , enable ) end
---Forces a quest pool cooldown to end immediately
---@param self rdgs.CQuestManager
---@param poolGUID integer
function CQuestManager.CheatResetPoolEntriesNet(self, poolGUID ) end
---Forces a quest pool cooldown to end immediately
---@param self rdgs.CQuestManager
---@param poolGUID integer
function CQuestManager.CheatEndPoolCooldownNet(self, poolGUID ) end
---Sets all pool countdown end timers for current processing participant to predefined T9 value
---@param self rdgs.CQuestManager
function CQuestManager.CheatSetAllPoolCountdownEndtimersToNewTime(self) end
---some test stuff delete later
---@param self rdgs.CQuestManager
function CQuestManager.CheatCycleCampaignChaptersNet(self) end
---Forces a quest pool to stop a quest blocking
---@param self rdgs.CQuestManager
---@param poolGUID integer
---@param questGUID integer
function CQuestManager.CheatEndQuestBlockingNet(self, poolGUID , questGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CQuestManager.isValid() end

return CQuestManager
