---@meta rdgs.CAreaWallManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaWallManager
local CAreaWallManager = {}
---@param self rdgs.CAreaWallManager
---@param targetPosition rdmath.Vector3|table|number[]
---@param damage integer
function CAreaWallManager.ApplyDamageAtPosition(self, targetPosition , damage ) end
---@param self rdgs.CAreaWallManager
function CAreaWallManager.ApplyDamageAtTargetPosition(self) end
---@param self rdgs.CAreaWallManager
function CAreaWallManager.ApplyRepairAtTargetPosition(self) end
---@param self rdgs.CAreaWallManager
---@param position rdmath.Vector3|table|number[]
---@return boolean
function CAreaWallManager.HasEdgeAt(self, position ) end
---@param self rdgs.CAreaWallManager
---@param position rdmath.Vector3|table|number[]
---@return boolean
function CAreaWallManager.HasGateAt(self, position ) end
---@param self rdgs.CAreaWallManager
function CAreaWallManager.DebugGenerateMazeOfWalls(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaWallManager.isValid() end

return CAreaWallManager
