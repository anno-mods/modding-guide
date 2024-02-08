# Creating a Quest

At first you should think about what kind of Quest you would like to have.  
The vanilla game offers several templates for different kinds of quests (search templates.xml for `<Name>QuestTypes</Name>`), mostly different regarding their WinCondition and some prefilled text. Using the correct template will make it a bit easier, but is not mandatory. Since all Quest templates have as far as I know the very same properties, you can use any of them and replace the values like you want and use any WinCondition and combine them like you want.

For this Tutorial we will create 2 simple Quests (search assets.xml of the game for vanilla examples of other quest types):
- a A7_QuestSustain quest, like "own X for a time of Y".
- a delivery quest (deliver product x with a ship to kontor of Y) using template A7_QuestDeliveryObject (deliver to pirates as long you have peace with them)

## A7_QuestSustain
Ok, we want to make a Quest from the Queen, offered as soon as we unlocked schnapps, to sustain an amount of schnapps in our island storage above 20 tons.


It is always good to take a look how the vanilla game made this, so we will search for a A7_QuestSustain that looks similar to what we want to do and copy paste and adjust it.  

- Vanilla Code GUID 152411 : **Champaign shower - Gasparov**
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <Asset>
    <Template>A7_QuestSustain</Template>
    <Values>
      <Standard>
        <GUID>152411</GUID>
        <Name>Champaign shower - Gasparov</Name>
      </Standard>
      <Quest>
        <StarterMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </StarterMessage>
        <SuccessMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </SuccessMessage>
        <FailureMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </FailureMessage>
        <SelectionReminderMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </SelectionReminderMessage>
        <AbortedManuallyMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </AbortedManuallyMessage>
        <AbortedAutomaticallyMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </AbortedAutomaticallyMessage>
        <InvitationMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification>
                <NotificationText>3554</NotificationText>
              </BaseNotification>
              <NotificationSubtitle>
                <SubtitleGroup>-590493010</SubtitleGroup>
              </NotificationSubtitle>
            </Values>
          </Notification>
        </InvitationMessage>
        <EscortShipSelectedMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </EscortShipSelectedMessage>
        <ReminderMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </ReminderMessage>
        <ResolveConfirmationMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </ResolveConfirmationMessage>
        <InvitationSmugglerQuestMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </InvitationSmugglerQuestMessage>
        <SmugglerQuestTradingStationReached>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </SmugglerQuestTradingStationReached>
        <StartInvitationGiveItemMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </StartInvitationGiveItemMessage>
        <StartFollowShipMessage>
          <Notification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <CharacterNotification />
              <BaseNotification />
              <NotificationSubtitle />
            </Values>
          </Notification>
        </StartFollowShipMessage>
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
        <OnActiveQuestTimedOut>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnActiveQuestTimedOut>
        <OnQuestFailed>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestFailed>
        <OnQuestDiscarded>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ActionList />
          </Values>
        </OnQuestDiscarded>
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
        <OnPhotographySuccessNewspaperAction>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <Action />
            <ActionForceNewspaper />
          </Values>
        </OnPhotographySuccessNewspaperAction>
        <QuestGiver>83</QuestGiver>
        <StoryText>18198</StoryText>
        <QuestActivation>ConfirmationDialog</QuestActivation>
        <NeededProgressLevel>LateMidGame;LateGame;EndGame</NeededProgressLevel>
        <DelayTimer>1200000</DelayTimer>
        <ConfirmOnReachedCondition>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <ConditionQuestResolveConfirmation />
            <Condition />
            <ConditionQuestObjective />
          </Values>
        </ConfirmOnReachedCondition>
        <ReputationQuestFail>
          <ReputationFailList>
            <Item>
              <VectorElement>
                <InheritedIndex>0</InheritedIndex>
                <InheritanceMapV2>
                  <Entry>
                    <TemplateName>A7_QuestEscortObject</TemplateName>
                    <Index>0</Index>
                  </Entry>
                  <Entry>
                    <TemplateName>A7_QuestPickupObject</TemplateName>
                    <Index>0</Index>
                  </Entry>
                  <Entry>
                    <TemplateName>A7_QuestSustain</TemplateName>
                    <Index>0</Index>
                  </Entry>
                </InheritanceMapV2>
              </VectorElement>
              <ReputationParticipant>Second_ai_06_Gasparov</ReputationParticipant>
              <ReputationAmount>-4</ReputationAmount>
            </Item>
          </ReputationFailList>
        </ReputationQuestFail>
        <ReputationQuestDeclined>
          <ReputationDeclinedList>
            <Item>
              <ReputationParticipant>Second_ai_06_Gasparov</ReputationParticipant>
              <ReputationAmount>-3</ReputationAmount>
            </Item>
          </ReputationDeclinedList>
        </ReputationQuestDeclined>
        <StarterSpeechBubble>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <Condition />
            <ConditionTutorialInteraction>
              <HintText>18222</HintText>
              <ObjectFilter>
                <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                <Values>
                  <ObjectFilter>
                    <ObjectGUID>102582</ObjectGUID>
                  </ObjectFilter>
                </Values>
              </ObjectFilter>
              <UseSpecificPortrait>1</UseSpecificPortrait>
              <SpecificPortraitProfile>83</SpecificPortraitProfile>
            </ConditionTutorialInteraction>
          </Values>
        </StarterSpeechBubble>
        <SuccessSpeechBubble>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <Condition />
            <ConditionTutorialInteraction />
          </Values>
        </SuccessSpeechBubble>
      </Quest>
      <PreConditionList>
        <Condition>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <Condition />
            <ConditionAlwaysTrue />
          </Values>
        </Condition>
        <SubConditions>
          <Item>
            <SubCondition>
              <Template>PreConditionList</Template>
              <Values>
                <PreConditionList>
                  <Condition>
                    <Values>
                      <Condition />
                      <ConditionPlayerCounter>
                        <PlayerCounter>PopulationByLevel</PlayerCounter>
                        <CounterAmount>1</CounterAmount>
                        <Context>15000004</Context>
                      </ConditionPlayerCounter>
                    </Values>
                    <Template>ConditionPlayerCounter</Template>
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
                    <Template>ConditionPlayerCounter</Template>
                    <Values>
                      <Condition />
                      <ConditionPlayerCounter>
                        <PlayerCounter>GoodsInStock</PlayerCounter>
                        <Context>120016</Context>
                        <ComparisonOp>AtMost</ComparisonOp>
                        <CounterAmount>5</CounterAmount>
                      </ConditionPlayerCounter>
                    </Values>
                  </Condition>
                </PreConditionList>
              </Values>
            </SubCondition>
          </Item>
        </SubConditions>
      </PreConditionList>
      <Text>
        <LocaText>
          <English>
            <Text>Champagne Socialist</Text>
            <Status>Exported</Status>
          </English>
        </LocaText>
        <LineID>28888</LineID>
      </Text>
      <Reward>
        <RewardAssets>
          <Item>
            <VectorElement>
              <InheritanceMapV2>
                <Entry>
                  <TemplateName>A7_QuestPickupObject</TemplateName>
                  <Index>0</Index>
                </Entry>
              </InheritanceMapV2>
            </VectorElement>
            <Reward>150038</Reward>
            <Amount>3</Amount>
          </Item>
        </RewardAssets>
        <RewardReputation>
          <Item>
            <VectorElement>
              <InheritedIndex>0</InheritedIndex>
              <InheritanceMapV2>
                <Entry>
                  <TemplateName>A7_QuestEscortObject</TemplateName>
                  <Index>0</Index>
                </Entry>
                <Entry>
                  <TemplateName>A7_QuestPickupObject</TemplateName>
                  <Index>0</Index>
                </Entry>
                <Entry>
                  <TemplateName>A7_QuestSustain</TemplateName>
                  <Index>0</Index>
                </Entry>
              </InheritanceMapV2>
            </VectorElement>
            <ReputationParticipant>Second_ai_06_Gasparov</ReputationParticipant>
            <ReputationAmount>5</ReputationAmount>
          </Item>
        </RewardReputation>
      </Reward>
      <Objectives>
        <WinConditions>
          <Item>
            <Objective>
              <Template>SustainObjective</Template>
              <Values>
                <ConditionQuestObjective />
                <ConditionPlayerCounter>
                  <PlayerCounter>PopulationSatisfactionByGood</PlayerCounter>
                  <Context>120016</Context>
                  <CounterAmount>15</CounterAmount>
                </ConditionPlayerCounter>
                <ConditionQuestSustain>
                  <SustainTime>300000</SustainTime>
                </ConditionQuestSustain>
                <ConditionPropsExecutionPlaceSettings>
                  <ExecutionPlaceConfirmOnReached>0</ExecutionPlaceConfirmOnReached>
                </ConditionPropsExecutionPlaceSettings>
              </Values>
            </Objective>
          </Item>
        </WinConditions>
      </Objectives>
      <QuestOptional>
        <HasStarterObject>Specific</HasStarterObject>
        <StarterObject>
          <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
          <Values>
            <Condition />
            <ConditionStarterObject>
              <StarterObjectObject>
                <Template>ConditionObjectSpawnedObject</Template>
                <Values>
                  <ConditionObjectSpawnedObject>
                    <ExecutionObject>102582</ExecutionObject>
                    <ObjectSpawnArea>
                      <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                      <Values>
                        <SpawnArea>
                          <SpawnContext>PlayerKontor</SpawnContext>
                          <DistanceToContext>30</DistanceToContext>
                        </SpawnArea>
                      </Values>
                    </ObjectSpawnArea>
                    <DoSetVisualObjectOwner>1</DoSetVisualObjectOwner>
                    <VisualObjectOwner>Second_ai_06_Gasparov</VisualObjectOwner>
                  </ConditionObjectSpawnedObject>
                  <ConditionScanner />
                  <ConditionObjectiveSignsAndFeedback>
                    <Infolayer>500173</Infolayer>
                  </ConditionObjectiveSignsAndFeedback>
                </Values>
              </StarterObjectObject>
            </ConditionStarterObject>
            <ConditionQuestObjective />
            <ConditionPropsSessionSettings />
          </Values>
        </StarterObject>
      </QuestOptional>
    </Values>
  </Asset>
  ```
  </details>

This is quite alot of code. 
### Messages:
Here ([Quest Messages](./0-Properties-Quest-QuestPool.md#startermessagesuccessmessage-)) we read, that some default messages are added automatically depending on the QuestGiver. And since the structure is inherited from the template anyways, we can clear up the code already by just removing nearly all these Message nodes and only leave the ones where we want to add custom text/audio. As mentioned on that link, the `A7_QuestSustain` Template does set custom text for the InvitationMessage. So we have to add our default PaMSy Subtitle back, which can be found in GUID 150 (PaMSy of the Queen) and is `<SubtitleGroup>-85031022</SubtitleGroup>`.  

### On-Actions:
The very same is true for these [On-Actions](./0-Properties-Quest-QuestPool.md#onqueststartonquestdeclined), simply clear the code up be removing all of them you don't want to add actions to.

### Quest
Now we finally come to the [relevant values](./0-Properties-Quest-QuestPool.md#questgiver).  
- We want to have **Queen GUID 75** as our QuestGiver, you can either find his GUID in the assets.xml yourself or use a tool like this: https://a1800.net/?langSearch=english&textSearch=The+Queen .  
- Enter your GUIDs for StoryText/DescriptionText/AlternativeRewardTitle/QuestHints, see here how to add your own strings: https://github.com/anno-mods/modding-guide/tree/main/hier0nimus-tutorials/02-making-new-specialists#structure-of-the-file
It is enough to have these text-GUIDs defined in the text files, no need to add assets for them in the assets.xml file.
- [MaxCallOut/MaxSolveCount/MaxAbortCount](./0-Properties-Quest-QuestPool.md#maxcalloutmaxsolvecountmaxabortcount): For easier testing, we want the Quest to be solvable/triggered or aborted unlimited times for now. So we simply don*t mention them, which makes them default to -1==unlimited.
- [CountForQuestLimit](./0-Properties-Quest-QuestPool.md#countforquestlimit) will not be mentioned and defaults to 1, relevant later for QuestPools.
- [PreActivationTimer/QuestTimeLimit](./0-Properties-Quest-QuestPool.md#preactivationtimerquesttimelimit): We don't want our quest to be cancelled while it is offered, so we dont mention PreActivationTimer which defaults to 0==disabled. And as time to complete the Quest we use 2 minutes (120000 in ms) for easier testing (after finishing we will increase this of course).
- [QuestCategory](./0-Properties-Quest-QuestPool.md#questcategory) always should be RandomQuest
- As [QuestActivation](./0-Properties-Quest-QuestPool.md#questactivation) I will use ManualActivation, so the user must click on this star-icon on the map to activate it.
- [IsAbortable](./0-Properties-Quest-QuestPool.md#isabortable) set to 1, so user can abort it if he wants.
- [NeededProgressLevel](./0-Properties-Quest-QuestPool.md#neededprogresslevel) will not be mentioned, so it will default to all progresslevels being allowed.
- [DelayTimer](./0-Properties-Quest-QuestPool.md#latencytimerdelaytimer) for a bit immersion we will use a DelayTimer of 10000ms, so the Quest is not instantly offered after PreConditions are fullfilled.
- [QuestTrackerVisibility/QuestBookVisibility](./0-Properties-Quest-QuestPool.md#questtrackervisibilityquestbookvisibility) default values are fine, so we also don't mention them.
- [ConfirmOnReached](./0-Properties-Quest-QuestPool.md#confirmonreachedcustomizeconfirmonreachedconditionconfirmonreachedcondition): while for many quests it makes sense to ask if one wants to complete the quest, it does not make that much sense for a Sustain-Quest, so we will not mention it which makes it default to 0 (keep in mind that your choosen template also sets values. some templates set this to 1, meaning if you don't mention it with other templates it defaults to 1 then). We also don't need to mention CustomizeConfirmOnReachedCondition/ConfirmOnReachedCondition in this case.  
- [HasExclusiveQuestGiver](./0-Properties-Quest-QuestPool.md#hasexclusivequestgiver): Setting it to 0, because we want The Queen to also offer her other Quests at the same time.
- [QuestSessionDependencies](./0-Properties-Quest-QuestPool.md#questsessiondependenciesquestblockedsessions) use the Old World Session GUID 180023 here, because we want the Quest to start here.
- [QuestDifficulty](./0-Properties-Quest-QuestPool.md#questdifficulty) the money reward balancing should see our Quest as Medium Difficulty.
- [KeepCheckingPreconditionsWhenRunning](./0-Properties-Quest-QuestPool.md#keepcheckingpreconditionswhenrunning) does not matter for this Quest, because the PreConditions can not be false again anyways. Not mentioning it, which defaults to 0=disabled.
- [ReputationQuestFail/ReputationQuestDeclined/Reward-RewardReputation](./0-Properties-Quest-QuestPool.md#reputationquestfailreputationquestdeclinedreward-rewardreputation): Since this is a Quest for The Queen, who does not really care for what we do, we don't want reputation from anyone. Unfortunately our template adds -2/+3 ReputationAmount (see link for explanation), so we have to empty these by using `<ReputationFailList />` and `<RewardReputation />`.  
As `RewardAsset` we will use the MoneyPool and an Item from the Archibald Rewardpool GUID 192540 `<Name>Third_party_02 (Archibald Blake) Forced Voluntary Reward</Name>` (but of course you can also create your own RewardPool with custom rewards and chances). Since our Quest Starter is no ship, we can not really pick up our reward-item, so we have to add `<SentToQuestArea>1</SentToQuestArea>` to the Reards, so they are directly credited to our island storage.    
In the vanilla Quest above you will see alot of `VectorElement/InheritanceMapV2`, we do not really know if this does anything at all, but even if it does, it is not needed. Simply remove all of this and just enter the allowed nodes based on p-t.xml. 
- [HasStarterSpeechBubble/StarterSpeechBubble/HasSuccessSpeechBubble/SuccessSpeechBubble](./0-Properties-Quest-QuestPool.md#hasstarterspeechbubblestarterspeechbubblehassuccessspeechbubblesuccessspeechbubble): I don't care for these Speech-Bubbles, so I will remove them.
- [CanBeActiveForMultipleParticipants](./0-Properties-Quest-QuestPool.md#canbeactiveformultipleparticipants): I'm fine with having multiple humans at the same time doing this Quest, so I set this to 1.

### PreConditionList
Here you can add whatever conditions you want that must be true before this Quest is allowed to be triggered.  
Since our Quest is about sustaining an amount of schnapps, we will only start the Quest after the player unlocked the product and built at least 2 Schnapps Distilleries.  

### QuestOptional
As [QuestOptional](./0-Properties-Quest-QuestPool.md#questoptional) we will use `ConditionObjectSpawnedObject` and spawn a Queen starter-object near of our own Schnapps Distilleries. As Infolayer (the icon around our quest starter) we will use the default quest marker (same for minimap). See example code below.  

### WinConditions
As [WinConditions](./0-Properties-Quest-QuestPool.md#winconditions) we will use the `SustainObjective` we already have in the vanilla Quest we copied initially and slightly change it.  
As PlayerCounter we will check for `GoodsInStock` instead (see datasets.xml `<Name>PlayerCounter</Name>` for allowed values) and enter the Schnapps GUID 1010216 as `Context` and set CounterAmount to 30. If we do not set `CounterScope` it defaults to Global, so it does not matter where we have the 30 tons of schnapps. `SustainTime` will be for testing 1 minute (60000 ms) and we want the timer to start from new, if the player goes below the 30 schnapps, so we set `<ResetTimer>1</ResetTimer>`. The text `TextCombinedContextValue` is used to describe this particular objective and is in the template `SustainObjective` set to GUID 12761. When we look this up eg. in vanilla texts_english.xml you see that this is ment for usage with `PopulationSatisfactionByGood`, but we want to sustain a specific amount of goods instead. So we can either write our own text, search the texts file for better fitting ones or better search the vanilla assets.xml for Sustain Quests that already use `GoodsInStock` and see what they use as text. This way you will find `<TextCombinedContextValue>20078</TextCombinedContextValue>` which fits better.  
For each objective there will be a value for "confirm or not", in this case it is `ExecutionPlaceConfirmOnReached` we will set to 0, to not have to confirm after we completed this particular objective.  

### Adding the Quest Asset to assets.xml:
As mentioned [here](./0-Properties-Quest-QuestPool.md#questsgroupssubpools), the game often uses Group GUIDs to add Pools to QuestPools (and Items to Rewardpools!). This means it does matter where you add your Quest (or Item) Asset with ModOp AddNextSibling, to not accidently adding your Asset to a vanilla Pool. For Quests I think it is safe to add your **Quest next to GUID 152264** and for **Items next to GUID 112574**, because these do not seem to belong to any Group that has its own GUID.  
- Our Quest Code now looks like this:
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <ModOp Type="addNextSibling" GUID="152264">
    <Asset>
      <Template>A7_QuestSustain</Template>
      <Values>
        <Standard>
          <GUID>2001000001</GUID>
          <Name>Sustain Schnapps - Queen</Name>
        </Standard>
        <Quest>
          <InvitationMessage>
            <Notification>
              <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
              <Values>
                <NotificationSubtitle>
                  <SubtitleGroup>-85031022</SubtitleGroup>
                </NotificationSubtitle>
              </Values>
            </Notification>
          </InvitationMessage>
          <QuestGiver>75</QuestGiver>
          <StoryText>14038</StoryText>
          <QuestTimeLimit>120000</QuestTimeLimit>
          <QuestCategory>RandomQuest</QuestCategory>
          <QuestActivation>ManualActivation</QuestActivation>
          <IsAbortable>1</IsAbortable>
          <DelayTimer>10000</DelayTimer>
          <HasExclusiveQuestGiver>0</HasExclusiveQuestGiver>
          <QuestDifficulty>Medium</QuestDifficulty>
          <QuestSessionDependencies>
            <Item>
              <SessionOrRegion>180023</SessionOrRegion>
            </Item>
          </QuestSessionDependencies>
          <CanBeActiveForMultipleParticipants>1</CanBeActiveForMultipleParticipants>
          <ReputationQuestFail>
            <ReputationFailList />
          </ReputationQuestFail>
        </Quest>
        <PreConditionList>
          <Condition>
            <Template>ConditionUnlocked</Template>
            <Values>
              <Condition />
              <ConditionUnlocked>
                <UnlockNeeded>1010216</UnlockNeeded>
              </ConditionUnlocked>
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
                          <PlayerCounter>ObjectBuilt</PlayerCounter>
                          <Context>1010294</Context>
                          <ComparisonOp>AtLeast</ComparisonOp>
                          <CounterAmount>2</CounterAmount>
                        </ConditionPlayerCounter>
                      </Values>
                    </Condition>
                  </PreConditionList>
                </Values>
              </SubCondition>
            </Item>
          </SubConditions>
        </PreConditionList>
        <Reward>
          <RewardAssets>
            <Item>
              <Reward>150038</Reward>
              <SentToQuestArea>1</SentToQuestArea>
              <Amount>1</Amount>
            </Item>
            <Item>
              <Reward>192540</Reward>
              <SentToQuestArea>1</SentToQuestArea>
              <Amount>1</Amount>
            </Item>
          </RewardAssets>
          <RewardReputation />
          <GenerateIgnoreUnlocks>1</GenerateIgnoreUnlocks>
        </Reward>
        <Objectives>
          <WinConditions>
            <Item>
              <Objective>
                <Template>SustainObjective</Template>
                <Values>
                  <ConditionQuestObjective />
                  <ConditionPlayerCounter>
                    <PlayerCounter>GoodsInStock</PlayerCounter>
                    <Context>1010216</Context>
                    <CounterAmount>30</CounterAmount>
                  </ConditionPlayerCounter>
                  <ConditionQuestSustain>
                    <SustainTime>30000</SustainTime>
                    <ResetTimer>1</ResetTimer>
                  </ConditionQuestSustain>
                  <ConditionPropsExecutionPlaceSettings>
                    <ExecutionPlaceConfirmOnReached>0</ExecutionPlaceConfirmOnReached>
                  </ConditionPropsExecutionPlaceSettings>
                </Values>
              </Objective>
            </Item>
          </WinConditions>
        </Objectives>
        <QuestOptional>
          <HasStarterObject>Specific</HasStarterObject>
          <StarterObject>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <Condition />
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
                            <MatcherGUID>2001000003</MatcherGUID>
                            <DistanceToContext>3</DistanceToContext>
                          </SpawnArea>
                        </Values>
                      </ObjectSpawnArea>
                      <DoSetVisualObjectOwner>1</DoSetVisualObjectOwner>
                      <VisualObjectOwner>Third_party_01_Queen</VisualObjectOwner>
                    </ConditionObjectSpawnedObject>
                    <ConditionScanner />
                    <ConditionObjectiveSignsAndFeedback />
                  </Values>
                </StarterObjectObject>
              </ConditionStarterObject>
              <ConditionQuestObjective />
              <ConditionPropsSessionSettings />
            </Values>
          </StarterObject>
        </QuestOptional>
      </Values>
    </Asset>
  </ModOp>
  ```
  </details>
