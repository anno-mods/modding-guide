local TestHelper = {}

local Session = require("sessions")
local SpecialGUIDs = require("specialguids")

-- some helpers for using DTest
TestHelper.Agent0 = 0
TestHelper.Agent1 = 1
TestHelper.Agent2 = 2
TestHelper.Agent3 = 3

---@class TestHelper.MapOptions
---@field savegame? string name of the savegame to be loaded
---@field profile? table name of the savegame to be loaded
---@field sessionGUID? integer name of the savegame to be loaded
---@field preserveSlots? boolean name of the savegame to be loaded
---@field difficulty? table name of the savegame to be loaded
---@field seed? integer name of the savegame to be loaded
---@field secondParties? table of second party guids
TestHelper.MapOptions = {}

---starts a new game with the configuration given in the table param
---@param mapOptions TestHelper.MapOptions 
--- needs some options to be able to start a game by
--- using a savegame:
---  - savegame: if a savegame should be loaded, just provide the savegame file name
---  - sessionGUID: a guid that identifies a T9 asset with a Session-Property (require sessions)
---  - seed: if given, this will seed the random generator, to make subsequent runs deterministic
---  - difficulty: table with overrides of difficulty settings
---  - secondParties: participantGUIDs that should be added
---@private
function TestHelper.startNewGame(mapOptions)
    if type(mapOptions) == "table" then

        local sessionGUID = Session.Invalid

        if mapOptions.savegame then
            if not mapOptions.profile or not mapOptions.profile.name then
                error("profile name missing")
            end
            print("prepare to load save game")
            GameSetup:LoadSavegame(mapOptions.profile.name, mapOptions.savegame)
        else
            print("Started new game: " .. flatten(mapOptions))
            sessionGUID = mapOptions.sessionGUID or Session.Europe_Session
            local SinglePlayerSandboxGameSetup = SpecialGUIDs.SinglePlayerSandbox
            local preserveSlots = mapOptions.preserveSlots or false
            GameSetup:LoadGameSetup(SinglePlayerSandboxGameSetup, preserveSlots)

            GameSetup.CurrentGameSetup:ResetSecondParties()
            GameSetup.CurrentGameSetup:ResetDifficultyPreset(SpecialGUIDs.DebugDifficulty)

            GameSetup:ScriptOverrideMaps(sessionGUID)
                        
            if mapOptions.secondParties then
                for i = 1, #mapOptions.secondParties do
                    local setupSlot = GameSetup.CurrentGameSetup:GetSetupSlot(datasets.MPSlot.Slot1 + i)
                    setupSlot:SetSecondParty(mapOptions.secondParties[i]);
                end
            end

            if mapOptions.difficulty then
                for category,value in pairs(mapOptions.difficulty) do
                    GameSetup.CurrentGameSetup:SetDifficultyCategoryValue(category, value)
                end
            end
         
            if mapOptions.seed then
                GameSetup.CurrentGameSetup.GameSeed = mapOptions.seed
            end

            local defaultProfile = {
                name = "Test Run",
                color = SpecialGUIDs.PARTICIPANT_DEFAULT_COLOR_01,
                portraitGUID = SpecialGUIDs.TestPortrait,
                logoGUID = SpecialGUIDs.TestLogo
            }
            for k,v in pairs(mapOptions.profile or {}) do
                defaultProfile[k] = v
            end
            GameSetup:SetProfileCreationData(defaultProfile.name, defaultProfile.color, defaultProfile.portraitGUID, defaultProfile.logoGUID)
        end

        GameSetup:InitExternalGameStartConfig()

        if TestHelper.getTotalAgentCount() == 1 then
            assert(GameSetup:InitStartGame(), "Was not able to start game")
            Game:EnterCorrectLoadingScene(sessionGUID)
        end
    else
        TestHelper.fail("Cannot start game - options table missing")
    end
end

---wraps startNewGame with some waits to await the end of loading and the meta tick as final timing
---@param mapOptions TestHelper.MapOptions
function TestHelper.startNewGameBlocking(mapOptions)
    system.waitUILoaded()
    if TestHelper.getAgentIndex() == 0 then
        TestHelper.startNewGame(mapOptions) --only one peer should start the game
    end
    await(events.OnSessionEnter)
end

---wraps game.Save with waiting to make it synchronous
---@param name string name of the savegame to create
---@param canOverride boolean if true, existing savegames with that name will be overridden
---@return boolean true if savegame has been created
function TestHelper.saveGameBlocking(name, canOverride)
    local success, filename = await(Game:Save(name, canOverride))
    if success then
        print("!!! Received end of saving name " .. tostring(filename) .. "\n")
        return true
    else
        print("!!! Failed saving name " .. tostring(name) .. "\n")
    end
    return false
