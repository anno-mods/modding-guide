---@meta rdgs.CQuestComponentHelper
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CQuestComponentHelper
local CQuestComponentHelper = {}
CheatStartStoryLineForCurrentPlayerNet = CQuestComponentHelper
GetQuestComponent = CQuestComponentHelper
GetLocationInfo = CQuestComponentHelper
---Cheat to starts a new storyline in the correct manager. Decisions - governor decision manager, Contracts - Contract manager, Quest - questmanager
---@param storyLineGUID integer
function CQuestComponentHelper.CheatStartStoryLineForCurrentPlayerNet(storyLineGUID ) end
---@param componentID quest.ComponentID
---@return rdgs.CQuestComponent
function CQuestComponentHelper.GetQuestComponent(componentID ) end
---Returns the components location info for a given componentID, if it doesn\'t exist the request will be passed on to the parent component until a location was found or we reached the topmost parent
---@param componentID quest.ComponentID
---@return rdgs.CLocationInfo|nil
function CQuestComponentHelper.GetLocationInfo(componentID ) end

return CQuestComponentHelper
