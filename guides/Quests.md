# WIP Tutorial Quests, written by Serp:

The Anno devs meanwhile finally published an xml file that contains all allowed properties and values with sometimes a short description (next to assets.xml of game files):
properties-toolone.xml ( https://github.com/anno-mods/modding-guide/blob/main/documentation/properties-toolone.xml will call it p-t.xml as abbreviation)
You can look up many quest related values there to find out what they do.

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
(In Triggers it is called `TriggerActions/Item/TriggerAction`, while on some other locations is is `Actions/Item/Action` instead, compare with vanilla if you are unsure what to use)
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
Starting a Quest with `ActionStartQuest` does ignore many things Quests can have defined, especially it does ignore the `PreConditionList` of a Quest! If you want to use all features from Quests, you maybe better should use a QuestPool https://github.com/anno-mods/modding-guide/tree/main/guides/Quests.md#QuestPools


### Advanced Usage:
TODO evlt auch Interhit UseCurrentSession GetQuestSessionFromArea usw eingehen.



## QuestPools:
(Again take a look at p-t.xml and search for `<Name>QuestPool</Name>` (the one that has "DisabledByDefault" difrectly below it) to see all allowed values and some description.)

QuestPools are a helper construct to automatically start quests on regular basis if PreConditions are fullfilled. Eg. if you made like 10 Quests that simply should be chosen randomly if preconditions are fullfilled (just like the games Random Quests) you can put your Quests in a pool and define how often the pool should start up to how many quests at once and so on.
It also supports adding QuestLines into the pool instead of Quests directly to make sure they are started one after the other.

Example: `<GUID>150082</GUID> <Name>OQ_B.Jorgensen_Pool</Name>`  
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
Another way to add yours quests is listing them one by one using:
```xml
<Quests>
  <Item>
    <Quest>113430</Quest>
  </Item>
  <Item>
    <Quest>113432</Quest>
  </Item>
</Quests>
```
