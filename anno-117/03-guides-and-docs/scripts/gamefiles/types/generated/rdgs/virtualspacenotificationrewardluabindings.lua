---@meta rdgs.VirtualSpaceNotificationReward
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceNotificationReward
local VirtualSpaceNotificationReward = {}
Static.CreateRewardAmountText = VirtualSpaceNotificationReward
Static.IsRewardAmountNotNull = VirtualSpaceNotificationReward
---We want to show the reward amount of character notifications in the infotip, but we don\'t get this notification object anymore so we write the amount in the RefOid and convert it to text here
---@param rewardAmount integer
---@return string
function VirtualSpaceNotificationReward.CreateRewardAmountText(rewardAmount ) end
---@param rewardAmount integer
---@return boolean
function VirtualSpaceNotificationReward.IsRewardAmountNotNull(rewardAmount ) end

return VirtualSpaceNotificationReward
