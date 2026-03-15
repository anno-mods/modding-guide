---@meta rdgs.CAreaAttractivityManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaAttractivityManager
---@field Attractivity integer		
local CAreaAttractivityManager = {}
Attractivity = CAreaAttractivityManager
---datasets::AttractivityType type
---@param self rdgs.CAreaAttractivityManager
---@param type integer
---@return integer
function CAreaAttractivityManager.GetAttractivityType(self, type ) end
---@param self rdgs.CAreaAttractivityManager
---@param increase boolean
---@param bigStep boolean
function CAreaAttractivityManager.CheatChangeAttractivityNet(self, increase , bigStep ) end

return CAreaAttractivityManager