- While GUID 2001000000 is a copy of `<GUID>133229</GUID><Name>Queen Object + Standee</Name>` made visible and with proper `MeshPlacement`:
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <ModOp Type="addNextSibling" GUID="133229">
    <Asset>
      <BaseAssetGUID>133229</BaseAssetGUID>
      <Values>
        <Standard>
          <GUID>2001000000</GUID>
          <Name>Queen Quest Starter</Name>
        </Standard>
        <Mesh>
          <MeshPlacement>Default</MeshPlacement>
          <InitialVisibility>1</InitialVisibility>
        </Mesh>
      </Values>
    </Asset>
  </ModOp>
  ```
  </details>
- And GUID 2001000003 is a Matcher Asset, which is looking for a Schnapps Destillery owned by us (Matchers can only be used in actions spawning things nearby X and define a few details about next to what exactly we want to spawn something):
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <ModOp Type="addNextSibling" GUID="150725">
    <Asset>
      <Template>Matcher</Template>
      <Values>
        <Standard>
          <GUID>2001000003</GUID>
          <Name>Schnapps Destillery Processing</Name>
        </Standard>
        <Matcher>
          <Criterion>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <MatcherCriterion />
              <MatcherCriterionAnd>
                <CriterionOperandListAnd>
                  <Item>
                    <CriterionOperand>
                      <Template>MatcherCriterionGUID</Template>
                      <Values>
                        <MatcherCriterion />
                        <MatcherCriterionGUID>
                          <ObjectMatched>1010294</ObjectMatched>
                        </MatcherCriterionGUID>
                      </Values>
                    </CriterionOperand>
                  </Item>
                  <Item>
                    <CriterionOperand>
                      <Template>MatcherCriterionOwner</Template>
                      <Values>
                        <MatcherCriterion />
                        <MatcherCriterionOwner>
                          <UseProcessingParticipant>1</UseProcessingParticipant>
                        </MatcherCriterionOwner>
                      </Values>
                    </CriterionOperand>
                  </Item>
                </CriterionOperandListAnd>
              </MatcherCriterionAnd>
            </Values>
          </Criterion>
        </Matcher>
      </Values>
    </Asset>
  </ModOp>
  ```
  </details>


