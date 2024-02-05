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
Here ([Quest Messages](./0-Properties-Quest-QuestPool.md#startermessagesuccessmessage-)) we read, that some default messages are added automatically depending on the QuestGiver. And since the structure is inherited from the template anyways, we can clear up the code already by just removing all these Message nodes and only leave the ones where we want to add custom text/audio.  

### On-Actions:
The very same is true for these [On-Actions](./0-Properties-Quest-QuestPool.md#onqueststartonquestdeclined), simply clear the code up be removing all of them you don't want to add actions to.

### Quest
Now we finally come to the [relevant values](./0-Properties-Quest-QuestPool.md#questgiver).  
- We want to have **Queen GUID 75** as our QuestGiver, you can either find his GUID in the assets.xml yourself or use a tool like this: https://a1800.net/?langSearch=english&textSearch=The+Queen .  
- Enter your GUIDs for StoryText/DescriptionText/AlternativeRewardTitle/QuestHints, see here how to add your own strings: https://github.com/anno-mods/modding-guide/tree/main/hier0nimus-tutorials/02-making-new-specialists#structure-of-the-file
It is enough to have these text-GUIDs defined in the text files, no need to add assets for them in the assets.xml file.
- [MaxCallOut/MaxSolveCount/MaxAbortCount](./0-Properties-Quest-QuestPool.md#maxcalloutmaxsolvecountmaxabortcount): For now our Quest should only be solveable a single time, but how often it is triggered or aborted we don't care. So we set MaxSolveCount to 1 and the others will not be mentioned, which makes them default to -1==disabled.
- [CountForQuestLimit](./0-Properties-Quest-QuestPool.md#countforquestlimit) will not be mentioned and defaults to 1, relevant later for QuestPools.
- [PreActivationTimer/QuestTimeLimit](./0-Properties-Quest-QuestPool.md#preactivationtimerquesttimelimit): We don't want our quest to be cancelled while it is offered, so we dont mention PreActivationTimer which defaults to 0==disabled. And as time to complete the Quest we use 40 minutes (2400000 in ms).
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
- [ReputationQuestFail/ReputationQuestDeclined/Reward-RewardReputation](./0-Properties-Quest-QuestPool.md#reputationquestfailreputationquestdeclinedreward-rewardreputation): Since this is a Quest for The Queen, who does not really care for what we do, we don't need to deal with reputation and just dont add them to use the default which does nothing I think (template has -2/+3 ReputationAmount but no ReputationParticipant defined, which defaults to Human0 and no one cares about the opinion of Human0 about us).  
As `RewardAsset` we will use the MoneyPool and an Item from the Archibald Rewardpool GUID 192540 `<Name>Third_party_02 (Archibald Blake) Forced Voluntary Reward</Name>` (but of course you can also create your own RewardPool with custom rewards and chances)  
In the vanilla Quest above you will see alot of `VectorElement/InheritanceMapV2`, we do not really know if this does anything at all, but even if it does, it is not needed. Simply remove all of this and just enter the allowed nodes based on p-t.xml. 
- [HasStarterSpeechBubble/StarterSpeechBubble/HasSuccessSpeechBubble/SuccessSpeechBubble](./0-Properties-Quest-QuestPool.md#hasstarterspeechbubblestarterspeechbubblehassuccessspeechbubblesuccessspeechbubble): I don't care for these Speech-Bubbles, so I will remove them.
- [CanBeActiveForMultipleParticipants](./0-Properties-Quest-QuestPool.md#canbeactiveformultipleparticipants): I'm fine with having multiple humans at the same time doing this Quest, so I set this to 1.

### PreConditionList
Here you can add whatever conditions you want that must be true before this Quest is allowed to be triggered.  
Since our Quest is about sustaining an amount of schnapps, we will only start the Quest after the player unlocked the product and built at least 2 Schnapps Distilleries.  

### QuestOptional
As [QuestOptional](./0-Properties-Quest-QuestPool.md#questoptional) we will use `ConditionObjectSpawnedObject ` and spawn a Queen starter-object near of our own Schnapps Distilleries. As Infolayer (the icon around our quest starter) we will use the default quest marker (same for minimap).

### Adding the Quest Asset to assets.xml:
As mentioned ([here](./0-Properties-Quest-QuestPool.md#questsgroupssubpools), the game often uses Group GUIDs to add Pools to QuestPools (and Items to Rewardpools!). This means it does matter where you add your Quest (or Item) Asset with ModOp AddNextSibling, to not accidently adding your Asset to a vanilla Pool. For Quests I think it is safe to add your **Quest next to GUID 152264** and for **Items next to GUID 112574**, because these do not seem to belong to any Group that has its own GUID.  
- Our Quest Code:


## A7_QuestDeliveryObject
Quest from pirate. reputation invert from other pirate, start on prebuilt lighthouse, precondition peace and abort if no longer peace. delivery wood, sails and money with ship.

### QuestOptional
As [QuestOptional](./0-Properties-Quest-QuestPool.md#questoptional) we will use `ConditionObjectPrebuiltObject` and start the Quest at the lighthouse from Harlow. 

