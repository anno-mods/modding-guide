# WIP Tutorial Quests, written by Serp:

The Anno devs meanwhile finally published an xml file that contains all allowed properties and values with sometimes a short description (next to assets.xml of game files):
[properties-toolone.xml](https://github.com/anno-mods/modding-guide/blob/main/documentation/properties-toolone.xml) (I will call it p-t.xml below as abbreviation).  
You can look up many things there to find out what is supported where and what they do.

# The Quest itself:

TODO AddNextSibling verlinken zu QuestGroup
 

# How to start a Quest:

You can start quests with several different ways. What to use mainly depends on how you want your quests to start and how many you have.  
Simply using `ActionStartQuest` in any Trigger or Quest Actions works fine and may be the easiest solution for a single Quest.  
But when you have multiple Quests that either should be chosen randomly or even a Questline that should start one after the other, it will save alot of work and headaches to use ***QuestPools*** and if you want also ***QuestLines***.

## ActionStartQuest:
### Basic usage:
Open p-t.xml and search for `<Name>ActionStartQuest</Name>` to see valid content of this action and some descriptions.

**Example:**  
(In Triggers it is called `TriggerActions/Item/TriggerAction`, while on some other locations it is `Actions/Item/Action` instead, compare with vanilla if you are unsure what to use)
```xml
  <Item>
    <TriggerAction>
      <Template>ActionStartQuest</Template>
      <Values>
        <Action />
        <ActionStartQuest>
          <Quest>150621</Quest>
          <QuestSession>180023</QuestSession>
        </ActionStartQuest>
      </Values>
    </TriggerAction>
  </Item>
```
This action will start the **Quest 150621 in Old World session 180023**.  
`QuestSession` p-t.xml description:  
> The session where this quest should be started or a region(= list of sessions) where a session is randomly chosen from if the player entered that session already

Hardcoding the session like this is always the easiest way to define the session the quest should start.

***Important Note:***  
Starting a Quest with `ActionStartQuest` does ignore many things Quests can have defined, especially it does ignore the `PreConditionList` of a Quest! If you want to use all features from Quests, you maybe better should use a [QuestPool](https://github.com/anno-mods/modding-guide/blob/main/guides/Quests.md#questpools).


### Advanced Usage:
TODO evlt auch Interhit UseCurrentSession GetQuestSessionFromArea usw eingehen.



## QuestPools:
(Again take a look at p-t.xml and search for `<Name>QuestPool</Name>` (the one that has "DisabledByDefault" directly below it) to see all allowed values and some description)

QuestPools are a helper construct to automatically start quests on regular basis if PreConditions are fullfilled. Eg. if you made like 10 Quests that simply should be chosen randomly if preconditions are fullfilled (just like the games Random Quests) you can put your Quests in a pool and define how often the pool should start up to how many quests at once and so on. It also supports adding QuestLines into the pool instead of Quests directly to make sure they are started one after the other.

#### Example for QuestLine `<GUID>112116</GUID> <Name>STQ_SunkenTreasure_Singleplayer_Pool</Name>`
```xml
<Asset>
  <Template>QuestPool</Template>
  <Values>
    <Standard>
      <GUID>112116</GUID>
      <Name>STQ_SunkenTreasure_Singleplayer_Pool</Name>
    </Standard>
    <QuestPool>
      <Quests>
        <Item>
          <Quest>113430</Quest>
        </Item>
        <Item>
          <Quest>113432</Quest>
        </Item>
      </Quests>
      <IsMainStoryPool>1</IsMainStoryPool>
      <IsTopLevel>1</IsTopLevel>
      <QuestLimit>3</QuestLimit>
      <PoolCooldown>0</PoolCooldown>
      <QuestCooldown>0</QuestCooldown>
      <QuestPoolActionCallbacks>
        <OnQuestStart>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestStart>
        <OnQuestDeclined>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestDeclined>
        <OnQuestActive>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestActive>
        <OnQuestAborted>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestAborted>
        <OnQuestTimedOut>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestTimedOut>
        <OnQuestFailed>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestFailed>
        <OnQuestSucceeded>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestSucceeded>
        <OnQuestEnd>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestEnd>
        <OnQuestDiscarded>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestDiscarded>
      </QuestPoolActionCallbacks>
    </QuestPool>
    <Locked />
    <PreConditionList>
      <Condition>
        <Template>ConditionIsDLCActive</Template>
        <Values>
          <Condition />
          <ConditionIsDLCActive>
            <DLCAssetList>
              <Item>
                <DLCAsset>410040</DLCAsset>
              </Item>
            </DLCAssetList>
          </ConditionIsDLCActive>
          <ConditionPropsNegatable />
        </Values>
      </Condition>
      <SubConditions>
        <Item>
          <SubCondition>
            <Template>PreConditionList</Template>
            <Values>
              <PreConditionList>
                <Condition>
                  <Template>ConditionUnlocked</Template>
                  <Values>
                    <Condition />
                    <ConditionUnlocked>
                      <UnlockNeeded>113818</UnlockNeeded>
                    </ConditionUnlocked>
                    <ConditionPropsNegatable />
                  </Values>
                </Condition>
              </PreConditionList>
            </Values>
          </SubCondition>
        </Item>
        <Item>
          <SubCondition>
            <Template>PreConditionList</Template>
            <Values>
              <PreConditionList>
                <Condition>
                  <Template>ConditionIsMultiplayer</Template>
                  <Values>
                    <Condition />
                    <ConditionIsMultiplayer />
                    <ConditionPropsNegatable>
                      <NegateCondition>1</NegateCondition>
                    </ConditionPropsNegatable>
                  </Values>
                </Condition>
              </PreConditionList>
            </Values>
          </SubCondition>
        </Item>
      </SubConditions>
    </PreConditionList>
  </Values>
</Asset>
```
- At first this pool lists the Quests or QuestLines this Pool should start (in p-t.xml you see that Quest and QuestLine is valid: `<NeededProperty>Quest;QuestLine</NeededProperty>`)
A `QuestLine` is simply a list of Quests one after the other and the pool will make sure to start them in that order if the previous Quest is done.
- I'm not sure what `IsMainStoryPool` is for, but I guess we don't need it for quests added by mods.
- `IsTopLevel`=1 is relevant because Pools can even include other pools. Only the TopLevel pool (the one that is not included within other pools) should have this set to 1 and it means that this pool is the one responsible to start the quests (while lower-level pools wait for "instructions" from their higher pool).
- `QuestLimit`: "The max number of quests that this pool can call simultaneously". So the amount of quests that can be active at the same time from this pool (if PreConditions are met). Not really sure why vanilla sets it to 3 here, while it only inlcudes 2 Questlines, which means the max is 2 Quests at once anyway.
- `PoolCooldown`: "Defines the time the pool is blocked after calling a quest". Eg. if you want to start a quest once every 30 minutes or so, enter a time in ms here. Since this vanilla pool wants to start the Questline Quests as soon as the PreConditions are fullfilled and the quest before is done, it uses a cooldown of 0.
- `QuestCooldown`: "A quest of this pool is blocked for this time when it was resolved.", so if you want to make sure the same quest is not chosen again too soon, if you allow a quest to be active multiple times. In this vanilla example all quests are only active once, so does not really matter.
- `QuestPoolActionCallbacks`: Here you can define Actions eg. on success or on discard and so on of Quests started via this Pool. You can also define these actions within the Quests itself, but if you want them to be the same for all quests of this pool, define it here. In vanilla there is eg. often code to remove the Quest-Offer-Ship (the one with a star above) if the Quest is discarded (rejected from the user before it really starts).
- `PreConditionList`: Here you can define Conditions that must be true for the Pool to start Quests. As long as they are not true, the pool does not start Quests. You can also define PreConditions for individual Quests in the Quests themself. In this example the pool GUID=112116 only starts quests, if the Sunken Treasures DLC is active, the GUID=113818 is unlocked and it is not a multiplayer game.

This Pool will automatically start the Quests as soon as the PreConditions of the Pool and of the first Quest of the Questlines are met. There is no need to add this pool somewhere else or to activate it. If you set DisabledByDefault=1 in a pool it will be disabled (not starting any quests) and need to be enabled first with ActionSetQuestPoolEnablement and IsQuestPoolEnabled=1. But enabling/disabling pools with ActionSetQuestPoolEnablement is only needed if you are not able to include it as PreCondition (this vanilla pool is eg. disabled when the player looses the continental island).  
Some QuestPools are also added to AI player assets, like `<QuestPool>150082</QuestPool>` is added to Jorgensen. This is not mandatory, as far as I know this only means that Quests are offered at the lighthouse of the AI and you don't have to define the starting point of a Quest in the Quest itself.


#### Advanced Example with random Quests: `<GUID>150082</GUID> <Name>OQ_B.Jorgensen_Pool</Name>`  
TODO dann auch mit TopLevel pool usw.
This is one of the pools that should start optional random quests from the AI for the human players.
```xml
<Asset>
  <Template>QuestPool</Template>
  <Values>
    <Standard>
      <GUID>150082</GUID>
      <Name>OQ_B.Jorgensen_Pool</Name>
      <IconFilename>data/ui/2kimages/main/assets/bg_om_info.png</IconFilename>
    </Standard>
    <QuestPool>
      <Groups>
        <Item>
          <QuestGroup>-616566410</QuestGroup>
        </Item>
      </Groups>
      <PoolCooldown>1800000</PoolCooldown>
      <CooldownOnQuestStart>1</CooldownOnQuestStart>
      <CooldownOnQuestEnd>1</CooldownOnQuestEnd>
      <QuestCooldown>82800000</QuestCooldown>
      <QuestPoolActionCallbacks>
        <OnQuestStart>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestStart>
        <OnQuestDeclined>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestDeclined>
        <OnQuestActive>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestActive>
        <OnQuestAborted>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestAborted>
        <OnQuestTimedOut>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestTimedOut>
        <OnQuestFailed>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestFailed>
        <OnQuestSucceeded>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestSucceeded>
        <OnQuestEnd>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestEnd>
        <OnQuestDiscarded>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList>
              <Actions>
                <Item>
                  <Action>
                    <Template>ActionDelayedActions</Template>
                    <Values>
                      <Action />
                      <ActionDelayedActions>
                        <ExecutionDelay>30000</ExecutionDelay>
                        <DelayedActions>
                          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                          <Values>
                            <ActionList>
                              <Actions>
                                <Item>
                                  <Action>
                                    <Template>ActionDeleteObjects</Template>
                                    <Values>
                                      <Action />
                                      <ActionDeleteObjects />
                                      <ObjectFilter>
                                        <ObjectGUID>102577</ObjectGUID>
                                      </ObjectFilter>
                                    </Values>
                                  </Action>
                                </Item>
                              </Actions>
                            </ActionList>
                          </Values>
                        </DelayedActions>
                      </ActionDelayedActions>
                    </Values>
                  </Action>
                </Item>
              </Actions>
            </ActionList>
          </Values>
        </OnQuestDiscarded>
      </QuestPoolActionCallbacks>
    </QuestPool>
    <Locked />
    <PreConditionList>
      <Condition>
        <Template>ConditionIsDiscovered</Template>
        <Values>
          <Condition />
          <ParticipantRelation>
            <SourceIsOwner>1</SourceIsOwner>
            <TargetParticipant>Second_ai_01_Jorgensen</TargetParticipant>
          </ParticipantRelation>
          <ConditionIsDiscovered />
          <ConditionPropsNegatable />
        </Values>
      </Condition>
      <SubConditions>
        <Item>
          <SubCondition>
            <Template>PreConditionList</Template>
            <Values>
              <PreConditionList>
                <Condition>
                  <Template>ConditionPlayerCounter</Template>
                  <Values>
                    <Condition />
                    <ConditionPlayerCounter>
                      <Context>100549</Context>
                      <CounterAmount>1</CounterAmount>
                      <CounterScope>Session</CounterScope>
                      <CounterScopeKeepFirstFound>0</CounterScopeKeepFirstFound>
                      <CheckSpecificParticipant>1</CheckSpecificParticipant>
                      <CheckedParticipant>Second_ai_01_Jorgensen</CheckedParticipant>
                    </ConditionPlayerCounter>
                  </Values>
                </Condition>
              </PreConditionList>
            </Values>
          </SubCondition>
        </Item>
        <Item>
          <SubCondition>
            <Template>PreConditionList</Template>
            <Values>
              <PreConditionList>
                <Condition>
                  <Template>ConditionDiplomaticState</Template>
                  <Values>
                    <Condition />
                    <ConditionDiplomaticState>
                      <SourceIsQuestOwner2>1</SourceIsQuestOwner2>
                      <TargetParticipant2>Second_ai_01_Jorgensen</TargetParticipant2>
                    </ConditionDiplomaticState>
                    <ConditionPropsNegatable>
                      <NegateCondition>1</NegateCondition>
                    </ConditionPropsNegatable>
                  </Values>
                </Condition>
              </PreConditionList>
            </Values>
          </SubCondition>
        </Item>
      </SubConditions>
    </PreConditionList>
  </Values>
</Asset>
```
#### QuestGroup
At first you see `QuestGroup` which is according to p-t.xml 
> A list of quest groups that this pool can call.

When you search for the GUID -616566410 you will find it to be a Group GUID above alot of Assets being Quests from Jorgensen. This is a easy way to automatically include all Quests within that Group, but it is not very clear for the reader and modder. Because it also means you must take care where to put your own quest to avoid accidently adding it to such a existing group!  

## Multiplayer:

TODO, in general works, but make sure everyone can fullfill it, make sure to not use "Human0" which is only the host, but instead things with "Processing" in the name. And do not use Conditions like "MovieFinished/NotificationRemoved/EnterUIState/LeaveUIState" and similar, looking for the client dealing with UI because unfortunately they are causing desyncs.


---



TODO: das packen zu allgemein Quests: The same Quest and also the same Trigger can be started/triggered multiple times at once. So make sure to only start/register them once at the same time.


# Properties/Values of Quests explained:
See templates.xml searching for "<Name>A7_Quest" to see the properties a normal quest has. See p-t.xml and search for <Name>Quest</Name> (there are multiple results, in current version it is in line 46508) and the other relevant properties.  
Properties/values I don't mention here should be self explanatory or already explained enough by the description in p-t.xml.  
"Defaults to" is based on the default values defined in properties.xml. There may be other values defined in the template you are using (if defined nowhere the values will be 0).


#### `StarterMessage/SuccessMessage` :
and all those "Message" values:  
According to p-t.xml you can define a Notification here or set `SuppressMessage`: *"Do not play any notification and do not fall back to PamSy configuration"*.  
If no message is defined here and `SuppressMessage` is not set to 1, the game automatically adds CharacterNotifications based on the "PaMSy" of the Questgiver.
Eg. the pirate Anne Harlow (`GUID 73`) is using: 
```xml
<ParticipantMessageObject>
  <ParticipantMessages>148</ParticipantMessages>
</ParticipantMessageObject>
```
while in the asset `GUID 148` are notifications defined that should be played in specific situations, eg. on "QuestSuccessful" and so on.  
So most of the time for generic quests it is enough to leave this "Message" values from the Quest empty or even better do completely skip them (not mention them at all in your code) since they are inherited from the templates anyways.

#### `OnQuestStart/OnQuestDeclined`:
  and all those "On..." values followed by `ActionList`:  
Here you can add any Actions you want to be executed when the Quest reaches a specific status. Most names are self explanatory. Make sure to read the description in p-t.xml if you are not sure.  
Eg. `OnQuestStart` already happens as soon as the player is able to accept the Quest (eg. the "quest star" to accept a quest becomes visible), while `OnQuestActive` starts as soon as the player accepted the Quest.

#### `QuestGiver`:
*"This is the guys picture will be shown in the quest"*. As mentioned above this is also where the default messages will be taken from. A quest can not start, if the QuestGiver does not exist in the game (eg. Jorgensen can not start a quest if she is not part of the game). Most neutral QuestGivers like the farmers (`<GUID>86</GUID>`) are using the `Profile_Virtual_NeverOwnsObjects` template which has `<CreateModeMeta>AutoCreate_Always</CreateModeMeta>` defined to make sure they always exist in every game.

#### `StoryText/DescriptionText/AlternativeRewardTitle/QuestHints`:
`StoryText`: *"This is the fluff text of a quest."* eg. an embellished story.  
`DescriptionText`: *"This is the description of a quest."* telling the player what to do exactly in short. Not needed if the WinConditions are self explanatory already.  
`AlternativeRewardTitle`: *"An alternative headline for the rewards"*. Defaults to GUID 2653 ("Reward"). So use it if you think this word does not fit for your Quest.  
`QuestHints`: Add Text GUIDs here for short hints how to solve the Quest like "Search near X" or mention the session name where to look and stuff like this.

#### `MaxCallOut/MaxSolveCount/MaxAbortCount`:
*"Maximum number that this quest can be triggered."* / *"Maximum number that this quest can be solved."* / *"Maximum number that this quest can be aborted."*  
Defaults to -1. A value <= 0 means infinite calls are possible. Eg. use these to make sure eg. a QuestPool can only start your Quest once at all/until solved once. 

#### `CountForQuestLimit`:
*"True if this quest counts for the global and the pool quest limits."*. Defaults to 1. Set this to 0 if you don't want a quest to prevent other quests of the same pool to be started. I don't know if there really is a global limit and how much it is.

#### `PreActivationTimer/QuestTimeLimit`:
`PreActivationTimer`: *"This timer cancelles a quest if the quest has not become active until the timer runs out."* Eg. used for Quests that need to be accepted by the user first, eg. the ones popping up in the world with a star-icon spinning over them. If the user does not activate/accept the quest within PreActivationTimer, it is cancelled. Default will be 0 which disables this timer.  
`QuestTimeLimit`: *"If a time limit is set, the quest will fail if it is not completed within this time"*. Defaults to 1800000 ms. Timer starts after the Quest was activated/accepted.

#### `QuestCategory`:
*"The category of the quest defines the internal behaviour of the quest."*. Defaults to MainQuest. Since we can neither change nor look at the "interal behaviour", we can only test a bit what this does exactly. See datasets.xml QuestCategory for all allowed values. But it might be best to always use "RandomQuest" here unless you want to add a new Quest to the vanilla Story Questline.

#### `QuestActivation`:
*"Defines at which point this quest changes its status to "Activated"*. Defaults to QuestStart. Only activated quests are visible in the Quest Tracker." For allowed values see datasets.xml QuestActivationTime.  
`ManualActivation` means the Quest will appear as acceptable Quest on the map eg. with the star-icon and the user can select and start it this way.  
`QuestStart` means the Quest will directly be active in the players Questlog without a choice to accept/decline, but of course the player might be able to abort it.  
`ConfirmationDialog` not tested by me, I assume it directly starts a notification if you want accept the quest or not.  

#### `IsAbortable`:
*"If true, this quest can be aborted in the assignment center or the quest tracker"*. Defaults to 1. Allow to abort accepted/active quests or not.

#### `NeededProgressLevel`:
*"This quest can only be triggered if the player progress level matches these checked levels."* Defaults to `EarlyGame;EarlyMidGame;MidGame;LateMidGame;LateGame;EndGame` so all progresslevels are allowed by default.

#### `LatencyTimer/DelayTimer`:
`LatencyTimer`: *"Latency before a quest can start after all other preconditions are fulfilled. The latency starts again if a single precondition check fails during the countdown. This needs to be checked over the whole duration and is EXPENSIVE for game performance"*.  
`DelayTimer`: *"Delay the quest after the preconditions were fulfilled once. The preconditions will be checked once again after the delay finished. This is a CHEAPER alternative to the latency timer in terms of performance"*.  
Use one of these, at best DelayTimer, if you want the PreConditions of the Quest to be fullfilled for a specific amount of time before the Quest is allowed to appear.

#### `QuestTrackerVisibility/QuestBookVisibility`:
`QuestTrackerVisibility`: *"Defines when this quest will be visible in the quest tracker."* Defaults to Session (so only visible in the session the Quest is active in). See datasets.xml QuestTrackerVisibility.   
`QuestBookVisibility`: *"Defines when this quest will be visible in the quest book."* Defaults to SameAsQuestTracker. See datasets.xml QuestBookVisibility.  

#### `ConfirmOnReached/CustomizeConfirmOnReachedCondition/ConfirmOnReachedCondition`:
`ConfirmOnReached`: *"After solving the quest stays in quest tracker and needs to be confirmed by player"*. Defaults to 0.  
`CustomizeConfirmOnReachedCondition`: *"If true, a custom confirmOnReached condition can be configured for this quest specifically"*. Defaults to 0.  
`ConfirmOnReachedCondition`: *"Use this to provide a custom configuration for the resolve confirmation for this quest"*. Needs CustomizeConfirmOnReachedCondition set to 1 to be used. Also see p-t.xml and vanilla usage of it for more info how to use. It is not needed for basic quests.  

#### `HasExclusiveQuestGiver`:
*"Optional quests are only started if no other exclusive quest is already running with the same quest giver"*. Defaults to 1. Most of the time you should set this to 0 if you don't want to block other quests from the same QuestGiver.

#### `QuestBlackList`:
I don't know what this does, it is neither used in vanilla nor explained in p-t.xml. I assume quests listed here can not be active at the same time? But one needs to test.

#### `QuestSessionDependencies/QuestBlockedSessions`:
`QuestSessionDependencies`: *"If not empty, the quest can only be triggered if **one** of the specified sessions is loaded"*. I think if nothing else is defined and the quest is started via a QuestPool, this is also the Quest the session will be active in.  
`QuestBlockedSessions`: *"If not empty, the quest can not be triggered in one of the specified sessions"*.  
Both also accept Regions. 

#### `QuestDifficulty`:
*"This is the balanced difficulty of this quest"*. Defaults to Easy. Allowed values: Easy, Medium or Hard. These are mostly relevant for (money) reward balancing you can find in RewardBalancing GUID 140501.  

#### `KeepCheckingPreconditionsWhenRunning`:
*"If true, the quest keeps checking the preconditions and will abort automatically if they are not met any longer"*. Defaults to 0. This is eg. especially helpful for Quests involving QuestGivers you can have different treaties with. Eg. you can add a PreCondition that the player must at least have TradeRights with the QuestGiver and set KeepCheckingPreconditionsWhenRunning=1 to automatically abort the active Quest if this is no longer the case.  
**Note**: `KeepCheckingPreconditionsWhenRunning` does only check the PreConditions of the Quest itself, not the ones from the executing QuestPool.  
The game does already cancels Quests to players you declare war to, but this is bugged since it only cancels one Quest. If there are multiple they are not all cancelled, so it is better to also include this as PreCondition if practicable.

#### `ReputationQuestFail/ReputationQuestDeclined/Reward-RewardReputation`:
Adding a list with `ReputationParticipant` *"The participant that rewards reputation"* and `ReputationAmount` *"The amount of reputation that is rewarded. This number can be negative to create a reputation loss"*. So you can make the player loose reputation when a quest fails, but also gain reputation with other AIs.  
`Reward/RewardReputation` is defined outside of the Quest property, but works the same and is awared on Success of the Quest.

#### `ResetPreconditionsAfterQuestWasTriggered`:
*"If true, the interal state of all preconditions will be reset. This is especially important for ConditionEvent which otherwise endlessly remembers any received event"*. Defaults to 0. I think this is only relevant if your PreCondition contain ConditionEvent like SessionEnter an such events. If you use such an event and leave this value 0, only "Entering the Session" once is enough to have the PreCondition true always, also for the next time the same Quest might start. If you set it to 1 instead, you must enter the Session everytime again to again allow the Quest to be started.  
So most of the time this is not relevant for you.

#### `RespectRelatedQuestSession`:
*"If true, this quest tries to spawn in the same session as another quest that is configured in the preconditions. We try to determine the correct quest out of all conditions given. An assert will be thrown if we don't manage to find a quest but this flag is set"*. Better define the sessions in different way to be sure, eg. in QuestSessionDependencies if started via a Pool or with QuestSession if started via ActionStartQuest.

#### `HasStarterSpeechBubble/StarterSpeechBubble/HasSuccessSpeechBubble/SuccessSpeechBubble`:
Did not use this yet. Feel free to add how to use this if you know more about it.

#### `CanBeActiveForMultipleParticipants`:
*"Only takes effect in quest pools. Checking this will stop preventing the quest from being called from the pool, while another player has this quest running"*. Defaults to 0, but set it to 1 if you only want one human player to have the same Quest active at the same time.
