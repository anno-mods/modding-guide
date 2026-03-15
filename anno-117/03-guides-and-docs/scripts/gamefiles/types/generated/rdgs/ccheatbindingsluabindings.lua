---@meta rdgs.CCheatBindings
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CCheatBindings
---@field SessionGuid integer		
local CCheatBindings = {}
Cheats = CCheatBindings
---Damages all currently selected gameobjects by the given percent
---@param self rdgs.CCheatBindings
---@param percentage number
---@param damageDealerParticipant rdgs.ParticipantGUID
---@param countAsUnitAttack boolean
function CCheatBindings.DamageSelectedObjects(self, percentage , damageDealerParticipant , countAsUnitAttack ) end
---Damages all currently selected gameobjects by the given percent
---@param self rdgs.CCheatBindings
---@param percentage number
---@param damageDealerParticipant rdgs.ParticipantGUID
function CCheatBindings.DamageSelectedObjects(self, percentage , damageDealerParticipant ) end
---Damages all currently selected gameobjects by the given percent
---@param self rdgs.CCheatBindings
---@param percentage number
function CCheatBindings.DamageSelectedObjects(self, percentage ) end
---Heals all currently selected gameobjects by the given percent
---@param self rdgs.CCheatBindings
---@param percentage number
function CCheatBindings.HealSelectedObjects(self, percentage ) end
---Sets if the selected gameobjects are invincible (attackable, but doesn\'t take damage)
---@param self rdgs.CCheatBindings
---@param value boolean
function CCheatBindings.SetSelectedObjectsInvincible(self, value ) end
---Destroys all currently selected gameobjects
---@param self rdgs.CCheatBindings
function CCheatBindings.DestroySelectedObjects(self) end
---Spawns a list of predefined troops or ships at current mouse position for the current player
---@param self rdgs.CCheatBindings
function CCheatBindings.SpawnForces(self) end
---Spawns a gameObject of specified GUID at current Mouse Pick Pos which is owned by the current player
---@param self rdgs.CCheatBindings
---@param guid integer
---@param owner rdgs.ParticipantGUID|nil
---@param spawnAtPickPos boolean
---@param spawnPosition rdmath.Vector3|table|number[]|nil
function CCheatBindings.SpawnGameObject(self, guid , owner , spawnAtPickPos , spawnPosition ) end
---Spawns a gameObject of specified GUID at current Mouse Pick Pos which is owned by the current player
---@param self rdgs.CCheatBindings
---@param guid integer
---@param owner rdgs.ParticipantGUID|nil
---@param spawnAtPickPos boolean
function CCheatBindings.SpawnGameObject(self, guid , owner , spawnAtPickPos ) end
---Spawns a gameObject of specified GUID at current Mouse Pick Pos which is owned by the current player
---@param self rdgs.CCheatBindings
---@param guid integer
---@param owner rdgs.ParticipantGUID|nil
function CCheatBindings.SpawnGameObject(self, guid , owner ) end
---Spawns a gameObject of specified GUID at current Mouse Pick Pos which is owned by the current player
---@param self rdgs.CCheatBindings
---@param guid integer
function CCheatBindings.SpawnGameObject(self, guid ) end
---Enables or disables the resolving of textsources. All texts will show the unresolved textsources
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleTextSourceResolving(self) end
---Shows the given text as on screen notification
---@param self rdgs.CCheatBindings
---@param textGuid rdsdk.TextId
function CCheatBindings.ShowOnScreenText(self, textGuid ) end
---Shows the given explainer popup
---@param self rdgs.CCheatBindings
---@param explainerPopupGUID integer
function CCheatBindings.ShowExplainerPopup(self, explainerPopupGUID ) end
---Shows the given text popup
---@param self rdgs.CCheatBindings
---@param textPopupGUID integer
function CCheatBindings.ShowTextPopup(self, textPopupGUID ) end
---Create a notification based on toolOne Data of the provided GUID
---@param self rdgs.CCheatBindings
---@param notificationGuid integer
function CCheatBindings.ShowNotification(self, notificationGuid ) end
---Plays Audio and triggers Subtitle Text
---@param self rdgs.CCheatBindings
---@param subtitleId rdsdk.TextId
function CCheatBindings.ShowCharacterNotification(self, subtitleId ) end
---Opens the debug info page in a webbrowser
---@param self rdgs.CCheatBindings
function CCheatBindings.OpenDebugInfoPage(self) end
---Shows/Hides the AI debug information
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleAIDebug(self) end
---Shows/Hides the console
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleConsole(self) end
---toggles ScriptConsole
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleScriptConsole(self) end
---Copies the current build version number (e.g. 1.0312) into the clipboard
---@param self rdgs.CCheatBindings
function CCheatBindings.CopyBuildStringToClipboard(self) end
---switches frame capturing on and off
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleFrameCaptureMode(self) end
---Starts or stops cpu profiling using telemetry. 
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleTelemetry(self) end
---Writes a single memory snapshot using the memory visualizer
---@param self rdgs.CCheatBindings
function CCheatBindings.WriteMemorySnapshot(self) end
---Sets the allocation sampling period that is used in the memory visualizer
---@param self rdgs.CCheatBindings
---@param period integer
function CCheatBindings.SetMemorySnapshotSampling(self, period ) end
---write gear performance profiler stream on disk
---@param self rdgs.CCheatBindings
---@param fileName string
function CCheatBindings.StartPerformancefProfileStream(self, fileName ) end
---stop gear performance profiler disk stream
---@param self rdgs.CCheatBindings
function CCheatBindings.StopPerformanceProfileStream(self) end
---Opens the currently selected object in Bob
---@param self rdgs.CCheatBindings
function CCheatBindings.OpenSelectionInBob(self) end
---Opens the currently selected object in Bob2
---@param self rdgs.CCheatBindings
function CCheatBindings.OpenSelectionInBob2(self) end
---@param self rdgs.CCheatBindings
---@param filename string
function CCheatBindings.OpenInBob2(self, filename ) end
---opens the currently selected object in T9
---@param self rdgs.CCheatBindings
function CCheatBindings.OpenSelectionInT9(self) end
---@param self rdgs.CCheatBindings
---@param guid integer
function CCheatBindings.OpenInT9(self, guid ) end
---Opens the currently opened infotip in the infotip tool
---@param self rdgs.CCheatBindings
function CCheatBindings.OpenInfoTip(self) end
---@param self rdgs.CCheatBindings
---@param guid integer
function CCheatBindings.OpenInInfoTip(self, guid ) end
---@param self rdgs.CCheatBindings
---@param filename string
function CCheatBindings.OpenInAnnoEditor(self, filename ) end
---player earns the achievement with the given GUID. Returns true if the achievement was earned succesfully
---@param self rdgs.CCheatBindings
---@param achievementGuid integer
---@return boolean
function CCheatBindings.GainAchievement(self, achievementGuid ) end
---player earns any achievement that was not earned so far
---@param self rdgs.CCheatBindings
function CCheatBindings.GainRandomAchievement(self) end
---Exectures all the actions in the action list of the given asset
---@param self rdgs.CCheatBindings
---@param actionGuid integer
function CCheatBindings.ExecuteActions(self, actionGuid ) end
---start build mode without build costs and unlock check
---@param self rdgs.CCheatBindings
---@param guid integer
function CCheatBindings.StartBuildMode(self, guid ) end
---replace selected object with new guid
---@param self rdgs.CCheatBindings
---@param guid integer
function CCheatBindings.ReplaceSelected(self, guid ) end
---shows or hides the version label scene
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleVersionLabel(self) end
---shows or hides the playground scene
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleUiPlayground(self) end
---shows or hides the build informations
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleBuildInformation(self) end
---shows or hides the scene with the given name
---@param self rdgs.CCheatBindings
---@param stateName string
function CCheatBindings.ToggleStateVisibility(self, stateName ) end
---starts or stops any updates for the given scene
---@param self rdgs.CCheatBindings
---@param stateName string
function CCheatBindings.ToggleStateUpdates(self, stateName ) end
---enters or leaves the ui debug mode
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleDebugUI(self) end
---toggles between FPS view and standard game camera (in debug builds only)
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleFpsView(self) end
---toggles the highlight for any dynamic button prompt (gamepad only)
---@param self rdgs.CCheatBindings
function CCheatBindings.ToggleHighlightDynamicButtonPrompts(self) end
---enforces an immediate reload of the whole UI
---@param self rdgs.CCheatBindings
function CCheatBindings.ReloadUI(self) end
---tries to find a textfield under the mouse cursor and copies the text into the clipboard
---@param self rdgs.CCheatBindings
function CCheatBindings.CopyTextUnderMouse(self) end
---use this to show (or hide) all collectables in a level
---@param self rdgs.CCheatBindings
---@param show boolean
function CCheatBindings.ShowAllCollectables(self, show ) end
---Enforces a new wind direction
---@param self rdgs.CCheatBindings
---@param newDir number
---@param keepForTenMinutes boolean
function CCheatBindings.SetWindDirection(self, newDir , keepForTenMinutes ) end
---Enforces a new wind direction
---@param self rdgs.CCheatBindings
---@param newDir number
function CCheatBindings.SetWindDirection(self, newDir ) end
---@param self rdgs.CCheatBindings
---@param guid integer
function CCheatBindings.UnloadSession(self, guid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CCheatBindings.isValid() end

return CCheatBindings
