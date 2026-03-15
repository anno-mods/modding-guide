---@meta rdgs.CEmperorTributeHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CEmperorTributeHandler
---@field ActiveContractTribute integer		Returns the current Emperor Tribute the participant is paying per minute. CAUTION: This value is positive as they are costs.
---@field ActiveContractRemainingTime rdtime		Returns the time left for the current active contract
---@field EmperorImpatienceValue integer		TextSources
---@field EmperorReputationValue integer		
local CEmperorTributeHandler = {}
---@param self rdgs.CEmperorTributeHandler
---@param tributeType integer
---@param response integer
---@return integer
function CEmperorTributeHandler.GetNextEmperorImpatience(self, tributeType , response ) end
---@param self rdgs.CEmperorTributeHandler
---@param tributeType integer
---@param response integer
---@return integer
function CEmperorTributeHandler.GetNextEmperorReputation(self, tributeType , response ) end
---@param self rdgs.CEmperorTributeHandler
---@param tributeType integer
---@param response integer
---@return integer
function CEmperorTributeHandler.GetNextContractTribute(self, tributeType , response ) end
---@param self rdgs.CEmperorTributeHandler
---@param tributeType integer
---@return rdtime
function CEmperorTributeHandler.GetNextContractDuration(self, tributeType ) end

return CEmperorTributeHandler
