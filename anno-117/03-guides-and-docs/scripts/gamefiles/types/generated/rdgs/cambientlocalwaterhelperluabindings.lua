---@meta rdgs.CAmbientLocalWaterHelper
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAmbientLocalWaterHelper
local CAmbientLocalWaterHelper = {}
---Create a new ambient local water with the given settings\n\\return true if the ambient local water was created or false if an error occurred
---@param self rdgs.CAmbientLocalWaterHelper
---@param name string
---@param desc rd3d.LocalWaterAreaDesc
---@return boolean
function CAmbientLocalWaterHelper.Create(self, name , desc ) end
---Delete an existing ambient local water
---@param self rdgs.CAmbientLocalWaterHelper
---@param name string
function CAmbientLocalWaterHelper.Delete(self, name ) end
---Update an existing ambient local water
---@param self rdgs.CAmbientLocalWaterHelper
---@param name string
---@param desc rd3d.LocalWaterAreaDesc
function CAmbientLocalWaterHelper.Update(self, name , desc ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAmbientLocalWaterHelper.isValid() end

return CAmbientLocalWaterHelper
