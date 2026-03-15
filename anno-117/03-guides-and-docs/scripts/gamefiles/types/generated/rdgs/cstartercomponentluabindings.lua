---@meta rdgs.CStarterComponent
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CStarterComponent
---@field GUID integer		Returns the component GUID
local CStarterComponent = {}
---@see CQuestComponent parent class
---@return boolean returns true if weak pointer holds a valid reference
function CStarterComponent.isValid() end
---Accepts the offered starter, this will complete this component and take the accept output path
---@param self rdgs.CStarterComponent
function CStarterComponent.AcceptStarter(self) end
---Decline the offered starter, this will complete this component and take the declined output path
---@param self rdgs.CStarterComponent
function CStarterComponent.DeclineStarter(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CStarterComponent.isValid() end

return CStarterComponent