end

---Connects with multiple clients using DTest or uses existing connection (if started with /multiclient)
---and waits for a map to load on all clients.
---The client count is either defined by DTest (getTotalAgentCount) or by the command line parameter /multiclient x
---@param mapOptions table
function TestHelper.startNewMPGameBlocking(mapOptions)
    
    local agent = TestHelper.getAgentIndex()
    print(f"Agent {agent} waits for main menu...")
    system.waitUILoaded()

    print("Configure game setup...")
    if not TestHelper.isDTestActive() then
        mapOptions.preserveSlots = true
    end
    TestHelper.startNewGame(mapOptions) -- create GameSetup before creating session!

    print("Waiting for connection...")
    system.waitPP(3000)  -- online preconditions may take a while - just wait. Will be fixed in future
    TestHelper.waitForConnection() --waits until all clients are connected to the lobby
    print("Connection established")

    system.waitPP(5000)  -- wait for lobby ui
    TestHelper.takeScreenshot()
    system.waitPP(1000)  -- wait for screenshot

    if agent == 0 then
        if not TestHelper.isDTestActive() then
            print("non-DTest mode: start test script on all clients")
            AutomatedTest:StartScriptOnRemotes() --all clients will now start the same test script, if DTest is not controlling
        end
        print("Host starts loading session...")
        Online:LoadMPSession()
    end

    print("Wait until session entered...")
    await(events.OnSessionEnter)

    print("startNewMPGameBlocking finished.")
end

---Creates a screenshot in the folder assigned to the test. Multiple screenshots will be
---names differently.
function TestHelper.takeScreenshot()
    AutomatedTest:TakeScreenshot()
end

---If test is started in DTest env, this method returns true
---@return boolean
function TestHelper.isDTestActive()
    return AutomatedTest.IsDTestActive
end

---If in multiplayer test, this will return the agent index. In single player this will be always 0
---@return integer index of this agent
function TestHelper.getAgentIndex()
    return AutomatedTest.AgentIndex
end

---If in multiplayer test, this will return the planned / configured amount of agents for this test
---@return integer count of agents
function TestHelper.getTotalAgentCount()
    return AutomatedTest.TotalAgentCount
end

---get the current platform name as specified in the DTEST project
---@return string platform
function TestHelper.getPlatform()
    return AutomatedTest.Platform
end

---get the current config name as specified in the DTEST project
function TestHelper.getConfig()
    return AutomatedTest.Config
end

---get the current profile used to run the test
function TestHelper.getProfile()
    return AutomatedTest.Profile
end

---helper function to trigger cheats
---@param cheatName string name of the cheat
---@param ifCountIsEven boolean cheat is only triggered if cheat count is even
function TestHelper.TriggerCheat(cheatName, ifCountIsEven)
    if ifCountIsEven and Cheat:GetCheatCount(cheatName) % 2 ~= 0 then
        return
    end
    Cheat:TriggerCheatByName(cheatName)
end

---blocks until all clients have been connected. How many client that need to be depends on the method you are connecting:
--- - by using /autoconnect or /multiclient cli params, this is a fixed number in commandline params
--- - by manually joining some clients into a lobby, this will be at least 2
--- - by using DTest (multi client test), this is a fixed number in DTest config
function TestHelper.waitForConnection()
    if not AutomatedTest.IsConnected then
        local sessionDescriptorEvent = "Test=session=descriptor"

        if AutomatedTest.AgentIndex == 0 then
            local success, sessionDescriptor = await(AutomatedTest:CreateMultiplayerSession())
            if success and (not sessionDescriptor or sessionDescriptor == '') then
                error("Returned session descriptor not valid.")
            end
            TestHelper.broadcastEvent(sessionDescriptorEvent, sessionDescriptor)
        elseif AutomatedTest.AgentIndex > 0 then
            local sessionDescriptor = TestHelper.waitForEvent(sessionDescriptorEvent)
            if sessionDescriptor and sessionDescriptor ~= '' then
                print("joining session " .. sessionDescriptor)
                AutomatedTest:JoinSession(sessionDescriptor or "")
            end
        else
            error("invalid agent index returned")
        end
    end

    while not AutomatedTest.IsConnected do
        system.waitPP(100)
    end
end

---Wait for a specific event
---@param eventId string The event identifier to wait for
---@return string? payload the payload carried by this event
function TestHelper.waitForEvent(eventId)
    local success, payload = await(AutomatedTest:Event(eventId))
    if success then
        TestHelper.expect_true(true, "Received event " .. eventId .. ": " .. payload)
    else
        TestHelper.expect_true(false, "Failure while waiting for event " .. eventId)
    end
    return payload