## A7_QuestDeliveryObject
Now real quick without explaining everything again, lets make a simple Quest from pirate Harlow to deliver wood, sails and money with ship to her lighthouse and also starting there. You will get reputation from her, but negative reputation from LaFortune when completing the Quest. As PreCondition we will check for TradeRights and abort the Quest if you have no longer TradeRights.

### QuestOptional
As [QuestOptional](./0-Properties-Quest-QuestPool.md#questoptional) we will use `ConditionObjectPrebuiltObject` and start the Quest at the lighthouse from Harlow. 


## Starting the Quests: QuestPool
See here how to [create a QuestPools](./Creating%20QuestPools.md)

---

## Advanced Sustain Quest
Now we will expand the Sustain Quest we already created above and add some "complicated" stuff to it:
- Spawn the Starter Object (the Queen) on the island with the highest Population from the player.
- Make use of the QuestArea (Area==Island), so you have to sustain and deliver the schnapps on that island, not anywhere else.
- Add another Objective, executed Linear: Delivery on Island (give the Queen some schnapps), where the amount to deliver should scale based on progresslevel (this only works for delivery quests)
- Make the Queen-starter object moveable and move her after delivering her schnapps to the next tavern while you have to sustain an amount of schnapps.  

TODO Explanation  

- The advanced Quest and Starter Object look like this now:
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <ModOp Type="addNextSibling" GUID="152264">
    <Asset>
      <Template>A7_QuestSustain</Template>
      <Values>
        <Standard>
          <GUID>2001000001</GUID>
          <Name>Sustain Schnapps - Queen</Name>
        </Standard>
        <Quest>
          <InvitationMessage>
            <Notification>
              <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
              <Values>
                <NotificationSubtitle>
                  <SubtitleGroup>-85031022</SubtitleGroup>
                </NotificationSubtitle>
              </Values>
            </Notification>
          </InvitationMessage>
          <QuestGiver>75</QuestGiver>
          <StoryText>14038</StoryText>
          <MaxSolveCount>-1</MaxSolveCount>
          <QuestTimeLimit>120000</QuestTimeLimit>
          <QuestCategory>RandomQuest</QuestCategory>
          <QuestActivation>ManualActivation</QuestActivation>
          <IsAbortable>1</IsAbortable>
          <DelayTimer>10000</DelayTimer>
          <HasExclusiveQuestGiver>0</HasExclusiveQuestGiver>
          <ResetPreconditionsAfterQuestWasTriggered>1</ResetPreconditionsAfterQuestWasTriggered>
          <QuestDifficulty>Medium</QuestDifficulty>
          <QuestSessionDependencies>
            <Item>
              <SessionOrRegion>180023</SessionOrRegion>
            </Item>
          </QuestSessionDependencies>
          <CanBeActiveForMultipleParticipants>1</CanBeActiveForMultipleParticipants>
          <ReputationQuestFail>
            <ReputationFailList />
          </ReputationQuestFail>
        </Quest>
        <PreConditionList>
          <Condition>
            <Template>ConditionMutualAreaInSubconditions</Template>
            <Values>
              <Condition>
                <SubConditionCompletionOrder>Linear</SubConditionCompletionOrder>
              </Condition>
              <ConditionMutualAreaInSubconditions>
                <AreaFlags>MostPopulatedArea</AreaFlags>
                <UseProcessingSession>1</UseProcessingSession>
              </ConditionMutualAreaInSubconditions>
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
                          <UnlockNeeded>1010216</UnlockNeeded>
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
                      <Template>ConditionPlayerCounter</Template>
                      <Values>
                        <Condition />
                        <ConditionPlayerCounter>
                          <PlayerCounter>ObjectBuilt</PlayerCounter>
                          <Context>1010294</Context>
                          <ComparisonOp>AtLeast</ComparisonOp>
                          <CounterAmount>3</CounterAmount>
                          <CounterScope>Area</CounterScope>
                          <CounterScopeUseCurrentContext>0</CounterScopeUseCurrentContext>
                          <CounterScopeKeepFirstFound>0</CounterScopeKeepFirstFound>
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
                      <Template>ConditionPlayerCounter</Template>
                      <Values>
                        <Condition />
                        <ConditionPlayerCounter>
                          <PlayerCounter>ObjectBuilt</PlayerCounter>
                          <Context>1010358</Context>
                          <ComparisonOp>AtLeast</ComparisonOp>
                          <CounterAmount>1</CounterAmount>
                          <CounterScope>Area</CounterScope>
                          <CounterScopeUseCurrentContext>0</CounterScopeUseCurrentContext>
                          <CounterScopeKeepFirstFound>0</CounterScopeKeepFirstFound>
                        </ConditionPlayerCounter>
                      </Values>
                    </Condition>
                  </PreConditionList>
                </Values>
              </SubCondition>
            </Item>
          </SubConditions>
        </PreConditionList>
        <Reward>
          <RewardAssets>
            <Item>
              <Reward>150038</Reward>
              <SentToQuestArea>1</SentToQuestArea>
              <Amount>1</Amount>
            </Item>
            <Item>
              <Reward>192540</Reward>
              <SentToQuestArea>1</SentToQuestArea>
              <Amount>1</Amount>
            </Item>
          </RewardAssets>
          <RewardReputation />
          <GenerateIgnoreUnlocks>1</GenerateIgnoreUnlocks>
        </Reward>
        <Objectives>
          <WinConditionCompletionOrder>Linear</WinConditionCompletionOrder>
          <WinConditions>
            <Item>
              <Objective>
                <Template>DeliveryObjective</Template>
                <Values>
                  <ConditionQuestDelivery>
                    <DeliveryObject_cqd>
                      <Item>
                        <ObjectGUID>1010216</ObjectGUID>
                        <Min>10</Min>
                        <Max>20</Max>
                      </Item>
                    </DeliveryObject_cqd>
                    <DeliveryType>Area</DeliveryType>
                    <UseQuestArea>1</UseQuestArea>
                    <ConfirmOnReach>1</ConfirmOnReach>
                    <DeliveryExecutionPlace>
                      <Template>ConditionObjectStarterObject</Template>
                      <Values>
                        <ConditionScanner />
                        <ConditionObjectStarterObject />
                        <ConditionObjectiveSignsAndFeedback />
                      </Values>
                    </DeliveryExecutionPlace>
                  </ConditionQuestDelivery>
                  <ConditionQuestObjective>
                    <TextCombinedContextValue>12754</TextCombinedContextValue>
                    <ObjectiveSuccessMessage>
                      <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                      <Values>
                        <CharacterNotification>
                          <NotificationTextFemale>133444</NotificationTextFemale>
                        </CharacterNotification>
                        <BaseNotification>
                          <NotificationText>133444</NotificationText>
                        </BaseNotification>
                        <NotificationSubtitle>
                          <SubtitleGroup>911287094</SubtitleGroup>
                        </NotificationSubtitle>
                      </Values>
                    </ObjectiveSuccessMessage>
                    <OnSuccessActions>
                      <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                      <Values>
                        <ActionList>
                          <Actions>
                            <Item>
                              <Action>
                                <Template>ActionMoveObject</Template>
                                <Values>
                                  <Action />
                                  <ObjectFilter>
                                    <ObjectGUID>2001000000</ObjectGUID>
                                    <CheckParticipantID>1</CheckParticipantID>
                                    <ObjectParticipantID>Neutral</ObjectParticipantID>
                                    <CheckQuestStarterSession>1</CheckQuestStarterSession>
                                    <CheckQuestArea>1</CheckQuestArea>
                                    <ObjectRestrictToQuestObjects>1</ObjectRestrictToQuestObjects>
                                  </ObjectFilter>
                                  <ObjectTargetFilter>
                                    <TargetGUID>1010358</TargetGUID>
                                    <TargetCheckParticipantID>1</TargetCheckParticipantID>
                                    <TargetCheckProcessingParticipantID>1</TargetCheckProcessingParticipantID>
                                    <TargetCheckQuestStarterSession>1</TargetCheckQuestStarterSession>
                                    <TargetCheckQuestArea>1</TargetCheckQuestArea>
                                  </ObjectTargetFilter>
                                  <ActionMoveObject>
                                    <IgnoreEveryDistractionDuringMove>1</IgnoreEveryDistractionDuringMove>
                                    <SearchMode>Closest</SearchMode>
                                  </ActionMoveObject>
                                </Values>
                              </Action>
                            </Item>
                          </Actions>
                        </ActionList>
                      </Values>
                    </OnSuccessActions>
                  </ConditionQuestObjective>
                  <ObjectiveScaling>
                    <ScaleObjectives>1</ScaleObjectives>
                    <ScaleFactors>
                      <EarlyGame>
                        <Factor>1</Factor>
                      </EarlyGame>
                      <EarlyMidGame>
                        <Factor>2</Factor>
                      </EarlyMidGame>
                      <MidGame>
                        <Factor>3</Factor>
                      </MidGame>
                      <LateMidGame>
                        <Factor>4</Factor>
                      </LateMidGame>
                      <LateGame>
                        <Factor>5</Factor>
                      </LateGame>
                      <EndGame>
                        <Factor>6</Factor>
                      </EndGame>
                    </ScaleFactors>
                  </ObjectiveScaling>
                  <ConditionPropsSessionSettings />
                </Values>
              </Objective>
            </Item>
            <Item>
              <Objective>
                <Template>SustainObjective</Template>
                <Values>
                  <ConditionQuestObjective>
                    <TextCombinedContextValue>20078</TextCombinedContextValue>
                  </ConditionQuestObjective>
                  <ConditionPlayerCounter>
                    <PlayerCounter>GoodsInStock</PlayerCounter>
                    <Context>1010216</Context>
                    <CounterAmount>30</CounterAmount>
                    <CounterScope>Area</CounterScope>
                    <CounterScopeUseCurrentContext>0</CounterScopeUseCurrentContext>
                  </ConditionPlayerCounter>
                  <ConditionQuestSustain>
                    <SustainTime>30000</SustainTime>
                    <ResetTimer>1</ResetTimer>
                    <LimitToQuestArea_Sustain>1</LimitToQuestArea_Sustain>
                  </ConditionQuestSustain>
                  <ConditionPropsExecutionPlaceSettings>
                    <ExecutionPlaceConfirmOnReached>0</ExecutionPlaceConfirmOnReached>
                  </ConditionPropsExecutionPlaceSettings>
                </Values>
              </Objective>
            </Item>
          </WinConditions>
        </Objectives>
        <QuestOptional>
          <HasStarterObject>Specific</HasStarterObject>
          <StarterObject>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Values>
              <Condition />
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
                            <MatcherGUID>2001000003</MatcherGUID>
                            <DistanceToContext>4</DistanceToContext>
                            <LimitToQuestArea>1</LimitToQuestArea>
                          </SpawnArea>
                        </Values>
                      </ObjectSpawnArea>
                      <ObjectDespawn>Despawn</ObjectDespawn>
                      <DoSetVisualObjectOwner>1</DoSetVisualObjectOwner>
                      <VisualObjectOwner>Third_party_01_Queen</VisualObjectOwner>
                    </ConditionObjectSpawnedObject>
                    <ConditionScanner />
                    <ConditionObjectiveSignsAndFeedback />
                  </Values>
                </StarterObjectObject>
              </ConditionStarterObject>
              <ConditionQuestObjective />
              <ConditionPropsSessionSettings />
            </Values>
          </StarterObject>
        </QuestOptional>
      </Values>
    </Asset>
  </ModOp>
  
  <!-- Walking Land Unit Queen as Starter (has no walking animation, but just for demonstration) -->
  <ModOp Type="addNextSibling" GUID="133229">
    <Asset>
      <Template>LandSpy</Template>
      <Values>
        <Standard>
          <GUID>2001000000</GUID>
          <Name>Queen Quest Starter</Name>
          <IconFilename>data/ui/2kimages/main/profiles/3rd_party_01.png</IconFilename>
        </Standard>
        <Mesh>
          <MeshPlacement>OnTerrainPhysics</MeshPlacement>
        </Mesh>
        <Object>
          <Variations>
            <Item>
              <Filename>data/dlc08/graphics/quest/quest_units/queen/queen.cfg</Filename>
            </Item>
          </Variations>
        </Object>
        <Walking>
          <WalkSequence>walk01</WalkSequence>
          <IdleSequence2>idle01</IdleSequence2>
          <DiscoverRadius>10</DiscoverRadius>
          <ReservationLength>0</ReservationLength>
          <ReservationWidth>0</ReservationWidth>
          <TurnAroundRadius>0</TurnAroundRadius>
          <Acceleration>5</Acceleration>
          <TurnRadius>0.1</TurnRadius>
          <TurnSpeed>200</TurnSpeed>
          <TurnDeceleration>0</TurnDeceleration>
          <TurnMovement>70</TurnMovement>
          <LeaningSpeed>0.01</LeaningSpeed>
          <LeaningDamping>0.01</LeaningDamping>
          <ForwardSpeed>1.0</ForwardSpeed>
          <WindMinSlowdownFactor>1</WindMinSlowdownFactor>
          <WindMaxSpeedupFactor>1</WindMaxSpeedupFactor>
          <MinSlowdownFactor>1</MinSlowdownFactor>
          <CurveSegmentDensity>High</CurveSegmentDensity>
          <PathPlannerLayer>Street</PathPlannerLayer>
        </Walking>
        <CommandQueue>
          <IsPlayerControllableVehicle>0</IsPlayerControllableVehicle>
          <InsecurityAttractiveness>0</InsecurityAttractiveness>
        </CommandQueue>
        <Drifting>
          <OverrideAssetWidthAndLength>0</OverrideAssetWidthAndLength>
          <AffectedByDriftingWhileIdle>0</AffectedByDriftingWhileIdle>
          <AffectedByDriftingWhileMoving>0</AffectedByDriftingWhileMoving>
          <CausesDrifting>0</CausesDrifting>
        </Drifting>
      </Values>
    </Asset>
  </ModOp>
  ```
  </details>
