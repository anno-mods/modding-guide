---@meta rdgs.CQuestCampaignHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CQuestCampaignHandler
---@field VoadaTradeRightTendency integer		Returns voadas reasoning value towards trade rights with the human participant
---@field VoadaCeaseFireTendency integer		Returns voadas reasoning value towards a cease fire with the human participant
local CQuestCampaignHandler = {}
---@param self rdgs.CQuestCampaignHandler
---@param newChapter datasets.QuestCampaignChapter
function CQuestCampaignHandler.SetActiveChapter(self, newChapter ) end
---@return boolean returns true if weak pointer holds a valid reference
function CQuestCampaignHandler.isValid() end

return CQuestCampaignHandler
