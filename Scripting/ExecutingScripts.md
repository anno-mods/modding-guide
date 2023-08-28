# Commands

There are some entry points where you can directly run lua Commands. GlobalGUIBalancing (2001271) defines keybinds that invoke lua functions, so why shouldn't we? Here is a command to reload all mods. 

```XML

<ModOp Type="add" GUID='2001271' Path="/Values/GUIConfig/KeyBindings">
    <Item>
        <KeyTypes>Shift;F3</KeyTypes>
        <Command>mods.reload()</Command>
        <Active>Session;WorldMap</Active>
        <AvailableOnPlatforms>PC</AvailableOnPlatforms>
    </Item>
</ModOp>
```

# ActionExecuteScript 

More important and versatile, The GameEvent Pipeline has an Action to run a lua script:

```XML
<Item>
    <Action>
        <Template>ActionExecuteScript</Template>
        <Values>
            <Action />
            <ActionExecuteScript>
                <ScriptFileName>data/script/myscript.lua</ScriptFileName>
            </ActionExecuteScript>
        </Values>
    </Action>
</Item>
```

You use this just like any other action in any place where you can add them. At the end, you find a practical example how the AI shipyard uses lua scripting. 

> A script is executed for all players through ActionExecuteScript. 

# Executing a Script on Game Start

Honestly, this topic is quite a pain as you cannot really do this (Ubisoft, please fix your fucking MetagameLoaded Event)

A common workaround I use is to execute a script on each SessionEnter using ConditionEvent. That way, you lose the saved state of your table because you reinitalize it, but you should not use state to begin with (More on that in the preserving state tutorial).

So, here is my default trigger setup for this: 

```XML
<Asset>
	<Template>Trigger</Template>
	<Values>
		<Standard>
			<GUID>2001000000</GUID>
			<Name>Trigger Reinitialize Script</Name>
		</Standard>
		<Trigger>
			<TriggerCondition>
				<Template>ConditionEvent</Template>
				<Values>
					<Condition />
					<ConditionEvent>
						<ConditionEvent>SessionEnter</ConditionEvent>
					</ConditionEvent>
				</Values>
			</TriggerCondition>
			<TriggerActions>
				<Item>
					<TriggerAction>
						<Template>ActionExecuteScript</Template>
						<Values>
							<Action />
							<ActionExecuteScript>
								<ScriptFileName>data/scripts/my_script.lua</ScriptFileName>
							</ActionExecuteScript>
						</Values>
					</TriggerAction>
				</Item>
				<Item>
					<TriggerAction>
						<Template>ActionResetTrigger</Template>
						<Values>
							<Action />
							<ActionResetTrigger />
						</Values>
					</TriggerAction>
				</Item>
			</TriggerActions>
		</Trigger>
		<TriggerSetup />
	</Values>
</Asset>
```

my_script.lua is essentially just a library of functions that I need to execute later on. Because the script is entirely stateless, I don't really give a damn about the reinitialization - All I care about is that the functions are there when I need them. 

# Practical Example: AI Shipyard

Because you only get so far with theory, in this code walkthrough, I am gonna break down the scripting part of the AI shipyard mod, (Credits: originally written by kskudlik, I just maintained it after that)

## Scripts

```lua 
-- ai_shipyard.lua (Library of functions, stripped down for readability)

local Participants = {
	"jorgensen"
    -- ... and many more
}

local ParticipantID = {
	["jorgensen"] = 25
    -- ... and many more
}

local DenyQuest = {
	["AlreadyIngame"] = 930500,
	["tooManyAIs"] = 930501
}

local AcceptQuest = {
	["jorgensen"] = 930251
    -- .. and many more
}

local IsValidParticipant -- Is the Participant entered valid? 
local IsDefined -- Is the Participant already ingame? 
local TooManyParticipants -- Have we reached the participant limit yet?

-- Accepts a Participant
local function Accept(ParticipantName)
	ts.SessionParticipants.SetCheatCreateSessionParticipant(ParticipantID[ParticipantName])
	ts.Quests.StartQuestForCurrentPlayerNet(AcceptQuest[ParticipantName])
end

-- Initiates Spawn of a participant and accepts or denies them.
local function Spawn(ParticipantName)
	if not IsValidParticipant(ParticipantName) then
		return
	end

	if IsDefined(ParticipantName) then
		ts.Quests.StartQuestForCurrentPlayerNet(DenyQuest["AlreadyIngame"])
	elseif TooManyParticipants() then
		ts.Quests.StartQuestForCurrentPlayerNet(DenyQuest["tooManyAIs"])
	else
		Accept(ParticipantName)
	end
end

AISpawner = {
	SpawnParticipant = Spawn,
}
```

