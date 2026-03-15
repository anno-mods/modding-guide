---@meta rdgs.IBuildMode
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.IBuildMode
local IBuildMode = {}
---@param self rdgs.IBuildMode
---@param rotateDirection rdsdk.RotateDirection
function IBuildMode.ChangeDirection(self, rotateDirection ) end
---@param self rdgs.IBuildMode
---@param direction rdsdk.Direction8
function IBuildMode.SetDirection(self, direction ) end

return IBuildMode
