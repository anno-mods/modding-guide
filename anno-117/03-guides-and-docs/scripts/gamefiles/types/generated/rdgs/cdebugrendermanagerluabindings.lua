---@meta rdgs.CDebugRenderManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDebugRenderManager
---@field DebugJunkyard rdgs.CDebugJunkyard		
local CDebugRenderManager = {}
DebugRender = CDebugRenderManager
---@param self rdgs.CDebugRenderManager
---@param layer integer
function CDebugRenderManager.SetDebugDrawGrid(self, layer ) end
---Toggles the m_ShowCollectables flag
---@param self rdgs.CDebugRenderManager
function CDebugRenderManager.ToggleShowQuestHint(self) end
---@param self rdgs.CDebugRenderManager
---@param index integer
---@param enable boolean
function CDebugRenderManager.SetCommonRenderConditions(self, index , enable ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDebugRenderManager.isValid() end

return CDebugRenderManager