```lua 
-- data/scripts/bente.lua
-- Wrapper Script around the spawn command for bente jorgensen.
AISpawner.SpawnParticipant("jorgensen")
```

## Listening to Ship Built event

```XML
<!-- assets.xml -->
<ModOp GUID="130216" Type="addNextSibling">
	<Asset>
		<Template>Trigger</Template>
		<Values>
			<Standard>
				<GUID>930101</GUID>
				<Name>Built: Bente Jorgensen</Name>
				<IconFilename />
			</Standard>
			<Trigger>
				<TriggerCondition>
					<!-- the Trigger listens to Bente's Flagship being built -->
					<Template>ConditionEvent</Template>
					<Values>
						<Condition />
						<ConditionEvent>
							<ConditionEvent>ObjectBuilt</ConditionEvent>
							<ContextAsset>930001</ContextAsset>
						</ConditionEvent>
						<ConditionPropsNegatable />
					</Values>
				</TriggerCondition>
				<TriggerActions>
					<!-- ActionExecuteScript runs the wrapper script -->
					<Item>
						<TriggerAction>
							<Template>ActionExecuteScript</Template>
							<Values>
								<Action />
								<ActionExecuteScript>
									<ScriptFileName>data/scripts/bente.lua</ScriptFileName>
								</ActionExecuteScript>
							</Values>
						</TriggerAction>
					</Item>
					<Item>
						<TriggerAction>
							<Template>ActionResetTrigger</Template>
							<Values>
								<Action />
								<ActionResetTrigger />
							</Values>
						</TriggerAction>
					</Item>
				</TriggerActions>
			</Trigger>
			<TriggerSetup />
		</Values>
	</Asset>
</ModOp>
```

## Success 

When Bente passed all conditions and successfully spawned, the script calls `Accept("jorgensen")` and
- adds Bente as a new Session Participant 
- starts the Accept Quest that you see below. 

```XML
<!-- assets.xml -->
<ModOp GUID="152280" Type="addNextSibling">
	<Asset>
		<BaseAssetGUID>930250</BaseAssetGUID>
		<Values>
			<Standard>
				<GUID>930251</GUID>
				<Name>Accept Second_ai_01 (Bente Jorgensen)</Name>
			</Standard>
			<Quest>
				<OnQuestStart>
					<Values>
						<ActionList>
							<Actions>
								<!-- Adds Construction Material to Bentes Ship -->
								<Item>
									<Action>
										<Template>ActionAddGoodsToItemContainer</Template>
										<Values>
											<Action />
											<ActionAddGoodsToItemContainer>
												<Goods>
													<Item>
														<Good>1010196</Good>
														<Amount>50</Amount>
													</Item>
													<Item>
														<Good>1010218</Good>
														<Amount>50</Amount>
													</Item>
												</Goods>
												<ItemContainerObjects>
													<Values>
														<ObjectFilter>
															<ObjectGUID>930001</ObjectGUID>
														</ObjectFilter>
													</Values>
												</ItemContainerObjects>
											</ActionAddGoodsToItemContainer>
										</Values>
									</Action>
								</Item>
								<!-- Hands the Ship over to Bente, who is now created. Otherwise, this would not
								work. -->
								<Item>
									<Action>
										<Template>ActionChangeParticipant</Template>
										<Values>
											<Action />
											<ActionChangeParticipant>
												<NewParticipantID>Second_ai_01_Jorgensen</NewParticipantID>
											</ActionChangeParticipant>
											<ObjectFilter>
												<ObjectGUID>930001</ObjectGUID>
											</ObjectFilter>
										</Values>
									</Action>
								</Item>
								<!-- Converts Bente Jorgensens "Special Flagship" into a default Flagship -->
								<Item>
									<Action>
										<Template>ActionSetObjectGUID</Template>
										<Values>
											<Action />
											<ActionSetObjectGUID>
												<NewGUID>101121</NewGUID>
											</ActionSetObjectGUID>
											<ObjectFilter>
												<ObjectGUID>930001</ObjectGUID>
											</ObjectFilter>
										</Values>
									</Action>
								</Item>
							</Actions>
						</ActionList>
					</Values>
				</OnQuestStart>
			</Quest>
		</Values>
	</Asset>
</ModOp>
```

> As you may have spotted, not everything is lua scripted. In general, it is a safer, faster, easier and no-more-headaches way to just use the GameEvents pipeline whenever you can. However, in some cases the API does things the GameEvents pipeline simply cannot. Also, complex control flows can be a nightmare using GameEvents. In these cases, you should write a script. 
