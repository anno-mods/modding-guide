---@meta rdgs.CAutomatedTestManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAutomatedTestManager
---@field Player rdgs.CAutomatedTestPlayer		Get the player instance, which is responsible for playback of recorded replays
---@field Recorder rdgs.CAutomatedTestRecorder		Get the recorder instance, which is responsible for recording of replays
---@field IsDTestActive boolean		true if DTestAgent is enabled and initialized
---@field AgentIndex integer		index assigned by the DTest agency to identify this client in network test
---@field TotalAgentCount integer		returns amount of agents in the current test session
---@field Platform string		returns platform of the test system
---@field Config string		returns config of the test
---@field Profile string		returns profile defined in DTest
---@field AccumulatedPauseTime rdtime		returns the total time the game was paused
---@field IsConnected boolean		
local CAutomatedTestManager = {}
AutomatedTest = CAutomatedTestManager
---@param self rdgs.CAutomatedTestManager
---@param positionWorld rdmath.Vector3|table|number[]
---@return integer
function CAutomatedTestManager.GetObjectGuidAtPosition(self, positionWorld ) end
---@param self rdgs.CAutomatedTestManager
---@param positionWorld rdmath.Vector3|table|number[]
---@return rdgs.CGameObject
function CAutomatedTestManager.GetObjectAtPosition(self, positionWorld ) end
---Finishes the replay and cleans up afterwards
---@param self rdgs.CAutomatedTestManager
---@param wasReplaySuccessful boolean
function CAutomatedTestManager.FinishReplay(self, wasReplaySuccessful ) end
---activates the recording of user interactions which can be used as code snippet
---@param self rdgs.CAutomatedTestManager
function CAutomatedTestManager.StartSnippetRecording(self) end
---ends the recording of user interactions. If copyToClipboard is true, you can share it with all applications that have access to the clipboard
---@param self rdgs.CAutomatedTestManager
function CAutomatedTestManager.StopSnippetRecording(self) end
---change the input device that is used (mouse/keyboard or gamepad)
---@param self rdgs.CAutomatedTestManager
---@param newTypeIsGamepadMode boolean
function CAutomatedTestManager.ChangeDeviceType(self, newTypeIsGamepadMode ) end
---tiny little helper to start the build mode
---@param self rdgs.CAutomatedTestManager
---@param buildingGuid integer
function CAutomatedTestManager.StartBuildMode(self, buildingGuid ) end
---helper to find objects by position (TODO: shouldn\'t this be a function of a gameobject related manager?)
---@param self rdgs.CAutomatedTestManager
---@param worldPosition rdmath.Vector3|table|number[]
---@return rdgs.GameObjectID
function CAutomatedTestManager.GetObjectIDByPosition(self, worldPosition ) end
---Sends gamepad events to the UI to be executed there
---@param self rdgs.CAutomatedTestManager
---@param actionTypesIDs integer[]
---@param buttonConditionIndices integer[]
function CAutomatedTestManager.SendFakeGamepadEvents(self, actionTypesIDs , buttonConditionIndices ) end
---Helper method to simulate pressed control keys
---@param self rdgs.CAutomatedTestManager
---@param keys integer[]
function CAutomatedTestManager.FakePressedKeys(self, keys ) end
---creates a multiplayer lobby and provides the session descriptor as result.
---@param self rdgs.CAutomatedTestManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CAutomatedTestManager.CreateMultiplayerSession(self) end
---@param self rdgs.CAutomatedTestManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CAutomatedTestManager.CreateMultiplayerSession(self) end
---@param self rdgs.CAutomatedTestManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CAutomatedTestManager.CreateMultiplayerSession(self) end
---@param self rdgs.CAutomatedTestManager
---@param sourceFile std.filesystem.path
---@param optSubFolder std.filesystem.path|nil
function CAutomatedTestManager.CopyFileToArtifacts(self, sourceFile , optSubFolder ) end
---@param self rdgs.CAutomatedTestManager
---@param partyID string
---@return boolean
function CAutomatedTestManager.JoinSession(self, partyID ) end
---@param self rdgs.CAutomatedTestManager
---@param eventId string
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CAutomatedTestManager.Event(self, eventId ) end
---@param self rdgs.CAutomatedTestManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CAutomatedTestManager.Event(self) end
---@param self rdgs.CAutomatedTestManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CAutomatedTestManager.Event(self) end
---@param self rdgs.CAutomatedTestManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CAutomatedTestManager.AnyEvent(self) end
---@param self rdgs.CAutomatedTestManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CAutomatedTestManager.AnyEvent(self) end
---@param self rdgs.CAutomatedTestManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CAutomatedTestManager.AnyEvent(self) end
---@param self rdgs.CAutomatedTestManager
---@param eventId string
---@param payload string
function CAutomatedTestManager.BroadcastEvent(self, eventId , payload ) end
---@param self rdgs.CAutomatedTestManager
---@param agentIndex integer
---@param eventId string
---@param payload string
function CAutomatedTestManager.UnicastEvent(self, agentIndex , eventId , payload ) end
---@param self rdgs.CAutomatedTestManager
---@param agentIndex integer
---@return integer
function CAutomatedTestManager.ConvertAgentIdxToProfileGUID(self, agentIndex ) end
---@param self rdgs.CAutomatedTestManager
---@param description string
---@param file string
---@param line integer
function CAutomatedTestManager.AssertionSucceeded(self, description , file , line ) end
---@param self rdgs.CAutomatedTestManager
---@param header string
---@param description string
---@param category string
---@param file string
---@param line integer
function CAutomatedTestManager.AssertionFailed(self, header , description , category , file , line ) end
---@param self rdgs.CAutomatedTestManager
function CAutomatedTestManager.StartScriptOnRemotes(self) end
---Creates a screenshot and saves it at predefined location\ncan be used multiple times during a test run
---@param self rdgs.CAutomatedTestManager
function CAutomatedTestManager.TakeScreenshot(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CAutomatedTestManager.isValid() end

return CAutomatedTestManager
