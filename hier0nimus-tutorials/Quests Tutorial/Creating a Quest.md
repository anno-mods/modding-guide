# Creating a Quest

At first you should think about what kind of Quest you would like to have.  
The vanilla game offers several templates for different kinds of quests (search templates.xml for `<Name>QuestTypes</Name>`), mostly different regarding their WinCondition and some prefilled text. Using the correct template will make it a bit easier, but is not mandatory. Since all Quest templates have as far as I know the very same properties, you can use any of them and replace the values like you want and use any WinCondition and combine them like you want.

For this Tutorial we will create 2 simple Quests (search assets.xml of the game for vanilla examples of other quest types):
- a A7_QuestSustain quest, like "own X for a time of Y".
- a delivery quest (deliver product x with a ship to kontor of Y) using template A7_QuestDeliveryObject

## - A7_QuestSustain
It is always good to take a look how the vanilla game made this, so we will search for a A7_QuestSustain that looks similar to what we want to do and copy paste and adjust it.  
<details>
<summary>Vanilla Code GUID 152411 : Champaign shower - Gasparov</summary>  

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
Here [Quest Messages](./0-Properties-Quest-QuestPool.md#startermessagesuccessmessage-) we read, that some default messages are added automatically depending on the QuestGiver. And since the structure is inherited from the template anyways, we can clear up the code already by just removing all these Message nodes and only leave the ones where we want to add custom text/audio.  

### On-Actions:
The very same is true for these [On-Actions](./0-Properties-Quest-QuestPool.md#onqueststartonquestdeclined), simply clear the code up be removing all of them you don't want to add actions to.

### Quest
Now we finally come to the [relevant values](./0-Properties-Quest-QuestPool.md#questgiver).  
- We want to have **Archibald GUID 45** as our QuestGiver, you can either find his GUID in the assets.xml yourself or use a tool like this: https://a1800.net/?langSearch=english&textSearch=Archibald+Blake .  
- Enter your GUIDs for StoryText/DescriptionText/AlternativeRewardTitle/QuestHints, see here how to add your own strings: https://github.com/anno-mods/modding-guide/tree/main/hier0nimus-tutorials/02-making-new-specialists#structure-of-the-file
It is enough to have these text-GUIDs defined in the text files, no need to add assets for them in the assets.xml file.
- For now our Quest should only be available a single time [MaxCallOut/MaxSolveCount/MaxAbortCount](./0-Properties-Quest-QuestPool.md#maxcalloutmaxsolvecountmaxabortcount), so we set all of these values to 1.
- [MaxCallOut/MaxSolveCount/MaxAbortCount](./0-Properties-Quest-QuestPool.md#countforquestlimit) will also be 1, relevant for later for QuestPools.
- [PreActivationTimer/QuestTimeLimit](./0-Properties-Quest-QuestPool.md#preactivationtimerquesttimelimit): We don't want our quest to be cancelled while it is offered, so we set the first to 0. And as time to complete the Quest we use 40 minutes (2400000 in ms).
- 

## - A7_QuestDeliveryObject
