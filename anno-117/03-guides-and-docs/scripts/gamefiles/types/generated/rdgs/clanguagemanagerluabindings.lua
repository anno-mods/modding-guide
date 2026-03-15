---@meta rdgs.CLanguageManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CLanguageManager
---@field TextLanguage datasets.Language		
---@field AudioLanguage datasets.Language		
---@field AvailableTextLanguages datasets.Language[]		
---@field AvailableAudioLanguages datasets.Language[]		
local CLanguageManager = {}
Language = CLanguageManager
---@param self rdgs.CLanguageManager
---@param language datasets.Language
function CLanguageManager.SetTextLanguage(self, language ) end
---@param self rdgs.CLanguageManager
function CLanguageManager.CheatCycleTextLanguage(self) end
---@param self rdgs.CLanguageManager
---@param language datasets.Language
function CLanguageManager.SetAudioLanguage(self, language ) end
---@param self rdgs.CLanguageManager
---@param language datasets.Language
function CLanguageManager.SetFixedLanguage(self, language ) end
---@return boolean returns true if weak pointer holds a valid reference
function CLanguageManager.isValid() end

return CLanguageManager
