---@meta rdgs.CScriptBindings
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CScriptBindings
---@field CurrentSelection rdgs.CGameObject[]		returns a list of current selected game objects
---@field HasNeverBeenEnteredByLocalPeer boolean		Checks whether the given session has never been entered (i.e. to play intro)
---@field IsUIStartUpPastSceneCreation boolean		return if the UI scenes startup is past the point where the scenes get created
---@field HasRunningGame boolean		returns true if there is a loaded metagame
---@field CameraFOV number		access the fov of the current camera control
---@field FarClipDist number		access the far clip plane distance of the current camera control
--- 
---@field OnEvery10s rdgs.ScriptEvent
local CScriptBindings = {}
Scripts = CScriptBindings
---example using id ref
---@param self rdgs.CScriptBindings
---@param p1 string
---@param p2 integer
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CScriptBindings.LongLastingAction(self, p1 , p2 ) end
---@param self rdgs.CScriptBindings
---@param id integer
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CScriptBindings.LongLastingAction(self, id ) end
---@param self rdgs.CScriptBindings
---@param id integer
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CScriptBindings.LongLastingAction(self, id ) end
---example using object state, no return
---@param self rdgs.CScriptBindings
---@param milisec integer
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CScriptBindings.WaitFor(self, milisec ) end
---@param self rdgs.CScriptBindings
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CScriptBindings.WaitFor(self) end
---tries to force-crash the game via different methods
---@param self rdgs.CScriptBindings
---@param mode integer
function CScriptBindings.Crash(self, mode ) end
---Adds/Removes RenderEngine Enable flags
---@param self rdgs.CScriptBindings
---@param flags integer
---@param enable boolean
function CScriptBindings.SetRenderEnableFlag(self, flags , enable ) end
---returns a game object identified by it\'s object id
---@param self rdgs.CScriptBindings
---@param oid rdgs.GameObjectID
---@return rdgs.CGameObject
function CScriptBindings.GetObject(self, oid ) end
---returns a game object identified by it\'s object id
---@param self rdgs.CScriptBindings
---@param objectID string
---@return rdgs.CGameObject
function CScriptBindings.GetObjectByID(self, objectID ) end
---tries to find a named object and returns it, if found. Otherwise returns null
---@param self rdgs.CScriptBindings
---@param objectLabel string
---@return rdgs.CGameObject
function CScriptBindings.GetObjectByLabel(self, objectLabel ) end
---returns all objects, that have the property assetProperty
---@param self rdgs.CScriptBindings
---@param assetDataType integer
---@param ownerGuid integer
---@return rdgs.CGameObject[]
function CScriptBindings.GetObjectGroupByProperty(self, assetDataType , ownerGuid ) end
---returns all objects, that have the property assetProperty
---@param self rdgs.CScriptBindings
---@param assetDataType integer
---@return rdgs.CGameObject[]
function CScriptBindings.GetObjectGroupByProperty(self, assetDataType ) end
---returns all objects, that have the guid
---@param self rdgs.CScriptBindings
---@param assetGUID integer
---@param owner rdgs.ParticipantGUID
---@return rdgs.CGameObject[]
function CScriptBindings.GetObjectGroupByGUID(self, assetGUID , owner ) end
---returns all objects, that have the guid
---@param self rdgs.CScriptBindings
---@param assetGUID integer
---@return rdgs.CGameObject[]
function CScriptBindings.GetObjectGroupByGUID(self, assetGUID ) end
---get object group by name. returns a list of all containing game objects.
---@param self rdgs.CScriptBindings
---@param name string
---@return rdgs.CGameObject[]
function CScriptBindings.GetObjectGroupByName(self, name ) end
---returns that most of the loading is done except InitAfterSerialize\nwhich needs to be done on all peers at the same time. It is also checked with all other peers.
---@param self rdgs.CScriptBindings
---@param sessionGuid integer
---@return boolean
function CScriptBindings.IsSessionLoadingDone(self, sessionGuid ) end
---start build mode
---@param self rdgs.CScriptBindings
---@param guid integer
function CScriptBindings.StartBuild(self, guid ) end
---starts the buildmode for a module of the currently selected building
---@param self rdgs.CScriptBindings
function CScriptBindings.StartBuildModule(self) end
---Changes the rotation of the buildmode if available or of the selected building
---@param self rdgs.CScriptBindings
---@param dir rdsdk.RotateDirection
function CScriptBindings.ChangeDirection(self, dir ) end
---Changes the variation of the buildmode if available or of the selected building
---@param self rdgs.CScriptBindings
---@param dir rdsdk.IterateDirection
function CScriptBindings.ChangeVariation(self, dir ) end
---Increases the current gametime by the given amount. Daytime is normalized here (0-1)
---@param self rdgs.CScriptBindings
---@param value number
function CScriptBindings.IncreaseTimeOfDay(self, value ) end
---@param self rdgs.CScriptBindings
---@param sequenceId integer
---@param label string
function CScriptBindings.StartFeedbackSequence(self, sequenceId , label ) end
---stops a eventually running camera sequence immediately
---@param self rdgs.CScriptBindings
function CScriptBindings.StopCameraSequence(self) end
---Hides the UI and starts the recording for a camera sequence
---@param self rdgs.CScriptBindings
---@param sequenceID integer
function CScriptBindings.RecordCameraSequence(self, sequenceID ) end
---adds a camera fx with given parameter to camera manager
---@param self rdgs.CScriptBindings
---@param freq number
---@param amp number
---@param duration number
function CScriptBindings.StartCameraShake(self, freq , amp , duration ) end
---toggles the rotation of the camera around its current LookAt position on the X/Z plane
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleRotatingCameraView(self) end
---toggles between post card view and standard game camera
---@param self rdgs.CScriptBindings
function CScriptBindings.TogglePostcardView(self) end
---toggles PhotoMode
---@param self rdgs.CScriptBindings
function CScriptBindings.TogglePhotoMode(self) end
---toggles ScriptConsole
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleScriptConsole(self) end
---toggles between resident view and standard game camera
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleResidentView(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleUI(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.PopUI(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleMetaUI(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleBuildmenu(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleShipList(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleTraderouteMenu(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleTechTreeMenu(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleDiplomacyMenu(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.TogglePrestigeMenu(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.ToggleReligionMenu(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.OpenStatisticsProductionMenu(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.OpenStatisticsGovernanceMenu(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.OpenDemoIntro(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.OpenPressDemoOutro(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.TogglePauseMenu(self) end
---@param self rdgs.CScriptBindings
function CScriptBindings.ShowTutorialOptionInGameSetup(self) end
---@param self rdgs.CScriptBindings
---@param sessionGuid integer
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CScriptBindings.JumpToSession(self, sessionGuid ) end
---@param self rdgs.CScriptBindings
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CScriptBindings.JumpToSession(self) end
---select next object of player in current session
---@param self rdgs.CScriptBindings
---@param moveCameraToObject boolean
function CScriptBindings.SelectNextObject(self, moveCameraToObject ) end
---select next object of player in all sessions
---@param self rdgs.CScriptBindings
---@param moveCameraToObject boolean
function CScriptBindings.SelectNextObjectInWorld(self, moveCameraToObject ) end
---center camera on selected object
---@param self rdgs.CScriptBindings
function CScriptBindings.JumpToSelection(self) end
---@param self rdgs.CScriptBindings
---@param objectID rdgs.GameObjectID
function CScriptBindings.JumpToObject(self, objectID ) end
---@param self rdgs.CScriptBindings
---@param effectType integer
function CScriptBindings.ForceWeather(self, effectType ) end
---used the anyLuaValue as callback (needs to be callable), which will be called for each lerp update until finished.
---@param self rdgs.CScriptBindings
---@param anyLuaValue table
---@param from number
---@param to number
---@param duration number
---@param easeFunc rdsdk.EasingType
function CScriptBindings.CreateLerpFX(self, anyLuaValue , from , to , duration , easeFunc ) end
---used the anyLuaValue as callback (needs to be callable), which will be called for each lerp update until finished.
---@param self rdgs.CScriptBindings
---@param anyLuaValue table
---@param from number
---@param to number
---@param duration number
function CScriptBindings.CreateLerpFX(self, anyLuaValue , from , to , duration ) end
---@return boolean returns true if weak pointer holds a valid reference
function CScriptBindings.isValid() end

return CScriptBindings