end

---Wait for any event
---@return string? eventId id of the event that was received
---@return string? payload the payload carried by this event
function TestHelper.waitForAnyEvent()
    local success, eventId, payload = await(AutomatedTest:Event())
    if success then
        TestHelper.expect_true(true, "Received event " .. eventId .. ": " .. payload)
    else
        TestHelper.expect_true(false, "Failure while waiting for any event")
    end
    return eventId, payload
end

---Sends an event to all agents within the test
---@param eventId string The event type to send
---@param payload? string Optional custom data to send with the event
function TestHelper.broadcastEvent(eventId, payload)
    AutomatedTest:BroadcastEvent(eventId, payload or "")
end

---Send an event to the specified agent within the test
---@param agentIndex integer The destination agent index to send to event to
---@param eventId string The event type to send
---@param payload? string Optional custom data to send with the event
function TestHelper.unicastEvent(agentIndex, eventId, payload)
    AutomatedTest:UnicastEvent(agentIndex, eventId, payload or "")
end

---Converts the agent index into a ProfileGUID used by the game to identify players
---@param agentIndex integer agent to address
---@return integer profileGUID identifier of player
function TestHelper.agentToProfileGUID(agentIndex)
    return AutomatedTest:ConvertAgentIdxToProfileGUID(agentIndex)
end

---MUST be called at the end of a test case to report it's end to DTest
function TestHelper.done()
    if TestHelper.getTotalAgentCount() > 1 then
        local clientFinishedEvent = "Test=agent=has=finshed"
        local hostFinishedEvent = "Test=host=has=finshed"
        if TestHelper.getAgentIndex() == TestHelper.Agent0 then
            TestHelper.broadcastEvent(hostFinishedEvent)
            for i = 2,TestHelper.getTotalAgentCount() do
                TestHelper.waitForEvent(clientFinishedEvent)
            end
        else
            TestHelper.unicastEvent(TestHelper.Agent0, clientFinishedEvent, tostring(TestHelper.getAgentIndex()))
            TestHelper.waitForEvent(hostFinishedEvent)
        end
    end
    AutomatedTest:FinishReplay(true)
end

function TestHelper.fail(description)
    assert(nil, "Fail: " .. tostring(description))
end

---if test value is not greater than excludedMin it will be reported to DTest with a comment including values and optional description
---@param testValue any current value read from the game to be checked
---@param excludedMin any the excluded minimum - testValue must be greater than this
---@param description? string description will be prefixed to the output, if comparison operator returns false
function TestHelper.expect_gt(testValue, excludedMin, description)
    if (testValue > excludedMin) then
        local file, line = system.extractFileLineFunction(debug.traceback(), 1)
        AutomatedTest:AssertionSucceeded(description or "<no description>", file, line or 0)
    else
        local header = "Value is " .. tostring(testValue) .. ", should be greater than " .. tostring(excludedMin)
        local callstack = debug.traceback()
        local category = "asserted"
        local file, line = system.extractFileLineFunction(callstack, 1)
        AutomatedTest:AssertionFailed(header, (description or "<no description>") .. "\n" .. callstack, category, file, line or 0)
    end
end

---if test value is not greater than and not equal to includedMin it will be reported to DTest with a comment including values and optional description
---@param testValue any current value read from the game to be checked
---@param includedMin any the included minimum - testValue must be greater than this or equal to it
---@param description? string description will be prefixed to the output, if comparison operator returns false
function TestHelper.expect_gte(testValue, includedMin, description)
    if (testValue >= includedMin) then
        local file, line = system.extractFileLineFunction(debug.traceback(), 1)
        AutomatedTest:AssertionSucceeded(description or "<no description>", file, line or 0)
    else
        local header = "Value is " .. tostring(testValue) .. ", should be greater than or equal to " .. tostring(includedMin)
        local callstack = debug.traceback()
        local category = "asserted"
        local file, line = system.extractFileLineFunction(callstack, 1)
        AutomatedTest:AssertionFailed(header, (description or "<no description>") .. "\n" .. callstack, category, file, line or 0)
    end
end

