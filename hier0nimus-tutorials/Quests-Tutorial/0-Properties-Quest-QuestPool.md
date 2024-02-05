Written by Serp

- [Quests](./Properties-Quest-QuestPool.md#propertiesvalues-of-quests-explained)
- [QuestPools](./Properties-Quest-QuestPool.md#propertiesvalues-of-questpools)

The Anno devs meanwhile finally published an xml file that contains all allowed properties and values with sometimes a short description (next to assets.xml of game files):
[properties-toolone.xml](https://github.com/anno-mods/modding-guide/blob/main/documentation/properties-toolone.xml) (I will call it p-t.xml below as abbreviation).  
You can look up many things there to find out what is supported where and what they do.  
In the following I copy pasted these property descriptions and added some notes to it to make some things a bit more clear.  

# Properties/Values of Quests explained:
See templates.xml searching for `<Name>QuestTypes</Name>` to see the properties a normal quest has. See p-t.xml and search for `<Name>Quest</Name>` (there are multiple results, in current version it is in line 46508) and the other relevant properties.    
Properties/values I don't mention here should be self explanatory or already explained enough by the description in p-t.xml.  

**"Defaults to**" is based on the default values defined in properties.xml. There may be other values defined in the template you are using (if defined nowhere the values will be 0).


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
So most of the time for generic quests it is enough to leave this "Message" values from the Quest empty or even better do completely skip them (not mention them at all in your code) since they are inherited from the templates/internally prefilled with PaMSy anyways unless you want to add your own text/audio for specific messages.  
**Note:** Some Quest templates are ...
- A custom Notification you can put into any of these messages looks like this:
  <details>
  <summary>(CLICK) CODE</summary>  
  
  For explanation what node does what, see properties-toolone.xml searching for `<Name>BaseNotification</Name>` and `<Name>CharacterNotification</Name>`
  ```xml
  <Notification>
    <Template>CharacterNotification</Template>
    <Values>
      <CharacterNotification>
        <Profile>45</Profile>
        <NotificationTextFemale>FEMALE_TEXT_GUID</NotificationTextFemale>
      </CharacterNotification>
      <BaseNotification>
        <NotificationText>MALE_TEXT_GUID</NotificationText>
        <NotificationPriority>400</NotificationPriority>
        <DisplayTimeout>30000</DisplayTimeout>
        <NotificationMinDisplayTime>60000</NotificationMinDisplayTime>
      </BaseNotification>
      <NotificationSubtitle>
        <Subtitle>AAUDIOTEXT_GUID</Subtitle>
      </NotificationSubtitle>
    </Values>
  </Notification>
  ```
  As I already mentioned, the game already defaults to the QuestGiver, so adding "Profile" here to define who will be speaking is not needed, if you want it to be the QuestGiver.
  You can also leave out NotificationPriority/DisplayTimeout/NotificationMinDisplayTime to use the default values and be on the save side.
  </details>


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
The same Quest can only be active once at the same time IF started via a QuestPool (ActionStartQuest can start multiple times), regardless of any other settings. 

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
Adding a list with `ReputationParticipant` *"The participant that rewards reputation"* and `ReputationAmount` *"The amount of reputation that is rewarded. This number can be negative to create a reputation loss"*. So you can make the player loose reputation when a quest fails, but also gain reputation with other AIs (not only QuestGiver).  
`Reward/RewardReputation` is defined outside of the Quest property, but works the same and is awared on Success of the Quest.  
- `<Name>Reward</Name>` copied from p-t.xml to see all allowed nodes:
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <Property>
    <Name>Reward</Name>
    <ValueDefinition>
      <DataType>Vector</DataType>
      <Name>RewardAssets</Name>
      <Items>
        <ValueDefinition>
          <DataType>Asset</DataType>
          <Name>Reward</Name>
          <NeededProperty>Product;Item;RewardPool;RegionRewardPool;ResourceRewardPool;Session;BuildPermit</NeededProperty>
        </ValueDefinition>
        <ValueDefinition>
          <DataType>Integer</DataType>
          <Name>Amount</Name>
        </ValueDefinition>
        <ValueDefinition>
          <DataType>Boolean</DataType>
          <Name>SentToQuestArea</Name>
          <Description>Indicates if the reward should be sent to the kontor of the quest area</Description>
        </ValueDefinition>
        <ValueDefinition>
          <DataType>Boolean</DataType>
          <Name>IsHidden</Name>
          <Description>Indicates whether this reward should not be shown as a reward preview upon quest invitation (i.e. Bonus Reward)</Description>
        </ValueDefinition>
        <ValueDefinition>
          <DataType>Boolean</DataType>
          <Name>IsDisguised</Name>
          <Description>Indicates whether this (item) reward is disguised as visible, but unknown reward to not give away the actual item earned upon invitation</Description>
        </ValueDefinition>
      </Items>
    </ValueDefinition>
    <ValueDefinition>
      <DataType>Vector</DataType>
      <Name>RewardReputation</Name>
      <Description>List of reputation rewards distributed</Description>
      <Items>
        <ValueDefinition>
          <DataType>Choice</DataType>
          <Name>ReputationParticipant</Name>
          <Description>The participant that rewards reputation</Description>
          <DataSet>ParticipantID</DataSet>
        </ValueDefinition>
        <ValueDefinition>
          <DataType>Integer</DataType>
          <Name>ReputationAmount</Name>
          <Description>The amount of reputation that is rewarded. This number can be negative to create a reputation loss</Description>
        </ValueDefinition>
      </Items>
    </ValueDefinition>
    <ValueDefinition>
      <DataType>Boolean</DataType>
      <Name>GenerateIgnoreUnlocks</Name>
      <Description>do not check unlocks when generating rewards</Description>
    </ValueDefinition>
    <ValueDefinition>
      <DataType>Boolean</DataType>
      <Name>GenerateRewardsUnique</Name>
      <Description>same Reward GUID is not chosen multiple times if a pool is listed as reward asset</Description>
    </ValueDefinition>
    <ValueDefinition>
      <DataType>Vector</DataType>
      <Name>PenaltyList</Name>
      <Items>
        <ValueDefinition>
          <DataType>Struct</DataType>
          <Name>Penalty</Name>
          <Items>
            <ValueDefinition>
              <DataType>AutoCreateAsset</DataType>
              <Name>Action</Name>
              <AllowedTemplates />
              <AllowedProperties>Action</AllowedProperties>
            </ValueDefinition>
            <ValueDefinition>
              <DataType>Boolean</DataType>
              <Name>IsHidden</Name>
            </ValueDefinition>
            <ValueDefinition>
              <DataType>Boolean</DataType>
              <Name>IsDisguised</Name>
            </ValueDefinition>
            <ValueDefinition>
              <DataType>Asset</DataType>
              <Name>Icon</Name>
            </ValueDefinition>
            <ValueDefinition>
              <DataType>Text</DataType>
              <Name>Infotip</Name>
              <NeededProperty>Text</NeededProperty>
            </ValueDefinition>
          </Items>
        </ValueDefinition>
      </Items>
    </ValueDefinition>
  </Property>
  ```
  </details>
Usual Reward will be `<Reward>150038</Reward>` which is the "MoneyPool", so basically just money, but because it is in this pool it can scale by QuestDifficulty. Usual Amount for this MoneyPool Reward are between 1 and 10, test it ingame in how much this results, I don't know exactly.  
If you also want an Item or RewardPool including Items or other possibly Locked things as reward, make sure to set `<GenerateIgnoreUnlocks>1</GenerateIgnoreUnlocks>` otherwise the reward will not appear, if the player did not unlock it (eg. the item) yet.  



#### `ResetPreconditionsAfterQuestWasTriggered`:
*"If true, the interal state of all preconditions will be reset. This is especially important for ConditionEvent which otherwise endlessly remembers any received event"*. Defaults to 0. I think this is only relevant if your PreCondition contain ConditionEvent like SessionEnter an such events. If you use such an event and leave this value 0, only "Entering the Session" once is enough to have the PreCondition true always, also for the next time the same Quest might start. If you set it to 1 instead, you must enter the Session everytime again to again allow the Quest to be started.  
So most of the time this is not relevant for you.

#### `RespectRelatedQuestSession`:
*"If true, this quest tries to spawn in the same session as another quest that is configured in the preconditions. We try to determine the correct quest out of all conditions given. An assert will be thrown if we don't manage to find a quest but this flag is set"*. Better define the sessions in different way to be sure, eg. in QuestSessionDependencies if started via a Pool or with QuestSession if started via ActionStartQuest.

#### `HasStarterSpeechBubble/StarterSpeechBubble/HasSuccessSpeechBubble/SuccessSpeechBubble`:
Did not use this yet. Feel free to add how to use this if you know more about it.

#### `CanBeActiveForMultipleParticipants`:
*"Only takes effect in quest pools. Checking this will stop preventing the quest from being called from the pool, while another player has this quest running"*. Defaults to 0, but set it to 1 if you want it possible that the Quest can be active for more than one human player at the same time.

#### `QuestOptional`:
This contains on what object (where) you want your Quest to start. Mostly relevant if you set `QuestActivation` to `ManualActivation`, then this object will be the one with the star-icon over it the player has to click on to get the Quest offered.  
- `<Name>QuestOptional</Name>`/`<Name>ConditionStarterObject</Name>` copied from p-t.xml to see all allowed nodes:
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <Property>
    <Name>QuestOptional</Name>
    <ValueDefinition>
      <DataType>Choice</DataType>
      <Name>HasStarterObject</Name>
      <Category>Init</Category>
      <ReadOnlyDependingOnExportVersions>1</ReadOnlyDependingOnExportVersions>
      <DataSet>QuestStarterObjectChoice</DataSet>
    </ValueDefinition>
    <ValueDefinition>
      <DataType>AutoCreateAsset</DataType>
      <Name>StarterObject</Name>
      <Category>Init</Category>
      <ReadOnlyDependingOnExportVersions>1</ReadOnlyDependingOnExportVersions>
      <AllowedTemplates>ConditionStarterObject</AllowedTemplates>
      <AllowedProperties />
    </ValueDefinition>
  </Property>


  <Property>
    <Name>ConditionStarterObject</Name>
    <ValueDefinition>
      <DataType>Boolean</DataType>
      <Name>MoveIntoSession</Name>
      <Description>True, if the StarterObjectObject should move into the session to the docking place. False, if the StarterObjectObject should be selectable from the very beginning</Description>
    </ValueDefinition>
    <ValueDefinition>
      <DataType>Float</DataType>
      <Name>DockingPlaceDistance</Name>
      <Description>If MoveIntoSession is true, then the StarterObjectObject tries to come near StarterObjectDockingPlace, respecting this distance</Description>
    </ValueDefinition>
    <ValueDefinition>
      <DataType>AutoCreateAsset</DataType>
      <Name>StarterObjectObject</Name>
      <Description>The object that needs to be selected to start the quest. If MoveIntoSession is true, this object (=ship) will need to move into position first</Description>
      <AllowedTemplates>ConditionObjectPlayerKontor;ConditionObjectClientQuestObject;ConditionObjectPrebuiltObject;ObjectFilterWithSignsAndFeedback;ConditionObjectSpawnedObject</AllowedTemplates>
      <AllowedProperties />
    </ValueDefinition>
    <ValueDefinition>
      <DataType>AutoCreateAsset</DataType>
      <Name>StarterObjectDockingPlace</Name>
      <Description>The place where the StarterObjectObject tries to move to, when MoveIntoSession is true</Description>
      <AllowedTemplates>ConditionObjectClientQuestObject;ConditionObjectPlayerKontor;ConditionObjectPrebuiltObject</AllowedTemplates>
      <AllowedProperties />
    </ValueDefinition>
    <ValueDefinition>
      <DataType>Boolean</DataType>
      <Name>OverwriteExistingQuestArea</Name>
      <Description>If true, the starter condition will not only set the area of the starter object as quest area when it is empty but also when is already set</Description>
    </ValueDefinition>
  </Property>
  ```
  </details>
`HasStarterObject` is in vanilla only `None` (for no starter object) or `Specific` to define one. Technically also `QuestGiver` is allowed, but never used by vanilla, so I don't know what it does.  
The both most used `StarterObjectObject` in vanilla are: 
- `ConditionObjectPrebuiltObject` to make an already existing object the starter of a Quest, eg. a Lighthouse or Harbour from AI.  
  **Note**: the Quest signs will be over ALL objects that match this GUID/Owner. So it is often better to use unique objects, like lighthouses of AI or spawn a unique object first.  
  <details>
  <summary>(CLICK) example CODE</summary>  
  
  Start Quest at schnapps destilleries owned by us with the default quest icons (infolayer).  
  
  ```xml
  <ConditionStarterObject>
    <StarterObjectObject>
      <Template>ConditionObjectPrebuiltObject</Template>
      <Values>
        <ConditionObjectPrebuiltObject>
          <PrebuiltObject>1010294</PrebuiltObject>
          <PrebuiltObjectCheckOwner>1</PrebuiltObjectCheckOwner>
          <PrebuiltUseProcessingParticipant>1</PrebuiltUseProcessingParticipant>
        </ConditionObjectPrebuiltObject>
        <ConditionScanner />
        <ConditionObjectiveSignsAndFeedback>
          <Infolayer>500693</Infolayer>
          <MinimapToken>2001840</MinimapToken>
        </ConditionObjectiveSignsAndFeedback>
      </Values>
    </StarterObjectObject>
  </ConditionStarterObject>
  ```
  </details>
- `ConditionObjectSpawnedObject` to spawn a new object, eg. a Ship from the QuestGiver as starter object. If you use this you should add a new ship-asset with your unique GUID as starter to prevent interference with other Quests.  
  <details>
  <summary>(CLICK) example CODE</summary>  
  
  Spawn a copy of the LaFortune Quest-Ship-Starter near the Lighthouse of LaFortune, disguised with owner LaFortune (Quest ships always belong to Neutral, so they can not be attacked by anyone)
  ```xml
  <ConditionStarterObject>
    <StarterObjectObject>
      <Template>ConditionObjectSpawnedObject</Template>
      <Values>
        <ConditionObjectSpawnedObject>
          <ExecutionObject>2001000000</ExecutionObject>
          <ObjectSpawnArea>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <SpawnArea>
                <SpawnContext>Object</SpawnContext>
                <ContextGUID>100708</ContextGUID>
                <DistanceToContext>20</DistanceToContext>
              </SpawnArea>
            </Values>
          </ObjectSpawnArea>
          <DoSetVisualObjectOwner>1</DoSetVisualObjectOwner>
          <VisualObjectOwner>Third_party_04_Pirate_LaFortune</VisualObjectOwner>
        </ConditionObjectSpawnedObject>
        <ConditionScanner />
        <ConditionObjectiveSignsAndFeedback>
          <Infolayer>500173</Infolayer>
        </ConditionObjectiveSignsAndFeedback>
      </Values>
    </StarterObjectObject>
  </ConditionStarterObject>

  <!-- Ship Asset copy for starter object from LaFortune -->
  <ModOp Type="addNextSibling" GUID="102590">
    <Asset>
      <BaseAssetGUID>102590</BaseAssetGUID>
      <Values>
        <Standard>
          <GUID>2001000000</GUID>
          <Name>Ship Quest (LaFortune)</Name>
        </Standard>
      </Values>
    </Asset>
  </ModOp>
  ```
  </details>


---


# Properties/Values of Questpools:
(Again take a look at p-t.xml and search for `<Name>QuestPool</Name>` (the one that has "DisabledByDefault" directly below it) to see all allowed values and some description)

QuestPools are a helper construct to automatically start quests on regular basis if PreConditions are fullfilled. Eg. if you made like 10 Quests that simply should be chosen randomly if preconditions are fullfilled (just like the games Random Quests) you can put your Quests in a pool and define how often the pool should start up to how many quests at once and so on. It also supports adding QuestLines into the pool instead of Quests directly to make sure they are started one after the other.

A Pool will automatically start the Quests as soon as the PreConditions of the Pool and of the first Quest of the Questlines are met. There is no need to add this pool somewhere else or to activate it. If you set DisabledByDefault=1 in a pool it will be disabled (not starting any quests) and need to be enabled first with ActionSetQuestPoolEnablement and IsQuestPoolEnabled=1. But enabling/disabling pools with ActionSetQuestPoolEnablement is only needed if you are not able to include it as PreCondition (this vanilla pool is eg. disabled when the player looses the continental island).  
Some QuestPools are also added to AI player assets, like `<QuestPool>150082</QuestPool>` is added to Jorgensen. This is not mandatory, as far as I know this only means that Quests are offered at the lighthouse of the AI and you don't have to define the starting point of a Quest in the Quest itself.

#### `DisabledByDefault`:
Disabled Pools do not start Quests. Defaults to 0. For basic usage, just leave this at 0 and don't mess with Enabling/Disabling QuestPools. Most of the time the PreConditions you can define for Pools/Quests are more then enough. Eg. the vanilla game disables the QuestPool for Cape-Quests if the player looses the continental island. An alternative would be to add "owning the continental island" into the PreConditions of the Pool. There may be cases where disabling/enabling Pools is better, but they are rare (use ActionSetQuestPoolEnablement and IsQuestPoolEnabled=1 to enable a disabled pool).

#### `Quests/Groups/SubPools`:
Lists inlucding Quests/Groups/SubPools, you can define a Weight for each of them to have some more likely to be chosen.    
`Quests`: can be directly the Quest GUIDs you want to include or `QuestLine` objects to make sure they are automatically played one after the other.  
`Groups`: When you search for the `GUID -616566410` you will find it to be a Group GUID above alot of Assets being Quests from Jorgensen and used in a QuestPool. This is a easy way to automatically include all Quests within that Group, but it is not very clear for the reader and modder. Because it also means you must take care **where to put** your own quest to avoid accidently adding it to such a existing group!  
`SubPools`: Pools can even include other Pools. Eg. you want a Pool to start some random Quests, but you have many Quests of different categories and want different cooldowns for them. Then you can order them into different SubPools with their own Cooldowns and start them with a TopLevel Pool. Eg. the TopLevel Pool calls a Quest once every 30 minutes and your SubPools have a PoolCooldown of 60 minutes, to make sure the same category of Quest is not chosen two times in a row.  

#### `IsMainStoryPool`:
Defaults to 0. Not really sure what this does, but I assume it should only be used for vanilla story Quests, so better don't touch this.

#### `IsTopLevel`:
*"If true, this pool will be used directly to select quests and does not depent on a parent pool to be chosen."* Defaults to 0. Relevant because Pools can even include other pools. Only the TopLevel pool (the one that is not included within other pools) should have this set to 1 and it means that this pool is the one responsible to start the quests (while lower-level pools wait for "instructions" from their higher pool).

#### `QuestLimit`:
*"The max number of quests that this pool can call simultaneously"*. Defaults to 1. So the amount of quests that can be active at the same time started from this pool (if PreConditions are met). 
 
#### `PoolCooldown/CooldownOnQuestStart/CooldownOnQuestEnd/QuestCooldown/AffectedByCooldownFactor`:
`PoolCooldown`: *"Defines the time the pool is blocked after calling a quest"*. Defaults to 120000 ms. Eg. if you want to trigger any quest of the pool once every 30 minutes or so, enter a time in ms here. Use a cooldown of 0 if you want all quests to directly be triggered as soon as all PreConditions are met.  
`CooldownOnQuestStart`: *"Starts the pool cooldown if no pool cooldown is running and a quest started"*. "Quest started" in this case is already true as soon as the Quest is triggered by the Pool, even if it is only currently offered on the map and the player still has to click and activate the Quest! This means if you use only this and put Cooldown eg. to 10 minutes, while the user discards/abort a Quest 11 minutes after it appeared on the map, the pool can immediately start another Quest.   
`CooldownOnQuestEnd`: *"Starts the pool cooldown if no pool cooldown is running and a quest ended"*. "OnQuestEnd", so it does not matter if it succeeded, failed or aborted/discarded.   
Keep in mind that this could have weird side effects, since the Cooldown is only started if cooldown is not already running. Eg. if you set it to 30 minutes and the user finishes the Quest in 29 minutes, 1 minute later the Pool can start another Quest. But if the user needs 31 minutes instead, there will be another Cooldown of 30 minutes. Setting both CooldownOnQuestStart and CooldownOnQuestStart to 0 disables to PoolCooldown, so it will start all available Quests immediately without Cooldown.   
`QuestCooldown`: *"A quest of this pool is blocked for this time when it was resolved."*. Defaults to 300000 ms. So if you want to make sure the same quest is not chosen again too soon, if you allow a quest to be active multiple times. Set it to 0 if you don't want such a cooldown. This has no effect in Pools only including SubPools. This cooldown is tight to the Quest and always starts at the end of the Quest, regardless of CooldownOnQuestStart/CooldownOnQuestEnd.   
`AffectedByCooldownFactor`: *"When true, the cooldown will be affected by the cooldown multiplier of the quest frequencies in the difficulty settings"*. Defaults to 1. I assume this affects both the Pool and the Quest Cooldown? Not sure.  

#### `QuestSessionDependencies`:
`QuestSessionDependencies`: *"If any sessions will be linked here, than this pool does only select new quests if **one** of the given sessions is currently running"*. Also supports Region.   

#### `QuestPoolCooldownMultiplierList`:
No description and never used from the game, but looking at p-t.xml `<Name>QuestPoolCoodownMultiplier</Name>` looks like one can make a Pool to multiply his Cooldown based on the Happiness of a specific population to make Quests appear more often. Not tested if this works. If you test it, please update this text.  

#### `QuestPoolActionCallbacks`:
Here you can define Actions eg. on success or on discard and so on of Quests started via this Pool. You can also define these actions within the Quests itself, but if you want them to be the same for all quests of this pool, define it here. In vanilla there is eg. often code to remove the Quest-Offer-Ship (the one with a star above) if the Quest is discarded (rejected from the user before it really starts).  

#### `PreConditionList`:
Here you can define Conditions that must be true for the Pool to start Quests. As long as they are not true, the pool does not start Quests. You can also define PreConditions for individual Quests in the Quests themself. Take a look at vanilla PreConditionList, eg. also with `<SubConditions>` to see how to use it.  