---if the given values are not equal it will be reported to DTest with a comment including values and optional description
---@param testValue any current value read from the game to be checked
---@param expectedValue any the value that is expected
---@param description? string description will be prefixed to the output, if comparison operator returns false
function TestHelper.expect_eq(testValue, expectedValue, description)
    if (testValue == expectedValue) then
        local file, line = system.extractFileLineFunction(debug.traceback(), 1)
        AutomatedTest:AssertionSucceeded(description or "<no description>", file, line or 0)
    else
        local header = "Value is " .. tostring(testValue) .. ", must be equal to " .. tostring(expectedValue)
        local callstack = debug.traceback()
        local category = "asserted"
        local file, line = system.extractFileLineFunction(callstack, 1)
        AutomatedTest:AssertionFailed(header, (description or "<no description>") .. "\n" .. callstack, category, file, line or 0)
    end
end

---if the given values are equal it will be reported to DTest with a comment including values and optional description
---@param testValue any current value read from the game to be checked
---@param unequalValue any the value that should not be equal
---@param description? string description will be prefixed to the output, if comparison operator returns false
function TestHelper.expect_neq(testValue, unequalValue, description)
    if (testValue ~= unequalValue) then
        local file, line = system.extractFileLineFunction(debug.traceback(), 1)
        AutomatedTest:AssertionSucceeded(description or "<no description>", file, line or 0)
    else
        local header = "Value is " .. tostring(testValue) .. ", must not be equal to " .. tostring(unequalValue)
        local callstack = debug.traceback()
        local category = "asserted"
        local file, line = system.extractFileLineFunction(callstack, 1)
        AutomatedTest:AssertionFailed(header, (description or "<no description>") .. "\n" .. callstack, category, file, line or 0)
    end
end

---if the given testValue is not less then excludingMax it will be reported to DTest with a comment including values and optional description
---@param testValue any current value read from the game to be checked
---@param excludingMax any the excluded maximum - testValue must be less than this
---@param description? string description will be prefixed to the output, if comparison operator returns false
function TestHelper.expect_lt(testValue, excludingMax, description)
    if (testValue < excludingMax) then
        local file, line = system.extractFileLineFunction(debug.traceback(), 1)
        AutomatedTest:AssertionSucceeded(description or "<no description>", file, line or 0)
    else
        local header = "Value is " .. tostring(testValue) .. ", must be lesser than " .. tostring(excludingMax)
        local callstack = debug.traceback()
        local category = "asserted"
        local file, line = system.extractFileLineFunction(callstack, 1)
        AutomatedTest:AssertionFailed(header, (description or "<no description>") .. "\n" .. callstack, category, file, line or 0)
    end
end

---if the given testValue is not less than and not equal to includingMax it will be reported to DTest with a comment including values and optional description
---@param testValue any current value read from the game to be checked
---@param includingMax any the included maximum - testValue must be less than this or equal to it
---@param description? string description will be prefixed to the output, if comparison operator returns false
function TestHelper.expect_lte(testValue, includingMax, description)
    if (testValue <= includingMax) then
        local file, line = system.extractFileLineFunction(debug.traceback(), 1)
        AutomatedTest:AssertionSucceeded(description or "<no description>", file, line or 0)
    else
        local header = "Value is " .. tostring(testValue) .. ", must be lesser than or equal to " .. tostring(includingMax)
        local callstack = debug.traceback()
        local category = "asserted"
        local file, line = system.extractFileLineFunction(callstack, 1)
        AutomatedTest:AssertionFailed(header, (description or "<no description>") .. "\n" .. callstack, category, file, line or 0)
    end
end

---if testValue is not true it will be reported to DTest with a comment including values and optional description
---@param testValue boolean triggers reporting if false
---@param description? string description will be shown in DTest output if test fails
function TestHelper.expect_true(testValue, description)
    if (testValue) then
        local file, line = system.extractFileLineFunction(debug.traceback(), 1)
        AutomatedTest:AssertionSucceeded(description or "<no description>", file, line or 0)
    else
        local header = "Expected Value to be true"
        local callstack = debug.traceback()
        local category = "asserted"
        local file, line = system.extractFileLineFunction(callstack, 1)
        AutomatedTest:AssertionFailed(header, (description or "<no description>") .. "\n" .. callstack, category, file, line or 0)
    end
end

---@param testValue boolean triggers reporting if false
---@param description? string description will be shown in DTest output if test fails
function TestHelper.expect_false(testValue, description)
    if (not testValue) then
        local file, line = system.extractFileLineFunction(debug.traceback(), 1)
        AutomatedTest:AssertionSucceeded(description or "<no description>", file, line or 0)
    else
        local header = "Expected Value to be false"
        local callstack = debug.traceback()
        local category = "asserted"
        local file, line = system.extractFileLineFunction(callstack, 1)
        AutomatedTest:AssertionFailed(header, (description or "<no description>") .. "\n" .. callstack, category, file, line or 0)
    end
end

return TestHelper