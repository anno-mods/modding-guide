# Anno 1800 Trigger Guide

A trigger watches for something and performs actions when its requirements are met. You can use one to unlock a building, react to an event, start a script, change a ship, or coordinate a longer sequence. The difficult part is usually deciding **when each requirement becomes eligible, what the trigger remembers, and when it starts again**.

This guide starts with a normal vanilla trigger and gradually introduces more features. Read the first chapters in order if you are new to triggers. Later, use the table of contents or search for an exact XML name such as `IsOptional`. All examples concern **Anno 1800**, not Anno 117.

**How to read the evidence:** “Vanilla data” describes exported structure and defaults. “Serp confirmation” records the author's explicit clarification. “Very likely”, “probable” and “unresolved” retain their stated uncertainty. None of the offline checks described here is a new game or multiplayer test. You still need the feature-specific vanilla audit before applying these patterns to a different object, quest, action or helper version.

## Contents

1. [What a trigger does](#what-a-trigger-does)
2. [Start with a normal vanilla trigger](#vanilla-trigger)
3. [Understand the XML structure and defaults](#xml-structure)
4. [Build your first custom trigger](#first-custom-trigger)
5. [Choose a condition and an action](#choose-conditions)
6. [Add subtriggers and understand completion](#subtriggers)
7. [Choose Parallel, Linear or MutuallyExclusive](#completion-modes)
8. [Add optional branches with IsOptional](#optional)
9. [Register, unregister and repeat](#registration)
10. [Choose participants and context](#participants-context)
11. [Use Lua, multiplayer and Coop](#lua-multiplayer)
12. [Handle savegames and mod removal](#savegames)
13. [Know the special cases](#special-cases)
14. [Complete recipes](#recipes)
15. [Learn from six real mod triggers](#real-mods)
16. [Troubleshooting and design checklist](#troubleshooting)
17. [Condition catalogue and common fields](#condition-catalogue)
18. [Sources, uncertainty and validation](#sources)

## Keyword index

| Search term | Explanation |
| --- | --- |
| `TriggerCondition`, `TriggerActions`, `AutoCreateTrigger`, `IsBaseAutoCreateAsset` | [XML structure](#xml-structure) |
| `Condition` in a ModOp | [Patch-time versus gameplay](#modop-condition) |
| `SubTriggers`, parent condition, simultaneous conditions | [Subtriggers](#subtriggers) |
| `SubConditionCompletionOrder`, `Parallel`, `Linear`, `MutuallyExclusive` | [Completion modes](#completion-modes) |
| `IsOptional` | [Optional branches](#optional) |
| `AutoRegisterTrigger`, `ActionRegisterTrigger`, `UnregisterTrigger` | [Registration](#registration) |
| `ActionResetTrigger`, `ResetTrigger` | [Repetition](#resettrigger) |
| `Trigger`, `FeatureUnlock`, `UnlockableAsset`, `AutoSelfUnlock` | [Asset kinds](#asset-kinds) |
| `UsedBySecondParties`, processing participant, `CheckedParticipant`, `CheckSpecificParticipant` | [Participants](#participants-context) |
| `ObjectFilter`, `ObjectTargetFilter`, `CheckParticipantID`, `ObjectUseParentConditionObjects` | [Object targets](#object-targets) |
| `CounterScope`, `CounterScopeUseCurrentContext`, `UseCurrentSession`, `InheritArea`, `QuestArea` | [Area and session context](#area-session) |
| `ConditionEvent`, `ContextAsset`, `ContextData`, `GUIDUnlocked`, `GUIDLocked` | [Events](#states-events) |
| `ConditionTimer`, `TimeLimit`, `KeepTimerOnUnregister` | [Timers](#timers) |
| `NegateCondition`, `ConditionPropsNegatable`, `UnlockNeeded` | [Negation](#negation) |
| `ActionExecuteScript`, `RegisterTriggerForCurrentParticipant`, `ForceBuild` | [Lua and Coop](#lua-multiplayer) |
| `DefaultLockedState`, missing unlock, code snapshot, save migration | [Savegames](#savegames) |
| `ConditionMutualAreaInSubconditions` | [MutualArea](#mutualarea) |
| `ConditionThreshold`, `ThresholdDuration`, `ConditionEvaluateTextSource` | [Text-source conditions](#text-source-conditions) |
| `ConditionInStorage`, `ConditionIsBuffed`, `ConditionItemUsed` | [Storage, sockets and buffs](#storage-buffs) |
| `QuestStarted`, `ObjectRestrictToQuestObjects`, `LinkAllActionsToQuest`, `LinkAllQuestActionsToQuest` | [Quests](#quests) |

<a id="what-a-trigger-does"></a>
## 1. What a trigger does

Imagine the rule: “When this player reaches a population requirement, unlock these buildings.” The **condition** checks the requirement. The **actions** unlock the buildings. The **owning trigger** connects them and stores the progress of that rule.

A useful first model is:

1. **Register:** make this trigger instance available to evaluate.
2. **Evaluate:** check its main condition and any eligible subordinate branches.
3. **Act:** execute actions at the level that has completed.
4. **Complete:** finish the whole trigger once its required tree is fulfilled.
5. **Repeat, if designed to:** use a reset or a later fresh registration.

An action inside a child can run before the whole tree completes. A completed sibling can also remain remembered while another sibling is still waiting. We will return to both points; they explain many surprising results.

The rule usually exists in a **participant context**: for example, a human company. That is different from “run on only this person's computer”. Coop clients can share one company, and a Lua action can execute on every human client.

<a id="vanilla-trigger"></a>
## 2. Start with a normal vanilla trigger

The native asset `130221`, named `intermediate moderate 4.0`, is a useful example of the ordinary structure used in vanilla `assets.xml`. It is a `Trigger` with a `ConditionPlayerCounter`, an action list, an empty reset and `TriggerSetup`.

Its counter uses `PopulationByLevel`, context `15000003` and `CounterAmount=1`. With the effective native defaults, this checks for **at least one current inhabitant of that population level** in the processing participant's global counter. It then unlocks a list of assets and unhides another list. Unlocking and unhiding are separate operations.

<details>
<summary>Original vanilla asset 130221 — complete Asset, not a ModOps file</summary>

```xml
<Asset>
  <Template>Trigger</Template>
  <Values>
    <Standard>
      <GUID>130221</GUID>
      <Name>intermediate moderate 4.0</Name>
      <IconFilename>data/ui/2kimages/main/profiles/resident_tier04.png</IconFilename>
    </Standard>
    <Trigger>
      <TriggerCondition>
        <Template>ConditionPlayerCounter</Template>
        <Values>
          <Condition/>
          <ConditionPlayerCounter>
            <PlayerCounter>PopulationByLevel</PlayerCounter>
            <Context>15000003</Context>
            <CounterAmount>1</CounterAmount>
          </ConditionPlayerCounter>
        </Values>
      </TriggerCondition>
      <TriggerActions>
        <Item>
          <TriggerAction>
            <Template>ActionUnlockAsset</Template>
            <Values>
              <Action/>
              <ActionUnlockAsset>
                <UnlockAssets>
                  <Item>
                    <Asset>140043</Asset>
                  </Item>
                  <Item>
                    <Asset>130047</Asset>
                  </Item>
                  <Item>
                    <Asset>130041</Asset>
                  </Item>
                  <Item>
                    <Asset>130120</Asset>
                  </Item>
                  <Item>
                    <Asset>130155</Asset>
                  </Item>
                  <Item>
                    <Asset>130175</Asset>
                  </Item>
                </UnlockAssets>
                <UnhideAssets>
                  <Item>
                    <Asset>140040</Asset>
                  </Item>
                  <Item>
                    <Asset>130051</Asset>
                  </Item>
                  <Item>
                    <Asset>140052</Asset>
                  </Item>
                  <Item>
                    <Asset>140053</Asset>
                  </Item>
                  <Item>
                    <Asset>1010524</Asset>
                  </Item>
                  <Item>
                    <Asset>1010333</Asset>
                  </Item>
                </UnhideAssets>
              </ActionUnlockAsset>
            </Values>
          </TriggerAction>
        </Item>
      </TriggerActions>
      <ResetTrigger>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <EmptyAutoCreateValue/>
        </Values>
      </ResetTrigger>
    </Trigger>
    <TriggerSetup/>
  </Values>
</Asset>
```

</details>

Read the example from the outside inward:

| Part | What to notice |
| --- | --- |
| `Standard/GUID` | The identity of the owning asset. Do not copy a vanilla GUID as your new trigger's identity. |
| `Trigger/TriggerCondition` | The embedded condition has its own `Template` and `Values`. |
| `ConditionPlayerCounter/Context` | A GUID interpreted by the selected counter, here a population level. It is not a generic “target GUID” field. |
| `TriggerActions/Item/TriggerAction` | A list of embedded actions; here `ActionUnlockAsset`. |
| `UnlockAssets` versus `UnhideAssets` | A building may need to become visible as well as unlocked, depending on its actual integration. |
| `ResetTrigger` with `EmptyAutoCreateValue` | No repeating reset is configured in this example. |
| Empty `TriggerSetup` | It retains effective template values; it does not mean all options are disabled. |

The condition does not serialize every field. For this counter, relevant exported defaults include `ComparisonOp=AtLeast`, `CounterScope=Global` and `CounterValueType=Current`. The Trigger template sets `AutoRegisterTrigger=1` and `UsedBySecondParties=1`. We will make human-only scope explicit in our custom example.

The original and all of its unlock/unhide targets, counter context and base chains were audited against the current source. This example teaches the trigger structure; it is not an instruction to copy its progression rewards into another mod. The audit covered the current assets.xml, templates.xml, properties-toolone.xml, properties.xml and datasets.xml exports; [the audit procedure is explained below](#vanilla-audit).

<a id="xml-structure"></a>
## 3. Understand the XML structure and defaults

An embedded condition or action resembles a small asset. It has a template and property blocks but usually no independent `Standard/GUID`. A subtrigger is an embedded `AutoCreateTrigger`, containing another `Trigger` tree.

| XML location | Purpose |
| --- | --- |
| Owning `Asset/Template` | Chooses `Trigger`, `FeatureUnlock` or another audited owning asset kind. |
| Owning `Asset/Values/Standard` | Contains the GUID and descriptive name. |
| `Values/Trigger/TriggerCondition` | The main condition. |
| `TriggerCondition/Values/Condition` | Shared condition settings. Completion order applies to this condition's children; `IsOptional` describes this condition's relationship to its parent. |
| `TriggerCondition/Values/ConditionPlayerCounter` | The specialized properties of this particular condition. |
| `Values/Trigger/TriggerActions` | Actions for completion at this level. |
| `Values/Trigger/SubTriggers/Item/SubTrigger` | A child trigger, with another `Template` and `Values/Trigger`. |
| `Values/Trigger/ResetTrigger` | An embedded reset tree, not an external trigger GUID. |
| `Values/TriggerSetup` | Owning-asset registration and participant settings. |

`Template` and property names are not always identical. For example, template `ConditionUnlockedList` uses property **`ConditionUnlockList`**. Copy the actual template contract rather than guessing the spelling.

### What an empty property means

`<Condition/>` supplies no local field overrides. The effective default for `SubConditionCompletionOrder` is `Parallel`. Similarly, `<TriggerSetup/>` does not disable registration or second-party use.

The Trigger template supplies `ConditionAlwaysTrue` and an empty reset as embedded defaults. The generic Trigger property's defaults mention other values, including `ConditionActiveRegion`. You must consider **the concrete template's override**, not just the generic property block. Missing serialized Boolean fields are not automatically documented as `0`; look up their effective definitions.

`IsBaseAutoCreateAsset=1` means “use the inherited embedded asset”. It does not mean “select whichever new condition property I happen to add”. When changing the kind of a condition, specify the intended `Template` and its valid properties explicitly.

<a id="asset-kinds"></a>
### Trigger, AutoCreateTrigger, FeatureUnlock and UnlockableAsset

| Kind | Use |
| --- | --- |
| `Trigger` | An identified condition/action tree. |
| `AutoCreateTrigger` | An inline child or reset tree without its own Standard/GUID. |
| `FeatureUnlock` | A trigger plus `Locked` state. Its template also sets `AutoSelfUnlock=1`. Audit that behavior when using it as a signal. |
| `UnlockableAsset` | A named lock/unlock state with no built-in trigger. Useful for a result or signal controlled elsewhere. |

An `UnlockableAsset` used as a signal does not produce the signal by itself. Something must unlock or relock it. Likewise, choosing `FeatureUnlock` is not a substitute for understanding the condition and registration state.

<a id="first-custom-trigger"></a>
## 4. Build your first custom trigger

Start with the same population condition as the vanilla example. Instead of unlocking vanilla progression assets, unlock a private result asset. This keeps the first exercise small and gives you a state that later examples can inspect.

**Example convention:** uppercase tokens such as `CUSTOM_TRIGGER_GUID` and `RESULT_GUID` are placeholders, not valid GUID values. Replace every token with an allocated, collision-free integer GUID. Use the same integer for every occurrence of the same token within that example. Do not deploy the offline fixture bindings. Each complete recipe is an independent example, not a set of files intended to be installed together.

<details>
<summary>First custom population trigger — complete ModOps; replace GUID tokens</summary>

```xml
<ModOps>
  <ModOp Type="AddNextSibling" GUID="130248">
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>RESULT_GUID</GUID>
          <Name>Documentation example RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>CUSTOM_TRIGGER_GUID</GUID>
          <Name>Documentation example CUSTOM_TRIGGER_GUID</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionPlayerCounter</Template>
            <Values>
              <Condition/>
              <ConditionPlayerCounter>
                <PlayerCounter>PopulationByLevel</PlayerCounter>
                <Context>15000003</Context>
                <ComparisonOp>AtLeast</ComparisonOp>
                <CounterAmount>1</CounterAmount>
                <CounterScope>Global</CounterScope>
                <CounterValueType>Current</CounterValueType>
              </ConditionPlayerCounter>
            </Values>
          </TriggerCondition>
          <TriggerActions>
            <Item>
              <TriggerAction>
                <Template>ActionUnlockAsset</Template>
                <Values>
                  <Action/>
                  <ActionUnlockAsset>
                    <UnlockAssets>
                      <Item>
                        <Asset>RESULT_GUID</Asset>
                      </Item>
                    </UnlockAssets>
                  </ActionUnlockAsset>
                </Values>
              </TriggerAction>
            </Item>
          </TriggerActions>
          <ResetTrigger>
            <Template>EmptyAutoCreateValue</Template>
            <Values>
              <EmptyAutoCreateValue/>
            </Values>
          </ResetTrigger>
        </Trigger>
        <TriggerSetup>
          <AutoRegisterTrigger>1</AutoRegisterTrigger>
          <UsedBySecondParties>0</UsedBySecondParties>
        </TriggerSetup>
      </Values>
    </Asset>
  </ModOp>
</ModOps>
```

</details>

This complete ModOps file inserts two assets after existing native anchor `130248`. The anchor is an insertion point, not a parent condition or a trigger to execute. The new `UnlockableAsset` starts locked. The new trigger checks the population, unlocks that result, and completes without a reset.

The custom example explicitly sets `AtLeast`, `Global`, `Current`, `AutoRegisterTrigger=1` and `UsedBySecondParties=0`. These make the intended behavior visible without teaching beginners to rely on an empty setup block. `UsedBySecondParties=0` selects the ordinary human-only workflow; it does not make a Lua action execute on only one client.

Put the bound example in your mod's `data/config/export/main/asset/assets.xml`, alongside normal `modinfo.json` metadata. A real mod needs a stable ModID and dependencies for every shared helper it uses. The isolated first example does not require a shared helper.

<a id="modop-condition"></a>
### ModOp Condition is a different mechanism

The XML ModOp is applied when the loader patches game data. Its `Condition="..."` attribute decides whether that patch is applied. A `TriggerCondition` is evaluated by the game during gameplay. They have different languages, purposes and lifetimes.

Do not place a gameplay condition in a ModOp attribute. For Anno 1800, use the supported `Type="..."`, `GUID="..."` and `Path="..."` operation forms. In the inspected loader, XPath conditions must return node selections; scalar expressions such as `Condition="true()"` are not a supported shortcut. Predicates inside a node selection are a different case.

<a id="choose-conditions"></a>
## 5. Choose a condition and an action

Before searching for XML, describe the rule in one sentence: “For this participant, after these prerequisites, when this event/state occurs, affect these objects, and repeat under this reset rule.” Then separate its requirements.

| Question | Usually start with | Check before using it |
| --- | --- | --- |
| Is a mod-owned signal currently unlocked? | `ConditionUnlocked` | Missing GUID behavior; whether you need state or an event. |
| Does a company own enough buildings, ships or population? | `ConditionPlayerCounter` | Counter kind, context GUID/pool, scope, owner and Current versus relative values. |
| Has an event just happened? | `ConditionEvent` | Exact event token and its context fields; listener must already be registered. |
| Has enough eligible time elapsed? | `ConditionTimer` | When the condition becomes eligible, reset design and interruption uncertainty. |
| Is an object close to another object? | `ConditionObjectPosition` | Both object filters, owner-enabling flags, existence and session. |
| Has one participant discovered another? | `ConditionIsDiscovered` | ParticipantRelation direction and processing participant. |
| Are multiple conditions true on the same island? | `ConditionMutualAreaInSubconditions` | Specialized main-condition arrangement; ordinary nested gates do not replace it. |
| Is a quest in a particular state? | `ConditionQuestState` | Quest versus quest-line identity and exact flags. |
| Are goods/items in a storage container? | `ConditionInStorage` | Cargo/storage versus sockets; object existence. |
| Is an appropriate active buff present? | `ConditionIsBuffed` | Active versus passive effect, handler and target context. |

Actions need a separate audit. A condition that finds an object does not necessarily hand that object to every later action. Check the action's filter, supported target property, participant, session and dependencies. A mod may have a correct condition and still affect the wrong objects.

<a id="states-events"></a>
### State checks versus event listeners

`ConditionUnlocked` asks whether a signal is unlocked **now**. `ConditionEvent` with `GUIDUnlocked` listens for an unlock **event after it becomes eligible**. A signal already unlocked before registration can satisfy the state check, but its earlier event is not replayed simply because a listener is added later.

Use a state when delayed observation is acceptable: “Whenever we start, continue if setup is complete.” Use an event when a later occurrence matters: “After A, wait for the next B.” Register the listener before emitting the event. Same-time registration and lock/unlock operations have missed events in recorded mod tests.

`ContextAsset` and `ContextData` are not interchangeable target fields. Their meaning belongs to each event. Use the `SimpleEventType` dataset's exact token; `SessionEnter`, for example, is not `SessionEntered`.

<a id="negation"></a>
### Negate a condition

Where the condition template includes `ConditionPropsNegatable`, `NegateCondition=1` in that property inverts the check. Do not invent a general `Negate` field or use the loader's `!` syntax here.

<details>
<summary>Negated unlocked condition — fragment for Trigger/TriggerCondition</summary>

```xml
<TriggerCondition>
  <Template>ConditionUnlocked</Template>
  <Values>
    <Condition/>
    <ConditionUnlocked>
      <UnlockNeeded>PRESENCE_GUID</UnlockNeeded>
    </ConditionUnlocked>
    <ConditionPropsNegatable>
      <NegateCondition>1</NegateCondition>
    </ConditionPropsNegatable>
  </Values>
</TriggerCondition>
```

</details>

This fragment checks that `PRESENCE_GUID` is still locked. Later, we use that specific pattern to stop a saved trigger after its mod-owned presence asset disappears. Negating an initialization-dependent player marker is a different matter: before initialization finishes, it can wrongly classify a player.

<a id="timers"></a>
### Timers and visible action effects

`ConditionTimer/TimeLimit` uses milliseconds in the reviewed examples: `1000` is one second and `3600000` is one hour. A nested timer becomes relevant after its ancestor gates allow it; do not assume every timer in a tree starts at outer registration.

**Probable, not confirmed:** Serp expects a nested timer to start over when a preceding condition becomes false and later becomes true again. This remains uncertain in the pirate ship-count example. Do not promise accumulated elapsed time, pause/resume, or an uninterrupted full interval without a matching runtime finding. `KeepTimerOnUnregister` describes retention on unregistration; the field alone does not expose every parent-false lifecycle detail.

An action can finish its invocation before its effect appears in a counter. Spawning, deleting and changing object GUIDs have caused completion/reset and next-cycle counter problems. A recorded 1000 ms workaround belongs to that particular example; it is not a universal delay for every action.

<a id="subtriggers"></a>
## 6. Add subtriggers and understand completion

A subtrigger is a smaller trigger under another trigger. It can have a condition, actions and further children. Use the tree to decide when work becomes eligible and where consequential actions belong.

**Central rule, confirmed by Serp:** no subordinate trigger executes before its parent condition is satisfied. This still applies when the parent sets `MutuallyExclusive`. That mode chooses among the parent's children; it does not bypass the parent condition.

For example, “ship near harbor → applicable trade tier → change ship GUID” keeps the change behind the harbor condition. Putting the harbor check next to a trade-tier check as a sibling expresses a different completion arrangement.

### A completed sibling is remembered

With ordinary sibling composition, a condition that completed earlier can remain completed. The main trigger may therefore finish after A was true yesterday and B becomes true today. Earlier child actions may already have run. A flat `Parallel` list is not a live Boolean AND that continuously retests everything together.

Serp's notes also report remembered completed subconditions when the main condition temporarily becomes false. Distinguish this stored progress from parent gating of subordinate execution. Do not assume an ancestor-false transition erases every kind of child progress; the timer's interruption contract remains separately qualified.

### To require several states together, nest the gates

For the reviewed ordinary simultaneous-check pattern, use one child at each level: **A → B → C → action**. Put the guarded action on C, not on A or B. That way it is at the level guarded by all three conditions. Avoid earlier side actions if the chain is intended to be a pure gate.

The complete simultaneous recipe below uses three private unlocked-state gates. It does not automatically generate those input signals; another audited part of your mod must provide them. MutualArea has its own specialized rules and must not be substituted for an ordinary gate chain without checking its contract.

### Put actions at the right level

| Location | When its actions can run |
| --- | --- |
| A child trigger | When that child tree completes under its ancestor gates. It need not wait for unrelated siblings. |
| The root trigger | When the required root tree completes. |
| A reset trigger | When the reset's own tree completes after being armed by completion of the main trigger. |

Sibling actions are useful for genuinely independent intermediate work. They are unsuitable if all actions must wait for a shared final barrier. A partially completed alternative may have had deeper side effects; `MutuallyExclusive` is not a transaction with automatic rollback.

<a id="completion-modes"></a>
## 7. Choose Parallel, Linear or MutuallyExclusive

Set `SubConditionCompletionOrder` in **the parent's `TriggerCondition/Values/Condition`**. It controls that parent's immediate children. Each child may use another mode for its own children.

| Mode | Meaning | Typical use |
| --- | --- | --- |
| `Parallel` | Eligible siblings do not wait for preceding siblings; all required branches must complete. Earlier successes can remain remembered. | Collect several accomplishments in any order. |
| `Linear` | Later siblings become eligible after earlier siblings complete. Earlier success is remembered, not a requirement for simultaneous truth. | A sequence of events or stages. |
| `MutuallyExclusive` | Select the first matching **complete** alternative from top to bottom, behind the parent gate. | Prefer one applicable outcome over another. |

<details>
<summary>Parent A with Parallel children B and C — embedded Trigger fragment</summary>

```xml
<Trigger>
  <TriggerCondition>
    <Template>ConditionUnlocked</Template>
    <Values>
      <Condition>
        <SubConditionCompletionOrder>Parallel</SubConditionCompletionOrder>
      </Condition>
      <ConditionUnlocked>
        <UnlockNeeded>GATE_A_GUID</UnlockNeeded>
      </ConditionUnlocked>
    </Values>
  </TriggerCondition>
  <TriggerActions>
    <Item>
      <TriggerAction>
        <Template>ActionUnlockAsset</Template>
        <Values>
          <Action/>
          <ActionUnlockAsset>
            <UnlockAssets>
              <Item>
                <Asset>RESULT_GUID</Asset>
              </Item>
            </UnlockAssets>
          </ActionUnlockAsset>
        </Values>
      </TriggerAction>
    </Item>
  </TriggerActions>
  <SubTriggers>
    <Item>
      <SubTrigger>
        <Template>AutoCreateTrigger</Template>
        <Values>
          <Trigger>
            <TriggerCondition>
              <Template>ConditionUnlocked</Template>
              <Values>
                <Condition/>
                <ConditionUnlocked>
                  <UnlockNeeded>GATE_B_GUID</UnlockNeeded>
                </ConditionUnlocked>
              </Values>
            </TriggerCondition>
            <TriggerActions/>
            <ResetTrigger>
              <Template>EmptyAutoCreateValue</Template>
              <Values>
                <EmptyAutoCreateValue/>
              </Values>
            </ResetTrigger>
          </Trigger>
        </Values>
      </SubTrigger>
    </Item>
    <Item>
      <SubTrigger>
        <Template>AutoCreateTrigger</Template>
        <Values>
          <Trigger>
            <TriggerCondition>
              <Template>ConditionUnlocked</Template>
              <Values>
                <Condition/>
                <ConditionUnlocked>
                  <UnlockNeeded>GATE_C_GUID</UnlockNeeded>
                </ConditionUnlocked>
              </Values>
            </TriggerCondition>
            <TriggerActions/>
            <ResetTrigger>
              <Template>EmptyAutoCreateValue</Template>
              <Values>
                <EmptyAutoCreateValue/>
              </Values>
            </ResetTrigger>
          </Trigger>
        </Values>
      </SubTrigger>
    </Item>
  </SubTriggers>
  <ResetTrigger>
    <Template>EmptyAutoCreateValue</Template>
    <Values>
      <EmptyAutoCreateValue/>
    </Values>
  </ResetTrigger>
</Trigger>
```

</details>

The `Parallel` fragment shows a parent A and two required children B/C. If you want B and C together at the action, use the nested simultaneous recipe instead. Replacing the mode with `Linear` makes C eligible after B completes, rather than making it continuously true alongside B.

### Linear event chains

An event chain “A then B” is not “A and B have happened somewhere in the past”. The B listener must be eligible when B occurs. An earlier B event can be missed. If your intent is simply that two persistent flags eventually become true, state checks may be more suitable than event listeners.

### MutuallyExclusive priority

Suppose the first alternative is “A plus a timer” and the second is “B”. A becoming true does not reserve the outcome while its timer is incomplete. A later complete B branch may win first. If both branches are complete candidates, their top-to-bottom order supplies priority. Keep the consequential outcome action at branch completion.

The native field description includes wording about exclusive children being solvable before the main condition. Serp explicitly clarified the construction rule: **parent gating still applies**. The original wording is retained in [the Condition schema below](#property-condition), alongside its source context. It is not a reason to run ship changes outside the parent's radius check.

<a id="optional"></a>
## 8. Add optional branches with IsOptional

`IsOptional=1` says this condition is not required for completion of its **parent**. It does not mean “run its actions even when false”. A side action still needs its branch's conditions to be satisfied.

Example: a root condition unlocks a required result. An optional child can unlock an extra result if its extra condition is met. The root can finish without that extra condition; the optional action is therefore conditional, not guaranteed.

<details>
<summary>Optional child and its action — fragment for SubTriggers/Item/SubTrigger</summary>

```xml
<SubTrigger>
  <Template>AutoCreateTrigger</Template>
  <Values>
<Trigger>
  <TriggerCondition>
    <Template>ConditionUnlocked</Template>
    <Values>
      <Condition>
        <IsOptional>1</IsOptional>
      </Condition>
      <ConditionUnlocked>
        <UnlockNeeded>GATE_A_GUID</UnlockNeeded>
      </ConditionUnlocked>
    </Values>
  </TriggerCondition>
  <TriggerActions>
    <Item>
      <TriggerAction>
        <Template>ActionUnlockAsset</Template>
        <Values>
          <Action/>
          <ActionUnlockAsset>
            <UnlockAssets>
              <Item>
                <Asset>OPTIONAL_RESULT_GUID</Asset>
              </Item>
            </UnlockAssets>
          </ActionUnlockAsset>
        </Values>
      </TriggerAction>
    </Item>
  </TriggerActions>
  <ResetTrigger>
    <Template>EmptyAutoCreateValue</Template>
    <Values>
      <EmptyAutoCreateValue/>
    </Values>
  </ResetTrigger>
</Trigger>
  </Values>
</SubTrigger>
```

</details>

### Optional branches with deeper descendants

**Very likely, not absolutely certain:** Serp considers the later notebook test correct. With one main condition, two optional children on level two, and non-optional descendants on level three, the main can complete without those branches finishing. The optional level-two branches exempt their descendants from blocking root completion. Recursively marking every descendant optional is not established as a universal requirement.

This corrects an earlier notebook claim; retain the qualification when designing deeper trees. It does not make the descendant actions unconditional, and it does not prove that a missed optional action will be retried after the owning trigger has completed.

### IsOptional on an owning main condition

Serp thinks this is ineffective and harmless when there is no parent condition. It is an author assessment, not a new controlled test. In particular, `IsOptional=1` on the main `ConditionIsDiscovered` of a manually registered trigger is not evidence that false discovery consumes that trigger. The discovery check remains the gate; an optional child has a different role.

<a id="registration"></a>
## 9. Register, unregister and repeat

An asset existing in XML and an instance being registered are different things. `AutoRegisterTrigger=1` provides ordinary automatic registration. Set it to `0` when another trigger or script should arm the asset at a deliberate point.

For XML manual registration, `ActionRegisterTrigger/TriggerAsset` names the owning target asset. With `UnregisterTrigger=1`, the same action type instead unregisters it. An inline subtrigger is not registered by assigning it an invented independent GUID.

<details>
<summary>Manual registration action — fragment for TriggerActions/Item</summary>

```xml
<TriggerAction>
  <Template>ActionRegisterTrigger</Template>
  <Values>
    <Action/>
    <ActionRegisterTrigger>
      <TriggerAsset>TARGET_TRIGGER_GUID</TriggerAsset>
    </ActionRegisterTrigger>
  </Values>
</TriggerAction>
```

</details>

**Serp-confirmed registration distinction:**

| Entry point / state | Behavior |
| --- | --- |
| XML `ActionRegisterTrigger`, already registered | Does nothing. It does not restart or refresh that active instance. |
| XML `ActionRegisterTrigger`, after full completion | The trigger is no longer registered and can be registered again. |
| Lua `RegisterTriggerForCurrentParticipant` | The same trigger can have multiple concurrent registrations. Do not use repeated calls as an assumed deduplication mechanism. |
| Registration from the trigger's own action list | May work, but remains unconfirmed. Prefer an established reset. |

The native description about resetting an already-created trigger is not a substitute for these state/entry-point distinctions. A call during an action list is not automatically a call after full trigger completion.

<a id="resettrigger"></a>
### ResetTrigger and ActionResetTrigger

`ResetTrigger` is an embedded tree belonging to the trigger. Serp reports it becomes registered when the main trigger completes; when its own conditions complete, it resets the parent. A one-second reset timer therefore adds a one-second wait **after completion**, not an interval measured only from the start of the main condition.

If the main condition is still true after the reset, the next cycle can finish quickly. Choose a meaningful cooldown or wait for an opposite state. An immediately true main plus immediately true reset can repeat expensive work much more frequently than intended.

`ActionResetTrigger` is a separate action with no `TriggerAsset` field in the inspected schema. Do not use it as if it were “register arbitrary target GUID again”. Look up the exact enclosing usage before inserting it into another workflow.

Resetting does not automatically undo every action. A spawned ship, unlocked asset or transferred resource is an independent consequence unless you explicitly provide reversal actions. Delayed effects also need to be considered when the next cycle starts.

Directly unlocking a `FeatureUnlock` does not itself register its embedded reset in the reviewed behavior. Keep the lock/unlock signal lifecycle separate from registration and full-tree completion.

<a id="participants-context"></a>
## 10. Choose participants and context

Before building a world-wide condition, decide who owns/evaluates the trigger and whom it checks. Ordinary triggers run for humans, or humans plus second-party AI where configured. Pirates and merchants can be checked/targeted third parties; they do not become ordinary processing participants just because their ID appears in a condition.

`UsedBySecondParties` concerns second-party AI creation. It does not select a single Coop client or prevent several human participants from responding to the same global event.

### ProcessingParticipant versus CheckedParticipant

The **processing participant** is the company whose trigger is evaluating. `CheckedParticipant` selects a different company for a supporting counter only when its enabling setting, such as `CheckSpecificParticipant=1`, is used. A default CheckedParticipant token is not proof that the check is enabled.

For `ConditionPlayerCounter`, choose `PlayerCounter`, `Context`, `ComparisonOp`, `CounterAmount`, `CounterScope` and `CounterValueType` as one contract. `Current` checks the current quantity. Relative counters have their own baseline timing; deletion or spawning may be visible only in a following cycle.

Third-party counters need `ProfileCounter` on the actual profile. Reviewed mods add it for their intended merchants/pirates. Do not assume every third-party profile supports a copied query.

### Human/AI readiness and defeat

Shared WhichPlayer/IsAI conditions establish marker states after initialization. Negating a still-false marker too early can misclassify the player. Prefer positive markers and the helper's actual readiness workflow. The reviewed Human0 marker is `1500001613`, with WhichPlayer_Serp and its dependencies; it is not a native condition available without those mods.

`ConditionIsParticipantInGame` describes game-setup selection, not a reliable live defeat test. Pirates can remain true after defeat; session/re-registration behavior also affected recorded tests. PirateDefeatHelpers uses specialized positive lighthouse/state signals instead. A remaining ship does not prove that a human has not lost.

Defeated AI and defeated/disconnected humans do not have identical trigger lifetimes. Serp reports explicit registration/reset actions can allow already-defeated participants to execute; saved human triggers and ordinary resets can continue after defeat/disconnection. Decide which behavior you need and use the audited loss/presence checks.

<a id="object-targets"></a>
### ObjectFilter and ObjectTargetFilter

A condition's matched object is not automatically the later action's target. A GUID filter can match many instances. An OID is an instance identity; a pool is a collection of asset types; these are different concepts.

Owner filtering also needs its enabling fields. `ObjectParticipantID` by itself is not an enabled owner check. Reviewed ObjectFilter examples use `CheckParticipantID=1`, including processing-participant cases. `ObjectTargetFilter` has its own settings; inspect both filters for an ObjectPosition check.

`ObjectUseParentConditionObjects` is marked incompletely implemented in native data and failed in several of Serp's object/counter tests. Do not use it as a general way to recover the one matched ship. Prefer a proven filter, an audited unique-ship invariant, or an appropriate identity/helper workflow. `MaxObjectCount` is described as a random subset, not a stable “first object” rule.

Pool support belongs to the consumer. PlayerCounterContextPool and ItemEffectTargetPool worked in some ObjectFilter tests; other consumers required AssetPool. Single-entry pool failures were recorded for ObjectFilter/ActionDeleteObjects, without establishing that all single-entry counter pools fail. Random pool spawning caused desync in recorded MP tests.

<a id="area-session"></a>
### Session, Area and QuestArea

| Context | What it does not automatically establish |
| --- | --- |
| `ConditionActiveSession` | A fixed action target session, loading state, or which client will execute Lua. Any Coop peer can satisfy it in the reported behavior. |
| `UseCurrentSession` / `CounterScopeUseActiveSession` | The same session semantics as ActiveSession. Serp reports these use the Coop leader's session. |
| `CounterScope=Area` | That arbitrary later actions are limited to that island. The condition must supply usable context to a supporting consumer. |
| `InheritArea=1` | A generic replacement for every quest/session/action context field. |
| `QuestArea` | Merely a session GUID. It carries quest-specific island context. |
| Lua current session | The processing company's one universal session. It is local to the executing client. |

Serp found trigger-only session propagation using an Area-scope PlayerCounter near its consuming action and appropriate QuestSession filters. Other counters could overwrite context, branching was inconsistent, and an intervening timer failed in one spawn test. Do not insert arbitrary delay nodes into a previously working context path.

For island-restricted action workflows, the reviewed human helper quests use `InheritQuestArea`, `GetQuestSessionFromArea` and/or registered-trigger `InheritArea`. `LimitToQuestArea` does not turn ordinary unlinked trigger actions into island-specific actions; it also has water/buildable-land restrictions. Quest-based human workflows cannot simply be transplanted to AI.

<a id="lua-multiplayer"></a>
## 11. Use Lua, multiplayer and Coop

`ActionExecuteScript` names a script file supplied by the mod or a real dependency. The script's existence, actual contents and accessible API matter. In the reviewed Campaign dependency, files named “slow” and “normal” currently contain only comments; their filenames do not establish game-speed changes.

<details>
<summary>Script action — fragment; supply this example script path in your mod</summary>

```xml
<TriggerAction>
  <Template>ActionExecuteScript</Template>
  <Values>
    <Action/>
    <ActionExecuteScript>
      <ScriptFileName>data/scripts/my_trigger.lua</ScriptFileName>
    </ActionExecuteScript>
  </Values>
</TriggerAction>
```

</details>

The XML processing participant and the Lua executing client are different. Serp reports XML ActionExecuteScript executes on **all human clients**. Checking Human0 in XML is useful for XML coordination, but does not by itself restrict a Lua call to one Coop peer.

### Three command categories

| Command behavior | Design requirement |
| --- | --- |
| Automatically synchronized mutation | Choose who submits it. Repeated submissions can multiply effects without producing a desync. |
| Unsynchronized simulated mutation | Every client must perform the same mutation on the same effective target in exactly the same game tick. |
| Local UI/display operation | Keep it local, but audit whether it also changes saved trigger/quest state. |

If you do not know the category, do not infer it from a method name or `Net` suffix. Per-client waits, local selections, differing sessions and `math.random()` can cause different execution times or targets. A loop that waits until every local client seems ready is not by itself a cross-client barrier.

The reviewed LuaLight lock/cooldown workflow and Medium/Ultra peer helpers solve specific handoff or multiplicity problems with their own dependencies. Keep their actual version and initialization contract. One human participant with several Coop clients is different from one client and from four separate human companies.

### ForceBuild: usable under a precise premise

The pirate script calls `ts.SessionParticipants.GetParticipant(Pirate_PID).Trader.ForceBuild()` directly. Its comment reports one built ship per game tick.

**Serp's conditional assessment:** the multiplayer usability statement assumes every client executes that direct call in **exactly the same tick**. A single direct call through ActionExecuteScript, repeated via separate script invocations, is relatively practical under that premise. This is not a new controlled MP test or a guarantee about arbitrary scheduling. The once-per-tick limit alone does not prove that all peers reached the same tick.

The answer also does not settle what SessionParticipants returns when clients are in different sessions. Do not generalize the pattern to delayed coroutines or other multiplayer-incompatible commands without their own target and timing audit.

### Local events can still desynchronize a trigger

A local movie, notification or GUI event may mark a saved trigger as complete at a different time on each peer, even without an obvious gameplay action. “It only displays something” or “the money test worked” is insufficient evidence for a different GUID/action combination.

Reviewed Campaign/Story Coop flows replace selected local event paths with synchronized relock signals and specific registration points. They do not justify auto-registering all UI listeners at game start or replacing every event with an unlocked-state check.

<a id="savegames"></a>
## 12. Handle savegames and mod removal

**Serp confirmation:** registering a trigger captures the code present at that moment as its saved definition. An existing registered instance retains that snapshot. A later **fresh** registration reads the current code. Editing XML in place does not automatically update the active saved instance.

This explains why an unregister/re-register migration can pick up changed conditions/actions, provided it actually reaches fresh registration. XML registration while already registered is a no-op, so that call alone does not refresh code.

Fresh code is not the same as correct migrated progress. A newly armed event listener does not reconstruct a missed quest event. An already-granted reward is not automatically protected from repetition. Adding a ResetTrigger to a completed historical GUID does not retroactively make it run. Use explicit guards for completed progression and do not recycle a historical trigger GUID merely because the old definition is gone.

### Stop saved triggers after removing a mod

Saved registered triggers can remain and fire after the mod's assets disappear. In Serp's tests, a missing `UnlockNeeded` GUID is treated as **unlocked**. A positive “my mod signal is unlocked” check can therefore become true after removal.

Use the reviewed presence pattern: a private `UnlockableAsset` with `DefaultLockedState=1`, never unlocked during normal play, and a **negated** `ConditionUnlocked` at the guarding level. While the asset exists and stays locked, the guard is true. When it disappears and is treated as unlocked, the guard becomes false.

The presence guard is different from an intentionally relock-to-start FeatureUnlock. That signal normally starts unlocked, disables AutoSelfUnlock, and is relocked to request execution. Mixing the two lock conventions reverses the intended behavior.

### Extend shared lifecycle helpers at the intended point

EventOnGameLoaded and OncePerSessionPerSaveLoad expose particular reset-action extension points so newly registered reset code can pick up additions. Follow their actual metadata and the Medium replacement where applicable. For semantic subscriptions, use your own consumer trigger against the helper signal rather than permanently embedding arbitrary saved actions in an unrelated helper.

For lifecycle choice: SessionEnter is useful for entry and can occur on load; first-ever session entry differs from first entry per save load. Shared OncePerSession identities may already have fired before a newly added mod. Global buffs can require prior visitation or an owned object; a globally loaded session alone may be too early. MetaGameLoaded/ProfileLoaded experiments were inconsistent, especially same-process reloads, so they are not a guaranteed every-load replacement.

<a id="special-cases"></a>
## 13. Know the special cases

These are findings with specific contexts, not reasons to treat every trigger as unreliable. Use a matching supported pattern where possible and keep the limitation next to the affected design.

<a id="mutualarea"></a>
### ConditionMutualAreaInSubconditions

The reviewed arrangement uses MutualArea as the **main condition**, with Area-producing conditions as siblings on the **same level**. Serp reports it did not fire when placed inside a subtrigger. Moving the checks into a serial child chain can prevent the intended common-area comparison.

**Very likely, not absolutely certain:** those subconditions need to be true simultaneously, unlike remembered ordinary Parallel completion. Serp reaffirmed the original comment at that confidence level. Matching one island does not automatically give later arbitrary actions QuestArea semantics.

<a id="text-source-conditions"></a>
### ConditionEvaluateTextSource and ConditionThreshold

`ConditionEvaluateTextSource` has numeric comparison fields in the schema, but Serp's numeric tests became true irrespective of the intended comparison. Boolean-returning commands were usable in those tests. Treat it as a schema/runtime discrepancy, not a supported arbitrary numeric calculator.

`ConditionThreshold` is not a universal workaround. Serp reaffirmed **all** CodeSnippets comments with their original certainty:

- Actions executed 23 times in the recorded intended-single-execution setup. Do not assume the exact count applies universally.
- The reset condition appeared never true, and using Threshold inside a SubTrigger hung new-game/save loading.
- Meta-storage usage appeared usable; area building counts required `IsAreaSpecific=1`; the tested ProfileCounter text source appeared not to work.
- `ThresholdDuration=0` appeared usable. Positive durations working, and milliseconds as their unit, remain **probable, not confirmed**.

Prefer a native counter for a supported quantity or an established Lua/lock bridge. Keep any deliberately isolated Threshold workaround's limitations visible; an exported field or successful XML parse does not demonstrate safe gameplay.

<a id="storage-buffs"></a>
### Storage, equipped items and buffs

`ConditionInStorage` detected storage/cargo slots, not equipped sockets in the reviewed tests. An absent object can satisfy a zero comparison; add an independent existence gate when absence must fail. Follow the actual comparison policy for multiple InStorageGoods entries rather than assuming a generic AND.

`ConditionIsBuffed` failed to detect passive socketed/global VehicleItem effects in Serp's ship test, even after adding Buff. Native examples use ActiveBuff; the `UseEffectHandler` description concerns other effect handlers as well. This does not prove every compatible active buff fails, or that passive sockets can be detected by copying a native active-buff example.

`ConditionItemUsed` exists as a property but has no same-named template in the 91 direct-Condition template catalogue. Inspect the custom template/embedded definition before using it. `ItemNeedsActivation` distinguishes equipment from activation; shooting items and ItemActionCompleted failed in the recorded setups. They are not general projectile event detectors.

Area-buff workflows used marker buildings when XML could not detect socket state. Periodically reapplying the trading speed effect is another reviewed workaround with its own lifecycle, not evidence that IsBuffed now detects that passive effect.

<a id="quests"></a>
### Quest events and quest-linked objects

`QuestSuccessfullyResolved` with ContextData worked in a recorded setup; `QuestStarted` did not. The hypothesis that pool-started quests behave differently from ActionStartQuest remains a **reasoned hypothesis, not further tested**. Do not document pool start as a proven repair.

The combined use of `LinkAllQuestActionsToQuest` at quest action registration and `LinkAllActionsToQuest` in the registered trigger allowed spawned objects to count as quest objects. **Still unresolved:** whether both flags are needed or one suffices. They do not automatically make preexisting, selected or sold objects quest objects. Specify an ObjectGUID with ObjectRestrictToQuestObjects where needed to avoid also matching a quest starter object such as a lighthouse.

Quest pool preconditions control granting; a quest's running cancellation requirements belong in its own preconditions with the applicable keep-checking setting. ActionStartQuest ignored ordinary start preconditions in the notes, while running checks still applied. QuestSessionDependencies is an OR among loaded sessions, not an all-sessions-loaded requirement. Lua `IsActive` could remain true after completion, so reviewed state helpers also checked HasEnded.

### Other recorded traps

| Case | Latest documented boundary |
| --- | --- |
| `ConditionAttractiveness` / `CountAllTypes` | Type summing versus per-type checks remains uncertain; the test did not trigger. PlayerCounter/Attractiveness for island totals is a proposed alternative, not newly confirmed. HowTo remains the latest known state. |
| `ConditionIslandsWithFertility`, Area scope | Did not satisfy the recorded test; not established as a per-island fertility predicate. |
| `ConditionCorporationDifficulty` in MP | Probably does not work; no further test or specific Coop-versus-multiple-participant scope was supplied. |
| `ActionAddGoodsToItemContainer` after spawning | Same-trigger insertion failed even with an in-list delay; a separately registered post-spawn trigger was used. |
| Third-party ship inventory | May require two full trigger executions, not just two actions; cause remains unknown. This is the latest HowTo state, not a guaranteed two-pass fix. NPC station insertion also failed. |
| `ActionTriggerPopup` | Auto-registration displayed a popup on every peer once; repeated Coop calls queued duplicates. The reviewed helper is WIP and uses manual initialization/coordination. |
| Random pool spawning | AssetPool choices caused desync in recorded MP setups; declared pool support is not MP safety. |
| `AllowProcessingSession` spawn in OnQuestEnd | Failed in that context although other quest contexts worked; do not substitute an arbitrary delay for the lifecycle audit. |
| World-wide zero-count guard | Several human participants could pass before the side effect appeared, producing several spawns. A global guard is not an atomic coordinator. |
| Reputation | ConditionReputation direction differs from ActionAddReputation's processing/target change. Reviewed LuaLight reputation bridging has its own execution contract. |
| Displayed unlock requirements | The smallest still-registered trigger GUID supplied the displayed requirement in Serp's tests; this is separate from unhide/unlock and obsolete Threshold UI workarounds. |

<a id="recipes"></a>
## 14. Complete recipes

The examples below are complete Anno 1800 ModOps, including their private result/input assets and explicit human-only registration settings. Replace GUID tokens before using them. Each recipe is isolated; do not combine their placeholder identities accidentally.

The locked input assets illustrate external signals. If you deploy a signal recipe unchanged, it will wait for signals that nothing produces. Supply a real audited producer or replace the input condition with the intended counter/event. Complete XML demonstrates valid structure, not a functioning application without its inputs.

### One execution after one second

The registered timer waits one second, unlocks RESULT_GUID and completes. There is no reset. This is a small structural example, not an every-save-load callback.

<details>
<summary>Single execution — complete ModOps; replace GUID tokens</summary>

```xml
<ModOps>
  <ModOp Type="AddNextSibling" GUID="130248">
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>RESULT_GUID</GUID>
          <Name>Documentation example RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>CUSTOM_TRIGGER_GUID</GUID>
          <Name>Documentation example CUSTOM_TRIGGER_GUID</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionTimer</Template>
            <Values>
              <Condition/>
              <ConditionTimer>
                <TimeLimit>1000</TimeLimit>
              </ConditionTimer>
            </Values>
          </TriggerCondition>
          <TriggerActions>
            <Item>
              <TriggerAction>
                <Template>ActionUnlockAsset</Template>
                <Values>
                  <Action/>
                  <ActionUnlockAsset>
                    <UnlockAssets>
                      <Item>
                        <Asset>RESULT_GUID</Asset>
                      </Item>
                    </UnlockAssets>
                  </ActionUnlockAsset>
                </Values>
              </TriggerAction>
            </Item>
          </TriggerActions>
          <ResetTrigger>
            <Template>EmptyAutoCreateValue</Template>
            <Values>
              <EmptyAutoCreateValue/>
            </Values>
          </ResetTrigger>
        </Trigger>
        <TriggerSetup>
          <AutoRegisterTrigger>1</AutoRegisterTrigger>
          <UsedBySecondParties>0</UsedBySecondParties>
        </TriggerSetup>
      </Values>
    </Asset>
  </ModOp>
</ModOps>
```

</details>

### Repeat with a separate reset wait

The main timer waits 10000 ms and unlocks RESULT_GUID. The reset waits another 1000 ms, relocks the result and resets the tree. This creates a repeated signal with approximately ten seconds of waiting followed by one second unlocked, according to the configured tree. The reset wait is part of the cycle. Replacing the main timer with a persistent state gate changes that timing; if that gate remains true, the next main completion can be immediate.

<details>
<summary>Repeating timer and reset — complete ModOps; replace GUID tokens</summary>

```xml
<ModOps>
  <ModOp Type="AddNextSibling" GUID="130248">
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>RESULT_GUID</GUID>
          <Name>Documentation example RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>CUSTOM_TRIGGER_GUID</GUID>
          <Name>Documentation example CUSTOM_TRIGGER_GUID</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionTimer</Template>
            <Values>
              <Condition/>
              <ConditionTimer>
                <TimeLimit>10000</TimeLimit>
              </ConditionTimer>
            </Values>
          </TriggerCondition>
          <TriggerActions>
            <Item>
              <TriggerAction>
                <Template>ActionUnlockAsset</Template>
                <Values>
                  <Action/>
                  <ActionUnlockAsset>
                    <UnlockAssets>
                      <Item>
                        <Asset>RESULT_GUID</Asset>
                      </Item>
                    </UnlockAssets>
                  </ActionUnlockAsset>
                </Values>
              </TriggerAction>
            </Item>
          </TriggerActions>
          <ResetTrigger>
            <Template>AutoCreateTrigger</Template>
            <Values>
              <Trigger>
                <TriggerCondition>
                  <Template>ConditionTimer</Template>
                  <Values>
                    <Condition/>
                    <ConditionTimer>
                      <TimeLimit>1000</TimeLimit>
                    </ConditionTimer>
                  </Values>
                </TriggerCondition>
                <TriggerActions>
                  <Item>
                    <TriggerAction>
                      <Template>ActionLockAsset</Template>
                      <Values>
                        <Action/>
                        <ActionLockAsset>
                          <LockAssets>
                            <Item>
                              <Asset>RESULT_GUID</Asset>
                            </Item>
                          </LockAssets>
                        </ActionLockAsset>
                      </Values>
                    </TriggerAction>
                  </Item>
                </TriggerActions>
                <ResetTrigger>
                  <Template>EmptyAutoCreateValue</Template>
                  <Values>
                    <EmptyAutoCreateValue/>
                  </Values>
                </ResetTrigger>
              </Trigger>
            </Values>
          </ResetTrigger>
        </Trigger>
        <TriggerSetup>
          <AutoRegisterTrigger>1</AutoRegisterTrigger>
          <UsedBySecondParties>0</UsedBySecondParties>
        </TriggerSetup>
      </Values>
    </Asset>
  </ModOp>
</ModOps>
```

</details>

### Require three live states together

The tree is A → B → C → result. Each level has one child; the only result action is at the deepest level. This demonstrates the ordinary nested-gate pattern, rather than collecting A/B/C as remembered siblings.

<details>
<summary>Three nested live-state gates — complete ModOps; replace GUID tokens</summary>

```xml
<ModOps>
  <ModOp Type="AddNextSibling" GUID="130248">
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>RESULT_GUID</GUID>
          <Name>Documentation example RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>GATE_A_GUID</GUID>
          <Name>Documentation example GATE_A_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>GATE_B_GUID</GUID>
          <Name>Documentation example GATE_B_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>GATE_C_GUID</GUID>
          <Name>Documentation example GATE_C_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>CUSTOM_TRIGGER_GUID</GUID>
          <Name>Documentation example CUSTOM_TRIGGER_GUID</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionUnlocked</Template>
            <Values>
              <Condition/>
              <ConditionUnlocked>
                <UnlockNeeded>GATE_A_GUID</UnlockNeeded>
              </ConditionUnlocked>
            </Values>
          </TriggerCondition>
          <TriggerActions/>
          <SubTriggers>
            <Item>
              <SubTrigger>
                <Template>AutoCreateTrigger</Template>
                <Values>
                  <Trigger>
                    <TriggerCondition>
                      <Template>ConditionUnlocked</Template>
                      <Values>
                        <Condition/>
                        <ConditionUnlocked>
                          <UnlockNeeded>GATE_B_GUID</UnlockNeeded>
                        </ConditionUnlocked>
                      </Values>
                    </TriggerCondition>
                    <TriggerActions/>
                    <SubTriggers>
                      <Item>
                        <SubTrigger>
                          <Template>AutoCreateTrigger</Template>
                          <Values>
                            <Trigger>
                              <TriggerCondition>
                                <Template>ConditionUnlocked</Template>
                                <Values>
                                  <Condition/>
                                  <ConditionUnlocked>
                                    <UnlockNeeded>GATE_C_GUID</UnlockNeeded>
                                  </ConditionUnlocked>
                                </Values>
                              </TriggerCondition>
                              <TriggerActions>
                                <Item>
                                  <TriggerAction>
                                    <Template>ActionUnlockAsset</Template>
                                    <Values>
                                      <Action/>
                                      <ActionUnlockAsset>
                                        <UnlockAssets>
                                          <Item>
                                            <Asset>RESULT_GUID</Asset>
                                          </Item>
                                        </UnlockAssets>
                                      </ActionUnlockAsset>
                                    </Values>
                                  </TriggerAction>
                                </Item>
                              </TriggerActions>
                              <ResetTrigger>
                                <Template>EmptyAutoCreateValue</Template>
                                <Values>
                                  <EmptyAutoCreateValue/>
                                </Values>
                              </ResetTrigger>
                            </Trigger>
                          </Values>
                        </SubTrigger>
                      </Item>
                    </SubTriggers>
                    <ResetTrigger>
                      <Template>EmptyAutoCreateValue</Template>
                      <Values>
                        <EmptyAutoCreateValue/>
                      </Values>
                    </ResetTrigger>
                  </Trigger>
                </Values>
              </SubTrigger>
            </Item>
          </SubTriggers>
          <ResetTrigger>
            <Template>EmptyAutoCreateValue</Template>
            <Values>
              <EmptyAutoCreateValue/>
            </Values>
          </ResetTrigger>
        </Trigger>
        <TriggerSetup>
          <AutoRegisterTrigger>1</AutoRegisterTrigger>
          <UsedBySecondParties>0</UsedBySecondParties>
        </TriggerSetup>
      </Values>
    </Asset>
  </ModOp>
</ModOps>
```

</details>

### Collect two events in order

The parent is AlwaysTrue and uses Linear children. First listen for an unlock event on A, then for a later unlock event on B; the root result follows their completion. Arm the trigger before A and emit B only after its listener is eligible. To collect persistent states instead, use state conditions with the corresponding different semantics.

<details>
<summary>Ordered event chain — complete ModOps; replace GUID tokens</summary>

```xml
<ModOps>
  <ModOp Type="AddNextSibling" GUID="130248">
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>RESULT_GUID</GUID>
          <Name>Documentation example RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>GATE_A_GUID</GUID>
          <Name>Documentation example GATE_A_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>GATE_B_GUID</GUID>
          <Name>Documentation example GATE_B_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>CUSTOM_TRIGGER_GUID</GUID>
          <Name>Documentation example CUSTOM_TRIGGER_GUID</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionAlwaysTrue</Template>
            <Values>
              <Condition>
                <SubConditionCompletionOrder>Linear</SubConditionCompletionOrder>
              </Condition>
              <ConditionAlwaysTrue/>
            </Values>
          </TriggerCondition>
          <TriggerActions>
            <Item>
              <TriggerAction>
                <Template>ActionUnlockAsset</Template>
                <Values>
                  <Action/>
                  <ActionUnlockAsset>
                    <UnlockAssets>
                      <Item>
                        <Asset>RESULT_GUID</Asset>
                      </Item>
                    </UnlockAssets>
                  </ActionUnlockAsset>
                </Values>
              </TriggerAction>
            </Item>
          </TriggerActions>
          <SubTriggers>
            <Item>
              <SubTrigger>
                <Template>AutoCreateTrigger</Template>
                <Values>
                  <Trigger>
                    <TriggerCondition>
                      <Template>ConditionEvent</Template>
                      <Values>
                        <Condition/>
                        <ConditionEvent>
                          <ConditionEvent>GUIDUnlocked</ConditionEvent>
                          <ContextAsset>GATE_A_GUID</ContextAsset>
                        </ConditionEvent>
                      </Values>
                    </TriggerCondition>
                    <TriggerActions/>
                    <ResetTrigger>
                      <Template>EmptyAutoCreateValue</Template>
                      <Values>
                        <EmptyAutoCreateValue/>
                      </Values>
                    </ResetTrigger>
                  </Trigger>
                </Values>
              </SubTrigger>
            </Item>
            <Item>
              <SubTrigger>
                <Template>AutoCreateTrigger</Template>
                <Values>
                  <Trigger>
                    <TriggerCondition>
                      <Template>ConditionEvent</Template>
                      <Values>
                        <Condition/>
                        <ConditionEvent>
                          <ConditionEvent>GUIDUnlocked</ConditionEvent>
                          <ContextAsset>GATE_B_GUID</ContextAsset>
                        </ConditionEvent>
                      </Values>
                    </TriggerCondition>
                    <TriggerActions/>
                    <ResetTrigger>
                      <Template>EmptyAutoCreateValue</Template>
                      <Values>
                        <EmptyAutoCreateValue/>
                      </Values>
                    </ResetTrigger>
                  </Trigger>
                </Values>
              </SubTrigger>
            </Item>
          </SubTriggers>
          <ResetTrigger>
            <Template>EmptyAutoCreateValue</Template>
            <Values>
              <EmptyAutoCreateValue/>
            </Values>
          </ResetTrigger>
        </Trigger>
        <TriggerSetup>
          <AutoRegisterTrigger>1</AutoRegisterTrigger>
          <UsedBySecondParties>0</UsedBySecondParties>
        </TriggerSetup>
      </Values>
    </Asset>
  </ModOp>
</ModOps>
```

</details>

### Choose a prioritized alternative

Branch A is first but includes a one-second descendant timer. Branch B can win while A is incomplete. If you require an outer proximity/readiness condition, replace the root's AlwaysTrue with that audited parent gate; MutuallyExclusive does not bypass it.

<details>
<summary>Prioritized alternatives — complete ModOps; replace GUID tokens</summary>

```xml
<ModOps>
  <ModOp Type="AddNextSibling" GUID="130248">
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>RESULT_GUID</GUID>
          <Name>Documentation example RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>GATE_A_GUID</GUID>
          <Name>Documentation example GATE_A_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>GATE_B_GUID</GUID>
          <Name>Documentation example GATE_B_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>ALTERNATE_RESULT_GUID</GUID>
          <Name>Documentation example ALTERNATE_RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>CUSTOM_TRIGGER_GUID</GUID>
          <Name>Documentation example CUSTOM_TRIGGER_GUID</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionAlwaysTrue</Template>
            <Values>
              <Condition>
                <SubConditionCompletionOrder>MutuallyExclusive</SubConditionCompletionOrder>
              </Condition>
              <ConditionAlwaysTrue/>
            </Values>
          </TriggerCondition>
          <TriggerActions/>
          <SubTriggers>
            <Item>
              <SubTrigger>
                <Template>AutoCreateTrigger</Template>
                <Values>
                  <Trigger>
                    <TriggerCondition>
                      <Template>ConditionUnlocked</Template>
                      <Values>
                        <Condition/>
                        <ConditionUnlocked>
                          <UnlockNeeded>GATE_A_GUID</UnlockNeeded>
                        </ConditionUnlocked>
                      </Values>
                    </TriggerCondition>
                    <TriggerActions/>
                    <SubTriggers>
                      <Item>
                        <SubTrigger>
                          <Template>AutoCreateTrigger</Template>
                          <Values>
                            <Trigger>
                              <TriggerCondition>
                                <Template>ConditionTimer</Template>
                                <Values>
                                  <Condition/>
                                  <ConditionTimer>
                                    <TimeLimit>1000</TimeLimit>
                                  </ConditionTimer>
                                </Values>
                              </TriggerCondition>
                              <TriggerActions>
                                <Item>
                                  <TriggerAction>
                                    <Template>ActionUnlockAsset</Template>
                                    <Values>
                                      <Action/>
                                      <ActionUnlockAsset>
                                        <UnlockAssets>
                                          <Item>
                                            <Asset>RESULT_GUID</Asset>
                                          </Item>
                                        </UnlockAssets>
                                      </ActionUnlockAsset>
                                    </Values>
                                  </TriggerAction>
                                </Item>
                              </TriggerActions>
                              <ResetTrigger>
                                <Template>EmptyAutoCreateValue</Template>
                                <Values>
                                  <EmptyAutoCreateValue/>
                                </Values>
                              </ResetTrigger>
                            </Trigger>
                          </Values>
                        </SubTrigger>
                      </Item>
                    </SubTriggers>
                    <ResetTrigger>
                      <Template>EmptyAutoCreateValue</Template>
                      <Values>
                        <EmptyAutoCreateValue/>
                      </Values>
                    </ResetTrigger>
                  </Trigger>
                </Values>
              </SubTrigger>
            </Item>
            <Item>
              <SubTrigger>
                <Template>AutoCreateTrigger</Template>
                <Values>
                  <Trigger>
                    <TriggerCondition>
                      <Template>ConditionUnlocked</Template>
                      <Values>
                        <Condition/>
                        <ConditionUnlocked>
                          <UnlockNeeded>GATE_B_GUID</UnlockNeeded>
                        </ConditionUnlocked>
                      </Values>
                    </TriggerCondition>
                    <TriggerActions>
                      <Item>
                        <TriggerAction>
                          <Template>ActionUnlockAsset</Template>
                          <Values>
                            <Action/>
                            <ActionUnlockAsset>
                              <UnlockAssets>
                                <Item>
                                  <Asset>ALTERNATE_RESULT_GUID</Asset>
                                </Item>
                              </UnlockAssets>
                            </ActionUnlockAsset>
                          </Values>
                        </TriggerAction>
                      </Item>
                    </TriggerActions>
                    <ResetTrigger>
                      <Template>EmptyAutoCreateValue</Template>
                      <Values>
                        <EmptyAutoCreateValue/>
                      </Values>
                    </ResetTrigger>
                  </Trigger>
                </Values>
              </SubTrigger>
            </Item>
          </SubTriggers>
          <ResetTrigger>
            <Template>EmptyAutoCreateValue</Template>
            <Values>
              <EmptyAutoCreateValue/>
            </Values>
          </ResetTrigger>
        </Trigger>
        <TriggerSetup>
          <AutoRegisterTrigger>1</AutoRegisterTrigger>
          <UsedBySecondParties>0</UsedBySecondParties>
        </TriggerSetup>
      </Values>
    </Asset>
  </ModOp>
</ModOps>
```

</details>

### An optional extra action

The root timer can complete and unlock RESULT_GUID without the optional unlocked-state child. The extra result is conditional on that child being satisfied while eligible; it is not guaranteed or promised a later retry.

<details>
<summary>Optional side action — complete ModOps; replace GUID tokens</summary>

```xml
<ModOps>
  <ModOp Type="AddNextSibling" GUID="130248">
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>RESULT_GUID</GUID>
          <Name>Documentation example RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>GATE_A_GUID</GUID>
          <Name>Documentation example GATE_A_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>OPTIONAL_RESULT_GUID</GUID>
          <Name>Documentation example OPTIONAL_RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>CUSTOM_TRIGGER_GUID</GUID>
          <Name>Documentation example CUSTOM_TRIGGER_GUID</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionTimer</Template>
            <Values>
              <Condition/>
              <ConditionTimer>
                <TimeLimit>1000</TimeLimit>
              </ConditionTimer>
            </Values>
          </TriggerCondition>
          <TriggerActions>
            <Item>
              <TriggerAction>
                <Template>ActionUnlockAsset</Template>
                <Values>
                  <Action/>
                  <ActionUnlockAsset>
                    <UnlockAssets>
                      <Item>
                        <Asset>RESULT_GUID</Asset>
                      </Item>
                    </UnlockAssets>
                  </ActionUnlockAsset>
                </Values>
              </TriggerAction>
            </Item>
          </TriggerActions>
          <SubTriggers>
            <Item>
              <SubTrigger>
                <Template>AutoCreateTrigger</Template>
                <Values>
                  <Trigger>
                    <TriggerCondition>
                      <Template>ConditionUnlocked</Template>
                      <Values>
                        <Condition>
                          <IsOptional>1</IsOptional>
                        </Condition>
                        <ConditionUnlocked>
                          <UnlockNeeded>GATE_A_GUID</UnlockNeeded>
                        </ConditionUnlocked>
                      </Values>
                    </TriggerCondition>
                    <TriggerActions>
                      <Item>
                        <TriggerAction>
                          <Template>ActionUnlockAsset</Template>
                          <Values>
                            <Action/>
                            <ActionUnlockAsset>
                              <UnlockAssets>
                                <Item>
                                  <Asset>OPTIONAL_RESULT_GUID</Asset>
                                </Item>
                              </UnlockAssets>
                            </ActionUnlockAsset>
                          </Values>
                        </TriggerAction>
                      </Item>
                    </TriggerActions>
                    <ResetTrigger>
                      <Template>EmptyAutoCreateValue</Template>
                      <Values>
                        <EmptyAutoCreateValue/>
                      </Values>
                    </ResetTrigger>
                  </Trigger>
                </Values>
              </SubTrigger>
            </Item>
          </SubTriggers>
          <ResetTrigger>
            <Template>EmptyAutoCreateValue</Template>
            <Values>
              <EmptyAutoCreateValue/>
            </Values>
          </ResetTrigger>
        </Trigger>
        <TriggerSetup>
          <AutoRegisterTrigger>1</AutoRegisterTrigger>
          <UsedBySecondParties>0</UsedBySecondParties>
        </TriggerSetup>
      </Values>
    </Asset>
  </ModOp>
</ModOps>
```

</details>

### A removable-mod presence guard

Never unlock PRESENCE_GUID. The main negated unlocked check guards the child timer/result. This is the established lock-based presence pattern, not a relock-to-start signal.

<details>
<summary>Mod presence guard — complete ModOps; replace GUID tokens</summary>

```xml
<ModOps>
  <ModOp Type="AddNextSibling" GUID="130248">
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>RESULT_GUID</GUID>
          <Name>Documentation example RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>PRESENCE_GUID</GUID>
          <Name>Documentation example PRESENCE_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>CUSTOM_TRIGGER_GUID</GUID>
          <Name>Documentation example CUSTOM_TRIGGER_GUID</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionUnlocked</Template>
            <Values>
              <Condition/>
              <ConditionUnlocked>
                <UnlockNeeded>PRESENCE_GUID</UnlockNeeded>
              </ConditionUnlocked>
              <ConditionPropsNegatable>
                <NegateCondition>1</NegateCondition>
              </ConditionPropsNegatable>
            </Values>
          </TriggerCondition>
          <TriggerActions/>
          <SubTriggers>
            <Item>
              <SubTrigger>
                <Template>AutoCreateTrigger</Template>
                <Values>
                  <Trigger>
                    <TriggerCondition>
                      <Template>ConditionTimer</Template>
                      <Values>
                        <Condition/>
                        <ConditionTimer>
                          <TimeLimit>1000</TimeLimit>
                        </ConditionTimer>
                      </Values>
                    </TriggerCondition>
                    <TriggerActions>
                      <Item>
                        <TriggerAction>
                          <Template>ActionUnlockAsset</Template>
                          <Values>
                            <Action/>
                            <ActionUnlockAsset>
                              <UnlockAssets>
                                <Item>
                                  <Asset>RESULT_GUID</Asset>
                                </Item>
                              </UnlockAssets>
                            </ActionUnlockAsset>
                          </Values>
                        </TriggerAction>
                      </Item>
                    </TriggerActions>
                    <ResetTrigger>
                      <Template>EmptyAutoCreateValue</Template>
                      <Values>
                        <EmptyAutoCreateValue/>
                      </Values>
                    </ResetTrigger>
                  </Trigger>
                </Values>
              </SubTrigger>
            </Item>
          </SubTriggers>
          <ResetTrigger>
            <Template>EmptyAutoCreateValue</Template>
            <Values>
              <EmptyAutoCreateValue/>
            </Values>
          </ResetTrigger>
        </Trigger>
        <TriggerSetup>
          <AutoRegisterTrigger>1</AutoRegisterTrigger>
          <UsedBySecondParties>0</UsedBySecondParties>
        </TriggerSetup>
      </Values>
    </Asset>
  </ModOp>
</ModOps>
```

</details>

### A positive Human0 marker and session gate

Requires the actual WhichPlayer_Serp dependency, including IsAIPlayer_Serp and initialization. `1500001613` is the helper's positive processing-Human0 marker. Session `180023` is the audited Moderate session. A Coop peer satisfying ActiveSession does not choose the later Lua client's session or guarantee a one-peer action.

<details>
<summary>Human0 and session guards — complete ModOps; replace GUID tokens</summary>

```xml
<ModOps>
  <ModOp Type="AddNextSibling" GUID="130248">
    <Asset>
      <Template>UnlockableAsset</Template>
      <Values>
        <Standard>
          <GUID>RESULT_GUID</GUID>
          <Name>Documentation example RESULT_GUID</Name>
        </Standard>
        <Locked>
          <DefaultLockedState>1</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>CUSTOM_TRIGGER_GUID</GUID>
          <Name>Documentation example CUSTOM_TRIGGER_GUID</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionUnlocked</Template>
            <Values>
              <Condition/>
              <ConditionUnlocked>
                <UnlockNeeded>1500001613</UnlockNeeded>
              </ConditionUnlocked>
            </Values>
          </TriggerCondition>
          <TriggerActions/>
          <SubTriggers>
            <Item>
              <SubTrigger>
                <Template>AutoCreateTrigger</Template>
                <Values>
                  <Trigger>
                    <TriggerCondition>
                      <Template>ConditionActiveSession</Template>
                      <Values>
                        <Condition/>
                        <ConditionActiveSession>
                          <ActiveSession>180023</ActiveSession>
                        </ConditionActiveSession>
                      </Values>
                    </TriggerCondition>
                    <TriggerActions/>
                    <SubTriggers>
                      <Item>
                        <SubTrigger>
                          <Template>AutoCreateTrigger</Template>
                          <Values>
                            <Trigger>
                              <TriggerCondition>
                                <Template>ConditionTimer</Template>
                                <Values>
                                  <Condition/>
                                  <ConditionTimer>
                                    <TimeLimit>1000</TimeLimit>
                                  </ConditionTimer>
                                </Values>
                              </TriggerCondition>
                              <TriggerActions>
                                <Item>
                                  <TriggerAction>
                                    <Template>ActionUnlockAsset</Template>
                                    <Values>
                                      <Action/>
                                      <ActionUnlockAsset>
                                        <UnlockAssets>
                                          <Item>
                                            <Asset>RESULT_GUID</Asset>
                                          </Item>
                                        </UnlockAssets>
                                      </ActionUnlockAsset>
                                    </Values>
                                  </TriggerAction>
                                </Item>
                              </TriggerActions>
                              <ResetTrigger>
                                <Template>EmptyAutoCreateValue</Template>
                                <Values>
                                  <EmptyAutoCreateValue/>
                                </Values>
                              </ResetTrigger>
                            </Trigger>
                          </Values>
                        </SubTrigger>
                      </Item>
                    </SubTriggers>
                    <ResetTrigger>
                      <Template>EmptyAutoCreateValue</Template>
                      <Values>
                        <EmptyAutoCreateValue/>
                      </Values>
                    </ResetTrigger>
                  </Trigger>
                </Values>
              </SubTrigger>
            </Item>
          </SubTriggers>
          <ResetTrigger>
            <Template>EmptyAutoCreateValue</Template>
            <Values>
              <EmptyAutoCreateValue/>
            </Values>
          </ResetTrigger>
        </Trigger>
        <TriggerSetup>
          <AutoRegisterTrigger>1</AutoRegisterTrigger>
          <UsedBySecondParties>0</UsedBySecondParties>
        </TriggerSetup>
      </Values>
    </Asset>
  </ModOp>
</ModOps>
```

</details>

<a id="real-mods"></a>
## 15. Learn from six real mod triggers

These are reviewed source examples with actual callers, dependencies and consumers. They illustrate why comments and integration invariants matter. The six cases are a sample, not certification of every workspace trigger.

### 1500003013 — BT Passive Trading

The main counter checks for Blake's base merchant ship. Its child ObjectPosition checks proximity within Radius=115 of the processing participant's harbor pool. Under that gate, MutuallyExclusive chooses the first complete trade-tier alternative in source order. Each selected branch delays its ship-GUID change by 1000 ms; the source reports that an immediate change invalidated the counter too early and prevented completion/reset.

The reset waits until none of the changed variants is near the relevant ports and restores base GUIDs. Its filters explicitly allow missing objects/targets where configured. Serp confirms the trade changes remain gated by the parent proximity condition.

The change action filters by GUID/owner, not by radius or automatically matched parent object. This makes sense because the fleet configuration documents a unique ship GUID per merchant/progression and Amount=1. It is not a safe copy for arbitrary fleets containing several identical ships. Overlapping harbor radii are an accepted source limitation.

[Original mod code: Asset at line 24](<https://github.com/Serpens66/Anno-1800-Mods/blob/master/Recommended-Mods/BT%20Passive%20Trading%20(Serp)/data/config/export/main/asset/MoreTradeForHumansArchi.include.xml#L24>), [GUID 1500003013 at line 28](<https://github.com/Serpens66/Anno-1800-Mods/blob/master/Recommended-Mods/BT%20Passive%20Trading%20(Serp)/data/config/export/main/asset/MoreTradeForHumansArchi.include.xml#L28>). These optional links show the source and its original comments in the public repository. The presentation below removes original comments and uses an English display Name; gameplay fields are retained. It depends on the original mod integration and is not a standalone recipe.

<details>
<summary>Reviewed trigger 1500003013 — complete owning Asset</summary>

```xml
<Asset>
  <Template>Trigger</Template>
  <Values>
    <Standard>
      <GUID>1500003013</GUID>
      <Name>Reviewed trigger 1500003013</Name>
    </Standard>
    <Trigger>
      <TriggerCondition>
        <Template>ConditionPlayerCounter</Template>
        <Values>
          <Condition/>
          <ConditionPlayerCounter>
            <PlayerCounter>ObjectBuilt</PlayerCounter>
            <Context>1500000041</Context>
            <CounterAmount>1</CounterAmount>
            <CheckedParticipant>Third_party_02_Blake</CheckedParticipant>
            <CheckSpecificParticipant>1</CheckSpecificParticipant>
          </ConditionPlayerCounter>
        </Values>
      </TriggerCondition>
      <SubTriggers>
        <Item>
          <SubTrigger>
            <Template>AutoCreateTrigger</Template>
            <Values>
              <Trigger>
                <TriggerCondition>
                  <Template>ConditionObjectPosition</Template>
                  <Values>
                    <Condition>
                      <SubConditionCompletionOrder>MutuallyExclusive</SubConditionCompletionOrder>
                    </Condition>
                    <ConditionPropsSessionSettings/>
                    <ConditionObjectPosition>
                      <Radius>115</Radius>
                      <ExpectObjectExists>0</ExpectObjectExists>
                      <ExpectTargetExists>0</ExpectTargetExists>
                    </ConditionObjectPosition>
                    <ObjectFilter>
                      <ObjectGUID>1500000041</ObjectGUID>
                      <CheckParticipantID>1</CheckParticipantID>
                      <ObjectParticipantID>Third_party_02_Blake</ObjectParticipantID>
                    </ObjectFilter>
                    <ObjectTargetFilter>
                      <TargetGUID>193897</TargetGUID>
                      <TargetCheckParticipantID>1</TargetCheckParticipantID>
                      <TargetCheckProcessingParticipantID>1</TargetCheckProcessingParticipantID>
                    </ObjectTargetFilter>
                    <ConditionPropsNegatable/>
                  </Values>
                </TriggerCondition>
                <SubTriggers>
                  <Item>
                    <SubTrigger>
                      <Template>AutoCreateTrigger</Template>
                      <Values>
                        <Trigger>
                          <TriggerCondition>
                            <Template>ConditionUnlocked</Template>
                            <Values>
                              <Condition/>
                              <ConditionUnlocked>
                                <UnlockNeeded>1500003072</UnlockNeeded>
                              </ConditionUnlocked>
                              <ConditionPropsNegatable/>
                            </Values>
                          </TriggerCondition>
                          <TriggerActions>
                            <Item>
                              <TriggerAction>
                                <Template>ActionDelayedActions</Template>
                                <Values>
                                  <Action/>
                                  <ActionDelayedActions>
                                    <ExecutionDelay>1000</ExecutionDelay>
                                    <DelayedActions>
                                      <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                                      <Values>
                                        <ActionList>
                                          <Actions>
                                            <Item>
                                              <Action>
                                                <Template>ActionSetObjectGUID</Template>
                                                <Values>
                                                  <Action/>
                                                  <ObjectFilter>
                                                    <ObjectGUID>1500000041</ObjectGUID>
                                                    <CheckParticipantID>1</CheckParticipantID>
                                                    <ObjectParticipantID>Third_party_02_Blake</ObjectParticipantID>
                                                  </ObjectFilter>
                                                  <ActionSetObjectGUID>
                                                    <NewGUID>1500003009</NewGUID>
                                                  </ActionSetObjectGUID>
                                                </Values>
                                              </Action>
                                            </Item>
                                          </Actions>
                                        </ActionList>
                                      </Values>
                                    </DelayedActions>
                                  </ActionDelayedActions>
                                </Values>
                              </TriggerAction>
                            </Item>
                          </TriggerActions>
                        </Trigger>
                      </Values>
                    </SubTrigger>
                  </Item>
                  <Item>
                    <SubTrigger>
                      <Template>AutoCreateTrigger</Template>
                      <Values>
                        <Trigger>
                          <TriggerCondition>
                            <Template>ConditionUnlocked</Template>
                            <Values>
                              <Condition/>
                              <ConditionUnlocked>
                                <UnlockNeeded>1500003071</UnlockNeeded>
                              </ConditionUnlocked>
                              <ConditionPropsNegatable/>
                            </Values>
                          </TriggerCondition>
                          <TriggerActions>
                            <Item>
                              <TriggerAction>
                                <Template>ActionDelayedActions</Template>
                                <Values>
                                  <Action/>
                                  <ActionDelayedActions>
                                    <ExecutionDelay>1000</ExecutionDelay>
                                    <DelayedActions>
                                      <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                                      <Values>
                                        <ActionList>
                                          <Actions>
                                            <Item>
                                              <Action>
                                                <Template>ActionSetObjectGUID</Template>
                                                <Values>
                                                  <Action/>
                                                  <ObjectFilter>
                                                    <ObjectGUID>1500000041</ObjectGUID>
                                                    <CheckParticipantID>1</CheckParticipantID>
                                                    <ObjectParticipantID>Third_party_02_Blake</ObjectParticipantID>
                                                  </ObjectFilter>
                                                  <ActionSetObjectGUID>
                                                    <NewGUID>1500003005</NewGUID>
                                                  </ActionSetObjectGUID>
                                                </Values>
                                              </Action>
                                            </Item>
                                          </Actions>
                                        </ActionList>
                                      </Values>
                                    </DelayedActions>
                                  </ActionDelayedActions>
                                </Values>
                              </TriggerAction>
                            </Item>
                          </TriggerActions>
                        </Trigger>
                      </Values>
                    </SubTrigger>
                  </Item>
                  <Item>
                    <SubTrigger>
                      <Template>AutoCreateTrigger</Template>
                      <Values>
                        <Trigger>
                          <TriggerCondition>
                            <Template>ConditionUnlocked</Template>
                            <Values>
                              <Condition/>
                              <ConditionUnlocked>
                                <UnlockNeeded>1500003070</UnlockNeeded>
                              </ConditionUnlocked>
                              <ConditionPropsNegatable/>
                            </Values>
                          </TriggerCondition>
                          <TriggerActions>
                            <Item>
                              <TriggerAction>
                                <Template>ActionDelayedActions</Template>
                                <Values>
                                  <Action/>
                                  <ActionDelayedActions>
                                    <ExecutionDelay>1000</ExecutionDelay>
                                    <DelayedActions>
                                      <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                                      <Values>
                                        <ActionList>
                                          <Actions>
                                            <Item>
                                              <Action>
                                                <Template>ActionSetObjectGUID</Template>
                                                <Values>
                                                  <Action/>
                                                  <ObjectFilter>
                                                    <ObjectGUID>1500000041</ObjectGUID>
                                                    <CheckParticipantID>1</CheckParticipantID>
                                                    <ObjectParticipantID>Third_party_02_Blake</ObjectParticipantID>
                                                  </ObjectFilter>
                                                  <ActionSetObjectGUID>
                                                    <NewGUID>1500003001</NewGUID>
                                                  </ActionSetObjectGUID>
                                                </Values>
                                              </Action>
                                            </Item>
                                          </Actions>
                                        </ActionList>
                                      </Values>
                                    </DelayedActions>
                                  </ActionDelayedActions>
                                </Values>
                              </TriggerAction>
                            </Item>
                          </TriggerActions>
                        </Trigger>
                      </Values>
                    </SubTrigger>
                  </Item>
                </SubTriggers>
              </Trigger>
            </Values>
          </SubTrigger>
        </Item>
      </SubTriggers>
      <ResetTrigger>
        <Template>AutoCreateTrigger</Template>
        <Values>
          <Trigger>
            <TriggerCondition>
              <Template>ConditionObjectPosition</Template>
              <Values>
                <Condition/>
                <ConditionPropsSessionSettings/>
                <ConditionObjectPosition>
                  <Radius>115</Radius>
                  <ExpectObjectExists>0</ExpectObjectExists>
                  <ExpectTargetExists>0</ExpectTargetExists>
                </ConditionObjectPosition>
                <ObjectFilter>
                  <ObjectGUID>1500003001</ObjectGUID>
                  <CheckParticipantID>1</CheckParticipantID>
                  <ObjectParticipantID>Third_party_02_Blake</ObjectParticipantID>
                </ObjectFilter>
                <ObjectTargetFilter>
                  <TargetGUID>193897</TargetGUID>
                  <TargetCheckParticipantID>1</TargetCheckParticipantID>
                  <TargetCheckProcessingParticipantID>1</TargetCheckProcessingParticipantID>
                </ObjectTargetFilter>
                <ConditionPropsNegatable>
                  <NegateCondition>1</NegateCondition>
                </ConditionPropsNegatable>
              </Values>
            </TriggerCondition>
            <SubTriggers>
              <Item>
                <SubTrigger>
                  <Template>AutoCreateTrigger</Template>
                  <Values>
                    <Trigger>
                      <TriggerCondition>
                        <Template>ConditionObjectPosition</Template>
                        <Values>
                          <Condition/>
                          <ConditionPropsSessionSettings/>
                          <ConditionObjectPosition>
                            <Radius>115</Radius>
                            <ExpectObjectExists>0</ExpectObjectExists>
                            <ExpectTargetExists>0</ExpectTargetExists>
                          </ConditionObjectPosition>
                          <ObjectFilter>
                            <ObjectGUID>1500003005</ObjectGUID>
                            <CheckParticipantID>1</CheckParticipantID>
                            <ObjectParticipantID>Third_party_02_Blake</ObjectParticipantID>
                          </ObjectFilter>
                          <ObjectTargetFilter>
                            <TargetGUID>193897</TargetGUID>
                            <TargetCheckParticipantID>1</TargetCheckParticipantID>
                            <TargetCheckProcessingParticipantID>1</TargetCheckProcessingParticipantID>
                          </ObjectTargetFilter>
                          <ConditionPropsNegatable>
                            <NegateCondition>1</NegateCondition>
                          </ConditionPropsNegatable>
                        </Values>
                      </TriggerCondition>
                      <SubTriggers>
                        <Item>
                          <SubTrigger>
                            <Template>AutoCreateTrigger</Template>
                            <Values>
                              <Trigger>
                                <TriggerCondition>
                                  <Template>ConditionObjectPosition</Template>
                                  <Values>
                                    <Condition/>
                                    <ConditionPropsSessionSettings/>
                                    <ConditionObjectPosition>
                                      <Radius>115</Radius>
                                      <ExpectObjectExists>0</ExpectObjectExists>
                                      <ExpectTargetExists>0</ExpectTargetExists>
                                    </ConditionObjectPosition>
                                    <ObjectFilter>
                                      <ObjectGUID>1500003009</ObjectGUID>
                                      <CheckParticipantID>1</CheckParticipantID>
                                      <ObjectParticipantID>Third_party_02_Blake</ObjectParticipantID>
                                    </ObjectFilter>
                                    <ObjectTargetFilter>
                                      <TargetGUID>193897</TargetGUID>
                                      <TargetCheckParticipantID>1</TargetCheckParticipantID>
                                      <TargetCheckProcessingParticipantID>1</TargetCheckProcessingParticipantID>
                                    </ObjectTargetFilter>
                                    <ConditionPropsNegatable>
                                      <NegateCondition>1</NegateCondition>
                                    </ConditionPropsNegatable>
                                  </Values>
                                </TriggerCondition>
                              </Trigger>
                            </Values>
                          </SubTrigger>
                        </Item>
                      </SubTriggers>
                    </Trigger>
                  </Values>
                </SubTrigger>
              </Item>
            </SubTriggers>
            <TriggerActions>
              <Item>
                <TriggerAction>
                  <Template>ActionSetObjectGUID</Template>
                  <Values>
                    <Action/>
                    <ObjectFilter>
                      <ObjectGUID>1500003001</ObjectGUID>
                      <CheckParticipantID>1</CheckParticipantID>
                      <ObjectParticipantID>Third_party_02_Blake</ObjectParticipantID>
                    </ObjectFilter>
                    <ActionSetObjectGUID>
                      <NewGUID>1500000041</NewGUID>
                    </ActionSetObjectGUID>
                  </Values>
                </TriggerAction>
              </Item>
              <Item>
                <TriggerAction>
                  <Template>ActionSetObjectGUID</Template>
                  <Values>
                    <Action/>
                    <ObjectFilter>
                      <ObjectGUID>1500003005</ObjectGUID>
                      <CheckParticipantID>1</CheckParticipantID>
                      <ObjectParticipantID>Third_party_02_Blake</ObjectParticipantID>
                    </ObjectFilter>
                    <ActionSetObjectGUID>
                      <NewGUID>1500000041</NewGUID>
                    </ActionSetObjectGUID>
                  </Values>
                </TriggerAction>
              </Item>
              <Item>
                <TriggerAction>
                  <Template>ActionSetObjectGUID</Template>
                  <Values>
                    <Action/>
                    <ObjectFilter>
                      <ObjectGUID>1500003009</ObjectGUID>
                      <CheckParticipantID>1</CheckParticipantID>
                      <ObjectParticipantID>Third_party_02_Blake</ObjectParticipantID>
                    </ObjectFilter>
                    <ActionSetObjectGUID>
                      <NewGUID>1500000041</NewGUID>
                    </ActionSetObjectGUID>
                  </Values>
                </TriggerAction>
              </Item>
            </TriggerActions>
          </Trigger>
        </Values>
      </ResetTrigger>
    </Trigger>
    <TriggerSetup>
      <UsedBySecondParties>0</UsedBySecondParties>
    </TriggerSetup>
  </Values>
</Asset>
```

</details>

### 1500003820 — PirateExtraSpawn eligibility and timer

The chain is human discovery of Harlow → positive custom not-defeated signal → at most three ships in pirate pool 700138 → one-hour timer → four registrations of 1500003835 at 0/500/1000/1500 ms. The reset waits 30000 ms before rearming.

The custom helper checks Harlow's lighthouse/ruin state in session 180023 and maintains paired positive defeated/not-defeated signals. It is not a generic IsParticipantInGame check. The counter sums the compatible pool members; it does not require a separate count threshold for every pirate ship type.

Serp considers full timer restart after an ancestor becomes false **probable, not confirmed**. The workflow splits ForceBuild into individual scripts under the all-client same-tick premise; counter Global scope does not establish the Lua session.

### 1500003835 — PirateExtraSpawn manual dispatch

This owning trigger uses AutoRegisterTrigger=0. Its main discovery condition gates an optional positive not-defeated child that calls the Harlow ForceBuild script. The root IsOptional flag is assessed as ineffective without a parent; the child's flag can let the parent finish without its extra action.

A false discovery main is not proven to be consumed by optionality. If the trigger is still registered and waiting, another XML registration does nothing. After full completion, a later XML registration can start a fresh attempt. Lua concurrent registration is a separate entry point.

[Original mod code: Asset at line 17](<https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-/blob/main/shared_PirateExtraSpawn/data/config/export/main/asset/SpawnShipsIfWeak.include.xml#L17>), [GUID 1500003820 at line 21](<https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-/blob/main/shared_PirateExtraSpawn/data/config/export/main/asset/SpawnShipsIfWeak.include.xml#L21>). These optional links show the source and its original comments in the public repository. The presentation below removes original comments and uses an English display Name; gameplay fields are retained. It depends on the original mod integration and is not a standalone recipe.

<details>
<summary>Reviewed trigger 1500003820 — complete owning Asset</summary>

```xml
<Asset>
  <Template>Trigger</Template>
  <Values>
    <Standard>
      <GUID>1500003820</GUID>
      <Name>Reviewed trigger 1500003820</Name>
    </Standard>
    <Trigger>
      <TriggerCondition>
        <Template>ConditionIsDiscovered</Template>
        <Values>
          <Condition/>
          <ParticipantRelation>
            <SourceIsOwner>1</SourceIsOwner>
            <TargetParticipant>Third_party_03_Pirate_Harlow</TargetParticipant>
          </ParticipantRelation>
          <ConditionIsDiscovered/>
          <ConditionPropsNegatable/>
        </Values>
      </TriggerCondition>
      <SubTriggers>
        <Item>
          <SubTrigger>
            <Template>AutoCreateTrigger</Template>
            <Values>
              <Trigger>
                <TriggerCondition>
                  <Template>Harlow_Currently_NOT_Defeated</Template>
                  <Values/>
                </TriggerCondition>
                <SubTriggers>
                  <Item>
                    <SubTrigger>
                      <Template>AutoCreateTrigger</Template>
                      <Values>
                        <Trigger>
                          <TriggerCondition>
                            <Template>ConditionPlayerCounter</Template>
                            <Values>
                              <Condition/>
                              <ConditionPlayerCounter>
                                <PlayerCounter>ObjectBuilt</PlayerCounter>
                                <Context>700138</Context>
                                <CounterAmount>3</CounterAmount>
                                <ComparisonOp>AtMost</ComparisonOp>
                                <CheckSpecificParticipant>1</CheckSpecificParticipant>
                                <CheckedParticipant>Third_party_03_Pirate_Harlow</CheckedParticipant>
                              </ConditionPlayerCounter>
                            </Values>
                          </TriggerCondition>
                          <SubTriggers>
                            <Item>
                              <SubTrigger>
                                <Template>AutoCreateTrigger</Template>
                                <Values>
                                  <Trigger>
                                    <TriggerCondition>
                                      <Template>ConditionTimer</Template>
                                      <Values>
                                        <Condition/>
                                        <ConditionTimer>
                                          <TimeLimit>3600000</TimeLimit>
                                        </ConditionTimer>
                                      </Values>
                                    </TriggerCondition>
                                    <TriggerActions>
                                      <Item>
                                        <TriggerAction>
                                          <Template>ActionRegisterTrigger</Template>
                                          <Values>
                                            <Action/>
                                            <ActionRegisterTrigger>
                                              <TriggerAsset>1500003835</TriggerAsset>
                                            </ActionRegisterTrigger>
                                          </Values>
                                        </TriggerAction>
                                      </Item>
                                      <Item>
                                        <TriggerAction>
                                          <Template>ActionDelayedActions</Template>
                                          <Values>
                                            <Action/>
                                            <ActionDelayedActions>
                                              <ExecutionDelay>500</ExecutionDelay>
                                              <DelayedActions>
                                                <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                                                <Values>
                                                  <ActionList>
                                                    <Actions>
                                                      <Item>
                                                        <Action>
                                                          <Template>ActionRegisterTrigger</Template>
                                                          <Values>
                                                            <Action/>
                                                            <ActionRegisterTrigger>
                                                              <TriggerAsset>1500003835</TriggerAsset>
                                                            </ActionRegisterTrigger>
                                                          </Values>
                                                        </Action>
                                                      </Item>
                                                    </Actions>
                                                  </ActionList>
                                                </Values>
                                              </DelayedActions>
                                            </ActionDelayedActions>
                                          </Values>
                                        </TriggerAction>
                                      </Item>
                                      <Item>
                                        <TriggerAction>
                                          <Template>ActionDelayedActions</Template>
                                          <Values>
                                            <Action/>
                                            <ActionDelayedActions>
                                              <ExecutionDelay>1000</ExecutionDelay>
                                              <DelayedActions>
                                                <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                                                <Values>
                                                  <ActionList>
                                                    <Actions>
                                                      <Item>
                                                        <Action>
                                                          <Template>ActionRegisterTrigger</Template>
                                                          <Values>
                                                            <Action/>
                                                            <ActionRegisterTrigger>
                                                              <TriggerAsset>1500003835</TriggerAsset>
                                                            </ActionRegisterTrigger>
                                                          </Values>
                                                        </Action>
                                                      </Item>
                                                    </Actions>
                                                  </ActionList>
                                                </Values>
                                              </DelayedActions>
                                            </ActionDelayedActions>
                                          </Values>
                                        </TriggerAction>
                                      </Item>
                                      <Item>
                                        <TriggerAction>
                                          <Template>ActionDelayedActions</Template>
                                          <Values>
                                            <Action/>
                                            <ActionDelayedActions>
                                              <ExecutionDelay>1500</ExecutionDelay>
                                              <DelayedActions>
                                                <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                                                <Values>
                                                  <ActionList>
                                                    <Actions>
                                                      <Item>
                                                        <Action>
                                                          <Template>ActionRegisterTrigger</Template>
                                                          <Values>
                                                            <Action/>
                                                            <ActionRegisterTrigger>
                                                              <TriggerAsset>1500003835</TriggerAsset>
                                                            </ActionRegisterTrigger>
                                                          </Values>
                                                        </Action>
                                                      </Item>
                                                    </Actions>
                                                  </ActionList>
                                                </Values>
                                              </DelayedActions>
                                            </ActionDelayedActions>
                                          </Values>
                                        </TriggerAction>
                                      </Item>
                                    </TriggerActions>
                                  </Trigger>
                                </Values>
                              </SubTrigger>
                            </Item>
                          </SubTriggers>
                        </Trigger>
                      </Values>
                    </SubTrigger>
                  </Item>
                </SubTriggers>
              </Trigger>
            </Values>
          </SubTrigger>
        </Item>
      </SubTriggers>
      <ResetTrigger>
        <Template>AutoCreateTrigger</Template>
        <Values>
          <Trigger>
            <TriggerCondition>
              <Template>ConditionTimer</Template>
              <Values>
                <Condition/>
                <ConditionTimer>
                  <TimeLimit>30000</TimeLimit>
                </ConditionTimer>
              </Values>
            </TriggerCondition>
          </Trigger>
        </Values>
      </ResetTrigger>
    </Trigger>
    <TriggerSetup>
      <AutoRegisterTrigger>1</AutoRegisterTrigger>
      <UsedBySecondParties>0</UsedBySecondParties>
    </TriggerSetup>
  </Values>
</Asset>
```

</details>

[Original mod code: Asset at line 438](<https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-/blob/main/shared_PirateExtraSpawn/data/config/export/main/asset/SpawnShipsIfWeak.include.xml#L438>), [GUID 1500003835 at line 442](<https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-/blob/main/shared_PirateExtraSpawn/data/config/export/main/asset/SpawnShipsIfWeak.include.xml#L442>). These optional links show the source and its original comments in the public repository. The presentation below removes original comments and uses an English display Name; gameplay fields are retained. It depends on the original mod integration and is not a standalone recipe.

<details>
<summary>Reviewed trigger 1500003835 — complete owning Asset</summary>

```xml
<Asset>
  <Template>Trigger</Template>
  <Values>
    <Standard>
      <GUID>1500003835</GUID>
      <Name>Reviewed trigger 1500003835</Name>
    </Standard>
    <Trigger>
      <TriggerCondition>
        <Template>ConditionIsDiscovered</Template>
        <Values>
          <Condition>
            <IsOptional>1</IsOptional>
          </Condition>
          <ParticipantRelation>
            <SourceIsOwner>1</SourceIsOwner>
            <TargetParticipant>Third_party_03_Pirate_Harlow</TargetParticipant>
          </ParticipantRelation>
          <ConditionIsDiscovered/>
          <ConditionPropsNegatable/>
        </Values>
      </TriggerCondition>
      <SubTriggers>
        <Item>
          <SubTrigger>
            <Template>AutoCreateTrigger</Template>
            <Values>
              <Trigger>
                <TriggerCondition>
                  <Template>Harlow_Currently_NOT_Defeated</Template>
                  <Values>
                    <Condition>
                      <IsOptional>1</IsOptional>
                    </Condition>
                  </Values>
                </TriggerCondition>
                <TriggerActions>
                  <Item>
                    <TriggerAction>
                      <Template>ActionExecuteScript</Template>
                      <Values>
                        <Action/>
                        <ActionExecuteScript>
                          <ScriptFileName>data/scripts_serp/forcebuild_harlow.lua</ScriptFileName>
                        </ActionExecuteScript>
                      </Values>
                    </TriggerAction>
                  </Item>
                </TriggerActions>
              </Trigger>
            </Values>
          </SubTrigger>
        </Item>
      </SubTriggers>
    </Trigger>
    <TriggerSetup>
      <AutoRegisterTrigger>0</AutoRegisterTrigger>
      <UsedBySecondParties>0</UsedBySecondParties>
    </TriggerSetup>
  </Values>
</Asset>
```

</details>

### 1500001103 — PirateComebackFleetFix quest-end cleanup

The mod adds a delayed registration to the native resettle quest's OnQuestEnd while preserving the native unregister action. Comments describe a special ending when loading during resettlement; ordinary endings also run the harmless cleanup.

The manually registered trigger waits for the positive Human0 marker. Its optional child checks Harlow's ruined harbor and deletes the labeled resettlement fleet in session 180023. If repaired, the optional leaf does not need to block parent completion. The Human0 marker coordinates this XML delete action; it would not deduplicate an arbitrary Lua action by itself.

[Original mod code: Asset at line 131](<https://github.com/Serpens66/Anno-1800-Mods/blob/master/YouKnowWhatYouDo-Mods/P%20PirateComebackFleetFix%20(Serp)/data/config/export/main/asset/ComebackFleet.include.xml#L131>), [GUID 1500001103 at line 135](<https://github.com/Serpens66/Anno-1800-Mods/blob/master/YouKnowWhatYouDo-Mods/P%20PirateComebackFleetFix%20(Serp)/data/config/export/main/asset/ComebackFleet.include.xml#L135>). These optional links show the source and its original comments in the public repository. The presentation below removes original comments and uses an English display Name; gameplay fields are retained. It depends on the original mod integration and is not a standalone recipe.

<details>
<summary>Reviewed trigger 1500001103 — complete owning Asset</summary>

```xml
<Asset>
  <Template>Trigger</Template>
  <Values>
    <Standard>
      <GUID>1500001103</GUID>
      <Name>Reviewed trigger 1500001103</Name>
    </Standard>
    <Trigger>
      <TriggerCondition>
        <Template>ConditionUnlocked</Template>
        <Values>
          <Condition/>
          <ConditionUnlocked>
            <UnlockNeeded>1500001613</UnlockNeeded>
          </ConditionUnlocked>
          <ConditionPropsNegatable/>
        </Values>
      </TriggerCondition>
      <SubTriggers>
        <Item>
          <SubTrigger>
            <Template>AutoCreateTrigger</Template>
            <Values>
              <Trigger>
                <TriggerCondition>
                  <Template>ConditionPlayerCounter</Template>
                  <Values>
                    <Condition>
                      <IsOptional>1</IsOptional>
                    </Condition>
                    <ConditionPlayerCounter>
                      <PlayerCounter>RuinCount</PlayerCounter>
                      <Context>100681</Context>
                      <CounterAmount>1</CounterAmount>
                      <ComparisonOp>AtLeast</ComparisonOp>
                      <CheckSpecificParticipant>1</CheckSpecificParticipant>
                      <CheckedParticipant>Third_party_03_Pirate_Harlow</CheckedParticipant>
                    </ConditionPlayerCounter>
                  </Values>
                </TriggerCondition>
                <TriggerActions>
                  <Item>
                    <TriggerAction>
                      <Template>ActionDeleteObjects</Template>
                      <Values>
                        <Action/>
                        <ActionDeleteObjects>
                          <ShipsLeaveMapFirst>0</ShipsLeaveMapFirst>
                        </ActionDeleteObjects>
                        <ObjectFilter>
                          <ObjectLabel>PirateHarlowResettleGroup</ObjectLabel>
                          <ObjectSession>180023</ObjectSession>
                        </ObjectFilter>
                      </Values>
                    </TriggerAction>
                  </Item>
                </TriggerActions>
              </Trigger>
            </Values>
          </SubTrigger>
        </Item>
      </SubTriggers>
    </Trigger>
    <TriggerSetup>
      <AutoRegisterTrigger>0</AutoRegisterTrigger>
      <UsedBySecondParties>0</UsedBySecondParties>
    </TriggerSetup>
  </Values>
</Asset>
```

</details>

### 1500004302 — Campaign in Coop play path

Local notification buttons submit synchronized RelockNet signals. The play listener watches another asset's GUIDLocked event, not MovieFinished. It unregisters the skip listener, queues the movie with SuppressGamePause, emits a transition signal and emits a completion signal after 219000 ms.

Downstream patched vanilla triggers enter the Moderate session after 1000 ms and later unload the previous session. The movie trigger therefore causes unloading indirectly. The dependency supplies the named slow/normal scripts, but their current files are comment-only. The fixed movie duration is a specific workaround, not a generic video completion detector.

### 1500004332 — Campaign in Coop skip path

The skip/default UI command relocks its own signal. This listener unregisters the play trigger, emits the same transition signal, and waits 4000 ms before emitting the shared completion signal. Unregistering the play listener does not remove its Locked property or stop other listeners observing the later completion relock.

4000 ms exceeds the downstream configured 1000 ms transition delay. That is consistent ordering, not proof that every session transition has finished on every client. The reviewed integration supports Coop with one human participant slot. Save refresh can read new code on fresh registration, but still needs correct progress guards.

[Original mod code: Asset at line 223](<https://github.com/Serpens66/Anno-1800-Mods/blob/master/YouKnowWhatYouDo-Mods/Campaign%20in%20Coop%20(Serp)/data/config/export/main/asset/AntiDesync/MovieUnlocks.include.xml#L223>), [GUID 1500004302 at line 227](<https://github.com/Serpens66/Anno-1800-Mods/blob/master/YouKnowWhatYouDo-Mods/Campaign%20in%20Coop%20(Serp)/data/config/export/main/asset/AntiDesync/MovieUnlocks.include.xml#L227>). These optional links show the source and its original comments in the public repository. The presentation below removes original comments and uses an English display Name; gameplay fields are retained. It depends on the original mod integration and is not a standalone recipe.

<details>
<summary>Reviewed trigger 1500004302 — complete owning Asset</summary>

```xml
<Asset>
  <Template>FeatureUnlock</Template>
  <Values>
    <Standard>
      <GUID>1500004302</GUID>
      <Name>Reviewed trigger 1500004302</Name>
    </Standard>
    <Locked>
      <DefaultLockedState>0</DefaultLockedState>
    </Locked>
    <Trigger>
      <TriggerCondition>
        <Template>ConditionEvent</Template>
        <Values>
          <Condition/>
          <ConditionEvent>
            <ConditionEvent>GUIDLocked</ConditionEvent>
            <ContextAsset>1500004391</ContextAsset>
          </ConditionEvent>
          <ConditionPropsNegatable/>
        </Values>
      </TriggerCondition>
      <TriggerActions>
        <Item>
          <TriggerAction>
            <Template>ActionRegisterTrigger</Template>
            <Values>
              <Action/>
              <ActionRegisterTrigger>
                <TriggerAsset>1500004332</TriggerAsset>
                <UnregisterTrigger>1</UnregisterTrigger>
              </ActionRegisterTrigger>
            </Values>
          </TriggerAction>
        </Item>
        <Item>
          <TriggerAction>
            <Template>ActionExecuteScript</Template>
            <Values>
              <Action/>
              <ActionExecuteScript>
                <ScriptFileName>data/gamespeed_slow_serp.lua</ScriptFileName>
              </ActionExecuteScript>
            </Values>
          </TriggerAction>
        </Item>
        <Item>
          <TriggerAction>
            <Template>ActionPlayMovie</Template>
            <Values>
              <Action/>
              <ActionPlayMovie>
                <Movie>1500004202</Movie>
                <SuppressGamePause>1</SuppressGamePause>
              </ActionPlayMovie>
            </Values>
          </TriggerAction>
        </Item>
        <Item>
          <TriggerAction>
            <Template>ActionLockAsset</Template>
            <Values>
              <Action/>
              <ActionLockAsset>
                <LockAssets>
                  <Item>
                    <Asset>1500004234</Asset>
                  </Item>
                </LockAssets>
              </ActionLockAsset>
            </Values>
          </TriggerAction>
        </Item>
        <Item>
          <TriggerAction>
            <Template>ActionDelayedActions</Template>
            <Values>
              <Action/>
              <ActionDelayedActions>
                <ExecutionDelay>219000</ExecutionDelay>
                <DelayedActions>
                  <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                  <Values>
                    <ActionList>
                      <Actions>
                        <Item>
                          <Action>
                            <Template>ActionExecuteScript</Template>
                            <Values>
                              <Action/>
                              <ActionExecuteScript>
                                <ScriptFileName>data/gamespeed_normal_serp.lua</ScriptFileName>
                              </ActionExecuteScript>
                            </Values>
                          </Action>
                        </Item>
                        <Item>
                          <Action>
                            <Template>ActionLockAsset</Template>
                            <Values>
                              <Action/>
                              <ActionLockAsset>
                                <LockAssets>
                                  <Item>
                                    <Asset>1500004302</Asset>
                                  </Item>
                                </LockAssets>
                              </ActionLockAsset>
                            </Values>
                          </Action>
                        </Item>
                      </Actions>
                    </ActionList>
                  </Values>
                </DelayedActions>
              </ActionDelayedActions>
            </Values>
          </TriggerAction>
        </Item>
      </TriggerActions>
    </Trigger>
    <TriggerSetup>
      <UsedBySecondParties>0</UsedBySecondParties>
      <AutoSelfUnlock>0</AutoSelfUnlock>
    </TriggerSetup>
  </Values>
</Asset>
```

</details>

[Original mod code: Asset at line 352](<https://github.com/Serpens66/Anno-1800-Mods/blob/master/YouKnowWhatYouDo-Mods/Campaign%20in%20Coop%20(Serp)/data/config/export/main/asset/AntiDesync/MovieUnlocks.include.xml#L352>), [GUID 1500004332 at line 356](<https://github.com/Serpens66/Anno-1800-Mods/blob/master/YouKnowWhatYouDo-Mods/Campaign%20in%20Coop%20(Serp)/data/config/export/main/asset/AntiDesync/MovieUnlocks.include.xml#L356>). These optional links show the source and its original comments in the public repository. The presentation below removes original comments and uses an English display Name; gameplay fields are retained. It depends on the original mod integration and is not a standalone recipe.

<details>
<summary>Reviewed trigger 1500004332 — complete owning Asset</summary>

```xml
<Asset>
  <Template>FeatureUnlock</Template>
  <Values>
    <Standard>
      <GUID>1500004332</GUID>
      <Name>Reviewed trigger 1500004332</Name>
    </Standard>
    <Locked>
      <DefaultLockedState>0</DefaultLockedState>
    </Locked>
    <Trigger>
      <TriggerCondition>
        <Template>ConditionEvent</Template>
        <Values>
          <Condition/>
          <ConditionEvent>
            <ConditionEvent>GUIDLocked</ConditionEvent>
            <ContextAsset>1500004332</ContextAsset>
          </ConditionEvent>
          <ConditionPropsNegatable/>
        </Values>
      </TriggerCondition>
      <TriggerActions>
        <Item>
          <TriggerAction>
            <Template>ActionRegisterTrigger</Template>
            <Values>
              <Action/>
              <ActionRegisterTrigger>
                <TriggerAsset>1500004302</TriggerAsset>
                <UnregisterTrigger>1</UnregisterTrigger>
              </ActionRegisterTrigger>
            </Values>
          </TriggerAction>
        </Item>
        <Item>
          <TriggerAction>
            <Template>ActionLockAsset</Template>
            <Values>
              <Action/>
              <ActionLockAsset>
                <LockAssets>
                  <Item>
                    <Asset>1500004234</Asset>
                  </Item>
                </LockAssets>
              </ActionLockAsset>
            </Values>
          </TriggerAction>
        </Item>
        <Item>
          <TriggerAction>
            <Template>ActionDelayedActions</Template>
            <Values>
              <Action/>
              <ActionDelayedActions>
                <ExecutionDelay>4000</ExecutionDelay>
                <DelayedActions>
                  <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
                  <Values>
                    <ActionList>
                      <Actions>
                        <Item>
                          <Action>
                            <Template>ActionLockAsset</Template>
                            <Values>
                              <Action/>
                              <ActionLockAsset>
                                <LockAssets>
                                  <Item>
                                    <Asset>1500004302</Asset>
                                  </Item>
                                </LockAssets>
                              </ActionLockAsset>
                            </Values>
                          </Action>
                        </Item>
                      </Actions>
                    </ActionList>
                  </Values>
                </DelayedActions>
              </ActionDelayedActions>
            </Values>
          </TriggerAction>
        </Item>
      </TriggerActions>
    </Trigger>
    <TriggerSetup>
      <AutoSelfUnlock>0</AutoSelfUnlock>
      <UsedBySecondParties>0</UsedBySecondParties>
    </TriggerSetup>
  </Values>
</Asset>
```

</details>

### Integration details needed to read these cases

The selected PirateExtraSpawn and PirateComebackFleetFix bundles use PirateDefeatHelpers 1.041; the inspected copies were byte-identical. The checked WhichPlayer 1.091 and IsAIPlayer 1.02 bundles match their standalone counterparts. Campaign in Coop 1.021 uses StoryQuestsInCoop 1.031 and its CheckSingleHuman 1.02 bundle. An installed higher-version shared mod can change the effective dependency; those versions are the reviewed scope, not universal requirements for all future versions.

The positive Harlow-not-defeated helper maps its custom condition to unlock 1500001145. This signal checks lighthouse 100707 with RuinCount at most zero in session 180023, then self-unlocks. The paired defeated signal 1500001147 checks ruin state and each side resets/relocks through the opposite signal. Both start locked, so absence of the positive signal during initialization is not itself a confirmed defeat. Native Harlow profile 73 has ProfileCounter; pirate pool 700138 contains ship types 102429–102432.

The positive Human0 marker 1500001613 is initially locked. WhichPlayer initializer 1500001672 invokes its human-identification script and maps human ParticipantIDs 0–3 to synchronized marker unlocks. That is why waiting for the positive marker matters. It selects a company, not one Coop peer.

For the Campaign movie path, local play submits RelockNet(1500004300) and RelockNet(1500004391); skip/default submits RelockNet(1500004300) and RelockNet(1500004332). The shared availability identity is 1500004300. Play/skip both emit transition signal 1500004234. Patched native trigger 150721 listens for that edge, enters session 180023 after 1000 ms, unlocks PrologueCompleted 142310 and restores selected object visibility. The completion relock on 1500004302 is consumed by patched 150594/150836; 150594 unloads session 180014. Save migration 1500004385 unregisters and, after 1000 ms, re-registers relevant listeners. Fresh registration refreshes code; correct progress guards and listener ordering are still needed.

The movie copy derives from native Video 600170. Both named game-speed scripts in the reviewed dependency contain only comments. Availability checking does not prove an atomic resolution of two peers choosing conflicting buttons; preserve the original single-decision/host caveat.

The Harlow dispatch script's effective direct call is shown here. It needs the correct participant/session and all-client tick alignment explained earlier; it is not a new guarantee for clients in different sessions.

<details>
<summary>Harlow ForceBuild dispatch — effective Lua call</summary>

```lua
local Pirate_PID = 17 -- Harlow
ts.SessionParticipants.GetParticipant(Pirate_PID).Trader.ForceBuild()
```

</details>

<a id="troubleshooting"></a>
## 16. Troubleshooting and design checklist

| Symptom | Check first |
| --- | --- |
| Trigger never fires | Is it registered? Is a positive initialization marker ready? Are the counter type/context/scope valid? Is an owner filter actually enabled? |
| Condition fired in the past but event listener stays false | Was the listener armed before the event? Is this an edge where a persistent state would better express the intent? |
| Conditions were never true together but root completed | Did you use remembered Parallel siblings rather than nested live gates? |
| Linear chain misses its second event | Did B happen before the B listener became eligible? |
| Wrong alternative wins | Was the earlier branch fully complete, including descendants? Are siblings in the intended priority order? |
| Optional action did not run | Optional means non-blocking, not unconditional or guaranteed eventual retry. |
| Trigger runs only once | Is there an actual embedded reset or a later fresh registration? Is the reset condition reachable? |
| XML registration appears to do nothing | Is the instance already registered? It is a no-op in that state. |
| Lua produces duplicate work | Can several clients or repeated Lua calls create concurrent registrations? Is the command automatically synchronized? |
| Ship/action affects too many objects | Is the action filter broader than the condition? Is the unique-object invariant really present? |
| Counter or reset breaks after an action | Does the action invalidate its condition immediately? Has the counter updated before the next baseline? |
| Correct session, wrong island | Session context is not QuestArea. Check producer/consumer propagation and supported island restriction. |
| New XML seems ignored in a save | Existing registered code is a snapshot. Did you actually reach fresh registration, and did the new event already occur? |
| Removed mod still causes actions | Does the saved trigger have a valid presence guard? A missing positive unlock asset is treated as unlocked in the reported tests. |
| Coop desync despite simple actions | Local event completion, differing ticks/targets/sessions, random pool choices, or multiple synchronized submissions may be involved. |
| Infinite loading or surprising repeated effects with Threshold | Preserve its known subtrigger/reset and repetition limits; do not treat it as a normal drop-in numeric condition. |

### Before you finish a trigger

1. State the exact behavior, processing participant, targets and repeat rule in plain language.
2. Audit its templates, properties, effective defaults, datasets, concrete references and action consumers.
3. Decide what must be true together and what may be remembered; draw the gate/branch sequence before writing nested XML.
4. Place each action at the level whose completion should permit it. Follow its target filters separately.
5. Trace registration, eligibility, branch completion, root completion and reset. Include condition changes caused by actions.
6. Trace initialization, defeat, absence, save load, code refresh and mod removal where relevant.
7. For Lua/Coop, count clients separately from participants and identify command synchronization, tick and target requirements.
8. Check XML/ModOps offline. Label game observations and remaining uncertainty honestly; test new runtime assumptions only in the relevant game setup.

### Four worked design checks

| Task | Reasoned design |
| --- | --- |
| A, B and C must hold together before an action | Use A → B → C with the action at C; Parallel siblings can remember separate earlier successes. |
| Prefer outcome A, otherwise outcome B | Put the alternatives in source priority order under a suitable parent gate using MutuallyExclusive; complete descendants determine eligibility. |
| Perform a repeating action | Use the embedded reset/cooldown and explain its total cycle, current condition after side effects and fresh snapshot boundary. |
| Resume a save-sensitive Coop workflow | Separate synchronized signals from local UI, register listeners before edges, refresh saved code through fresh registration and guard completed progress. Human0 does not imply one Lua peer. |

These are reader walkthroughs supported by the guide, not independent new-agent or game tests.

<a id="condition-catalogue"></a>
## 17. Condition catalogue and common fields

The 91 entries below are native templates with a direct `Condition` property in the captured revision. Purposes are descriptions from their names/fields and reviewed evidence, not certification of every use. A quest objective, selector or schema-only property may belong to another consumer. Absence of a same-named Condition template is not proof that a property can never be used.

The catalogue links to property sections in this same file and lists native owners as provenance for inspection in your own vanilla assets.xml. Some owners are achievements or disabled/tutorial content; their existence does not prove suitability for a live mod trigger. “No explicit sample” means search inherited/inline Values as well, not “unused in vanilla”.

| Template and candidate purpose | Property contracts | Captured native owners |
| --- | --- | --- |
| `ConditionActiveRegion`: Presence in a session of a chosen region | [Condition](#property-condition), [ConditionActiveRegion](#property-conditionactiveregion) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionActiveSession`: Active-session presence / blacklist | [Condition](#property-condition), [ConditionActiveSession](#property-conditionactivesession) | GUID 150746 (assets.xml:749853); GUID 150810 (assets.xml:750145) |
| `ConditionAlwaysFalse`: Never-satisfied gate | [Condition](#property-condition), [ConditionAlwaysFalse](#property-conditionalwaysfalse) | GUID 150770 (assets.xml:759660); GUID 150621 (assets.xml:760286) |
| `ConditionAlwaysTrue`: Unconditional gate | [Condition](#property-condition), [ConditionAlwaysTrue](#property-conditionalwaystrue) | GUID 11468 (assets.xml:705276)); GUID 150746 (assets.xml:749853) |
| `ConditionAreaClaimed`: Claimed status of a specified island | [Condition](#property-condition), [ConditionAreaClaimed](#property-conditionareaclaimed) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionAttractiveness`: Attractiveness type/value and scope | [Condition](#property-condition), [ConditionAttractiveness](#property-conditionattractiveness) | GUID 114562 (assets.xml:2936511); GUID 136971 (assets.xml:4174050) |
| `ConditionBuildingsInBlueprintmode`: Blueprint count for a building type | [Condition](#property-condition), [ConditionBuildingsInBlueprintmode](#property-conditionbuildingsinblueprintmode) | GUID 7968 (assets.xml:845696); GUID 7970 (assets.xml:846065) |
| `ConditionBurningObject`: Burning-object list | [Condition](#property-condition), [ConditionBurningObject](#property-conditionburningobject) | GUID 400095 (assets.xml:2345790) |
| `ConditionBusActivationNeedSaturation`: Need saturation across filtered objects | [Condition](#property-condition), [ObjectFilter](#property-objectfilter), [ConditionBusActivationNeedSaturation](#property-conditionbusactivationneedsaturation) | GUID 132790 (assets.xml:4026724); GUID 134573 (assets.xml:4027085) |
| `ConditionCameraMovement`: Tracked camera action/distance | [Condition](#property-condition), [ConditionCameraMovement](#property-conditioncameramovement) | GUID 10000108 (assets.xml:2724296) |
| `ConditionCorporationDifficulty`: Game-setup difficulty flags | [Condition](#property-condition), [ConditionCorporationDifficulty](#property-conditioncorporationdifficulty) | GUID 151121 (assets.xml:801816); GUID 151271 (assets.xml:802215) |
| `ConditionDecision`: Player decision with an option list | [Condition](#property-condition), [ConditionDecision](#property-conditiondecision) | GUID 119886 (assets.xml:3347446); GUID 119899 (assets.xml:3356261) |
| `ConditionDecisionOption`: Decision option, actions, cost/unlock/UI behavior | [Condition](#property-condition), [ConditionDecisionOption](#property-conditiondecisionoption) | GUID 119886 (assets.xml:3347446); GUID 119899 (assets.xml:3356261) |
| `ConditionDiplomaticState`: Desired relationship state between participants | [Condition](#property-condition), [ConditionDiplomaticState](#property-conditiondiplomaticstate), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 151441 (assets.xml:882161); GUID 152462 (assets.xml:925286) |
| `ConditionDiplomaticStateChanged`: Diplomatic-state change / alliance count | [Condition](#property-condition), [ConditionDiplomaticStateChanged](#property-conditiondiplomaticstatechanged) | GUID 400101 (assets.xml:2346008) |
| `ConditionEvaluateTextSource`: Textsource evaluation (numeric runtime discrepancy) | [Condition](#property-condition), [ConditionEvaluateTextSource](#property-conditionevaluatetextsource), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 103532 (assets.xml:4476686) |
| `ConditionEvent`: SimpleEventType listener with event-specific context | [Condition](#property-condition), [ConditionEvent](#property-conditionevent), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 150810 (assets.xml:750145); GUID 8452 (assets.xml:750718) |
| `ConditionExpeditionFinished`: Finished expedition / morale comparison | [Condition](#property-condition), [ConditionExpeditionFinished](#property-conditionexpeditionfinished) | GUID 400090 (assets.xml:2345744) |
| `ConditionExportGoodsLeveled`: Docklands export level/count | [Condition](#property-condition), [ConditionExportGoodsLeveled](#property-conditionexportgoodsleveled) | GUID 132391 (assets.xml:3954030); GUID 132392 (assets.xml:3954126) |
| `ConditionFactoryProductivity`: Productivity of filtered factories | [Condition](#property-condition), [ConditionFactoryProductivity](#property-conditionfactoryproductivity), [ObjectFilter](#property-objectfilter) | GUID 151274 (assets.xml:856139); GUID 151247 (assets.xml:859522) |
| `ConditionFestival`: Festival type and active/ended state | [Condition](#property-condition), [ConditionFestival](#property-conditionfestival) | GUID 134255 (assets.xml:4060482) |
| `ConditionFiniteResource`: Remaining finite-resource quantity/types | [Condition](#property-condition), [ConditionFiniteResource](#property-conditionfiniteresource) | GUID 139176 (assets.xml:4960994); GUID 139175 (assets.xml:4961750) |
| `ConditionFirstTimeEventHappened`: First-time event for an asset | [Condition](#property-condition), [ConditionFirstTimeEventHappened](#property-conditionfirsttimeeventhappened) | GUID 400077 (assets.xml:2344837) |
| `ConditionGUIEvent`: Local UI-state enter/leave listener | [Condition](#property-condition), [ConditionGUIEvent](#property-conditionguievent) | GUID 10000135 (assets.xml:2724436); GUID 10000136 (assets.xml:2724531) |
| `ConditionGameEnded`: Win/lose state | [Condition](#property-condition), [ConditionGameEnded](#property-conditiongameended) | GUID 400093 (assets.xml:2344772) |
| `ConditionGamePadAction`: Tracked gamepad action/count | [Condition](#property-condition), [ConditionGamePadAction](#property-conditiongamepadaction) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionHaciendaDecreesActive`: Selected active Hacienda decree flags | [Condition](#property-condition), [ConditionHaciendaDecreesActive](#property-conditionhaciendadecreesactive), [ObjectFilter](#property-objectfilter) | GUID 26028 (assets.xml:4339383) |
| `ConditionHaciendaModuleCount`: Hacienda module count | [Condition](#property-condition), [ConditionHaciendaModuleCount](#property-conditionhaciendamodulecount) | GUID 25851 (assets.xml:4339429) |
| `ConditionHappinessMood`: Population happiness mood for a participant | [Condition](#property-condition), [ConditionHappinessMood](#property-conditionhappinessmood) | GUID 151041 (assets.xml:1169026); GUID 151042 (assets.xml:1169446) |
| `ConditionInPalaceRange`: Any/all assets in palace range | [Condition](#property-condition), [ConditionInPalaceRange](#property-conditioninpalacerange) | GUID 269322 (assets.xml:3125768) |
| `ConditionInStorage`: Goods/items in filtered storage | [Condition](#property-condition), [ConditionInStorage](#property-conditioninstorage), [ObjectFilter](#property-objectfilter) | GUID 124997 (assets.xml:3854898); GUID 131058 (assets.xml:3855015) |
| `ConditionIrrigatedModules`: Irrigated/non-irrigated farm modules | [Condition](#property-condition), [ConditionIrrigatedModules](#property-conditionirrigatedmodules), [ObjectFilter](#property-objectfilter) | GUID 25486 (assets.xml:4289967); GUID 25595 (assets.xml:4290080) |
| `ConditionIrrigationCapacityExceeded`: Irrigation-capacity excess | [Condition](#property-condition), [ConditionIrrigationCapacityExceeded](#property-conditionirrigationcapacityexceeded) | GUID 127909 (assets.xml:3859729) |
| `ConditionIsBuffed`: Applied compatible buff count | [Condition](#property-condition), [ObjectFilter](#property-objectfilter), [ConditionIsBuffed](#property-conditionisbuffed), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 269953 (assets.xml:3145155); GUID 118946 (assets.xml:3145225) |
| `ConditionIsCampaign`: Campaign mode | [ConditionPropsNegatable](#property-conditionpropsnegatable), [ConditionIsCampaign](#property-conditioniscampaign), [Condition](#property-condition) | GUID 150559 (assets.xml:800519); GUID 151121 (assets.xml:801816) |
| `ConditionIsCraftingInProgress`: Crafting-in-progress state | [Condition](#property-condition), [ConditionIsCraftingInProgress](#property-conditioniscraftinginprogress) | GUID 127940 (assets.xml:3863653) |
| `ConditionIsCreativeMode`: Creative mode | [ConditionPropsNegatable](#property-conditionpropsnegatable), [Condition](#property-condition), [ConditionIsCreativeMode](#property-conditioniscreativemode) | GUID 140885 (assets.xml:705334); GUID 18585 (assets.xml:3849805) |
| `ConditionIsDLCActive`: Activation of listed DLC assets | [Condition](#property-condition), [ConditionIsDLCActive](#property-conditionisdlcactive), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 130258 (assets.xml:669943); GUID 130259 (assets.xml:670082) |
| `ConditionIsDiscovered`: Participant discovery through ParticipantRelation | [Condition](#property-condition), [ParticipantRelation](#property-participantrelation), [ConditionIsDiscovered](#property-conditionisdiscovered), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 153231 (assets.xml:798628); GUID 151276 (assets.xml:835214) |
| `ConditionIsDocklandsExportPyramidFull`: Docklands pyramid completion | [Condition](#property-condition), [ConditionIsDocklandsExportPyramidFull](#property-conditionisdocklandsexportpyramidfull) | GUID 132122 (assets.xml:3960007); GUID 132196 (assets.xml:3962392)) |
| `ConditionIsGamepadMode`: Gamepad input mode | [Condition](#property-condition), [ConditionIsGamepadMode](#property-conditionisgamepadmode), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 150810 (assets.xml:750145); GUID 8452 (assets.xml:750718) |
| `ConditionIsIndustrialized`: Industrialization amount/type or filtered objects | [Condition](#property-condition), [ConditionIsIndustrialized](#property-conditionisindustrialized), [ObjectFilter](#property-objectfilter) | GUID 7738 (assets.xml:4886529) |
| `ConditionIsMultiplayer`: Multiplayer game mode, distinct from slot count | [Condition](#property-condition), [ConditionIsMultiplayer](#property-conditionismultiplayer), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 10000108 (assets.xml:2724296); GUID 10000135 (assets.xml:2724436) |
| `ConditionIsParticipantInGame`: Participant selected in setup; not reliable live defeat detection | [Condition](#property-condition), [ConditionIsParticipantInGame](#property-conditionisparticipantingame), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 151153 (assets.xml:1146747); GUID 137827 (assets.xml:1168785) Cancel if no MoRE Anne is present) |
| `ConditionIsPaused`: Paused state of filtered buildings | [Condition](#property-condition), [ConditionIsPaused](#property-conditionispaused), [ObjectFilter](#property-objectfilter) | GUID 105920 (assets.xml:4171230); GUID 136918 (assets.xml:4172087) |
| `ConditionIsTutorial`: Tutorial mode | [Condition](#property-condition), [ConditionIsTutorial](#property-conditionistutorial), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 153287 (assets.xml:850439); GUID 153288 (assets.xml:850943) |
| `ConditionIslandsDiscovered`: Discovered-island count and scope | [Condition](#property-condition), [ConditionIslandsDiscovered](#property-conditionislandsdiscovered) | GUID 10000050 (assets.xml:2722682) |
| `ConditionIslandsWithFertility`: Owned-island count with a fertility / scope | [Condition](#property-condition), [ConditionIslandsWithFertility](#property-conditionislandswithfertility) | GUID 133189 (assets.xml:880851); GUID 153303 (assets.xml:881313) |
| `ConditionMetagameLoaded`: Loaded metagame / human count | [Condition](#property-condition), [ConditionMetagameLoaded](#property-conditionmetagameloaded) | GUID 400096 (assets.xml:2344730) |
| `ConditionModuleCount`: Absolute/percentage building-module amount | [Condition](#property-condition), [ObjectFilter](#property-objectfilter), [ConditionModuleCount](#property-conditionmodulecount) | GUID 151176 (assets.xml:818517); GUID 151243 (assets.xml:818914) |
| `ConditionMonoCulture`: Monoculture delta comparison | [Condition](#property-condition), [ConditionMonoCulture](#property-conditionmonoculture) | GUID 139555 (assets.xml:4961597); GUID 139174 (assets.xml:4961673) |
| `ConditionMonumentEventActive`: Listed monument events active (property name is plural) | [Condition](#property-condition), [ConditionMonumentEventsActive](#property-conditionmonumenteventsactive) | GUID 400089 (assets.xml:2345600); GUID 400103 (assets.xml:2345652) |
| `ConditionMonumentProgress`: Filtered monument progress | [Condition](#property-condition), [ConditionMonumentProgress](#property-conditionmonumentprogress), [ObjectFilter](#property-objectfilter) | GUID 136660 (assets.xml:4163830); GUID 136747 (assets.xml:4166694) |
| `ConditionMoveVehicle`: Vehicle movement/distance, optional label | [Condition](#property-condition), [ConditionMoveVehicle](#property-conditionmovevehicle), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionMutualAreaInSubconditions`: Common area of specialized child conditions | [Condition](#property-condition), [ConditionMutualAreaInSubconditions](#property-conditionmutualareainsubconditions) | GUID 152558 (assets.xml:1072784); GUID 151041 (assets.xml:1169026) |
| `ConditionNewspaperPossible`: Newspaper-possible state | [Condition](#property-condition), [ConditionNewspaperPossible](#property-conditionnewspaperpossible) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionNewspaperPublished`: Published newspaper / replaced-page amount | [Condition](#property-condition), [ConditionNewspaperPublished](#property-conditionnewspaperpublished) | GUID 400091 (assets.xml:2344672); GUID 111797 (assets.xml:2778856) |
| `ConditionObjHPCheck`: Target GUID/owner HP percentage | [Condition](#property-condition), [ConditionObjHPCheck](#property-conditionobjhpcheck) | GUID 150936 (assets.xml:774269); GUID 150938 (assets.xml:774349) |
| `ConditionObjectPosition`: Filtered objects near filtered targets | [Condition](#property-condition), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings), [ConditionObjectPosition](#property-conditionobjectposition), [ObjectFilter](#property-objectfilter), [ObjectTargetFilter](#property-objecttargetfilter), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 124965 (assets.xml:3366506); GUID 124963 (assets.xml:3366690) |
| `ConditionObjectSelected`: Filtered-object selection / incident/ruin state | [Condition](#property-condition), [ConditionObjectSelected](#property-conditionobjectselected), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings), [ObjectFilter](#property-objectfilter), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 152289 (assets.xml:826985); GUID 151357 (assets.xml:844386) |
| `ConditionOverlapsAABB`: Overlap of two asset bounds | [Condition](#property-condition), [ConditionOverlapsAABB](#property-conditionoverlapsaabb), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 270144 (assets.xml:3147993) |
| `ConditionPalaceItemEquipBonusActive`: Palace item/effect building and equipment counts | [Condition](#property-condition), [ConditionPalaceItemEquipBonusActive](#property-conditionpalaceitemequipbonusactive) | GUID 269323 (assets.xml:3125843) |
| `ConditionPalaceUnlocks`: Ministry/decree unlock flags | [Condition](#property-condition), [ConditionPalaceUnlocks](#property-conditionpalaceunlocks) | GUID 269534 (assets.xml:3110714); GUID 269321 (assets.xml:3125726) |
| `ConditionPhotographyObject`: Photography framing/object settings (property PhotographObject) | [Condition](#property-condition), [ConditionPhotographObject](#property-conditionphotographobject) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionPlayerCounter`: Typed participant counter with context and scope | [Condition](#property-condition), [ConditionPlayerCounter](#property-conditionplayercounter) | GUID 130249 (assets.xml:669195); GUID 130250 (assets.xml:669256) |
| `ConditionProductCapacityReached`: Product storage capacity reached | [Condition](#property-condition), [ConditionProductCapacityReached](#property-conditionproductcapacityreached) | GUID 139195 (assets.xml:4960112) |
| `ConditionProductivity`: Good production rate/productivity comparison | [Condition](#property-condition), [ConditionProductivity](#property-conditionproductivity) | GUID 270147 (assets.xml:3148539); GUID 129692 (assets.xml:3926465)) |
| `ConditionQuestPoolQuestRunning`: Any/all listed quest pools running a quest | [Condition](#property-condition), [ConditionQuestPoolQuestRunning](#property-conditionquestpoolquestrunning), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 131177 (assets.xml:3474802); GUID 132628 (assets.xml:3872019) |
| `ConditionQuestResolveConfirmation`: Quest confirmation objective context | [ConditionQuestResolveConfirmation](#property-conditionquestresolveconfirmation), [Condition](#property-condition), [ConditionQuestObjective](#property-conditionquestobjective) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionQuestState`: Quest/quest-line state flags | [Condition](#property-condition), [ConditionQuestState](#property-conditionqueststate) | GUID 269946 (assets.xml:704306); GUID 152031 (assets.xml:751336) |
| `ConditionRecipeResearchCompleted`: Completed research recipes by research field | [Condition](#property-condition), [ConditionRecipeResearchCompleted](#property-conditionreciperesearchcompleted) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionReputation`: Directional participant reputation comparison | [Condition](#property-condition), [ConditionReputation](#property-conditionreputation), [ParticipantRelation](#property-participantrelation) | GUID 152489 (assets.xml:895598); GUID 152490 (assets.xml:896049) |
| `ConditionResearchPointLimitReached`: Research-point limit state | [Condition](#property-condition), [ConditionResearchPointLimitReached](#property-conditionresearchpointlimitreached) | GUID 127937 (assets.xml:3863236) |
| `ConditionResidentsInBuilding`: Resident count in filtered buildings | [Condition](#property-condition), [ObjectFilter](#property-objectfilter), [ConditionResidentsInBuilding](#property-conditionresidentsinbuilding) | GUID 136213 (assets.xml:4243604)) |
| `ConditionSeason`: Season in specified/all sessions | [Condition](#property-condition), [ConditionSeason](#property-conditionseason) | GUID 25207 (assets.xml:4287518); GUID 25212 (assets.xml:4287596) |
| `ConditionSelectionHappinessDebuffActive`: Selection happiness-category debuff flags | [Condition](#property-condition), [ConditionSelectionHappinessDebuffActive](#property-conditionselectionhappinessdebuffactive) | GUID 134424 (assets.xml:4089473); GUID 134425 (assets.xml:4089877) |
| `ConditionSessionLoading`: Session-loading context | [Condition](#property-condition), [ConditionSessionLoading](#property-conditionsessionloading), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionShipsInRange`: Ship/target range check with ownership and session settings | [Condition](#property-condition), [ConditionShipsInRange](#property-conditionshipsinrange), [SessionFilter](#property-sessionfilter) | GUID 151434 (assets.xml:781859); GUID 153171 (assets.xml:1079319) |
| `ConditionShipsOwnedInSession`: Ship/pool amount in a session | [Condition](#property-condition), [ConditionShipsOwnedInSession](#property-conditionshipsownedinsession) | GUID 151073 (assets.xml:783430); GUID 151498 (assets.xml:1208763) |
| `ConditionShipyardState`: Shipyard queue state and owner | [Condition](#property-condition), [ConditionShipyardState](#property-conditionshipyardstate) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionStarterObject`: Quest starter selection/movement/area setup | [Condition](#property-condition), [ConditionStarterObject](#property-conditionstarterobject), [ConditionQuestObjective](#property-conditionquestobjective), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionStaticResult`: Fixed ConditionResult token | [Condition](#property-condition), [ConditionStaticResult](#property-conditionstaticresult) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionTextPopupClosed`: Closed text-popup layout flags (not text GUID) | [Condition](#property-condition), [ConditionTextPopupClosed](#property-conditiontextpopupclosed) | GUID 120247 (assets.xml:3370710); GUID 120308 (assets.xml:3371625) |
| `ConditionTextPopupPagesViewed`: Viewed pages by popup layout | [Condition](#property-condition), [ConditionTextPopupPagesViewed](#property-conditiontextpopuppagesviewed) | GUID 400060 (assets.xml:2343888); GUID 400086 (assets.xml:2344056) |
| `ConditionThreshold`: Textsource threshold/duration (serious recorded limitations) | [Condition](#property-condition), [ConditionThreshold](#property-conditionthreshold) | No explicit-Template sample captured; also search Values/property and inherited definitions. |
| `ConditionTimePassed`: Time-passed comparison | [Condition](#property-condition), [ConditionTimePassed](#property-conditiontimepassed) | GUID 2287 (assets.xml:4503758) |
| `ConditionTimer`: Eligible-condition timer with ID/pause/unregister behavior | [Condition](#property-condition), [ConditionTimer](#property-conditiontimer) | GUID 151119 (assets.xml:868153); GUID 151344 (assets.xml:868716) |
| `ConditionTradeRouteCount`: Filtered trade-route amount | [Condition](#property-condition), [ConditionTradeRouteCount](#property-conditiontraderoutecount) | GUID 400073 (assets.xml:2345129); GUID 2657 (assets.xml:4500339) |
| `ConditionTutorialInteraction`: Tutorial/UI interaction and hint context | [Condition](#property-condition), [ConditionTutorialInteraction](#property-conditiontutorialinteraction) | GUID 151121 (assets.xml:801816); GUID 151271 (assets.xml:802215) |
| `ConditionUnlocked`: Current unlock state of an asset | [Condition](#property-condition), [ConditionUnlocked](#property-conditionunlocked), [ConditionPropsNegatable](#property-conditionpropsnegatable) | GUID 141003 (assets.xml:703981); GUID 141007 (assets.xml:704167) |
| `ConditionUnlockedList`: Unlock list with range operator (property ConditionUnlockList) | [Condition](#property-condition), [ConditionUnlockList](#property-conditionunlocklist) | GUID 152564 (assets.xml:908539); GUID 152546 (assets.xml:1070819) |

### Common property layouts and serialized defaults

All property links above now lead to this file. Frequently used blocks appear first; the remaining catalogue properties follow alphabetically. Each shared property is listed once. Descriptions and defaults below are vanilla data, not proof of undocumented runtime behavior. The parent-gating clarification and other runtime qualifications in the learning chapters remain authoritative for the reviewed designs.

**Read defaults in this order:** concrete asset overrides, BaseAssetGUID inheritance where applicable, concrete template property overrides, then generic property/container defaults. An absent serialized default is not an invented zero. Consult the template section as well as the property table.

[Template overrides](#native-template-overrides) · [Property index](#native-property-index) · [Dataset index](#native-dataset-index)

<a id="native-property-index"></a>
### Property index

[Condition](#property-condition), [Trigger](#property-trigger), [TriggerSetup](#property-triggersetup), [ConditionPlayerCounter](#property-conditionplayercounter), [ConditionTimer](#property-conditiontimer), [ConditionUnlocked](#property-conditionunlocked), [ConditionUnlockList](#property-conditionunlocklist), [ConditionEvent](#property-conditionevent), [ConditionPropsNegatable](#property-conditionpropsnegatable), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings), [ConditionActiveSession](#property-conditionactivesession), [ConditionIsDiscovered](#property-conditionisdiscovered), [ParticipantRelation](#property-participantrelation), [ConditionObjectPosition](#property-conditionobjectposition), [ObjectFilter](#property-objectfilter), [ObjectTargetFilter](#property-objecttargetfilter), [ConditionInStorage](#property-conditioninstorage), [ConditionIsBuffed](#property-conditionisbuffed), [ConditionQuestState](#property-conditionqueststate), [ConditionMutualAreaInSubconditions](#property-conditionmutualareainsubconditions), [ConditionEvaluateTextSource](#property-conditionevaluatetextsource), [ConditionThreshold](#property-conditionthreshold), [ActionRegisterTrigger](#property-actionregistertrigger), [ActionResetTrigger](#property-actionresettrigger), [ActionExecuteScript](#property-actionexecutescript), [Action](#property-action), [ActionDelayedActions](#property-actiondelayedactions), [ActionDeleteObjects](#property-actiondeleteobjects), [ActionLockAsset](#property-actionlockasset), [ActionPlayMovie](#property-actionplaymovie), [ActionSetObjectGUID](#property-actionsetobjectguid), [ActionUnlockAsset](#property-actionunlockasset), [ConditionActiveRegion](#property-conditionactiveregion), [ConditionAlwaysFalse](#property-conditionalwaysfalse), [ConditionAlwaysTrue](#property-conditionalwaystrue), [ConditionAreaClaimed](#property-conditionareaclaimed), [ConditionAttractiveness](#property-conditionattractiveness), [ConditionBuildingsInBlueprintmode](#property-conditionbuildingsinblueprintmode), [ConditionBurningObject](#property-conditionburningobject), [ConditionBusActivationNeedSaturation](#property-conditionbusactivationneedsaturation), [ConditionCameraMovement](#property-conditioncameramovement), [ConditionCorporationDifficulty](#property-conditioncorporationdifficulty), [ConditionDecision](#property-conditiondecision), [ConditionDecisionOption](#property-conditiondecisionoption), [ConditionDiplomaticState](#property-conditiondiplomaticstate), [ConditionDiplomaticStateChanged](#property-conditiondiplomaticstatechanged), [ConditionExpeditionFinished](#property-conditionexpeditionfinished), [ConditionExportGoodsLeveled](#property-conditionexportgoodsleveled), [ConditionFactoryProductivity](#property-conditionfactoryproductivity), [ConditionFestival](#property-conditionfestival), [ConditionFiniteResource](#property-conditionfiniteresource), [ConditionFirstTimeEventHappened](#property-conditionfirsttimeeventhappened), [ConditionGUIEvent](#property-conditionguievent), [ConditionGameEnded](#property-conditiongameended), [ConditionGamePadAction](#property-conditiongamepadaction), [ConditionHaciendaDecreesActive](#property-conditionhaciendadecreesactive), [ConditionHaciendaModuleCount](#property-conditionhaciendamodulecount), [ConditionHappinessMood](#property-conditionhappinessmood), [ConditionInPalaceRange](#property-conditioninpalacerange), [ConditionIrrigatedModules](#property-conditionirrigatedmodules), [ConditionIrrigationCapacityExceeded](#property-conditionirrigationcapacityexceeded), [ConditionIsCampaign](#property-conditioniscampaign), [ConditionIsCraftingInProgress](#property-conditioniscraftinginprogress), [ConditionIsCreativeMode](#property-conditioniscreativemode), [ConditionIsDLCActive](#property-conditionisdlcactive), [ConditionIsDocklandsExportPyramidFull](#property-conditionisdocklandsexportpyramidfull), [ConditionIsGamepadMode](#property-conditionisgamepadmode), [ConditionIsIndustrialized](#property-conditionisindustrialized), [ConditionIsMultiplayer](#property-conditionismultiplayer), [ConditionIsParticipantInGame](#property-conditionisparticipantingame), [ConditionIsPaused](#property-conditionispaused), [ConditionIsTutorial](#property-conditionistutorial), [ConditionIslandsDiscovered](#property-conditionislandsdiscovered), [ConditionIslandsWithFertility](#property-conditionislandswithfertility), [ConditionItemUsed](#property-conditionitemused), [ConditionMetagameLoaded](#property-conditionmetagameloaded), [ConditionModuleCount](#property-conditionmodulecount), [ConditionMonoCulture](#property-conditionmonoculture), [ConditionMonumentEventsActive](#property-conditionmonumenteventsactive), [ConditionMonumentProgress](#property-conditionmonumentprogress), [ConditionMoveVehicle](#property-conditionmovevehicle), [ConditionNewspaperPossible](#property-conditionnewspaperpossible), [ConditionNewspaperPublished](#property-conditionnewspaperpublished), [ConditionObjHPCheck](#property-conditionobjhpcheck), [ConditionObjectSelected](#property-conditionobjectselected), [ConditionOverlapsAABB](#property-conditionoverlapsaabb), [ConditionPalaceItemEquipBonusActive](#property-conditionpalaceitemequipbonusactive), [ConditionPalaceUnlocks](#property-conditionpalaceunlocks), [ConditionPhotographObject](#property-conditionphotographobject), [ConditionProductCapacityReached](#property-conditionproductcapacityreached), [ConditionProductivity](#property-conditionproductivity), [ConditionQuestObjective](#property-conditionquestobjective), [ConditionQuestPoolQuestRunning](#property-conditionquestpoolquestrunning), [ConditionQuestResolveConfirmation](#property-conditionquestresolveconfirmation), [ConditionRecipeResearchCompleted](#property-conditionreciperesearchcompleted), [ConditionReputation](#property-conditionreputation), [ConditionResearchPointLimitReached](#property-conditionresearchpointlimitreached), [ConditionResidentsInBuilding](#property-conditionresidentsinbuilding), [ConditionSeason](#property-conditionseason), [ConditionSelectionHappinessDebuffActive](#property-conditionselectionhappinessdebuffactive), [ConditionSessionLoading](#property-conditionsessionloading), [ConditionShipsInRange](#property-conditionshipsinrange), [ConditionShipsOwnedInSession](#property-conditionshipsownedinsession), [ConditionShipyardState](#property-conditionshipyardstate), [ConditionStarterObject](#property-conditionstarterobject), [ConditionStaticResult](#property-conditionstaticresult), [ConditionTextPopupClosed](#property-conditiontextpopupclosed), [ConditionTextPopupPagesViewed](#property-conditiontextpopuppagesviewed), [ConditionTimePassed](#property-conditiontimepassed), [ConditionTradeRouteCount](#property-conditiontraderoutecount), [ConditionTutorialInteraction](#property-conditiontutorialinteraction), [EmptyAutoCreateValue](#property-emptyautocreatevalue), [Locked](#property-locked), [SessionFilter](#property-sessionfilter), [Standard](#property-standard)

<a id="property-condition"></a>
<details>
<summary>Condition — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3682.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `SubConditionCompletionOrder` | Choice | [SubConditionCompletionOrder](#dataset-subconditioncompletionorder) | IsProValue=1 | Parallel: All sub conditions can be solved at any time. Linear: The sub conditions have to be completed in order. Mutually Exclusive: Only one sub condition has to be completed and the sub conditions are solvable before the main condition. |
| `IsOptional` | Boolean |  |  | Set to true, if it is not needed to satisfy this condition to satisfy the parent condition |
| `LinkAllActionsToQuest` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>Condition</Name>
  <HasImplementation>1</HasImplementation>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>SubConditionCompletionOrder</Name>
    <Description>Parallel: All sub conditions can be solved at any time. Linear: The sub conditions have to be completed in order. Mutually Exclusive: Only one sub condition has to be completed and the sub conditions are solvable before the main condition.</Description>
    <IsProValue>1</IsProValue>
    <DataSet>SubConditionCompletionOrder</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IsOptional</Name>
    <Description>Set to true, if it is not needed to satisfy this condition to satisfy the parent condition</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>LinkAllActionsToQuest</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<Condition>
  <SubConditionCompletionOrder>Parallel</SubConditionCompletionOrder>
</Condition>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-trigger"></a>
<details>
<summary>Trigger — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3765.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `TriggerCondition` | AutoCreateAsset |  | ForceSerialize=1; ReadOnlyDependingOnExportVersions=1; IsImportantValue=1; AllowedTemplates=; AllowedProperties=Condition |  |
| `TriggerActions` | Vector |  | ReadOnlyDependingOnExportVersions=1; IsImportantValue=1 |  |
| `TriggerActions/Item/TriggerAction` | AutoCreateAsset |  | ReadOnlyDependingOnExportVersions=1; AllowedTemplates=ActionLink; AllowedProperties=Action |  |
| `SubTriggers` | Vector |  | ReadOnlyDependingOnExportVersions=1 |  |
| `SubTriggers/Item/SubTrigger` | AutoCreateAsset |  | ReadOnlyDependingOnExportVersions=1; AllowedTemplates=AutoCreateTrigger; AllowedProperties= |  |
| `ResetTrigger` | AutoCreateAsset |  | ReadOnlyDependingOnExportVersions=1; AllowedTemplates=EmptyAutoCreateValue;AutoCreateTrigger; AllowedProperties= |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>Trigger</Name>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>TriggerCondition</Name>
    <ForceSerialize>1</ForceSerialize>
    <ReadOnlyDependingOnExportVersions>1</ReadOnlyDependingOnExportVersions>
    <IsImportantValue>1</IsImportantValue>
    <AllowedTemplates/>
    <AllowedProperties>Condition</AllowedProperties>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>TriggerActions</Name>
    <ReadOnlyDependingOnExportVersions>1</ReadOnlyDependingOnExportVersions>
    <IsImportantValue>1</IsImportantValue>
    <Items>
      <ValueDefinition>
        <DataType>AutoCreateAsset</DataType>
        <Name>TriggerAction</Name>
        <ReadOnlyDependingOnExportVersions>1</ReadOnlyDependingOnExportVersions>
        <AllowedTemplates>ActionLink</AllowedTemplates>
        <AllowedProperties>Action</AllowedProperties>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>SubTriggers</Name>
    <ReadOnlyDependingOnExportVersions>1</ReadOnlyDependingOnExportVersions>
    <Items>
      <ValueDefinition>
        <DataType>AutoCreateAsset</DataType>
        <Name>SubTrigger</Name>
        <ReadOnlyDependingOnExportVersions>1</ReadOnlyDependingOnExportVersions>
        <AllowedTemplates>AutoCreateTrigger</AllowedTemplates>
        <AllowedProperties/>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>ResetTrigger</Name>
    <ReadOnlyDependingOnExportVersions>1</ReadOnlyDependingOnExportVersions>
    <AllowedTemplates>EmptyAutoCreateValue;AutoCreateTrigger</AllowedTemplates>
    <AllowedProperties/>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<Trigger>
  <TriggerCondition>
    <Template>ConditionActiveRegion</Template>
    <Values>
      <Condition/>
      <ConditionActiveRegion/>
    </Values>
  </TriggerCondition>
  <TriggerActions/>
  <SubTriggers/>
  <ResetTrigger>
    <Template>EmptyAutoCreateValue</Template>
    <Values>
      <EmptyAutoCreateValue/>
    </Values>
  </ResetTrigger>
</Trigger>
```

Container-entry defaults:

```xml
<Trigger>
  <TriggerActions>
    <TriggerAction>
      <Template>ActionLink</Template>
      <Values>
        <ActionLink/>
      </Values>
    </TriggerAction>
  </TriggerActions>
  <SubTriggers>
    <SubTrigger>
      <Template>AutoCreateTrigger</Template>
      <Values>
        <Trigger>
          <TriggerCondition>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Template>ConditionAlwaysTrue</Template>
            <Values>
              <Condition/>
              <ConditionAlwaysTrue/>
            </Values>
          </TriggerCondition>
          <ResetTrigger>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Template>EmptyAutoCreateValue</Template>
            <Values>
              <EmptyAutoCreateValue/>
            </Values>
          </ResetTrigger>
        </Trigger>
      </Values>
    </SubTrigger>
  </SubTriggers>
</Trigger>
```

</details>

<a id="property-triggersetup"></a>
<details>
<summary>TriggerSetup — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3828.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `AutoRegisterTrigger` | Boolean |  | IsProValue=1 |  |
| `AutoSelfUnlock` | Boolean |  |  |  |
| `UsedBySecondParties` | Boolean |  |  | If true, this trigger will also be created for all second party players |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>TriggerSetup</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AutoRegisterTrigger</Name>
    <IsProValue>1</IsProValue>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AutoSelfUnlock</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UsedBySecondParties</Name>
    <Description>If true, this trigger will also be created for all second party players</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<TriggerSetup/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionplayercounter"></a>
<details>
<summary>ConditionPlayerCounter — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2561.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `PlayerCounter` | Choice | [PlayerCounter](#dataset-playercounter) |  | The type of this player counter |
| `Context` | Asset |  |  | The context info for the player counter |
| `ContextAllowAny` | Boolean |  |  | If true, all counters will be summed up, ignoring the context |
| `ComparisonOp` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  | The comparison operator for counter value and desired value |
| `CounterAmount` | Int64 |  |  | The desired value the counter should match |
| `CounterScope` | Choice | [CounterScope](#dataset-counterscope) |  | The scope of the counter |
| `CounterScopeUseCurrentContext` | Boolean |  |  | Use the processing scope for this counter |
| `CounterScopeUseActiveSession` | Boolean |  |  | Indicates whether the session that is taken as context is the active session of the player |
| `CounterScopeContext` | Asset |  |  | Context information for the counter scope, i.e. GUID of a region or session |
| `CounterScopeKeepFirstFound` | Boolean |  |  | If true, the first time this condition gets evaluated and a scope context was found it will be kept forever (e.g. You don't know in which session this coindition will be started, but once it was started it should keep looking in that session). Otherwise the scope context will be checked continuously (e.g. You want to keep checking in the given session, used for quest preconditions for example) |
| `RelativeToQuestStart` | Boolean |  |  | True: Counting from current condition start - False: Counting from 0. |
| `ShowAbsoluteValues` | Boolean |  |  | If RelativeToQuestStart is set, this value defines if absolute or relative values should be shown |
| `ShowInvertedValues` | Boolean |  |  | Indicates whether the player counter values shown in the questtracker should be inverted |
| `CounterValueType` | Choice | [CounterValueType](#dataset-countervaluetype) |  | Defines if the MIN the MAX or the CURRENT value should be returned. |
| `CheckSpecificParticipant` | Boolean |  |  | If true, not the condition owner will be checked but the participant that is specified under &lt;CheckedParticipant&gt; |
| `CheckedParticipant` | Choice | [ParticipantID](#dataset-participantid) |  | if &lt;CheckSpecificParticipant&gt; is true, then this defines the participant to check |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionPlayerCounter</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>PlayerCounter</Name>
    <Description>The type of this player counter</Description>
    <DataSet>PlayerCounter</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>Context</Name>
    <Description>The context info for the player counter</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ContextAllowAny</Name>
    <Description>If true, all counters will be summed up, ignoring the context</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ComparisonOp</Name>
    <Description>The comparison operator for counter value and desired value</Description>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Int64</DataType>
    <Name>CounterAmount</Name>
    <Description>The desired value the counter should match</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>CounterScope</Name>
    <Description>The scope of the counter</Description>
    <DataSet>CounterScope</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CounterScopeUseCurrentContext</Name>
    <Description>Use the processing scope for this counter</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CounterScopeUseActiveSession</Name>
    <Description>Indicates whether the session that is taken as context is the active session of the player</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>CounterScopeContext</Name>
    <Description>Context information for the counter scope, i.e. GUID of a region or session</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CounterScopeKeepFirstFound</Name>
    <Description>If true, the first time this condition gets evaluated and a scope context was found it will be kept forever (e.g. You don't know in which session this coindition will be started, but once it was started it should keep looking in that session). Otherwise the scope context will be checked continuously (e.g. You want to keep checking in the given session, used for quest preconditions for example)</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>RelativeToQuestStart</Name>
    <Description>True: Counting from current condition start - False: Counting from 0.</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ShowAbsoluteValues</Name>
    <Description>If RelativeToQuestStart is set, this value defines if absolute or relative values should be shown</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ShowInvertedValues</Name>
    <Description>Indicates whether the player counter values shown in the questtracker should be inverted</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>CounterValueType</Name>
    <Description>Defines if the MIN the MAX or the CURRENT value should be returned.</Description>
    <DataSet>CounterValueType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckSpecificParticipant</Name>
    <Description>If true, not the condition owner will be checked but the participant that is specified under &lt;CheckedParticipant&gt;</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>CheckedParticipant</Name>
    <Description>if &lt;CheckSpecificParticipant&gt; is true, then this defines the participant to check</Description>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionPlayerCounter>
  <PlayerCounter>ObjectBuilt</PlayerCounter>
  <Context>0</Context>
  <ComparisonOp>AtLeast</ComparisonOp>
  <CounterScope>Global</CounterScope>
  <CounterScopeUseCurrentContext>1</CounterScopeUseCurrentContext>
  <CounterScopeContext>0</CounterScopeContext>
  <CounterScopeKeepFirstFound>1</CounterScopeKeepFirstFound>
  <CounterValueType>Current</CounterValueType>
  <CheckedParticipant>Human0</CheckedParticipant>
</ConditionPlayerCounter>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditiontimer"></a>
<details>
<summary>ConditionTimer — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3011.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `TimeLimit` | Time |  |  | A time limit for the timer. |
| `IsPaused` | Boolean |  |  | True, when the timer is currently not ticking |
| `TimerID` | String |  |  | An ID by which the timer can be referenced from other conditions or actions. |
| `KeepTimerOnUnregister` | Boolean |  |  | timer value is not reset when condition is unregistered |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionTimer</Name>
  <ValueDefinition>
    <DataType>Time</DataType>
    <Name>TimeLimit</Name>
    <Description>A time limit for the timer.</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IsPaused</Name>
    <Description>True, when the timer is currently not ticking</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>TimerID</Name>
    <Description>An ID by which the timer can be referenced from other conditions or actions.</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>KeepTimerOnUnregister</Name>
    <Description>timer value is not reset when condition is unregistered</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionTimer/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionunlocked"></a>
<details>
<summary>ConditionUnlocked — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3202.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `UnlockNeeded` | Asset |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionUnlocked</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>UnlockNeeded</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionUnlocked>
  <UnlockNeeded>0</UnlockNeeded>
</ConditionUnlocked>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionunlocklist"></a>
<details>
<summary>ConditionUnlockList — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3209.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `UnlockNeededList` | Vector |  |  |  |
| `UnlockNeededList/Item/UnlockNeeded` | Asset |  |  |  |
| `UnlockRangeOP` | Choice | [RangeOperator](#dataset-rangeoperator) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionUnlockList</Name>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>UnlockNeededList</Name>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>UnlockNeeded</Name>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>UnlockRangeOP</Name>
    <DataSet>RangeOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionUnlockList>
  <UnlockNeededList/>
  <UnlockRangeOP>None</UnlockRangeOP>
</ConditionUnlockList>
```

Container-entry defaults:

```xml
<ConditionUnlockList>
  <UnlockNeededList>
    <UnlockNeeded>0</UnlockNeeded>
  </UnlockNeededList>
</ConditionUnlockList>
```

</details>

<a id="property-conditionevent"></a>
<details>
<summary>ConditionEvent — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1774.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ConditionEvent` | Choice | [SimpleEventType](#dataset-simpleeventtype) |  | The type of event that will be watched by this condition |
| `ContextData` | String |  | IsProValue=1 | A context string that defines additional information about the event (e.g. the GUID of an asset if the event type is Object_Destroyed) |
| `ContextAsset` | Asset |  |  | A context GUID that defines additional information about the event |
| `ContextAssetInfolayer` | Asset |  | IsProValue=1 |  |
| `EventCount` | Integer |  |  | The number of events of this type that should be called. Usually 1 |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionEvent</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ConditionEvent</Name>
    <Description>The type of event that will be watched by this condition</Description>
    <DataSet>SimpleEventType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>ContextData</Name>
    <Description>A context string that defines additional information about the event (e.g. the GUID of an asset if the event type is Object_Destroyed)</Description>
    <IsProValue>1</IsProValue>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ContextAsset</Name>
    <Description>A context GUID that defines additional information about the event</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ContextAssetInfolayer</Name>
    <IsProValue>1</IsProValue>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>EventCount</Name>
    <Description>The number of events of this type that should be called. Usually 1</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionEvent>
  <ConditionEvent>SessionLoad</ConditionEvent>
  <ContextAsset>0</ContextAsset>
  <ContextAssetInfolayer>0</ContextAssetInfolayer>
</ConditionEvent>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionpropsnegatable"></a>
<details>
<summary>ConditionPropsNegatable — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3726.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `NegateCondition` | Boolean |  |  | Negate the result (success/still checking) of this condition |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionPropsNegatable</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>NegateCondition</Name>
    <Description>Negate the result (success/still checking) of this condition</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionPropsNegatable/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionpropssessionsettings"></a>
<details>
<summary>ConditionPropsSessionSettings — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3734.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionPropsSessionSettings</Name>
  <Description>Base property for conditions with objects</Description>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionPropsSessionSettings/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionactivesession"></a>
<details>
<summary>ConditionActiveSession — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1391.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ActiveSession` | Asset |  | IsImportantValue=1; NeededProperty=Session;Sector | The session which has to be active. If no session is given then any session triggers this condition. |
| `ConditionActiveSessionUseActiveSession` | Boolean |  |  | Will override ActiveSession |
| `SessionBlacklist` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionActiveSession</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ActiveSession</Name>
    <Description>The session which has to be active. If no session is given then any session triggers this condition.</Description>
    <IsImportantValue>1</IsImportantValue>
    <NeededProperty>Session;Sector</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ConditionActiveSessionUseActiveSession</Name>
    <Description>Will override ActiveSession</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>SessionBlacklist</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionActiveSession>
  <ActiveSession>0</ActiveSession>
</ConditionActiveSession>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionisdiscovered"></a>
<details>
<summary>ConditionIsDiscovered — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2097.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsDiscovered</Name>
  <Description>Condition that checks whether a given participant has discovered another participant</Description>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsDiscovered/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-participantrelation"></a>
<details>
<summary>ParticipantRelation — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:795.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `SourceIsOwner` | Boolean |  |  | Indicates whether the source participant should be the owner of this condition (in quests this would be the quest receiver) |
| `SourceParticipant` | Choice | [ParticipantID](#dataset-participantid) |  | The participant that is the source of the relation (its state is checked against or of target) |
| `TargetIsOwner` | Boolean |  |  | Indicates whether the target participant should be the owner of this condition (in quests this would be the quest receiver) |
| `TargetParticipant` | Choice | [ParticipantID](#dataset-participantid) |  | The target participant of the relation |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ParticipantRelation</Name>
  <Description>Property that provides information on a source-target relation between two participants</Description>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>SourceIsOwner</Name>
    <Description>Indicates whether the source participant should be the owner of this condition (in quests this would be the quest receiver)</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>SourceParticipant</Name>
    <Description>The participant that is the source of the relation (its state is checked against or of target)</Description>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetIsOwner</Name>
    <Description>Indicates whether the target participant should be the owner of this condition (in quests this would be the quest receiver)</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>TargetParticipant</Name>
    <Description>The target participant of the relation</Description>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ParticipantRelation>
  <SourceParticipant>Human0</SourceParticipant>
  <TargetParticipant>Human0</TargetParticipant>
</ParticipantRelation>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionobjectposition"></a>
<details>
<summary>ConditionObjectPosition — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2404.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `Radius` | Float |  |  | an object is considered as at a target if its distance is less than this radius |
| `AllObjects` | Boolean |  |  | is it sufficient to have one of the objects at one of the targets, or are all objects checked? |
| `OnlyOneTarget` | Boolean |  |  | when all objects are checked, do they need to be at the same target object? |
| `ExpectObjectExists` | Boolean |  |  | If existence is expected and the object does not exist, the quest will auto resolve. Otherwise it will wait until the object exists |
| `ExpectTargetExists` | Boolean |  |  | If existence is expected and the target does not exist, the quest will fail. Otherwise it will wait until the target exists |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionObjectPosition</Name>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>Radius</Name>
    <Description>an object is considered as at a target if its distance is less than this radius</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AllObjects</Name>
    <Description>is it sufficient to have one of the objects at one of the targets, or are all objects checked?</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>OnlyOneTarget</Name>
    <Description>when all objects are checked, do they need to be at the same target object?</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ExpectObjectExists</Name>
    <Description>If existence is expected and the object does not exist, the quest will auto resolve. Otherwise it will wait until the object exists</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ExpectTargetExists</Name>
    <Description>If existence is expected and the target does not exist, the quest will fail. Otherwise it will wait until the target exists</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionObjectPosition/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-objectfilter"></a>
<details>
<summary>ObjectFilter — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:518.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ObjectLabel` | String |  |  | object label of a single object or group label for a group of objects |
| `ObjectGUID` | Asset |  | NeededProperty=Mesh | finds all objects with this GUID (performance critical!) which belong to ObjectParticipant |
| `CheckParticipantID` | Boolean |  |  | If true, ObjectParticipantID will be used to additionally check the owner of the objects |
| `CheckProcessingParticipantID` | Boolean |  |  |  |
| `ObjectParticipantID` | Choice | [ParticipantID](#dataset-participantid) |  | use together with ObjectGUID |
| `ObjectUseParentConditionObjects` | Boolean |  |  | Only used in Actions! Uses the objects that the parent condition found during evaluation. This is not implemented for many conditions yet, please contact PRG before you use this value |
| `ObjectIslands` | Vector |  |  |  |
| `ObjectIslands/Item/Island` | Asset |  | NeededProperty=Island |  |
| `ObjectSession` | Asset |  | NeededProperty=Session | If provided, only objects from the given session are filtered |
| `CheckQuestStarterSession` | Boolean |  |  | If true and this action is fired from within a quest, the quest start session will be checked for objects |
| `CheckQuestArea` | Boolean |  |  | If true and this filter is used within a quest, then the current quest area (if any) will be used to filter objects |
| `ObjectivePrebuiltObjectUseVisibilityAutomatism` | Boolean |  |  | This flag is only used in quest objectives! If true the quest will remember the initial object visibility on quest start and set the object to visible. When the quest ends it will restore the initial visibility again. If false, the object visibility is not touched |
| `ObjectRestrictToQuestObjects` | Boolean |  |  | If true and this action is fired from within a quest, only objects that are used in the linked quest will be taken into account |
| `IncludePreviewObjects` | Boolean |  |  |  |
| `IncludeOnlyBlueprintObjects` | Boolean |  |  | If true, ONLY blueprint objects will be filtered for. All other include booleans will be ignored in this case. |
| `IncludeEditorObjects` | Boolean |  |  |  |
| `MaxObjectCount` | Integer |  | Min=0 | If &gt; 0 this will set an upper limit for the number of filtered objects. Objects will be chosen at random from the filtered object list |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ObjectFilter</Name>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>ObjectLabel</Name>
    <Description>object label of a single object or group label for a group of objects</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ObjectGUID</Name>
    <Description>finds all objects with this GUID (performance critical!) which belong to ObjectParticipant</Description>
    <NeededProperty>Mesh</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckParticipantID</Name>
    <Description>If true, ObjectParticipantID will be used to additionally check the owner of the objects</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckProcessingParticipantID</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ObjectParticipantID</Name>
    <Description>use together with ObjectGUID</Description>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ObjectUseParentConditionObjects</Name>
    <Description>Only used in Actions! Uses the objects that the parent condition found during evaluation. This is not implemented for many conditions yet, please contact PRG before you use this value</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>ObjectIslands</Name>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>Island</Name>
        <NeededProperty>Island</NeededProperty>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ObjectSession</Name>
    <Description>If provided, only objects from the given session are filtered</Description>
    <NeededProperty>Session</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckQuestStarterSession</Name>
    <Description>If true and this action is fired from within a quest, the quest start session will be checked for objects</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckQuestArea</Name>
    <Description>If true and this filter is used within a quest, then the current quest area (if any) will be used to filter objects</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ObjectivePrebuiltObjectUseVisibilityAutomatism</Name>
    <Description>This flag is only used in quest objectives! If true the quest will remember the initial object visibility on quest start and set the object to visible. When the quest ends it will restore the initial visibility again. If false, the object visibility is not touched</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ObjectRestrictToQuestObjects</Name>
    <Description>If true and this action is fired from within a quest, only objects that are used in the linked quest will be taken into account</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IncludePreviewObjects</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IncludeOnlyBlueprintObjects</Name>
    <Description>If true, ONLY blueprint objects will be filtered for. All other include booleans will be ignored in this case.</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IncludeEditorObjects</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>MaxObjectCount</Name>
    <Description>If &gt; 0 this will set an upper limit for the number of filtered objects. Objects will be chosen at random from the filtered object list</Description>
    <Min>0</Min>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ObjectFilter>
  <ObjectGUID>0</ObjectGUID>
  <ObjectParticipantID>Human0</ObjectParticipantID>
  <ObjectIslands/>
  <ObjectSession>0</ObjectSession>
</ObjectFilter>
```

Container-entry defaults:

```xml
<ObjectFilter>
  <ObjectIslands>
    <Island>0</Island>
  </ObjectIslands>
</ObjectFilter>
```

</details>

<a id="property-objecttargetfilter"></a>
<details>
<summary>ObjectTargetFilter — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:706.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `TargetLabel` | String |  |  | object label of a single object or group label for a group of objects |
| `TargetGUID` | Asset |  |  | finds all objects with this GUID (performance critical!) which belong to TargetParticipant |
| `TargetCheckParticipantID` | Boolean |  |  | If true, ObjectParticipantID will be used to additionally check the owner of the objects |
| `TargetCheckProcessingParticipantID` | Boolean |  |  |  |
| `TargetParticipantID` | Choice | [ParticipantID](#dataset-participantid) |  | use together with TargetGUID |
| `TargetUseParentConditionObjects` | Boolean |  |  | Only used in Actions! Uses the objects that the parent condition found during evaluation. This is not implemented for many conditions yet, please contact PRG before you use this value |
| `TargetObjectIslands` | Vector |  |  |  |
| `TargetObjectIslands/Item/Island` | Asset |  | NeededProperty=Island |  |
| `TargetObjectSession` | Asset |  | NeededProperty=Session | If provided, only objects from the given session are filtered |
| `TargetCheckQuestStarterSession` | Boolean |  |  | If true and this action is fired from within a quest, the quest start session will be checked for objects |
| `TargetCheckQuestArea` | Boolean |  |  | If true and this filter is used within a quest, then the current quest area (if any) will be used to filter objects |
| `TargetObjectivePrebuiltObjectUseVisibilityAutomatism` | Boolean |  |  | This flag is only used in quest objectives! If true the quest will remember the initial object visibility on quest start and set the object to visible. When the quest ends it will restore the initial visibility again. If false, the object visibility is not touched |
| `TargetObjectRestrictToQuestObjects` | Boolean |  |  | If true and this action is fired from within a quest, only objects that are used in the linked quest will be taken into account |
| `TargetIncludePreviewObjects` | Boolean |  |  |  |
| `TargetIncludeOnlyBlueprintObjects` | Boolean |  |  | If true, ONLY blueprint objects will be filtered for. All other include booleans will be ignored in this case. |
| `TargetIncludeEditorObjects` | Boolean |  |  |  |
| `TargetMaxObjectCount` | Integer |  | Min=0 | If &gt; 0 this will set an upper limit for the number of filtered objects. Objects will be chosen at random from the filtered object list |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ObjectTargetFilter</Name>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>TargetLabel</Name>
    <Description>object label of a single object or group label for a group of objects</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>TargetGUID</Name>
    <Description>finds all objects with this GUID (performance critical!) which belong to TargetParticipant</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetCheckParticipantID</Name>
    <Description>If true, ObjectParticipantID will be used to additionally check the owner of the objects</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetCheckProcessingParticipantID</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>TargetParticipantID</Name>
    <Description>use together with TargetGUID</Description>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetUseParentConditionObjects</Name>
    <Description>Only used in Actions! Uses the objects that the parent condition found during evaluation. This is not implemented for many conditions yet, please contact PRG before you use this value</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>TargetObjectIslands</Name>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>Island</Name>
        <NeededProperty>Island</NeededProperty>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>TargetObjectSession</Name>
    <Description>If provided, only objects from the given session are filtered</Description>
    <NeededProperty>Session</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetCheckQuestStarterSession</Name>
    <Description>If true and this action is fired from within a quest, the quest start session will be checked for objects</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetCheckQuestArea</Name>
    <Description>If true and this filter is used within a quest, then the current quest area (if any) will be used to filter objects</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetObjectivePrebuiltObjectUseVisibilityAutomatism</Name>
    <Description>This flag is only used in quest objectives! If true the quest will remember the initial object visibility on quest start and set the object to visible. When the quest ends it will restore the initial visibility again. If false, the object visibility is not touched</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetObjectRestrictToQuestObjects</Name>
    <Description>If true and this action is fired from within a quest, only objects that are used in the linked quest will be taken into account</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetIncludePreviewObjects</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetIncludeOnlyBlueprintObjects</Name>
    <Description>If true, ONLY blueprint objects will be filtered for. All other include booleans will be ignored in this case.</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetIncludeEditorObjects</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>TargetMaxObjectCount</Name>
    <Description>If &gt; 0 this will set an upper limit for the number of filtered objects. Objects will be chosen at random from the filtered object list</Description>
    <Min>0</Min>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ObjectTargetFilter>
  <TargetGUID>0</TargetGUID>
  <TargetCheckParticipantID>1</TargetCheckParticipantID>
  <TargetParticipantID>Human0</TargetParticipantID>
  <TargetObjectIslands/>
  <TargetObjectSession>0</TargetObjectSession>
</ObjectTargetFilter>
```

Container-entry defaults:

```xml
<ObjectTargetFilter>
  <TargetObjectIslands>
    <Island>0</Island>
  </TargetObjectIslands>
</ObjectTargetFilter>
```

</details>

<a id="property-conditioninstorage"></a>
<details>
<summary>ConditionInStorage — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2020.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `InStorageGoods` | Vector |  |  | List of goods that are checked by the condition |
| `InStorageGoods/Item/Product` | Asset |  | NeededProperty=Product;Item | The product that gets checked |
| `InStorageGoods/Item/Amount` | Integer |  | Min=0 | The amount of the product that needs to be reached |
| `InStorageCompareOp` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `CheckQuestAreaKontor` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionInStorage</Name>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>InStorageGoods</Name>
    <Description>List of goods that are checked by the condition</Description>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>Product</Name>
        <Description>The product that gets checked</Description>
        <NeededProperty>Product;Item</NeededProperty>
      </ValueDefinition>
      <ValueDefinition>
        <DataType>Integer</DataType>
        <Name>Amount</Name>
        <Description>The amount of the product that needs to be reached</Description>
        <Min>0</Min>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>InStorageCompareOp</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckQuestAreaKontor</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionInStorage>
  <InStorageGoods/>
  <InStorageCompareOp>AtLeast</InStorageCompareOp>
</ConditionInStorage>
```

Container-entry defaults:

```xml
<ConditionInStorage>
  <InStorageGoods>
    <Product>0</Product>
  </InStorageGoods>
</ConditionInStorage>
```

</details>

<a id="property-conditionisbuffed"></a>
<details>
<summary>ConditionIsBuffed — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2068.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `Buff` | Asset |  | NeededProperty=Buff |  |
| `RequiredAmount` | Integer |  | Min=1 | The amount of applied buffs required to fulfill this condition |
| `UseEffectHandler` | Boolean |  | IsProValue=1 | Instead of checking if Buildings have the specific buff we check the EffectHandler (only used by BuffFactories, ForwardBuffs and AreaBuffs) for a specific buff and count the affected Buildings. This could increase performance when having a lot of potential affected Buildings. |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsBuffed</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>Buff</Name>
    <NeededProperty>Buff</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>RequiredAmount</Name>
    <Description>The amount of applied buffs required to fulfill this condition</Description>
    <Min>1</Min>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UseEffectHandler</Name>
    <Description>Instead of checking if Buildings have the specific buff we check the EffectHandler (only used by BuffFactories, ForwardBuffs and AreaBuffs) for a specific buff and count the affected Buildings. This could increase performance when having a lot of potential affected Buildings.</Description>
    <IsProValue>1</IsProValue>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsBuffed>
  <Buff>0</Buff>
  <RequiredAmount>1</RequiredAmount>
</ConditionIsBuffed>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionqueststate"></a>
<details>
<summary>ConditionQuestState — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2711.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ConditionQuestStateStates` | Flags | [QuestState](#dataset-queststate) |  | All the states that satisfy this condition. |
| `ConditionQuestStateIsBlacklist` | Boolean |  |  | Indicates whether the given state flags should be treated as a blacklist instead of a whitelist |
| `ConditionQuestStateQuestGUID` | Asset |  | NeededProperty=Quest;QuestLine | A quest or a quest line that should be checked |
| `ConditionQuestStateRangeOp` | Choice | [RangeOperator](#dataset-rangeoperator) |  | If the ConditionQuestStateQuestGUID is a quest line, this operator checks for which quests the states need to match |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionQuestState</Name>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>ConditionQuestStateStates</Name>
    <Description>All the states that satisfy this condition.</Description>
    <DataSet>QuestState</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ConditionQuestStateIsBlacklist</Name>
    <Description>Indicates whether the given state flags should be treated as a blacklist instead of a whitelist</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ConditionQuestStateQuestGUID</Name>
    <Description>A quest or a quest line that should be checked</Description>
    <NeededProperty>Quest;QuestLine</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ConditionQuestStateRangeOp</Name>
    <Description>If the ConditionQuestStateQuestGUID is a quest line, this operator checks for which quests the states need to match</Description>
    <DataSet>RangeOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionQuestState>
  <ConditionQuestStateStates/>
  <ConditionQuestStateQuestGUID>0</ConditionQuestStateQuestGUID>
  <ConditionQuestStateRangeOp>None</ConditionQuestStateRangeOp>
</ConditionQuestState>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionmutualareainsubconditions"></a>
<details>
<summary>ConditionMutualAreaInSubconditions — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2364.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `UseParentValues` | Boolean |  |  |  |
| `AreaFlags` | Flags | [MutualAreaMask](#dataset-mutualareamask) |  | Flags to filter only for certain types of islands |
| `SpecifySession` | Boolean |  |  | True, if the SessionAsset should be evaluated |
| `UseProcessingSession` | Boolean |  |  | True, if only areas of the processing session should be used |
| `SessionAsset` | Asset |  | NeededProperty=Session | If given and SpecifySession is true then only areas of this session are accepted |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionMutualAreaInSubconditions</Name>
  <Description>Condition that ensures that all subconditions are fulfilled in a mutal/common/shared area</Description>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UseParentValues</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>AreaFlags</Name>
    <Description>Flags to filter only for certain types of islands</Description>
    <DataSet>MutualAreaMask</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>SpecifySession</Name>
    <Description>True, if the SessionAsset should be evaluated</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UseProcessingSession</Name>
    <Description>True, if only areas of the processing session should be used</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>SessionAsset</Name>
    <Description>If given and SpecifySession is true then only areas of this session are accepted</Description>
    <NeededProperty>Session</NeededProperty>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionMutualAreaInSubconditions>
  <AreaFlags/>
  <SessionAsset>0</SessionAsset>
</ConditionMutualAreaInSubconditions>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionevaluatetextsource"></a>
<details>
<summary>ConditionEvaluateTextSource — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1755.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `TextSourceString` | String |  |  | The textsource that should be evaluated for this condition |
| `ComparisonType` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  | [only used when textsource returns a number] Type of comparison you want to apply to the result |
| `ComparisonValue` | Float |  |  | [only used when textsource returns a number] The value you want to comparte the result to |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionEvaluateTextSource</Name>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>TextSourceString</Name>
    <Description>The textsource that should be evaluated for this condition</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ComparisonType</Name>
    <Description>[only used when textsource returns a number] Type of comparison you want to apply to the result</Description>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>ComparisonValue</Name>
    <Description>[only used when textsource returns a number] The value you want to comparte the result to</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionEvaluateTextSource>
  <ComparisonType>AtLeast</ComparisonType>
</ConditionEvaluateTextSource>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionthreshold"></a>
<details>
<summary>ConditionThreshold — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2976.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `DataSource` | String |  |  |  |
| `LowerThreshold` | Float |  |  |  |
| `UpperThreshold` | Float |  |  |  |
| `ThresholdDuration` | Time |  |  |  |
| `IsAreaSpecific` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionThreshold</Name>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>DataSource</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>LowerThreshold</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>UpperThreshold</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Time</DataType>
    <Name>ThresholdDuration</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IsAreaSpecific</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionThreshold/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-actionregistertrigger"></a>
<details>
<summary>ActionRegisterTrigger — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:6903.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `TriggerAsset` | Asset |  | NeededProperty=Trigger |  |
| `UnregisterTrigger` | Boolean |  |  | If false, the trigger will be created. CAUTION: If it is already created it will be reset to its origin state. If true, the trigger will be unregistered instead of registered |
| `InheritArea` | Boolean |  |  | Set to true if you want the area by the paren Quest/Trigger to be passed on to the newly registered trigger |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ActionRegisterTrigger</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>TriggerAsset</Name>
    <NeededProperty>Trigger</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UnregisterTrigger</Name>
    <Description>If false, the trigger will be created. CAUTION: If it is already created it will be reset to its origin state. If true, the trigger will be unregistered instead of registered</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>InheritArea</Name>
    <Description>Set to true if you want the area by the paren Quest/Trigger to be passed on to the newly registered trigger</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ActionRegisterTrigger>
  <TriggerAsset>0</TriggerAsset>
</ActionRegisterTrigger>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-actionresettrigger"></a>
<details>
<summary>ActionResetTrigger — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:6973.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ActionResetTrigger</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ActionResetTrigger/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-actionexecutescript"></a>
<details>
<summary>ActionExecuteScript — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:6585.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ScriptFileName` | FileName |  |  | The script file that should be executed |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ActionExecuteScript</Name>
  <ValueDefinition>
    <DataType>FileName</DataType>
    <Name>ScriptFileName</Name>
    <Description>The script file that should be executed</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ActionExecuteScript/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-action"></a>
<details>
<summary>Action — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:7987.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>Action</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<Action/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-actiondelayedactions"></a>
<details>
<summary>ActionDelayedActions — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:6368.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `UseVariableAsDelay` | Boolean |  |  |  |
| `DelayVariable` | Choice | [Variables](#dataset-variables) |  |  |
| `ExecutionDelay` | Time |  |  |  |
| `DelayedActions` | AutoCreateAsset |  | AllowedTemplates=Actions; AllowedProperties= |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ActionDelayedActions</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UseVariableAsDelay</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>DelayVariable</Name>
    <DataSet>Variables</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Time</DataType>
    <Name>ExecutionDelay</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>DelayedActions</Name>
    <AllowedTemplates>Actions</AllowedTemplates>
    <AllowedProperties/>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ActionDelayedActions>
  <DelayVariable>Mercier_ARQTriggerChance</DelayVariable>
  <DelayedActions>
    <Template>Actions</Template>
    <Values>
      <ActionList/>
    </Values>
  </DelayedActions>
</ActionDelayedActions>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-actiondeleteobjects"></a>
<details>
<summary>ActionDeleteObjects — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:6414.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ShipsLeaveMapFirst` | Boolean |  |  | If true, all ships among the selected objects will leave the map before being destroyed |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ActionDeleteObjects</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ShipsLeaveMapFirst</Name>
    <Description>If true, all ships among the selected objects will leave the map before being destroyed</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ActionDeleteObjects/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-actionlockasset"></a>
<details>
<summary>ActionLockAsset — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:6714.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `LockAssets` | Vector |  |  |  |
| `LockAssets/Item/Asset` | Asset |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ActionLockAsset</Name>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>LockAssets</Name>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>Asset</Name>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ActionLockAsset>
  <LockAssets/>
</ActionLockAsset>
```

Container-entry defaults:

```xml
<ActionLockAsset>
  <LockAssets>
    <Asset>0</Asset>
  </LockAssets>
</ActionLockAsset>
```

</details>

<a id="property-actionplaymovie"></a>
<details>
<summary>ActionPlayMovie — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:6867.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `Movie` | Asset |  | NeededProperty=Video | Link to a movie asset that should be enqueued |
| `SuppressGamePause` | Boolean |  |  | If true, the game will NOT be paused during the movie |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ActionPlayMovie</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>Movie</Name>
    <Description>Link to a movie asset that should be enqueued</Description>
    <NeededProperty>Video</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>SuppressGamePause</Name>
    <Description>If true, the game will NOT be paused during the movie</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ActionPlayMovie>
  <Movie>0</Movie>
</ActionPlayMovie>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-actionsetobjectguid"></a>
<details>
<summary>ActionSetObjectGUID — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:7039.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `NewGUID` | Asset |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ActionSetObjectGUID</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>NewGUID</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ActionSetObjectGUID>
  <NewGUID>0</NewGUID>
</ActionSetObjectGUID>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-actionunlockasset"></a>
<details>
<summary>ActionUnlockAsset — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:7487.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `UnlockAssets` | Vector |  |  | Assets get unlocked |
| `UnlockAssets/Item/Asset` | Asset |  | NeededProperty=Locked;AssetPool |  |
| `UnhideAssets` | Vector |  |  | Assets get visible |
| `UnhideAssets/Item/Asset` | Asset |  | NeededProperty=Locked;AssetPool |  |
| `UnlockGroups` | Vector |  |  | Assets in these groups get unlocked  |
| `UnlockGroups/Item/Group` | QuestGroup |  | AssetConfig=AssetEditor |  |
| `UnhideGroups` | Vector |  |  | Assets in these groups get visible |
| `UnhideGroups/Item/Group` | QuestGroup |  | AssetConfig=AssetEditor |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ActionUnlockAsset</Name>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>UnlockAssets</Name>
    <Description>Assets get unlocked</Description>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>Asset</Name>
        <NeededProperty>Locked;AssetPool</NeededProperty>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>UnhideAssets</Name>
    <Description>Assets get visible</Description>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>Asset</Name>
        <NeededProperty>Locked;AssetPool</NeededProperty>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>UnlockGroups</Name>
    <Description>Assets in these groups get unlocked </Description>
    <Items>
      <ValueDefinition>
        <DataType>QuestGroup</DataType>
        <Name>Group</Name>
        <AssetConfig>AssetEditor</AssetConfig>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>UnhideGroups</Name>
    <Description>Assets in these groups get visible</Description>
    <Items>
      <ValueDefinition>
        <DataType>QuestGroup</DataType>
        <Name>Group</Name>
        <AssetConfig>AssetEditor</AssetConfig>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ActionUnlockAsset>
  <UnlockAssets/>
  <UnhideAssets/>
  <UnlockGroups/>
  <UnhideGroups/>
</ActionUnlockAsset>
```

Container-entry defaults:

```xml
<ActionUnlockAsset>
  <UnlockAssets>
    <Asset>0</Asset>
  </UnlockAssets>
  <UnhideAssets>
    <Asset>0</Asset>
  </UnhideAssets>
</ActionUnlockAsset>
```

</details>

<a id="property-conditionactiveregion"></a>
<details>
<summary>ConditionActiveRegion — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1382.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ActiveRegion` | Asset |  | NeededProperty=Region | The region from which a session has to be active. If no region is given then any active session triggers this condition. |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionActiveRegion</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ActiveRegion</Name>
    <Description>The region from which a session has to be active. If no region is given then any active session triggers this condition.</Description>
    <NeededProperty>Region</NeededProperty>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionActiveRegion>
  <ActiveRegion>0</ActiveRegion>
</ConditionActiveRegion>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionalwaysfalse"></a>
<details>
<summary>ConditionAlwaysFalse — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1410.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionAlwaysFalse</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionAlwaysFalse/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionalwaystrue"></a>
<details>
<summary>ConditionAlwaysTrue — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1413.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionAlwaysTrue</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionAlwaysTrue/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionareaclaimed"></a>
<details>
<summary>ConditionAreaClaimed — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1416.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `Island` | Asset |  | NeededProperty=Island | which construction area |
| `Claimed` | Boolean |  |  | Condition is valid if claimed status matches |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionAreaClaimed</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>Island</Name>
    <Description>which construction area</Description>
    <NeededProperty>Island</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>Claimed</Name>
    <Description>Condition is valid if claimed status matches</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionAreaClaimed>
  <Island>0</Island>
</ConditionAreaClaimed>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionattractiveness"></a>
<details>
<summary>ConditionAttractiveness — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1430.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `AttractivenessNeed` | Integer |  |  |  |
| `AttractivenessComparisonOp` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `AttractivenessType` | Choice | [AttractivityType](#dataset-attractivitytype) |  |  |
| `CountAllTypes` | Boolean |  |  |  |
| `AttractivenessSessionOrRegion` | Asset |  | NeededProperty=Session;Region |  |
| `AttractivenessCheckSpecificBuilding` | Boolean |  |  | If true, AttractivenessSpecificBuilding will be considered |
| `AttractivenessSpecificBuilding` | Asset |  |  | A specific building that is checked for its attractiveness |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionAttractiveness</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>AttractivenessNeed</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>AttractivenessComparisonOp</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>AttractivenessType</Name>
    <DataSet>AttractivityType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CountAllTypes</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>AttractivenessSessionOrRegion</Name>
    <NeededProperty>Session;Region</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AttractivenessCheckSpecificBuilding</Name>
    <Description>If true, AttractivenessSpecificBuilding will be considered</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>AttractivenessSpecificBuilding</Name>
    <Description>A specific building that is checked for its attractiveness</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionAttractiveness>
  <AttractivenessComparisonOp>AtLeast</AttractivenessComparisonOp>
  <AttractivenessType>Culture</AttractivenessType>
  <AttractivenessSessionOrRegion>0</AttractivenessSessionOrRegion>
  <AttractivenessSpecificBuilding>0</AttractivenessSpecificBuilding>
</ConditionAttractiveness>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionbuildingsinblueprintmode"></a>
<details>
<summary>ConditionBuildingsInBlueprintmode — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1466.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `BuildingCount` | Integer |  |  |  |
| `BlueprintBuildingType` | Asset |  |  | If this is set to something other than Invalid GUID, it will only count the blueprints for that procided GUID |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionBuildingsInBlueprintmode</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>BuildingCount</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>BlueprintBuildingType</Name>
    <Description>If this is set to something other than Invalid GUID, it will only count the blueprints for that procided GUID</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionBuildingsInBlueprintmode/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionburningobject"></a>
<details>
<summary>ConditionBurningObject — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1478.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `BurningObjects` | Vector |  |  |  |
| `BurningObjects/Item/BurningObjectGUID` | Asset |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionBurningObject</Name>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>BurningObjects</Name>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>BurningObjectGUID</Name>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionBurningObject>
  <BurningObjects/>
</ConditionBurningObject>
```

Container-entry defaults:

```xml
<ConditionBurningObject>
  <BurningObjects>
    <BurningObjectGUID>0</BurningObjectGUID>
  </BurningObjects>
</ConditionBurningObject>
```

</details>

<a id="property-conditionbusactivationneedsaturation"></a>
<details>
<summary>ConditionBusActivationNeedSaturation — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1491.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ObjectAmountComparisonOP` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  | Comparison Operator for the Amount of Objects that fulfill the configured need |
| `ObjectAmountThreshold` | Integer |  | Min=0 | Amount of Objects to fulfill the overall condition |
| `NeedsToCheck` | Vector |  |  | The needs that needs to be fulfilled per object |
| `NeedsToCheck/Item/GUID` | Asset |  |  |  |
| `NeedsToCheck/Item/ComparisonOP` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `NeedsToCheck/Item/Threshold` | Integer |  | Min=0; Max=100 |  |
| `NeedsRangeOP` | Choice | [RangeOperator](#dataset-rangeoperator) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionBusActivationNeedSaturation</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ObjectAmountComparisonOP</Name>
    <Description>Comparison Operator for the Amount of Objects that fulfill the configured need</Description>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>ObjectAmountThreshold</Name>
    <Description>Amount of Objects to fulfill the overall condition</Description>
    <Min>0</Min>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>NeedsToCheck</Name>
    <Description>The needs that needs to be fulfilled per object</Description>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>GUID</Name>
      </ValueDefinition>
      <ValueDefinition>
        <DataType>Choice</DataType>
        <Name>ComparisonOP</Name>
        <DataSet>ComparisonOperator</DataSet>
      </ValueDefinition>
      <ValueDefinition>
        <DataType>Integer</DataType>
        <Name>Threshold</Name>
        <Min>0</Min>
        <Max>100</Max>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>NeedsRangeOP</Name>
    <DataSet>RangeOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionBusActivationNeedSaturation>
  <ObjectAmountComparisonOP>AtLeast</ObjectAmountComparisonOP>
  <NeedsToCheck/>
  <NeedsRangeOP>None</NeedsRangeOP>
</ConditionBusActivationNeedSaturation>
```

Container-entry defaults:

```xml
<ConditionBusActivationNeedSaturation>
  <NeedsToCheck>
    <GUID>0</GUID>
    <ComparisonOP>AtLeast</ComparisonOP>
  </NeedsToCheck>
</ConditionBusActivationNeedSaturation>
```

</details>

<a id="property-conditioncameramovement"></a>
<details>
<summary>ConditionCameraMovement — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1533.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `CameraMovementComparator` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `CameraMovementActionToTrack` | Flags | [CameraMovementAction](#dataset-cameramovementaction) |  |  |
| `CameraMovementDistance` | Float |  |  | Distance is in meters |
| `StartDistanceTrackingOnFirstEvaluation` | Boolean |  |  | Should the distance of the camera action be tracked when the condition was evaluated for the first time or when the tracking for this participant started. |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionCameraMovement</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>CameraMovementComparator</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>CameraMovementActionToTrack</Name>
    <DataSet>CameraMovementAction</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>CameraMovementDistance</Name>
    <Description>Distance is in meters</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>StartDistanceTrackingOnFirstEvaluation</Name>
    <Description>Should the distance of the camera action be tracked when the condition was evaluated for the first time or when the tracking for this participant started.</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionCameraMovement>
  <CameraMovementComparator>AtLeast</CameraMovementComparator>
  <CameraMovementActionToTrack>Economy</CameraMovementActionToTrack>
</ConditionCameraMovement>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditioncorporationdifficulty"></a>
<details>
<summary>ConditionCorporationDifficulty — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1556.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `Difficulty` | Flags | [CorporationDifficulty](#dataset-corporationdifficulty) |  |  |
| `DifficultyConstructionCostRefund` | Flags | [DCConstructionCostRefund](#dataset-dcconstructioncostrefund) |  |  |
| `DifficultyLossCondition` | Flags | [DCLossCondition](#dataset-dclosscondition) |  |  |
| `DifficultyOptionalQuestFrequency` | Flags | [DCOptionalQuestFrequency](#dataset-dcoptionalquestfrequency) |  |  |
| `DifficultyOptionalQuestRewards` | Flags | [DCOptionalQuestRewards](#dataset-dcoptionalquestrewards) |  |  |
| `DifficultyRelocateBuildings` | Flags | [DCRelocateBuildings](#dataset-dcrelocatebuildings) |  |  |
| `DifficultyRevenue` | Flags | [DCRevenue](#dataset-dcrevenue) |  |  |
| `DifficultyStartCredits` | Flags | [DCStartCredits](#dataset-dcstartcredits) |  |  |
| `DifficultyStartShips` | Flags | [DCStartShips](#dataset-dcstartships) |  |  |
| `DifficultyStartWithKontor` | Flags | [DCStartWithKontor](#dataset-dcstartwithkontor) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionCorporationDifficulty</Name>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>Difficulty</Name>
    <DataSet>CorporationDifficulty</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>DifficultyConstructionCostRefund</Name>
    <DataSet>DCConstructionCostRefund</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>DifficultyLossCondition</Name>
    <DataSet>DCLossCondition</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>DifficultyOptionalQuestFrequency</Name>
    <DataSet>DCOptionalQuestFrequency</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>DifficultyOptionalQuestRewards</Name>
    <DataSet>DCOptionalQuestRewards</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>DifficultyRelocateBuildings</Name>
    <DataSet>DCRelocateBuildings</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>DifficultyRevenue</Name>
    <DataSet>DCRevenue</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>DifficultyStartCredits</Name>
    <DataSet>DCStartCredits</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>DifficultyStartShips</Name>
    <DataSet>DCStartShips</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>DifficultyStartWithKontor</Name>
    <DataSet>DCStartWithKontor</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionCorporationDifficulty>
  <Difficulty/>
  <DifficultyConstructionCostRefund/>
  <DifficultyLossCondition/>
  <DifficultyOptionalQuestFrequency/>
  <DifficultyOptionalQuestRewards/>
  <DifficultyRelocateBuildings/>
  <DifficultyRevenue/>
  <DifficultyStartCredits/>
  <DifficultyStartShips/>
  <DifficultyStartWithKontor/>
</ConditionCorporationDifficulty>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditiondecision"></a>
<details>
<summary>ConditionDecision — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1609.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `DecisionFluffText` | Text |  | NeededProperty=Text | The decision text displayed to the user to describe what decision to take |
| `DecisionPortrait` | Asset |  | NeededProperty=Portrait | The portrait that should be displayed in the decision popup |
| `DecisionOptionList` | Vector |  |  | The list of options to choose from |
| `DecisionOptionList/Item/DecisionOption` | AutoCreateAsset |  | AllowedTemplates=ConditionDecisionOption; AllowedProperties= |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionDecision</Name>
  <ValueDefinition>
    <DataType>Text</DataType>
    <Name>DecisionFluffText</Name>
    <Description>The decision text displayed to the user to describe what decision to take</Description>
    <NeededProperty>Text</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>DecisionPortrait</Name>
    <Description>The portrait that should be displayed in the decision popup</Description>
    <NeededProperty>Portrait</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>DecisionOptionList</Name>
    <Description>The list of options to choose from</Description>
    <Items>
      <ValueDefinition>
        <DataType>AutoCreateAsset</DataType>
        <Name>DecisionOption</Name>
        <AllowedTemplates>ConditionDecisionOption</AllowedTemplates>
        <AllowedProperties/>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionDecision>
  <DecisionFluffText>0</DecisionFluffText>
  <DecisionPortrait>0</DecisionPortrait>
  <DecisionOptionList/>
</ConditionDecision>
```

Container-entry defaults:

```xml
<ConditionDecision>
  <DecisionOptionList>
    <DecisionOption>
      <Template>ConditionDecisionOption</Template>
      <Values>
        <Condition/>
        <ConditionDecisionOption>
          <ActionList>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Template>Actions</Template>
            <Values>
              <ActionList/>
            </Values>
          </ActionList>
          <DecisionNotification>
            <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
            <Template>CharacterNotification</Template>
            <Values>
              <CharacterNotification/>
              <BaseNotification/>
              <NotificationSubtitle/>
            </Values>
          </DecisionNotification>
        </ConditionDecisionOption>
      </Values>
    </DecisionOption>
  </DecisionOptionList>
</ConditionDecision>
```

</details>

<a id="property-conditiondecisionoption"></a>
<details>
<summary>ConditionDecisionOption — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1637.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `DecisionOptionText` | Text |  | NeededProperty=Text | The text displayed on the decision button that describes the decision option |
| `DecisionOptionInfotip` | Text |  |  |  |
| `ActionList` | AutoCreateAsset |  | AllowedTemplates=Actions; AllowedProperties= | A list of actions that should be executed when the user chose this option |
| `UnlockRequirements` | Vector |  |  | A list of assets that need to be unlocked to be able to choose this decision option |
| `UnlockRequirements/Item/RequiredUnlock` | Asset |  | NeededProperty=Locked |  |
| `UnlockInfotipDescription` | Text |  | NeededProperty=Text | Infotip text that is displayed when this option is locked |
| `HideDecisionPanelAfterChoice` | Boolean |  |  | Indicates whether the decision popup should close after this option was taken |
| `FollowUpDecisionList` | Vector |  |  | A list of follow up decisions that will be a result of this decision option |
| `FollowUpDecisionList/Item/FollowUpDecision` | AutoCreateAsset |  | AllowedTemplates=ConditionDecision; AllowedProperties= |  |
| `HasDecisionCostBehavior` | Boolean |  |  | If true, any ActionAddGoodsToItemContainer in the action list would be evaluated and following things happen: 1. Decision gets disabled if player could not pay the resources 2. Resource requirements will be shown in infotip |
| `HasNotification` | Boolean |  |  | If true, triggers the DecisionNotification when the decision option was chosen |
| `DecisionNotification` | AutoCreateAsset |  | AllowedTemplates=CharacterNotification; AllowedProperties= | Will get triggered when this decision option was chosen and HasNotification is true |
| `ShowDecisionBuffs` | Boolean |  |  | If true, buff icons with infotip will be shown for each buff action in the action list |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionDecisionOption</Name>
  <ValueDefinition>
    <DataType>Text</DataType>
    <Name>DecisionOptionText</Name>
    <Description>The text displayed on the decision button that describes the decision option</Description>
    <NeededProperty>Text</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Text</DataType>
    <Name>DecisionOptionInfotip</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>ActionList</Name>
    <Description>A list of actions that should be executed when the user chose this option</Description>
    <AllowedTemplates>Actions</AllowedTemplates>
    <AllowedProperties/>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>UnlockRequirements</Name>
    <Description>A list of assets that need to be unlocked to be able to choose this decision option</Description>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>RequiredUnlock</Name>
        <NeededProperty>Locked</NeededProperty>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Text</DataType>
    <Name>UnlockInfotipDescription</Name>
    <Description>Infotip text that is displayed when this option is locked</Description>
    <NeededProperty>Text</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>HideDecisionPanelAfterChoice</Name>
    <Description>Indicates whether the decision popup should close after this option was taken</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>FollowUpDecisionList</Name>
    <Description>A list of follow up decisions that will be a result of this decision option</Description>
    <Items>
      <ValueDefinition>
        <DataType>AutoCreateAsset</DataType>
        <Name>FollowUpDecision</Name>
        <AllowedTemplates>ConditionDecision</AllowedTemplates>
        <AllowedProperties/>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>HasDecisionCostBehavior</Name>
    <Description>If true, any ActionAddGoodsToItemContainer in the action list would be evaluated and following things happen: 1. Decision gets disabled if player could not pay the resources 2. Resource requirements will be shown in infotip</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>HasNotification</Name>
    <Description>If true, triggers the DecisionNotification when the decision option was chosen</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>DecisionNotification</Name>
    <Description>Will get triggered when this decision option was chosen and HasNotification is true</Description>
    <AllowedTemplates>CharacterNotification</AllowedTemplates>
    <AllowedProperties/>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ShowDecisionBuffs</Name>
    <Description>If true, buff icons with infotip will be shown for each buff action in the action list</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionDecisionOption>
  <DecisionOptionText>0</DecisionOptionText>
  <DecisionOptionInfotip>0</DecisionOptionInfotip>
  <ActionList>
    <Template>Actions</Template>
    <Values>
      <ActionList/>
    </Values>
  </ActionList>
  <UnlockRequirements/>
  <UnlockInfotipDescription>0</UnlockInfotipDescription>
  <FollowUpDecisionList/>
  <DecisionNotification>
    <Template>CharacterNotification</Template>
    <Values>
      <CharacterNotification/>
      <BaseNotification/>
      <NotificationSubtitle/>
    </Values>
  </DecisionNotification>
  <ShowDecisionBuffs>1</ShowDecisionBuffs>
</ConditionDecisionOption>
```

Container-entry defaults:

```xml
<ConditionDecisionOption>
  <UnlockRequirements>
    <RequiredUnlock>0</RequiredUnlock>
  </UnlockRequirements>
  <FollowUpDecisionList>
    <FollowUpDecision>
      <Template>ConditionDecision</Template>
      <Values>
        <Condition/>
        <ConditionDecision/>
      </Values>
    </FollowUpDecision>
  </FollowUpDecisionList>
</ConditionDecisionOption>
```

</details>

<a id="property-conditiondiplomaticstate"></a>
<details>
<summary>ConditionDiplomaticState — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1715.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `SourceIsQuestOwner2` | Boolean |  |  | When true, the source participant is overriden by the quest owner |
| `SourceParticipant2` | Choice | [ParticipantID](#dataset-participantid) |  |  |
| `TargetIsQuestOwner2` | Boolean |  |  | When true, the target participant is overriden by the quest owner |
| `TargetParticipant2` | Choice | [ParticipantID](#dataset-participantid) |  |  |
| `DesiredState` | Choice | [DiplomacyState](#dataset-diplomacystate) |  |  |
| `IgnoreTeamAlliance` | Boolean |  |  | Indicates whether an alliance state should be considered when the two participants started the game as a team (in multiplayer) |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionDiplomaticState</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>SourceIsQuestOwner2</Name>
    <Description>When true, the source participant is overriden by the quest owner</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>SourceParticipant2</Name>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>TargetIsQuestOwner2</Name>
    <Description>When true, the target participant is overriden by the quest owner</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>TargetParticipant2</Name>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>DesiredState</Name>
    <DataSet>DiplomacyState</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IgnoreTeamAlliance</Name>
    <Description>Indicates whether an alliance state should be considered when the two participants started the game as a team (in multiplayer)</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionDiplomaticState>
  <SourceParticipant2>Human0</SourceParticipant2>
  <TargetParticipant2>Human0</TargetParticipant2>
  <DesiredState>War</DesiredState>
</ConditionDiplomaticState>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditiondiplomaticstatechanged"></a>
<details>
<summary>ConditionDiplomaticStateChanged — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1748.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `AllianceCount` | Integer |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionDiplomaticStateChanged</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>AllianceCount</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionDiplomaticStateChanged/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionexpeditionfinished"></a>
<details>
<summary>ConditionExpeditionFinished — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1804.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `Morale` | Integer |  |  |  |
| `MoraleComparisonOperator` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionExpeditionFinished</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>Morale</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>MoraleComparisonOperator</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionExpeditionFinished>
  <MoraleComparisonOperator>AtLeast</MoraleComparisonOperator>
</ConditionExpeditionFinished>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionexportgoodsleveled"></a>
<details>
<summary>ConditionExportGoodsLeveled — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1816.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ExportLevelComparisonOp` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `ExportLevelDesiredAmount` | Integer |  |  |  |
| `UpgradesRelativeToQuestStart` | Boolean |  |  |  |
| `ExportLevelToCheck` | Choice | [ExportLevel](#dataset-exportlevel) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionExportGoodsLeveled</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ExportLevelComparisonOp</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>ExportLevelDesiredAmount</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UpgradesRelativeToQuestStart</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ExportLevelToCheck</Name>
    <DataSet>ExportLevel</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionExportGoodsLeveled>
  <ExportLevelComparisonOp>AtLeast</ExportLevelComparisonOp>
  <ExportLevelDesiredAmount>1</ExportLevelDesiredAmount>
  <ExportLevelToCheck>Uncommon</ExportLevelToCheck>
</ConditionExportGoodsLeveled>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionfactoryproductivity"></a>
<details>
<summary>ConditionFactoryProductivity — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1837.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ProductivityComparison` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `ProductivityThreshold` | Integer |  | Min=0; Max=100 |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionFactoryProductivity</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ProductivityComparison</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>ProductivityThreshold</Name>
    <Min>0</Min>
    <Max>100</Max>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionFactoryProductivity>
  <ProductivityComparison>AtLeast</ProductivityComparison>
</ConditionFactoryProductivity>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionfestival"></a>
<details>
<summary>ConditionFestival — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1851.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `CheckFestival` | Choice | [FestivalType](#dataset-festivaltype) |  |  |
| `CheckForActive` | Boolean |  |  | Set to false to check if the festival has ended (is not active) |
| `IgnoreType` | Boolean |  |  | Don't care for the type of the festival, just check if any or none festival is active |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionFestival</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>CheckFestival</Name>
    <DataSet>FestivalType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckForActive</Name>
    <Description>Set to false to check if the festival has ended (is not active)</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IgnoreType</Name>
    <Description>Don't care for the type of the festival, just check if any or none festival is active</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionFestival>
  <CheckFestival>BeerFestival</CheckFestival>
</ConditionFestival>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionfiniteresource"></a>
<details>
<summary>ConditionFiniteResource — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1869.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `CheckResourceTypes` | Flags | [ResourceType](#dataset-resourcetype) |  |  |
| `ResourceAmountComp` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `ResourceAmountRemaining` | Integer |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionFiniteResource</Name>
  <Description>Is there a resource slot with the described type and remaining amount?</Description>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>CheckResourceTypes</Name>
    <DataSet>ResourceType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ResourceAmountComp</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>ResourceAmountRemaining</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionFiniteResource>
  <CheckResourceTypes/>
  <ResourceAmountComp>AtLeast</ResourceAmountComp>
</ConditionFiniteResource>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionfirsttimeeventhappened"></a>
<details>
<summary>ConditionFirstTimeEventHappened — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1887.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `SpecificAsset` | Asset |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionFirstTimeEventHappened</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>SpecificAsset</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionFirstTimeEventHappened>
  <SpecificAsset>0</SpecificAsset>
</ConditionFirstTimeEventHappened>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionguievent"></a>
<details>
<summary>ConditionGUIEvent — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1939.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `UIEventType` | Choice | [GUIEventType](#dataset-guieventtype) |  |  |
| `StateToCheck` | Choice | [GUIState](#dataset-guistate) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionGUIEvent</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>UIEventType</Name>
    <DataSet>GUIEventType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>StateToCheck</Name>
    <DataSet>GUIState</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionGUIEvent>
  <UIEventType>Enter</UIEventType>
  <StateToCheck>Video</StateToCheck>
</ConditionGUIEvent>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditiongameended"></a>
<details>
<summary>ConditionGameEnded — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1894.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `WinLoseState` | Choice | [WinLoseState](#dataset-winlosestate) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionGameEnded</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>WinLoseState</Name>
    <DataSet>WinLoseState</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionGameEnded>
  <WinLoseState>Win</WinLoseState>
</ConditionGameEnded>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditiongamepadaction"></a>
<details>
<summary>ConditionGamePadAction — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1902.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `GamePadActionComparator` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `GamePadActionToTrack` | Choice | [GamepadAction](#dataset-gamepadaction) |  |  |
| `GamePadActionTriggeredAmount` | Integer |  |  |  |
| `StartAmountTrackingOnFirstEvaluation` | Boolean |  |  | Should the number of times the game pad action is pressed be tracked when the condition was evaluated for the first time or when the tracking for this participant started. |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionGamePadAction</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>GamePadActionComparator</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>GamePadActionToTrack</Name>
    <DataSet>GamepadAction</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>GamePadActionTriggeredAmount</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>StartAmountTrackingOnFirstEvaluation</Name>
    <Description>Should the number of times the game pad action is pressed be tracked when the condition was evaluated for the first time or when the tracking for this participant started.</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionGamePadAction>
  <GamePadActionComparator>AtLeast</GamePadActionComparator>
  <GamePadActionToTrack>ChangeTabLeft</GamePadActionToTrack>
</ConditionGamePadAction>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionhaciendadecreesactive"></a>
<details>
<summary>ConditionHaciendaDecreesActive — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1952.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ActiveDecrees` | Flags | [MinistryDecreeTier](#dataset-ministrydecreetier) |  |  |
| `DecreesRangeOp` | Choice | [RangeOperator](#dataset-rangeoperator) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionHaciendaDecreesActive</Name>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>ActiveDecrees</Name>
    <DataSet>MinistryDecreeTier</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>DecreesRangeOp</Name>
    <DataSet>RangeOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionHaciendaDecreesActive>
  <ActiveDecrees/>
  <DecreesRangeOp>None</DecreesRangeOp>
</ConditionHaciendaDecreesActive>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionhaciendamodulecount"></a>
<details>
<summary>ConditionHaciendaModuleCount — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1965.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `HaciendaModuleCount` | Integer |  |  |  |
| `HaciendaModuleOperator` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionHaciendaModuleCount</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>HaciendaModuleCount</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>HaciendaModuleOperator</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionHaciendaModuleCount>
  <HaciendaModuleOperator>AtLeast</HaciendaModuleOperator>
</ConditionHaciendaModuleCount>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionhappinessmood"></a>
<details>
<summary>ConditionHappinessMood — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:1977.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `RequiredLevel` | Flags | [HappinessState](#dataset-happinessstate) |  |  |
| `UseProcessingParticipant_chl` | Boolean |  |  | Indicates whether the participants should be chosen dynamically by the current context (e.g. quest asignee) |
| `Participant_chl` | Choice | [ParticipantID](#dataset-participantid) |  |  |
| `PopulationLevel` | Asset |  | NeededProperty=PopulationLevel7 |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionHappinessMood</Name>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>RequiredLevel</Name>
    <DataSet>HappinessState</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UseProcessingParticipant_chl</Name>
    <Description>Indicates whether the participants should be chosen dynamically by the current context (e.g. quest asignee)</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>Participant_chl</Name>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>PopulationLevel</Name>
    <NeededProperty>PopulationLevel7</NeededProperty>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionHappinessMood>
  <RequiredLevel/>
  <UseProcessingParticipant_chl>1</UseProcessingParticipant_chl>
  <Participant_chl>Human0</Participant_chl>
  <PopulationLevel>0</PopulationLevel>
</ConditionHappinessMood>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditioninpalacerange"></a>
<details>
<summary>ConditionInPalaceRange — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2000.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `InRangeList` | Vector |  |  | List of assets that should be checked to be in range |
| `InRangeList/Item/BuildingAsset` | Asset |  |  | The building or pool asset that should be checked to be in range. |
| `CheckAny` | Boolean |  |  | Indicates whether any or all elements in the InRangeList must be in palace range for this condition to be fulfilled |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionInPalaceRange</Name>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>InRangeList</Name>
    <Description>List of assets that should be checked to be in range</Description>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>BuildingAsset</Name>
        <Description>The building or pool asset that should be checked to be in range.</Description>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckAny</Name>
    <Description>Indicates whether any or all elements in the InRangeList must be in palace range for this condition to be fulfilled</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionInPalaceRange>
  <InRangeList/>
</ConditionInPalaceRange>
```

Container-entry defaults:

```xml
<ConditionInPalaceRange>
  <InRangeList>
    <BuildingAsset>0</BuildingAsset>
  </InRangeList>
</ConditionInPalaceRange>
```

</details>

<a id="property-conditionirrigatedmodules"></a>
<details>
<summary>ConditionIrrigatedModules — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2051.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `IrrigatedModulesRange` | Choice | [RangeOperator](#dataset-rangeoperator) |  | Select range of modules which should be irrigated. CAUTION: Farms without any modules will be ignored in this condition |
| `CheckNonIrrigated` | Boolean |  |  | True, if you want to check the non-irrigated modules instead of the irrigated modules |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIrrigatedModules</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>IrrigatedModulesRange</Name>
    <Description>Select range of modules which should be irrigated. CAUTION: Farms without any modules will be ignored in this condition</Description>
    <DataSet>RangeOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckNonIrrigated</Name>
    <Description>True, if you want to check the non-irrigated modules instead of the irrigated modules</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIrrigatedModules>
  <IrrigatedModulesRange>None</IrrigatedModulesRange>
</ConditionIrrigatedModules>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionirrigationcapacityexceeded"></a>
<details>
<summary>ConditionIrrigationCapacityExceeded — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2065.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIrrigationCapacityExceeded</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIrrigationCapacityExceeded/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditioniscampaign"></a>
<details>
<summary>ConditionIsCampaign — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2088.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsCampaign</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsCampaign/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditioniscraftinginprogress"></a>
<details>
<summary>ConditionIsCraftingInProgress — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2091.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsCraftingInProgress</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsCraftingInProgress/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditioniscreativemode"></a>
<details>
<summary>ConditionIsCreativeMode — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2094.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsCreativeMode</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsCreativeMode/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionisdlcactive"></a>
<details>
<summary>ConditionIsDLCActive — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2101.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `DLCAssetList` | Vector |  |  | List of DLCs that should be checked for activation |
| `DLCAssetList/Item/DLCAsset` | Asset |  | NeededProperty=UplayProduct |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsDLCActive</Name>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>DLCAssetList</Name>
    <Description>List of DLCs that should be checked for activation</Description>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>DLCAsset</Name>
        <NeededProperty>UplayProduct</NeededProperty>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsDLCActive>
  <DLCAssetList/>
</ConditionIsDLCActive>
```

Container-entry defaults:

```xml
<ConditionIsDLCActive>
  <DLCAssetList>
    <DLCAsset>0</DLCAsset>
  </DLCAssetList>
</ConditionIsDLCActive>
```

</details>

<a id="property-conditionisdocklandsexportpyramidfull"></a>
<details>
<summary>ConditionIsDocklandsExportPyramidFull — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2116.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsDocklandsExportPyramidFull</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsDocklandsExportPyramidFull/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionisgamepadmode"></a>
<details>
<summary>ConditionIsGamepadMode — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2119.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsGamepadMode</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsGamepadMode/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionisindustrialized"></a>
<details>
<summary>ConditionIsIndustrialized — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2122.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `IndustrializationDesiredValue` | Integer |  |  |  |
| `IndustrializationComparisonOperator` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `CheckIndustrializationTypeInsteadOfObjectFilter` | Boolean |  |  | If true, all objects of a given type will be checked. Otherwise the object filter will be checked |
| `IndustrializationTypeChecked` | Choice | [IndustrializationType](#dataset-industrializationtype) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsIndustrialized</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>IndustrializationDesiredValue</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>IndustrializationComparisonOperator</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckIndustrializationTypeInsteadOfObjectFilter</Name>
    <Description>If true, all objects of a given type will be checked. Otherwise the object filter will be checked</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>IndustrializationTypeChecked</Name>
    <DataSet>IndustrializationType</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsIndustrialized>
  <IndustrializationTypeChecked>Powerplant</IndustrializationTypeChecked>
  <IndustrializationComparisonOperator>AtLeast</IndustrializationComparisonOperator>
</ConditionIsIndustrialized>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionismultiplayer"></a>
<details>
<summary>ConditionIsMultiplayer — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2211.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsMultiplayer</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsMultiplayer/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionisparticipantingame"></a>
<details>
<summary>ConditionIsParticipantInGame — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2214.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `InGameParticipant` | Choice | [ParticipantID](#dataset-participantid) |  | Checks if a participant was selected in the game setup. |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsParticipantInGame</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>InGameParticipant</Name>
    <Description>Checks if a participant was selected in the game setup.</Description>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsParticipantInGame>
  <InGameParticipant>Human0</InGameParticipant>
</ConditionIsParticipantInGame>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionispaused"></a>
<details>
<summary>ConditionIsPaused — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2223.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `IsObjectPaused` | Boolean |  |  | True if you want to check for paused buildings, False otherwise |
| `IsPauseRangeOp` | Choice | [RangeOperator](#dataset-rangeoperator) |  | Define which of the configured buildings need to match the paused state |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsPaused</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IsObjectPaused</Name>
    <Description>True if you want to check for paused buildings, False otherwise</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>IsPauseRangeOp</Name>
    <Description>Define which of the configured buildings need to match the paused state</Description>
    <DataSet>RangeOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsPaused>
  <IsPauseRangeOp>None</IsPauseRangeOp>
</ConditionIsPaused>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionistutorial"></a>
<details>
<summary>ConditionIsTutorial — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2237.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIsTutorial</Name>
  <Description>Condition checking if the tutorial is currently enabled</Description>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIsTutorial/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionislandsdiscovered"></a>
<details>
<summary>ConditionIslandsDiscovered — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2144.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `IslandsDiscoveredComparator` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `IslandsDiscoveredAmount` | Integer |  |  |  |
| `IslandsDiscoveredScope` | Choice | [CounterScope](#dataset-counterscope) |  |  |
| `IslandsDiscoveredCustomRegion` | Asset |  |  |  |
| `IslandsDiscoveredCustomSession` | Vector |  |  |  |
| `IslandsDiscoveredCustomSession/Item/GUID` | Asset |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIslandsDiscovered</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>IslandsDiscoveredComparator</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>IslandsDiscoveredAmount</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>IslandsDiscoveredScope</Name>
    <DataSet>CounterScope</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>IslandsDiscoveredCustomRegion</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>IslandsDiscoveredCustomSession</Name>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>GUID</Name>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIslandsDiscovered>
  <IslandsDiscoveredComparator>AtLeast</IslandsDiscoveredComparator>
  <IslandsDiscoveredScope>Area</IslandsDiscoveredScope>
  <IslandsDiscoveredCustomRegion>0</IslandsDiscoveredCustomRegion>
  <IslandsDiscoveredCustomSession/>
</ConditionIslandsDiscovered>
```

Container-entry defaults:

```xml
<ConditionIslandsDiscovered>
  <IslandsDiscoveredCustomSession>
    <GUID>0</GUID>
  </IslandsDiscoveredCustomSession>
</ConditionIslandsDiscovered>
```

</details>

<a id="property-conditionislandswithfertility"></a>
<details>
<summary>ConditionIslandsWithFertility — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2175.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `IslandComparator` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `IslandThreshold` | Integer |  | Min=0 |  |
| `FertilityContext` | Asset |  |  |  |
| `IslandScope` | Choice | [CounterScope](#dataset-counterscope) |  |  |
| `CustomRegion` | Asset |  |  |  |
| `CustomSessions` | Vector |  |  |  |
| `CustomSessions/Item/GUID` | Asset |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionIslandsWithFertility</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>IslandComparator</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>IslandThreshold</Name>
    <Min>0</Min>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>FertilityContext</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>IslandScope</Name>
    <DataSet>CounterScope</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>CustomRegion</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>CustomSessions</Name>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>GUID</Name>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionIslandsWithFertility>
  <IslandComparator>AtLeast</IslandComparator>
  <FertilityContext>0</FertilityContext>
  <IslandScope>Area</IslandScope>
  <CustomRegion>0</CustomRegion>
  <CustomSessions/>
</ConditionIslandsWithFertility>
```

Container-entry defaults:

```xml
<ConditionIslandsWithFertility>
  <CustomSessions>
    <GUID>0</GUID>
  </CustomSessions>
</ConditionIslandsWithFertility>
```

</details>

<a id="property-conditionitemused"></a>
<details>
<summary>ConditionItemUsed — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2244.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `TargetItem` | Asset |  |  | Item the player has to activate or to socket |
| `ItemAmount` | Integer |  |  | Amount of items the player has to activate or to socket |
| `ItemTargetObject` | Asset |  |  | At which game objects the item(s) have to be activated/socketed. If nothing is setup here, then it's only checked whether the item(s) have been activated. |
| `ItemNeedsActivation` | Boolean |  |  | True, if the item nees to be equipped AND activated |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionItemUsed</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>TargetItem</Name>
    <Description>Item the player has to activate or to socket</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>ItemAmount</Name>
    <Description>Amount of items the player has to activate or to socket</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ItemTargetObject</Name>
    <Description>At which game objects the item(s) have to be activated/socketed. If nothing is setup here, then it's only checked whether the item(s) have been activated.</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ItemNeedsActivation</Name>
    <Description>True, if the item nees to be equipped AND activated</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionItemUsed>
  <TargetItem>0</TargetItem>
  <ItemTargetObject>0</ItemTargetObject>
</ConditionItemUsed>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionmetagameloaded"></a>
<details>
<summary>ConditionMetagameLoaded — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2267.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `HumanPlayerCount` | Integer |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionMetagameLoaded</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>HumanPlayerCount</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionMetagameLoaded/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionmodulecount"></a>
<details>
<summary>ConditionModuleCount — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2277.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ModuleComparison` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  | The comparsion that should be used to compare the percentage of modules existing |
| `CheckAbsoluteCount` | Boolean |  |  | Indicates whether an absolute number of modules or a percentage of modules should be checked |
| `ModuleCount` | Integer |  |  |  |
| `RestrictToMandatoryModules` | Boolean |  |  | Indicates whether the absolute module count should be capped at the mandatory amount and ignore addional modules built for visuals |
| `ModulePercentage` | Float |  | Min=0; Max=1 | The percentage (0 = 0%, 1 = 100%) of modules that the current amount should be compared to |
| `RequiresIndustrialization` | Boolean |  |  |  |
| `RequiredIndustrialization` | Choice | [IndustrializationType](#dataset-industrializationtype) |  |  |
| `CheckAdditionalModuleOnly` | Boolean |  |  |  |
| `CheckIrrigatedModulesOnly` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionModuleCount</Name>
  <Description>Compares the current amount of modules built per building with a given percentage</Description>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ModuleComparison</Name>
    <Description>The comparsion that should be used to compare the percentage of modules existing</Description>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckAbsoluteCount</Name>
    <Description>Indicates whether an absolute number of modules or a percentage of modules should be checked</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>ModuleCount</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>RestrictToMandatoryModules</Name>
    <Description>Indicates whether the absolute module count should be capped at the mandatory amount and ignore addional modules built for visuals</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>ModulePercentage</Name>
    <Description>The percentage (0 = 0%, 1 = 100%) of modules that the current amount should be compared to</Description>
    <Min>0</Min>
    <Max>1</Max>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>RequiresIndustrialization</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>RequiredIndustrialization</Name>
    <DataSet>IndustrializationType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckAdditionalModuleOnly</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckIrrigatedModulesOnly</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionModuleCount>
  <ModuleComparison>AtLeast</ModuleComparison>
  <RequiredIndustrialization>Powerplant</RequiredIndustrialization>
</ConditionModuleCount>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionmonoculture"></a>
<details>
<summary>ConditionMonoCulture — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2325.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `MonocultureDeltaComp` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `MonocultureDelta` | Float |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionMonoCulture</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>MonocultureDeltaComp</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>MonocultureDelta</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionMonoCulture>
  <MonocultureDeltaComp>AtLeast</MonocultureDeltaComp>
</ConditionMonoCulture>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionmonumenteventsactive"></a>
<details>
<summary>ConditionMonumentEventsActive — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2337.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `MonumentEventsActive` | Vector |  |  |  |
| `MonumentEventsActive/Item/MonumentEventGUID` | Asset |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionMonumentEventsActive</Name>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>MonumentEventsActive</Name>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>MonumentEventGUID</Name>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionMonumentEventsActive>
  <MonumentEventsActive/>
</ConditionMonumentEventsActive>
```

Container-entry defaults:

```xml
<ConditionMonumentEventsActive>
  <MonumentEventsActive>
    <MonumentEventGUID>0</MonumentEventGUID>
  </MonumentEventsActive>
</ConditionMonumentEventsActive>
```

</details>

<a id="property-conditionmonumentprogress"></a>
<details>
<summary>ConditionMonumentProgress — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2350.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `MonumentComparisonOP` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `MonumentProgress` | Integer |  | Min=0; Max=100 |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionMonumentProgress</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>MonumentComparisonOP</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>MonumentProgress</Name>
    <Min>0</Min>
    <Max>100</Max>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionMonumentProgress>
  <MonumentComparisonOP>AtLeast</MonumentComparisonOP>
</ConditionMonumentProgress>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionmovevehicle"></a>
<details>
<summary>ConditionMoveVehicle — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3995.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `MoveVehicleTargetDistance` | Float |  |  |  |
| `VehicleLabel` | String |  |  | Which vehicle is moved? If left empty, the command vehicle needs to be moved by player command. |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionMoveVehicle</Name>
  <Templates>
    <Template>
      <TemplateFileName>cpp/property_header</TemplateFileName>
      <ExportFileName>$Globals.ComponentSourceFolder$/Asset/AssetData$Property.Name$.h</ExportFileName>
    </Template>
    <Template>
      <TemplateFileName>cpp/property_body</TemplateFileName>
      <ExportFileName>$Globals.ComponentSourceFolder$/Asset/AssetData$Property.Name$.cpp</ExportFileName>
    </Template>
  </Templates>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>MoveVehicleTargetDistance</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>VehicleLabel</Name>
    <Description>Which vehicle is moved? If left empty, the command vehicle needs to be moved by player command.</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionMoveVehicle/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionnewspaperpossible"></a>
<details>
<summary>ConditionNewspaperPossible — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2394.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionNewspaperPossible</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionNewspaperPossible/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionnewspaperpublished"></a>
<details>
<summary>ConditionNewspaperPublished — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2397.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `PagesReplaced` | Integer |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionNewspaperPublished</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>PagesReplaced</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionNewspaperPublished/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionobjhpcheck"></a>
<details>
<summary>ConditionObjHPCheck — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2450.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `HPTargetGUID` | Asset |  |  |  |
| `HPTargetOwner` | Choice | [ParticipantID](#dataset-participantid) |  |  |
| `HPPercentage` | Float |  | Min=0; Max=1 |  |
| `HPComparison` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `HPUnique` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionObjHPCheck</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>HPTargetGUID</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>HPTargetOwner</Name>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>HPPercentage</Name>
    <Min>0</Min>
    <Max>1</Max>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>HPComparison</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>HPUnique</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionObjHPCheck>
  <HPTargetGUID>0</HPTargetGUID>
  <HPTargetOwner>Human0</HPTargetOwner>
  <HPComparison>AtLeast</HPComparison>
</ConditionObjHPCheck>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionobjectselected"></a>
<details>
<summary>ConditionObjectSelected — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2432.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `IgnoreSelectionBeforeActivation` | Boolean |  |  | If true, this condition needs the selection to happen _after_ it was activated (e.g. the parent condition was fulfilled). If false, previous selections also count |
| `UseRuinState` | Choice | [Tristate](#dataset-tristate) |  |  |
| `IsInIncident` | Choice | [Tristate](#dataset-tristate) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionObjectSelected</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IgnoreSelectionBeforeActivation</Name>
    <Description>If true, this condition needs the selection to happen _after_ it was activated (e.g. the parent condition was fulfilled). If false, previous selections also count</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>UseRuinState</Name>
    <DataSet>Tristate</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>IsInIncident</Name>
    <DataSet>Tristate</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionObjectSelected>
  <UseRuinState>DontCare</UseRuinState>
  <IsInIncident>DontCare</IsInIncident>
</ConditionObjectSelected>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionoverlapsaabb"></a>
<details>
<summary>ConditionOverlapsAABB — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2477.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `AssetA` | Asset |  |  |  |
| `AssetB` | Asset |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionOverlapsAABB</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>AssetA</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>AssetB</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionOverlapsAABB>
  <AssetA>0</AssetA>
  <AssetB>0</AssetB>
</ConditionOverlapsAABB>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionpalaceitemequipbonusactive"></a>
<details>
<summary>ConditionPalaceItemEquipBonusActive — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2488.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `BuildingsWithEffectActive` | Vector |  |  |  |
| `BuildingsWithEffectActive/Item/Building` | Asset |  |  |  |
| `BuildingsWithEffectActive/Item/MinimalAmount` | Integer |  |  |  |
| `AffectedBuildingCount` | Integer |  |  |  |
| `AmountItemsEquipped` | Integer |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionPalaceItemEquipBonusActive</Name>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>BuildingsWithEffectActive</Name>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>Building</Name>
      </ValueDefinition>
      <ValueDefinition>
        <DataType>Integer</DataType>
        <Name>MinimalAmount</Name>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>AffectedBuildingCount</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>AmountItemsEquipped</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionPalaceItemEquipBonusActive>
  <BuildingsWithEffectActive/>
</ConditionPalaceItemEquipBonusActive>
```

Container-entry defaults:

```xml
<ConditionPalaceItemEquipBonusActive>
  <BuildingsWithEffectActive>
    <Building>0</Building>
  </BuildingsWithEffectActive>
</ConditionPalaceItemEquipBonusActive>
```

</details>

<a id="property-conditionpalaceunlocks"></a>
<details>
<summary>ConditionPalaceUnlocks — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2513.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `CheckMinistryUnlocks` | Flags | [PalaceMinistryType](#dataset-palaceministrytype) |  |  |
| `CheckDecreeUnlocks` | Array | [PalaceMinistryType](#dataset-palaceministrytype) |  |  |
| `CheckDecreeUnlocks/{dataset key}/DecreeUnlocks` | Flags | [MinistryDecreeTier](#dataset-ministrydecreetier) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionPalaceUnlocks</Name>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>CheckMinistryUnlocks</Name>
    <DataSet>PalaceMinistryType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Array</DataType>
    <Name>CheckDecreeUnlocks</Name>
    <DataSet>PalaceMinistryType</DataSet>
    <Items>
      <ValueDefinition>
        <DataType>Flags</DataType>
        <Name>DecreeUnlocks</Name>
        <DataSet>MinistryDecreeTier</DataSet>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionPalaceUnlocks>
  <CheckMinistryUnlocks/>
  <CheckDecreeUnlocks/>
</ConditionPalaceUnlocks>
```

Container-entry defaults:

```xml
<ConditionPalaceUnlocks>
  <CheckDecreeUnlocks>
    <DecreeUnlocks/>
  </CheckDecreeUnlocks>
</ConditionPalaceUnlocks>
```

</details>

<a id="property-conditionphotographobject"></a>
<details>
<summary>ConditionPhotographObject — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2533.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `StagedPhotography` | FileName |  |  | If set, this picture will be shown instead of the actual screenshot made by the player |
| `CircleAreaPercentage` | Float |  |  | The percentage of the area that the circle around the object has in relation to the total screen space. Toggle quest hint cheat during photography quest to see details |
| `ScreenBorderPercentage` | Float |  |  | The object has to be inside a smaller rectangle than the screen itself. This is the percentage of the area that is reduced from each border to define the inner rectangle |
| `AppearInNewspaperArticle` | Asset |  | NeededProperty=NewspaperArticle;NewspaperSpecialEditionArticle | If any article is selected, this picture will be shown in the given article |
| `ShowHintMarkerWhenOffscreen` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionPhotographObject</Name>
  <ValueDefinition>
    <DataType>FileName</DataType>
    <Name>StagedPhotography</Name>
    <Description>If set, this picture will be shown instead of the actual screenshot made by the player</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>CircleAreaPercentage</Name>
    <Description>The percentage of the area that the circle around the object has in relation to the total screen space. Toggle quest hint cheat during photography quest to see details</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>ScreenBorderPercentage</Name>
    <Description>The object has to be inside a smaller rectangle than the screen itself. This is the percentage of the area that is reduced from each border to define the inner rectangle</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>AppearInNewspaperArticle</Name>
    <Description>If any article is selected, this picture will be shown in the given article</Description>
    <NeededProperty>NewspaperArticle;NewspaperSpecialEditionArticle</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ShowHintMarkerWhenOffscreen</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionPhotographObject>
  <AppearInNewspaperArticle>0</AppearInNewspaperArticle>
  <ShowHintMarkerWhenOffscreen>1</ShowHintMarkerWhenOffscreen>
</ConditionPhotographObject>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionproductcapacityreached"></a>
<details>
<summary>ConditionProductCapacityReached — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2649.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `cpcr_ProductType` | Asset |  | NeededProperty=Product; |  |
| `cpcr_RangeOp` | Choice | [RangeOperator](#dataset-rangeoperator) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionProductCapacityReached</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>cpcr_ProductType</Name>
    <NeededProperty>Product;</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>cpcr_RangeOp</Name>
    <DataSet>RangeOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionProductCapacityReached>
  <cpcr_ProductType>0</cpcr_ProductType>
  <cpcr_RangeOp>None</cpcr_RangeOp>
</ConditionProductCapacityReached>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionproductivity"></a>
<details>
<summary>ConditionProductivity — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2662.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `Good_CP` | Asset |  |  | The Good that should be checked |
| `ComparisonMode` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `CheckAbsoluteProduction` | Boolean |  |  |  |
| `ProductivityRequired` | Float |  | Min=0; Max=1 | The required percentage of productivity |
| `ProductionRequired` | Float |  |  | The amount of production per minute of the required good |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionProductivity</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>Good_CP</Name>
    <Description>The Good that should be checked</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ComparisonMode</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckAbsoluteProduction</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>ProductivityRequired</Name>
    <Description>The required percentage of productivity</Description>
    <Min>0</Min>
    <Max>1</Max>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Float</DataType>
    <Name>ProductionRequired</Name>
    <Description>The amount of production per minute of the required good</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionProductivity>
  <Good_CP>0</Good_CP>
  <ComparisonMode>AtLeast</ComparisonMode>
</ConditionProductivity>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionquestobjective"></a>
<details>
<summary>ConditionQuestObjective — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:6012.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `IsVisibleInQuestTracker` | Boolean |  | Category=ConditionQuestObjective | true, if this condition should be shown in the quest tracker |
| `TextCombinedContextValue` | Text |  | Category=ConditionQuestObjective; NeededProperty=Text | this is the combined description text with a value text of a quest objetive (e.g. "Build houses 2 / 5") |
| `QuestTrackerIcon` | FileName |  |  |  |
| `ObjectiveSignsAndFeedback` | AutoCreateAsset |  | Category=ConditionQuestObjective; AllowedTemplates=ConditionObjectiveSignsAndFeedback; AllowedProperties= |  |
| `FakeMinimapPings` | Struct |  |  | Mininmappings that are not related to the objective can be defined here |
| `FakeMinimapPings/Objects` | Vector |  |  |  |
| `FakeMinimapPings/Objects/Item/FakeMinimapObjects` | AutoCreateAsset |  | AllowedTemplates=ObjectFilter; AllowedProperties= |  |
| `FakeMinimapPings/Objects/Item/SignsAndFeedback` | AutoCreateAsset |  | AllowedTemplates=ConditionObjectiveSignsAndFeedback; AllowedProperties= |  |
| `ObjectiveSuccessMessage` | AutoCreateAsset |  | AllowedTemplates=CharacterNotification; AllowedProperties= |  |
| `JumpToVisibility` | Choice | [QuestJumpToButtonVisibility](#dataset-questjumptobuttonvisibility) |  | Defines the visibility of the jump-to button for this objective |
| `OnSuccessActions` | AutoCreateAsset |  | AllowedTemplates=Actions; AllowedProperties= |  |
| `LinkAllQuestActionsToQuest` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionQuestObjective</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IsVisibleInQuestTracker</Name>
    <Description>true, if this condition should be shown in the quest tracker</Description>
    <Category>ConditionQuestObjective</Category>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Text</DataType>
    <Name>TextCombinedContextValue</Name>
    <Description>this is the combined description text with a value text of a quest objetive (e.g. "Build houses 2 / 5")</Description>
    <Category>ConditionQuestObjective</Category>
    <NeededProperty>Text</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>FileName</DataType>
    <Name>QuestTrackerIcon</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>ObjectiveSignsAndFeedback</Name>
    <Category>ConditionQuestObjective</Category>
    <AllowedTemplates>ConditionObjectiveSignsAndFeedback</AllowedTemplates>
    <AllowedProperties/>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Struct</DataType>
    <Name>FakeMinimapPings</Name>
    <Description>Mininmappings that are not related to the objective can be defined here</Description>
    <Items>
      <ValueDefinition>
        <DataType>Vector</DataType>
        <Name>Objects</Name>
        <Items>
          <ValueDefinition>
            <DataType>AutoCreateAsset</DataType>
            <Name>FakeMinimapObjects</Name>
            <AllowedTemplates>ObjectFilter</AllowedTemplates>
            <AllowedProperties/>
          </ValueDefinition>
          <ValueDefinition>
            <DataType>AutoCreateAsset</DataType>
            <Name>SignsAndFeedback</Name>
            <AllowedTemplates>ConditionObjectiveSignsAndFeedback</AllowedTemplates>
            <AllowedProperties/>
          </ValueDefinition>
        </Items>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>ObjectiveSuccessMessage</Name>
    <AllowedTemplates>CharacterNotification</AllowedTemplates>
    <AllowedProperties/>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>JumpToVisibility</Name>
    <Description>Defines the visibility of the jump-to button for this objective</Description>
    <DataSet>QuestJumpToButtonVisibility</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>OnSuccessActions</Name>
    <AllowedTemplates>Actions</AllowedTemplates>
    <AllowedProperties/>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>LinkAllQuestActionsToQuest</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionQuestObjective>
  <IsVisibleInQuestTracker>1</IsVisibleInQuestTracker>
  <TextCombinedContextValue>0</TextCombinedContextValue>
  <ObjectiveSignsAndFeedback>
    <Template>ConditionObjectiveSignsAndFeedback</Template>
    <Values>
      <ConditionObjectiveSignsAndFeedback/>
    </Values>
  </ObjectiveSignsAndFeedback>
  <FakeMinimapPings/>
  <ObjectiveSuccessMessage>
    <Template>CharacterNotification</Template>
    <Values>
      <CharacterNotification/>
      <BaseNotification/>
      <NotificationSubtitle/>
    </Values>
  </ObjectiveSuccessMessage>
  <JumpToVisibility>Show</JumpToVisibility>
  <OnSuccessActions>
    <Template>Actions</Template>
    <Values>
      <ActionList/>
    </Values>
  </OnSuccessActions>
</ConditionQuestObjective>
```

Container-entry defaults:

```xml
<ConditionQuestObjective>
  <FakeMinimapPings>
    <ContainerValues>
      <Objects>
        <FakeMinimapObjects>
          <Template>ObjectFilter</Template>
          <Values>
            <ObjectFilter/>
          </Values>
        </FakeMinimapObjects>
        <SignsAndFeedback>
          <Template>ConditionObjectiveSignsAndFeedback</Template>
          <Values>
            <ConditionObjectiveSignsAndFeedback/>
          </Values>
        </SignsAndFeedback>
      </Objects>
    </ContainerValues>
    <Objects/>
  </FakeMinimapPings>
</ConditionQuestObjective>
```

</details>

<a id="property-conditionquestpoolquestrunning"></a>
<details>
<summary>ConditionQuestPoolQuestRunning — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2691.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `EveryPoolMustBeRunning` | Boolean |  |  | Indicates whether every pool of the vector list should be running a quest. If false, the condition will be true if ANY quest pool is running a quest. |
| `QuestPoolsToCheck` | Vector |  |  | The list of quest pools to check |
| `QuestPoolsToCheck/Item/QuestPool` | Asset |  | NeededProperty=QuestPool |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionQuestPoolQuestRunning</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>EveryPoolMustBeRunning</Name>
    <Description>Indicates whether every pool of the vector list should be running a quest. If false, the condition will be true if ANY quest pool is running a quest.</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>QuestPoolsToCheck</Name>
    <Description>The list of quest pools to check</Description>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>QuestPool</Name>
        <NeededProperty>QuestPool</NeededProperty>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionQuestPoolQuestRunning>
  <QuestPoolsToCheck/>
</ConditionQuestPoolQuestRunning>
```

Container-entry defaults:

```xml
<ConditionQuestPoolQuestRunning>
  <QuestPoolsToCheck>
    <QuestPool>0</QuestPool>
  </QuestPoolsToCheck>
</ConditionQuestPoolQuestRunning>
```

</details>

<a id="property-conditionquestresolveconfirmation"></a>
<details>
<summary>ConditionQuestResolveConfirmation — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:5101.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ResolveConfirmationMessage` | AutoCreateAsset |  | AllowedTemplates=CharacterNotification; AllowedProperties= |  |
| `AvoidShipInRangeCondition` | Boolean |  |  | Does not generate a condition to force a ship to be near a target object |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionQuestResolveConfirmation</Name>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>ResolveConfirmationMessage</Name>
    <AllowedTemplates>CharacterNotification</AllowedTemplates>
    <AllowedProperties/>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AvoidShipInRangeCondition</Name>
    <Description>Does not generate a condition to force a ship to be near a target object</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionQuestResolveConfirmation>
  <ResolveConfirmationMessage>
    <Template>CharacterNotification</Template>
    <Values>
      <CharacterNotification/>
      <BaseNotification/>
      <NotificationSubtitle/>
    </Values>
  </ResolveConfirmationMessage>
</ConditionQuestResolveConfirmation>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionreciperesearchcompleted"></a>
<details>
<summary>ConditionRecipeResearchCompleted — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2737.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `CompletedResearchField` | Flags | [ResearchFields](#dataset-researchfields) |  | All research fields that should be checked |
| `ResearchComparisonOp` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  | The operator to compare the completed research recipes and the desired amount |
| `ResearchDesiredAmount` | Integer |  | Min=0 | The desired amount of completed research recipes |
| `ResearchRangeOp` | Choice | [RangeOperator](#dataset-rangeoperator) |  | Defines which research fields need to match the desired amount |
| `ResearchRelativeToQuestStart` | Boolean |  |  | True: Counting from current condition start - False: Counting from 0. |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionRecipeResearchCompleted</Name>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>CompletedResearchField</Name>
    <Description>All research fields that should be checked</Description>
    <DataSet>ResearchFields</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ResearchComparisonOp</Name>
    <Description>The operator to compare the completed research recipes and the desired amount</Description>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>ResearchDesiredAmount</Name>
    <Description>The desired amount of completed research recipes</Description>
    <Min>0</Min>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ResearchRangeOp</Name>
    <Description>Defines which research fields need to match the desired amount</Description>
    <DataSet>RangeOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ResearchRelativeToQuestStart</Name>
    <Description>True: Counting from current condition start - False: Counting from 0.</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionRecipeResearchCompleted>
  <CompletedResearchField/>
  <ResearchComparisonOp>AtLeast</ResearchComparisonOp>
  <ResearchRangeOp>None</ResearchRangeOp>
</ConditionRecipeResearchCompleted>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionreputation"></a>
<details>
<summary>ConditionReputation — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2772.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `Reputation` | Integer |  |  | [IngameValue] [ComparisonOperator] [Reputation] e.g. X &lt; 5 |
| `ComparisonOperator` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionReputation</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>Reputation</Name>
    <Description>[IngameValue] [ComparisonOperator] [Reputation] e.g. X &lt; 5</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ComparisonOperator</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionReputation>
  <ComparisonOperator>AtLeast</ComparisonOperator>
</ConditionReputation>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionresearchpointlimitreached"></a>
<details>
<summary>ConditionResearchPointLimitReached — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2785.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionResearchPointLimitReached</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionResearchPointLimitReached/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionresidentsinbuilding"></a>
<details>
<summary>ConditionResidentsInBuilding — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2788.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ResidentsComparisonOP` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `ResidentsAmount` | Integer |  |  |  |
| `ResidentsBuildingRangeOP` | Choice | [RangeOperator](#dataset-rangeoperator) |  | All Found Buildings need to reach the amount, any, or none? |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionResidentsInBuilding</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ResidentsComparisonOP</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>ResidentsAmount</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ResidentsBuildingRangeOP</Name>
    <Description>All Found Buildings need to reach the amount, any, or none?</Description>
    <DataSet>RangeOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionResidentsInBuilding>
  <ResidentsComparisonOP>AtLeast</ResidentsComparisonOP>
  <ResidentsBuildingRangeOP>All</ResidentsBuildingRangeOP>
</ConditionResidentsInBuilding>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionseason"></a>
<details>
<summary>ConditionSeason — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2806.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `SeasonToCheck` | Asset |  | NeededProperty=Season |  |
| `SessionToCheck` | Asset |  | NeededProperty=Session | Session to check season for. If empty all sessions will be checked. |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionSeason</Name>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>SeasonToCheck</Name>
    <NeededProperty>Season</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>SessionToCheck</Name>
    <Description>Session to check season for. If empty all sessions will be checked.</Description>
    <NeededProperty>Session</NeededProperty>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionSeason>
  <SeasonToCheck>0</SeasonToCheck>
  <SessionToCheck>0</SessionToCheck>
</ConditionSeason>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionselectionhappinessdebuffactive"></a>
<details>
<summary>ConditionSelectionHappinessDebuffActive — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2820.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `HapinessCategoriesToCheck` | Flags | [HappinessCategory](#dataset-happinesscategory) |  |  |
| `HapinessCategoryRangeOP` | Choice | [RangeOperator](#dataset-rangeoperator) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionSelectionHappinessDebuffActive</Name>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>HapinessCategoriesToCheck</Name>
    <DataSet>HappinessCategory</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>HapinessCategoryRangeOP</Name>
    <DataSet>RangeOperator</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionSelectionHappinessDebuffActive>
  <HapinessCategoriesToCheck/>
  <HapinessCategoryRangeOP>None</HapinessCategoryRangeOP>
</ConditionSelectionHappinessDebuffActive>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionsessionloading"></a>
<details>
<summary>ConditionSessionLoading — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2833.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionSessionLoading</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionSessionLoading/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionshipsinrange"></a>
<details>
<summary>ConditionShipsInRange — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2836.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `Range` | Integer |  | Min=0 | The range in which the ships can be detected |
| `TargetObject_sir` | Asset |  |  | The object that the ships should be near to |
| `CheckSpecificTargetOwner` | Boolean |  |  | Indicates whether the owner of the target object should be specified. |
| `UseProcessingParticipantAsTarget` | Boolean |  |  |  |
| `TargetOwnerParticipant` | Choice | [ParticipantID](#dataset-participantid) |  | The owner of the target object |
| `CheckSpecificShipOwner` | Boolean |  |  | Indicates whether a specific owner of the ships should be checked |
| `UseProcessingParticipantAsShipOwner` | Boolean |  |  |  |
| `ShipOwnerParticipant` | Choice | [ParticipantID](#dataset-participantid) |  | The particpant whose ships are checked to be near the target |
| `UseSpecificShipGuid` | Boolean |  |  | Indicates whether a specific ship needs to be close to the target. If empty, any ship will be able to fulfill the condition |
| `SpecifiedShipOrPool` | Asset |  |  | The guid of the ship or ship pool that should be near the target object(s) |
| `AllowKontorsInRange` | Boolean |  |  | True if ships and kontors are valid objects in range, False if only ships are |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionShipsInRange</Name>
  <ExportTextSourceStub>1</ExportTextSourceStub>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>Range</Name>
    <Description>The range in which the ships can be detected</Description>
    <Min>0</Min>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>TargetObject_sir</Name>
    <Description>The object that the ships should be near to</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckSpecificTargetOwner</Name>
    <Description>Indicates whether the owner of the target object should be specified.</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UseProcessingParticipantAsTarget</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>TargetOwnerParticipant</Name>
    <Description>The owner of the target object</Description>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>CheckSpecificShipOwner</Name>
    <Description>Indicates whether a specific owner of the ships should be checked</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UseProcessingParticipantAsShipOwner</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ShipOwnerParticipant</Name>
    <Description>The particpant whose ships are checked to be near the target</Description>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UseSpecificShipGuid</Name>
    <Description>Indicates whether a specific ship needs to be close to the target. If empty, any ship will be able to fulfill the condition</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>SpecifiedShipOrPool</Name>
    <Description>The guid of the ship or ship pool that should be near the target object(s)</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AllowKontorsInRange</Name>
    <Description>True if ships and kontors are valid objects in range, False if only ships are</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionShipsInRange>
  <TargetObject_sir>0</TargetObject_sir>
  <TargetOwnerParticipant>Human0</TargetOwnerParticipant>
  <ShipOwnerParticipant>Human0</ShipOwnerParticipant>
  <SpecifiedShipOrPool>0</SpecifiedShipOrPool>
</ConditionShipsInRange>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionshipsownedinsession"></a>
<details>
<summary>ConditionShipsOwnedInSession — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2896.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ShipSession` | Asset |  | NeededProperty=Session | The session in which the ship amount is checked |
| `ShipTarget` | Asset |  |  | The target ship GUID that should be checked (also accepts asset pools) |
| `ShipComparison` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  | The type of comparision that should be use to check the ship amount |
| `ShipAmount` | Integer |  | Min=0 | The ship amount that should be checked |
| `ShipOwner` | Choice | [ParticipantID](#dataset-participantid) |  | The owner of the ships |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionShipsOwnedInSession</Name>
  <Description>Condition that checks if a certain amount of ships of a participant are in a certain session</Description>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ShipSession</Name>
    <Description>The session in which the ship amount is checked</Description>
    <NeededProperty>Session</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ShipTarget</Name>
    <Description>The target ship GUID that should be checked (also accepts asset pools)</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ShipComparison</Name>
    <Description>The type of comparision that should be use to check the ship amount</Description>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>ShipAmount</Name>
    <Description>The ship amount that should be checked</Description>
    <Min>0</Min>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ShipOwner</Name>
    <Description>The owner of the ships</Description>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionShipsOwnedInSession>
  <ShipSession>0</ShipSession>
  <ShipTarget>0</ShipTarget>
  <ShipComparison>AtLeast</ShipComparison>
  <ShipOwner>Human0</ShipOwner>
</ConditionShipsOwnedInSession>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionshipyardstate"></a>
<details>
<summary>ConditionShipyardState — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2929.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ShipyardIsSomethingInQueue` | Boolean |  |  | true, if any object is currently in the construction queue of this shipyard |
| `ShipyardOwner` | Choice | [ParticipantID](#dataset-participantid) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionShipyardState</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ShipyardIsSomethingInQueue</Name>
    <Description>true, if any object is currently in the construction queue of this shipyard</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ShipyardOwner</Name>
    <DataSet>ParticipantID</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionShipyardState>
  <ShipyardOwner>Human0</ShipyardOwner>
</ConditionShipyardState>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionstarterobject"></a>
<details>
<summary>ConditionStarterObject — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:5364.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `MoveIntoSession` | Boolean |  |  | True, if the StarterObjectObject should move into the session to the docking place. False, if the StarterObjectObject should be selectable from the very beginning |
| `DockingPlaceDistance` | Float |  |  | If MoveIntoSession is true, then the StarterObjectObject tries to come near StarterObjectDockingPlace, respecting this distance |
| `StarterObjectObject` | AutoCreateAsset |  | AllowedTemplates=ConditionObjectPlayerKontor;ConditionObjectClientQuestObject;ConditionObjectPrebuiltObject;ObjectFilterWithSignsAndFeedback;ConditionObjectSpawnedObject; AllowedProperties= | The object that needs to be selected to start the quest. If MoveIntoSession is true, this object (=ship) will need to move into position first |
| `StarterObjectDockingPlace` | AutoCreateAsset |  | AllowedTemplates=ConditionObjectClientQuestObject;ConditionObjectPlayerKontor;ConditionObjectPrebuiltObject; AllowedProperties= | The place where the StarterObjectObject tries to move to, when MoveIntoSession is true |
| `OverwriteExistingQuestArea` | Boolean |  |  | If true, the starter condition will not only set the area of the starter object as quest area when it is empty but also when is already set |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionStarterObject</Name>
  <Templates>
    <Template>
      <TemplateFileName>cpp/property_header</TemplateFileName>
      <ExportFileName>$Globals.ComponentSourceFolder$/Asset/AssetData$Property.Name$.h</ExportFileName>
    </Template>
    <Template>
      <TemplateFileName>cpp/property_body</TemplateFileName>
      <ExportFileName>$Globals.ComponentSourceFolder$/Asset/AssetData$Property.Name$.cpp</ExportFileName>
    </Template>
  </Templates>
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
    <AllowedProperties/>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>StarterObjectDockingPlace</Name>
    <Description>The place where the StarterObjectObject tries to move to, when MoveIntoSession is true</Description>
    <AllowedTemplates>ConditionObjectClientQuestObject;ConditionObjectPlayerKontor;ConditionObjectPrebuiltObject</AllowedTemplates>
    <AllowedProperties/>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>OverwriteExistingQuestArea</Name>
    <Description>If true, the starter condition will not only set the area of the starter object as quest area when it is empty but also when is already set</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionStarterObject>
  <StarterObjectObject>
    <Template>ConditionObjectPlayerKontor</Template>
    <Values>
      <ConditionObjectPlayerKontor/>
      <ConditionScanner/>
      <ConditionObjectiveSignsAndFeedback/>
    </Values>
  </StarterObjectObject>
  <StarterObjectDockingPlace>
    <Template>ConditionObjectClientQuestObject</Template>
    <Values>
      <ConditionObjectClientQuestObject/>
      <ConditionScanner/>
      <ConditionObjectiveSignsAndFeedback/>
    </Values>
  </StarterObjectDockingPlace>
</ConditionStarterObject>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditionstaticresult"></a>
<details>
<summary>ConditionStaticResult — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2942.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `ConditionResult` | Choice | [ConditionResult](#dataset-conditionresult) |  |  |
| `IsNotReached` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionStaticResult</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ConditionResult</Name>
    <DataSet>ConditionResult</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>IsNotReached</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionStaticResult>
  <ConditionResult>Success</ConditionResult>
</ConditionStaticResult>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditiontextpopupclosed"></a>
<details>
<summary>ConditionTextPopupClosed — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2954.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `TextPopupLayouts` | Flags | [TextPopupLayout](#dataset-textpopuplayout) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionTextPopupClosed</Name>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>TextPopupLayouts</Name>
    <DataSet>TextPopupLayout</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionTextPopupClosed>
  <TextPopupLayouts/>
</ConditionTextPopupClosed>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditiontextpopuppagesviewed"></a>
<details>
<summary>ConditionTextPopupPagesViewed — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2962.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `PagesViewed` | Array | [TextPopupLayout](#dataset-textpopuplayout) |  |  |
| `PagesViewed/{dataset key}/ViewCount` | Integer |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionTextPopupPagesViewed</Name>
  <ValueDefinition>
    <DataType>Array</DataType>
    <Name>PagesViewed</Name>
    <DataSet>TextPopupLayout</DataSet>
    <Items>
      <ValueDefinition>
        <DataType>Integer</DataType>
        <Name>ViewCount</Name>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionTextPopupPagesViewed>
  <PagesViewed/>
</ConditionTextPopupPagesViewed>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditiontimepassed"></a>
<details>
<summary>ConditionTimePassed — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:2999.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `TimePassedComp` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  |  |
| `TimePassed` | Time |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionTimePassed</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>TimePassedComp</Name>
    <DataSet>ComparisonOperator</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Time</DataType>
    <Name>TimePassed</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionTimePassed>
  <TimePassedComp>AtLeast</TimePassedComp>
</ConditionTimePassed>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditiontraderoutecount"></a>
<details>
<summary>ConditionTradeRouteCount — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3034.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `TradeRouteCount` | Integer |  |  |  |
| `CountComparisonOp` | Choice | [ComparisonOperator](#dataset-comparisonoperator) |  | Comparison operator the is used to check the current count, i.e. (CurrentGameValue) (ComparisonOPerator) (TradeRouteCount) |
| `FilterTradeRouteTransportationType` | Flags | [TradeRouteTransportationType](#dataset-traderoutetransportationtype) |  | Only routes with the given transportation type will be counted. Will be skipped if no flag is set |
| `FilterAssignedTradeRouteObjectOrPool` | Asset |  |  | Only routes with the given assigned objects will be counted. Will be skipped if no asset or pool is set |
| `FilterTradeRoutesWithoutWarnings` | Boolean |  |  | If true, only trade routes without warnings will be counted |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionTradeRouteCount</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>TradeRouteCount</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>CountComparisonOp</Name>
    <DataSet>ComparisonOperator</DataSet>
    <Description>Comparison operator the is used to check the current count, i.e. (CurrentGameValue) (ComparisonOPerator) (TradeRouteCount)</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>FilterTradeRouteTransportationType</Name>
    <DataSet>TradeRouteTransportationType</DataSet>
    <Description>Only routes with the given transportation type will be counted. Will be skipped if no flag is set</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>FilterAssignedTradeRouteObjectOrPool</Name>
    <Description>Only routes with the given assigned objects will be counted. Will be skipped if no asset or pool is set</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>FilterTradeRoutesWithoutWarnings</Name>
    <Description>If true, only trade routes without warnings will be counted</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionTradeRouteCount>
  <CountComparisonOp>AtLeast</CountComparisonOp>
</ConditionTradeRouteCount>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-conditiontutorialinteraction"></a>
<details>
<summary>ConditionTutorialInteraction — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:3063.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `HintType` | Choice | [TutorialUiHintType](#dataset-tutorialuihinttype) |  | The type of hint that should be displayed |
| `AllowedInputTypes` | Flags | [InputMode](#dataset-inputmode) |  | Condition will be skipped if the active input mode is not checked here |
| `ShowScrollHintWhenOffscreen` | Boolean |  |  | True = When the hinted object is offscreen, show a marked in that direction. False = Don't. |
| `TutorialConditionType` | Choice | [TutorialCondition](#dataset-tutorialcondition) |  | The type of interaction that should be checked |
| `NegateTutorialConditionType` | Boolean |  |  | Indicates whether the tutorial condition type should be negated to succeed (NOT selected, NOT visible, etc.) |
| `HintEndCondition` | Choice | [TutorialUiHintEndCondition](#dataset-tutorialuihintendcondition) |  | The condition that has to be fulfilled to hide the hint |
| `HintDisplayTime` | Time |  |  | The duration the hint should be displayed before it disappears automatically |
| `HintAnchor` | Choice | [TutorialUiHintAnchor](#dataset-tutorialuihintanchor) |  | Describes the direction of the arrow pointing of to the tutorial element. The box will be positioned accordingly |
| `HintText` | Text |  | NeededProperty=Text | The text that should be displayed in the ui hint box |
| `TutorialUiCategory` | Choice | [TutorialUiCategory](#dataset-tutorialuicategory) |  | The category of the tutorial that is used to reference phoenix objects |
| `RefGuid` | Integer |  |  | The RefGUID of the phoenix element that should be highlighted |
| `RefGuidGamepad` | Asset |  | NeededProperty=TutorialUiElement; ExportPlatforms=XBox;Playstation;Stadia |  |
| `ContextObject` | Asset |  | ReadOnly=1; NeededProperty=Object |  |
| `OnlyShowOnQuestObjects` | Boolean |  |  |  |
| `ObjectFilter` | AutoCreateAsset |  | AllowedTemplates=ObjectFilter; AllowedProperties= |  |
| `HidePortrait` | Boolean |  |  | Indicates whether the speech bubble should have a portrait or not (false = show portrait) |
| `UseSpecificPortrait` | Boolean |  |  | Indicates whether a special portrait should be used for the hint. If false, the quest giver will be taken |
| `SpecificPortraitProfile` | Asset |  | NeededProperty=Profile | The profile asset of the portrait that should be displayed |
| `SpecifyHintColorType` | Boolean |  |  | Indicates whether there should be a specific color for the background of the hint |
| `HintColorType` | Choice | [TutorialUiHintColorType](#dataset-tutorialuihintcolortype) |  | The specific (background) color of the hint  |
| `UseSmallPortrait` | Boolean |  |  |  |
| `DeselectObjectOnClose` | Boolean |  |  |  |
| `ScreenOpenConditionType` | Choice | [TutorialConditionScreenType](#dataset-tutorialconditionscreentype) |  |  |
| `ScreenOpenConditionFlow` | Vector |  |  | Configure additional screens here that are also part of the flow. |
| `ScreenOpenConditionFlow/Item/Screen` | Choice | [TutorialConditionScreenType](#dataset-tutorialconditionscreentype) |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>ConditionTutorialInteraction</Name>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>HintType</Name>
    <Description>The type of hint that should be displayed</Description>
    <DataSet>TutorialUiHintType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Flags</DataType>
    <Name>AllowedInputTypes</Name>
    <Description>Condition will be skipped if the active input mode is not checked here</Description>
    <DataSet>InputMode</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>ShowScrollHintWhenOffscreen</Name>
    <Description>True = When the hinted object is offscreen, show a marked in that direction. False = Don't.</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>TutorialConditionType</Name>
    <Description>The type of interaction that should be checked</Description>
    <DataSet>TutorialCondition</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>NegateTutorialConditionType</Name>
    <Description>Indicates whether the tutorial condition type should be negated to succeed (NOT selected, NOT visible, etc.)</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>HintEndCondition</Name>
    <Description>The condition that has to be fulfilled to hide the hint</Description>
    <DataSet>TutorialUiHintEndCondition</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Time</DataType>
    <Name>HintDisplayTime</Name>
    <Description>The duration the hint should be displayed before it disappears automatically</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>HintAnchor</Name>
    <Description>Describes the direction of the arrow pointing of to the tutorial element. The box will be positioned accordingly</Description>
    <DataSet>TutorialUiHintAnchor</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Text</DataType>
    <Name>HintText</Name>
    <Description>The text that should be displayed in the ui hint box</Description>
    <NeededProperty>Text</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>TutorialUiCategory</Name>
    <Description>The category of the tutorial that is used to reference phoenix objects</Description>
    <DataSet>TutorialUiCategory</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>RefGuid</Name>
    <Description>The RefGUID of the phoenix element that should be highlighted</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>RefGuidGamepad</Name>
    <NeededProperty>TutorialUiElement</NeededProperty>
    <ExportPlatforms>XBox;Playstation;Stadia</ExportPlatforms>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>ContextObject</Name>
    <ReadOnly>1</ReadOnly>
    <NeededProperty>Object</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>OnlyShowOnQuestObjects</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>AutoCreateAsset</DataType>
    <Name>ObjectFilter</Name>
    <AllowedTemplates>ObjectFilter</AllowedTemplates>
    <AllowedProperties/>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>HidePortrait</Name>
    <Description>Indicates whether the speech bubble should have a portrait or not (false = show portrait)</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UseSpecificPortrait</Name>
    <Description>Indicates whether a special portrait should be used for the hint. If false, the quest giver will be taken</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>SpecificPortraitProfile</Name>
    <Description>The profile asset of the portrait that should be displayed</Description>
    <NeededProperty>Profile</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>SpecifyHintColorType</Name>
    <Description>Indicates whether there should be a specific color for the background of the hint</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>HintColorType</Name>
    <Description>The specific (background) color of the hint </Description>
    <DataSet>TutorialUiHintColorType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>UseSmallPortrait</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>DeselectObjectOnClose</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>ScreenOpenConditionType</Name>
    <DataSet>TutorialConditionScreenType</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>ScreenOpenConditionFlow</Name>
    <Items>
      <ValueDefinition>
        <DataType>Choice</DataType>
        <Name>Screen</Name>
        <DataSet>TutorialConditionScreenType</DataSet>
      </ValueDefinition>
    </Items>
    <Description>Configure additional screens here that are also part of the flow.</Description>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<ConditionTutorialInteraction>
  <HintType>None</HintType>
  <ShowScrollHintWhenOffscreen>1</ShowScrollHintWhenOffscreen>
  <TutorialConditionType>Click</TutorialConditionType>
  <HintEndCondition>None</HintEndCondition>
  <HintAnchor>Top</HintAnchor>
  <HintText>0</HintText>
  <TutorialUiCategory>ConstructionMenu</TutorialUiCategory>
  <ContextObject>0</ContextObject>
  <ObjectFilter>
    <Template>ObjectFilter</Template>
    <Values>
      <ObjectFilter/>
    </Values>
  </ObjectFilter>
  <SpecificPortraitProfile>0</SpecificPortraitProfile>
  <HintColorType>Info</HintColorType>
  <ScreenOpenConditionType>ConstructionMenu</ScreenOpenConditionType>
  <ScreenOpenConditionFlow>ConstructionMenu</ScreenOpenConditionFlow>
  <ScreenOpenConditionFlow>Economy</ScreenOpenConditionFlow>
</ConditionTutorialInteraction>
```

Container-entry defaults:

```xml
<ConditionTutorialInteraction>
  <ScreenOpenConditionFlow>
    <Screen>ConstructionMenu</Screen>
  </ScreenOpenConditionFlow>
</ConditionTutorialInteraction>
```

</details>

<a id="property-emptyautocreatevalue"></a>
<details>
<summary>EmptyAutoCreateValue — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:8537.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>EmptyAutoCreateValue</Name>
</Property>
```

</details>

Explicit property defaults:

```xml
<EmptyAutoCreateValue/>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-locked"></a>
<details>
<summary>Locked — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:28805.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `DefaultLockedState` | Boolean |  |  |  |
| `Unpackable` | Boolean |  |  | Is the asset unpackable for the player and will need additional interaction |
| `DLCDependency` | Asset |  | NeededProperty=UplayProduct | Enter the DLC asset here, if this asset is only available with a DLC |
| `Scope` | Choice | [LockScope](#dataset-lockscope) |  |  |
| `VisibleWhenLocked` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>Locked</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>DefaultLockedState</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>Unpackable</Name>
    <Description>Is the asset unpackable for the player and will need additional interaction</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Asset</DataType>
    <Name>DLCDependency</Name>
    <Description>Enter the DLC asset here, if this asset is only available with a DLC</Description>
    <NeededProperty>UplayProduct</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>Scope</Name>
    <DataSet>LockScope</DataSet>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>VisibleWhenLocked</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<Locked>
  <DefaultLockedState>1</DefaultLockedState>
  <DLCDependency>0</DLCDependency>
  <Scope>Participant</Scope>
</Locked>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="property-sessionfilter"></a>
<details>
<summary>SessionFilter — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:821.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `AllowParentConditionSession` | Boolean |  |  | Allow the session of the parent condition (if any) to be an allowed session for this action |
| `AllowActiveSession` | Boolean |  | ReadOnly=1 | THIS IS CURRENTLY NOT IMPLEMENTED! Ask programming if you really need it! Allows the currently active session to be allowed for this action. |
| `AllowProcessingSession` | Boolean |  |  | Allow the processing session to be an allowed session for this action |
| `Sessions` | Vector |  |  |  |
| `Sessions/Item/Session` | Asset |  | NeededProperty=Session |  |
| `AllowQuestSession` | Boolean |  |  |  |
| `AllowQuestArea` | Boolean |  |  |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>SessionFilter</Name>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AllowParentConditionSession</Name>
    <Description>Allow the session of the parent condition (if any) to be an allowed session for this action</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AllowActiveSession</Name>
    <Description>THIS IS CURRENTLY NOT IMPLEMENTED! Ask programming if you really need it! Allows the currently active session to be allowed for this action.</Description>
    <ReadOnly>1</ReadOnly>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AllowProcessingSession</Name>
    <Description>Allow the processing session to be an allowed session for this action</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>Sessions</Name>
    <Items>
      <ValueDefinition>
        <DataType>Asset</DataType>
        <Name>Session</Name>
        <NeededProperty>Session</NeededProperty>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AllowQuestSession</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>AllowQuestArea</Name>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<SessionFilter>
  <AllowParentConditionSession>1</AllowParentConditionSession>
  <Sessions/>
</SessionFilter>
```

Container-entry defaults:

```xml
<SessionFilter>
  <Sessions>
    <Session>0</Session>
  </Sessions>
</SessionFilter>
```

</details>

<a id="property-standard"></a>
<details>
<summary>Standard — full structure, defaults and dataset links</summary>

Source: properties-toolone.xml:161.

| Field path | Type | Dataset | Restrictions and metadata | Native description |
| --- | --- | --- | --- | --- |
| `GUID` | Integer |  | IsProValue=1; ReadOnly=1 |  |
| `Name` | String |  |  | Internal name of the asset |
| `WikiPage` | String |  | Export=0; ShowInTextView=0; ExportHistory=0; Browsable=0 | Name of the page after https://wiki.related-designs.de/wiki/display/MMHO/ |
| `Creator` | String |  | Export=0; ShowInTextView=0; ExportHistory=0; ReadOnly=1 | Creator of this profile |
| `CreationTime` | String |  | Export=0; ShowInTextView=0; ExportHistory=0; ReadOnly=1 | time when this asset was created |
| `Comments` | Vector |  | Export=0; IsProValue=1; ExportHistory=0; ReadOnly=1 | List of comments for this asset |
| `Comments/Item/Date` | String |  | Export=0 |  |
| `Comments/Item/User` | String |  | Export=0 |  |
| `Comments/Item/Comment` | String |  | Export=0 |  |
| `LastChangeUser` | String |  | Export=0; ShowInTextView=0; ExportHistory=0; ReadOnly=1 | user who made the last change |
| `LastChangeTime` | String |  | Export=0; ShowInTextView=0; ExportHistory=0; ReadOnly=1 | last time when this asset was changed |
| `IconFilename` | FileName |  |  |  |
| `ID` | String |  | Category= Standard; ShowInTextView=0; CopyAssetValue=0 | ID used to identify this GUID. A constant int will be generated which can be used by programmers |
| `Comment` | String |  | Export=0 | Comment used to describe this asset |
| `InfoDescription` | Text |  | NeededProperty=Text | Description fluff of the object, used with [ToolOneHelper InfoDescription([RefGuid])] |
| `GraphViewConfig` | String |  | Export=0; ShowInTextView=0 | The GraphView config to use when opening this asset in the graph view |
| `InheritIconFromParent` | Boolean |  | Export=0; ShowInTextView=0 |  |
| `Version` | Choice | [VersionType](#dataset-versiontype) | Export=0 |  |

<details>
<summary>Exact native property schema</summary>

```xml
<Property>
  <Name>Standard</Name>
  <ValueDefinition>
    <DataType>Integer</DataType>
    <Name>GUID</Name>
    <IsProValue>1</IsProValue>
    <ReadOnly>1</ReadOnly>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>Name</Name>
    <Description>Internal name of the asset</Description>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>WikiPage</Name>
    <Description>Name of the page after https://wiki.related-designs.de/wiki/display/MMHO/</Description>
    <Export>0</Export>
    <ShowInTextView>0</ShowInTextView>
    <ExportHistory>0</ExportHistory>
    <Browsable>0</Browsable>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>Creator</Name>
    <Description>Creator of this profile</Description>
    <Export>0</Export>
    <ShowInTextView>0</ShowInTextView>
    <ExportHistory>0</ExportHistory>
    <ReadOnly>1</ReadOnly>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>CreationTime</Name>
    <Description>time when this asset was created</Description>
    <Export>0</Export>
    <ShowInTextView>0</ShowInTextView>
    <ExportHistory>0</ExportHistory>
    <ReadOnly>1</ReadOnly>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Vector</DataType>
    <Name>Comments</Name>
    <Description>List of comments for this asset</Description>
    <Export>0</Export>
    <IsProValue>1</IsProValue>
    <ExportHistory>0</ExportHistory>
    <ReadOnly>1</ReadOnly>
    <Items>
      <ValueDefinition>
        <DataType>String</DataType>
        <Name>Date</Name>
        <Export>0</Export>
      </ValueDefinition>
      <ValueDefinition>
        <DataType>String</DataType>
        <Name>User</Name>
        <Export>0</Export>
      </ValueDefinition>
      <ValueDefinition>
        <DataType>String</DataType>
        <Name>Comment</Name>
        <Export>0</Export>
      </ValueDefinition>
    </Items>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>LastChangeUser</Name>
    <Description>user who made the last change</Description>
    <Export>0</Export>
    <ShowInTextView>0</ShowInTextView>
    <ExportHistory>0</ExportHistory>
    <ReadOnly>1</ReadOnly>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>LastChangeTime</Name>
    <Description>last time when this asset was changed</Description>
    <Export>0</Export>
    <ShowInTextView>0</ShowInTextView>
    <ExportHistory>0</ExportHistory>
    <ReadOnly>1</ReadOnly>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>FileName</DataType>
    <Name>IconFilename</Name>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>ID</Name>
    <Description>ID used to identify this GUID. A constant int will be generated which can be used by programmers</Description>
    <Category> Standard</Category>
    <ShowInTextView>0</ShowInTextView>
    <CopyAssetValue>0</CopyAssetValue>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>Comment</Name>
    <Description>Comment used to describe this asset</Description>
    <Export>0</Export>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Text</DataType>
    <Name>InfoDescription</Name>
    <Description>Description fluff of the object, used with [ToolOneHelper InfoDescription([RefGuid])]</Description>
    <NeededProperty>Text</NeededProperty>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>String</DataType>
    <Name>GraphViewConfig</Name>
    <Description>The GraphView config to use when opening this asset in the graph view</Description>
    <Export>0</Export>
    <ShowInTextView>0</ShowInTextView>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Boolean</DataType>
    <Name>InheritIconFromParent</Name>
    <Export>0</Export>
    <ShowInTextView>0</ShowInTextView>
  </ValueDefinition>
  <ValueDefinition>
    <DataType>Choice</DataType>
    <Name>Version</Name>
    <Export>0</Export>
    <DataSet>VersionType</DataSet>
  </ValueDefinition>
</Property>
```

</details>

Explicit property defaults:

```xml
<Standard>
  <Comments/>
  <InfoDescription>0</InfoDescription>
  <Version>main</Version>
</Standard>
```

Container-entry defaults:

No explicit serialized container-entry default.

</details>

<a id="native-template-overrides"></a>
### Native template overrides

These are the full exported template definitions for the 91 catalogue entries and the native trigger/action templates displayed in the learning examples. Nested IsBaseAutoCreateAsset uses the inherited embedded definition. Template names with no direct Condition property belong to their own owning/action/objective role. Custom mod conditions, such as the Harlow helper, are explained in the real-case section and are not silently presented as native templates.

<a id="template-actiondelayedactions"></a>
<details>
<summary>ActionDelayedActions — exact template property overrides</summary>

Source: templates.xml:96. Property blocks: [Action](#property-action), [ActionDelayedActions](#property-actiondelayedactions).

```xml
<Template>
  <Name>ActionDelayedActions</Name>
  <Properties>
    <Action/>
    <ActionDelayedActions>
      <DelayedActions>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <ActionList/>
        </Values>
      </DelayedActions>
    </ActionDelayedActions>
  </Properties>
</Template>
```

</details>

<a id="template-actiondeleteobjects"></a>
<details>
<summary>ActionDeleteObjects — exact template property overrides</summary>

Source: templates.xml:117. Property blocks: [Action](#property-action), [ActionDeleteObjects](#property-actiondeleteobjects), [ObjectFilter](#property-objectfilter).

```xml
<Template>
  <Name>ActionDeleteObjects</Name>
  <Properties>
    <Action/>
    <ActionDeleteObjects/>
    <ObjectFilter/>
  </Properties>
</Template>
```

</details>

<a id="template-actionexecutescript"></a>
<details>
<summary>ActionExecuteScript — exact template property overrides</summary>

Source: templates.xml:219. Property blocks: [Action](#property-action), [ActionExecuteScript](#property-actionexecutescript).

```xml
<Template>
  <Name>ActionExecuteScript</Name>
  <Properties>
    <Action/>
    <ActionExecuteScript/>
  </Properties>
</Template>
```

</details>

<a id="template-actionlockasset"></a>
<details>
<summary>ActionLockAsset — exact template property overrides</summary>

Source: templates.xml:267. Property blocks: [Action](#property-action), [ActionLockAsset](#property-actionlockasset).

```xml
<Template>
  <Name>ActionLockAsset</Name>
  <Properties>
    <Action/>
    <ActionLockAsset/>
  </Properties>
</Template>
```

</details>

<a id="template-actionplaymovie"></a>
<details>
<summary>ActionPlayMovie — exact template property overrides</summary>

Source: templates.xml:362. Property blocks: [Action](#property-action), [ActionPlayMovie](#property-actionplaymovie).

```xml
<Template>
  <Name>ActionPlayMovie</Name>
  <Properties>
    <Action/>
    <ActionPlayMovie/>
  </Properties>
</Template>
```

</details>

<a id="template-actionregistertrigger"></a>
<details>
<summary>ActionRegisterTrigger — exact template property overrides</summary>

Source: templates.xml:383. Property blocks: [Action](#property-action), [ActionRegisterTrigger](#property-actionregistertrigger).

```xml
<Template>
  <Name>ActionRegisterTrigger</Name>
  <IsExpertTemplate>1</IsExpertTemplate>
  <Properties>
    <Action/>
    <ActionRegisterTrigger/>
  </Properties>
</Template>
```

</details>

<a id="template-actionresettrigger"></a>
<details>
<summary>ActionResetTrigger — exact template property overrides</summary>

Source: templates.xml:439. Property blocks: [Action](#property-action), [ActionResetTrigger](#property-actionresettrigger).

```xml
<Template>
  <Name>ActionResetTrigger</Name>
  <Properties>
    <Action/>
    <ActionResetTrigger/>
  </Properties>
</Template>
```

</details>

<a id="template-actionsetobjectguid"></a>
<details>
<summary>ActionSetObjectGUID — exact template property overrides</summary>

Source: templates.xml:496. Property blocks: [Action](#property-action), [ObjectFilter](#property-objectfilter), [ActionSetObjectGUID](#property-actionsetobjectguid).

```xml
<Template>
  <Name>ActionSetObjectGUID</Name>
  <Properties>
    <Action/>
    <ObjectFilter/>
    <ActionSetObjectGUID/>
  </Properties>
</Template>
```

</details>

<a id="template-actionunlockasset"></a>
<details>
<summary>ActionUnlockAsset — exact template property overrides</summary>

Source: templates.xml:701. Property blocks: [Action](#property-action), [ActionUnlockAsset](#property-actionunlockasset).

```xml
<Template>
  <Name>ActionUnlockAsset</Name>
  <IsExpertTemplate>1</IsExpertTemplate>
  <Properties>
    <Action/>
    <ActionUnlockAsset/>
  </Properties>
</Template>
```

</details>

<a id="template-autocreatetrigger"></a>
<details>
<summary>AutoCreateTrigger — exact template property overrides</summary>

Source: templates.xml:3154. Property blocks: [Trigger](#property-trigger).

```xml
<Template>
  <Name>AutoCreateTrigger</Name>
  <IsExpertTemplate>1</IsExpertTemplate>
  <Properties>
    <Trigger>
      <TriggerCondition>
        <Template>ConditionAlwaysTrue</Template>
        <Values>
          <Condition/>
          <ConditionAlwaysTrue/>
        </Values>
      </TriggerCondition>
      <ResetTrigger>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <EmptyAutoCreateValue/>
        </Values>
      </ResetTrigger>
    </Trigger>
  </Properties>
</Template>
```

</details>

<a id="template-conditionactiveregion"></a>
<details>
<summary>ConditionActiveRegion — exact template property overrides</summary>

Source: templates.xml:932. Property blocks: [Condition](#property-condition), [ConditionActiveRegion](#property-conditionactiveregion).

```xml
<Template>
  <Name>ConditionActiveRegion</Name>
  <Properties>
    <Condition/>
    <ConditionActiveRegion/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionactivesession"></a>
<details>
<summary>ConditionActiveSession — exact template property overrides</summary>

Source: templates.xml:939. Property blocks: [Condition](#property-condition), [ConditionActiveSession](#property-conditionactivesession).

```xml
<Template>
  <Name>ConditionActiveSession</Name>
  <IsExpertTemplate>1</IsExpertTemplate>
  <Properties>
    <Condition/>
    <ConditionActiveSession/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionalwaysfalse"></a>
<details>
<summary>ConditionAlwaysFalse — exact template property overrides</summary>

Source: templates.xml:947. Property blocks: [Condition](#property-condition), [ConditionAlwaysFalse](#property-conditionalwaysfalse).

```xml
<Template>
  <Name>ConditionAlwaysFalse</Name>
  <Properties>
    <Condition/>
    <ConditionAlwaysFalse/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionalwaystrue"></a>
<details>
<summary>ConditionAlwaysTrue — exact template property overrides</summary>

Source: templates.xml:954. Property blocks: [Condition](#property-condition), [ConditionAlwaysTrue](#property-conditionalwaystrue).

```xml
<Template>
  <Name>ConditionAlwaysTrue</Name>
  <IsExpertTemplate>1</IsExpertTemplate>
  <Properties>
    <Condition/>
    <ConditionAlwaysTrue/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionareaclaimed"></a>
<details>
<summary>ConditionAreaClaimed — exact template property overrides</summary>

Source: templates.xml:962. Property blocks: [Condition](#property-condition), [ConditionAreaClaimed](#property-conditionareaclaimed).

```xml
<Template>
  <Name>ConditionAreaClaimed</Name>
  <Properties>
    <Condition/>
    <ConditionAreaClaimed>
      <Claimed>1</Claimed>
    </ConditionAreaClaimed>
  </Properties>
</Template>
```

</details>

<a id="template-conditionattractiveness"></a>
<details>
<summary>ConditionAttractiveness — exact template property overrides</summary>

Source: templates.xml:971. Property blocks: [Condition](#property-condition), [ConditionAttractiveness](#property-conditionattractiveness).

```xml
<Template>
  <Name>ConditionAttractiveness</Name>
  <Properties>
    <Condition/>
    <ConditionAttractiveness/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionbuildingsinblueprintmode"></a>
<details>
<summary>ConditionBuildingsInBlueprintmode — exact template property overrides</summary>

Source: templates.xml:978. Property blocks: [Condition](#property-condition), [ConditionBuildingsInBlueprintmode](#property-conditionbuildingsinblueprintmode).

```xml
<Template>
  <Name>ConditionBuildingsInBlueprintmode</Name>
  <Properties>
    <Condition/>
    <ConditionBuildingsInBlueprintmode/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionburningobject"></a>
<details>
<summary>ConditionBurningObject — exact template property overrides</summary>

Source: templates.xml:985. Property blocks: [Condition](#property-condition), [ConditionBurningObject](#property-conditionburningobject).

```xml
<Template>
  <Name>ConditionBurningObject</Name>
  <Properties>
    <Condition/>
    <ConditionBurningObject/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionbusactivationneedsaturation"></a>
<details>
<summary>ConditionBusActivationNeedSaturation — exact template property overrides</summary>

Source: templates.xml:992. Property blocks: [Condition](#property-condition), [ObjectFilter](#property-objectfilter), [ConditionBusActivationNeedSaturation](#property-conditionbusactivationneedsaturation).

```xml
<Template>
  <Name>ConditionBusActivationNeedSaturation</Name>
  <Properties>
    <Condition/>
    <ObjectFilter>
      <ObjectGUID>601445</ObjectGUID>
      <CheckParticipantID>1</CheckParticipantID>
      <CheckProcessingParticipantID>1</CheckProcessingParticipantID>
    </ObjectFilter>
    <ConditionBusActivationNeedSaturation>
      <NeedsRangeOP>All</NeedsRangeOP>
    </ConditionBusActivationNeedSaturation>
  </Properties>
</Template>
```

</details>

<a id="template-conditioncameramovement"></a>
<details>
<summary>ConditionCameraMovement — exact template property overrides</summary>

Source: templates.xml:1006. Property blocks: [Condition](#property-condition), [ConditionCameraMovement](#property-conditioncameramovement).

```xml
<Template>
  <Name>ConditionCameraMovement</Name>
  <Properties>
    <Condition/>
    <ConditionCameraMovement>
      <CameraMovementActionToTrack/>
    </ConditionCameraMovement>
  </Properties>
</Template>
```

</details>

<a id="template-conditioncorporationdifficulty"></a>
<details>
<summary>ConditionCorporationDifficulty — exact template property overrides</summary>

Source: templates.xml:1015. Property blocks: [Condition](#property-condition), [ConditionCorporationDifficulty](#property-conditioncorporationdifficulty).

```xml
<Template>
  <Name>ConditionCorporationDifficulty</Name>
  <Properties>
    <Condition/>
    <ConditionCorporationDifficulty>
      <Difficulty>Easy;Normal;Hard;Classic</Difficulty>
      <DifficultyConstructionCostRefund>Full;Half;None;PayCredits</DifficultyConstructionCostRefund>
      <DifficultyLossCondition>BailoutWithSlowLiquidation;BailoutWithFastLiquidation;Bankrupt</DifficultyLossCondition>
      <DifficultyOptionalQuestFrequency>Often;Normal;Rare</DifficultyOptionalQuestFrequency>
      <DifficultyOptionalQuestRewards>Plenty;Medium;Spare;PennyPinching</DifficultyOptionalQuestRewards>
      <DifficultyRelocateBuildings>On;Off;PayCredits</DifficultyRelocateBuildings>
      <DifficultyRevenue>Plenty;Medium;Spare</DifficultyRevenue>
      <DifficultyStartCredits>Plenty;Medium;Spare</DifficultyStartCredits>
      <DifficultyStartShips>None;OneShip;TradeFleet;WarFleet</DifficultyStartShips>
      <DifficultyStartWithKontor>Off;Standard;Full</DifficultyStartWithKontor>
    </ConditionCorporationDifficulty>
  </Properties>
</Template>
```

</details>

<a id="template-conditiondecision"></a>
<details>
<summary>ConditionDecision — exact template property overrides</summary>

Source: templates.xml:1033. Property blocks: [Condition](#property-condition), [ConditionDecision](#property-conditiondecision).

```xml
<Template>
  <Name>ConditionDecision</Name>
  <Properties>
    <Condition/>
    <ConditionDecision/>
  </Properties>
</Template>
```

</details>

<a id="template-conditiondecisionoption"></a>
<details>
<summary>ConditionDecisionOption — exact template property overrides</summary>

Source: templates.xml:1040. Property blocks: [Condition](#property-condition), [ConditionDecisionOption](#property-conditiondecisionoption).

```xml
<Template>
  <Name>ConditionDecisionOption</Name>
  <Properties>
    <Condition/>
    <ConditionDecisionOption>
      <ActionList>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <ActionList/>
        </Values>
      </ActionList>
      <DecisionNotification>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <CharacterNotification/>
          <BaseNotification/>
          <NotificationSubtitle/>
        </Values>
      </DecisionNotification>
    </ConditionDecisionOption>
  </Properties>
</Template>
```

</details>

<a id="template-conditiondiplomaticstate"></a>
<details>
<summary>ConditionDiplomaticState — exact template property overrides</summary>

Source: templates.xml:1062. Property blocks: [Condition](#property-condition), [ConditionDiplomaticState](#property-conditiondiplomaticstate), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionDiplomaticState</Name>
  <Properties>
    <Condition/>
    <ConditionDiplomaticState/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditiondiplomaticstatechanged"></a>
<details>
<summary>ConditionDiplomaticStateChanged — exact template property overrides</summary>

Source: templates.xml:1070. Property blocks: [Condition](#property-condition), [ConditionDiplomaticStateChanged](#property-conditiondiplomaticstatechanged).

```xml
<Template>
  <Name>ConditionDiplomaticStateChanged</Name>
  <Properties>
    <Condition/>
    <ConditionDiplomaticStateChanged/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionevaluatetextsource"></a>
<details>
<summary>ConditionEvaluateTextSource — exact template property overrides</summary>

Source: templates.xml:1077. Property blocks: [Condition](#property-condition), [ConditionEvaluateTextSource](#property-conditionevaluatetextsource), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionEvaluateTextSource</Name>
  <Properties>
    <Condition/>
    <ConditionEvaluateTextSource/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionevent"></a>
<details>
<summary>ConditionEvent — exact template property overrides</summary>

Source: templates.xml:1085. Property blocks: [Condition](#property-condition), [ConditionEvent](#property-conditionevent), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionEvent</Name>
  <IsExpertTemplate>1</IsExpertTemplate>
  <Properties>
    <Condition/>
    <ConditionEvent>
      <ContextAssetInfolayer>2001386</ContextAssetInfolayer>
      <EventCount>1</EventCount>
    </ConditionEvent>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionexpeditionfinished"></a>
<details>
<summary>ConditionExpeditionFinished — exact template property overrides</summary>

Source: templates.xml:1097. Property blocks: [Condition](#property-condition), [ConditionExpeditionFinished](#property-conditionexpeditionfinished).

```xml
<Template>
  <Name>ConditionExpeditionFinished</Name>
  <Properties>
    <Condition/>
    <ConditionExpeditionFinished/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionexportgoodsleveled"></a>
<details>
<summary>ConditionExportGoodsLeveled — exact template property overrides</summary>

Source: templates.xml:1104. Property blocks: [Condition](#property-condition), [ConditionExportGoodsLeveled](#property-conditionexportgoodsleveled).

```xml
<Template>
  <Name>ConditionExportGoodsLeveled</Name>
  <Properties>
    <Condition/>
    <ConditionExportGoodsLeveled/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionfactoryproductivity"></a>
<details>
<summary>ConditionFactoryProductivity — exact template property overrides</summary>

Source: templates.xml:1111. Property blocks: [Condition](#property-condition), [ConditionFactoryProductivity](#property-conditionfactoryproductivity), [ObjectFilter](#property-objectfilter).

```xml
<Template>
  <Name>ConditionFactoryProductivity</Name>
  <Properties>
    <Condition/>
    <ConditionFactoryProductivity/>
    <ObjectFilter/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionfestival"></a>
<details>
<summary>ConditionFestival — exact template property overrides</summary>

Source: templates.xml:1119. Property blocks: [Condition](#property-condition), [ConditionFestival](#property-conditionfestival).

```xml
<Template>
  <Name>ConditionFestival</Name>
  <Properties>
    <Condition/>
    <ConditionFestival/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionfiniteresource"></a>
<details>
<summary>ConditionFiniteResource — exact template property overrides</summary>

Source: templates.xml:1126. Property blocks: [Condition](#property-condition), [ConditionFiniteResource](#property-conditionfiniteresource).

```xml
<Template>
  <Name>ConditionFiniteResource</Name>
  <Properties>
    <Condition/>
    <ConditionFiniteResource/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionfirsttimeeventhappened"></a>
<details>
<summary>ConditionFirstTimeEventHappened — exact template property overrides</summary>

Source: templates.xml:1133. Property blocks: [Condition](#property-condition), [ConditionFirstTimeEventHappened](#property-conditionfirsttimeeventhappened).

```xml
<Template>
  <Name>ConditionFirstTimeEventHappened</Name>
  <Properties>
    <Condition/>
    <ConditionFirstTimeEventHappened/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionguievent"></a>
<details>
<summary>ConditionGUIEvent — exact template property overrides</summary>

Source: templates.xml:1154. Property blocks: [Condition](#property-condition), [ConditionGUIEvent](#property-conditionguievent).

```xml
<Template>
  <Name>ConditionGUIEvent</Name>
  <Properties>
    <Condition/>
    <ConditionGUIEvent/>
  </Properties>
</Template>
```

</details>

<a id="template-conditiongameended"></a>
<details>
<summary>ConditionGameEnded — exact template property overrides</summary>

Source: templates.xml:1140. Property blocks: [Condition](#property-condition), [ConditionGameEnded](#property-conditiongameended).

```xml
<Template>
  <Name>ConditionGameEnded</Name>
  <Properties>
    <Condition/>
    <ConditionGameEnded/>
  </Properties>
</Template>
```

</details>

<a id="template-conditiongamepadaction"></a>
<details>
<summary>ConditionGamePadAction — exact template property overrides</summary>

Source: templates.xml:1147. Property blocks: [Condition](#property-condition), [ConditionGamePadAction](#property-conditiongamepadaction).

```xml
<Template>
  <Name>ConditionGamePadAction</Name>
  <Properties>
    <Condition/>
    <ConditionGamePadAction/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionhaciendadecreesactive"></a>
<details>
<summary>ConditionHaciendaDecreesActive — exact template property overrides</summary>

Source: templates.xml:1161. Property blocks: [Condition](#property-condition), [ConditionHaciendaDecreesActive](#property-conditionhaciendadecreesactive), [ObjectFilter](#property-objectfilter).

```xml
<Template>
  <Name>ConditionHaciendaDecreesActive</Name>
  <Properties>
    <Condition/>
    <ConditionHaciendaDecreesActive/>
    <ObjectFilter/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionhaciendamodulecount"></a>
<details>
<summary>ConditionHaciendaModuleCount — exact template property overrides</summary>

Source: templates.xml:1169. Property blocks: [Condition](#property-condition), [ConditionHaciendaModuleCount](#property-conditionhaciendamodulecount).

```xml
<Template>
  <Name>ConditionHaciendaModuleCount</Name>
  <Properties>
    <Condition/>
    <ConditionHaciendaModuleCount/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionhappinessmood"></a>
<details>
<summary>ConditionHappinessMood — exact template property overrides</summary>

Source: templates.xml:1176. Property blocks: [Condition](#property-condition), [ConditionHappinessMood](#property-conditionhappinessmood).

```xml
<Template>
  <Name>ConditionHappinessMood</Name>
  <Properties>
    <Condition/>
    <ConditionHappinessMood/>
  </Properties>
</Template>
```

</details>

<a id="template-conditioninpalacerange"></a>
<details>
<summary>ConditionInPalaceRange — exact template property overrides</summary>

Source: templates.xml:1183. Property blocks: [Condition](#property-condition), [ConditionInPalaceRange](#property-conditioninpalacerange).

```xml
<Template>
  <Name>ConditionInPalaceRange</Name>
  <Properties>
    <Condition/>
    <ConditionInPalaceRange/>
  </Properties>
</Template>
```

</details>

<a id="template-conditioninstorage"></a>
<details>
<summary>ConditionInStorage — exact template property overrides</summary>

Source: templates.xml:1190. Property blocks: [Condition](#property-condition), [ConditionInStorage](#property-conditioninstorage), [ObjectFilter](#property-objectfilter).

```xml
<Template>
  <Name>ConditionInStorage</Name>
  <Properties>
    <Condition/>
    <ConditionInStorage/>
    <ObjectFilter/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionirrigatedmodules"></a>
<details>
<summary>ConditionIrrigatedModules — exact template property overrides</summary>

Source: templates.xml:1198. Property blocks: [Condition](#property-condition), [ConditionIrrigatedModules](#property-conditionirrigatedmodules), [ObjectFilter](#property-objectfilter).

```xml
<Template>
  <Name>ConditionIrrigatedModules</Name>
  <Properties>
    <Condition/>
    <ConditionIrrigatedModules/>
    <ObjectFilter/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionirrigationcapacityexceeded"></a>
<details>
<summary>ConditionIrrigationCapacityExceeded — exact template property overrides</summary>

Source: templates.xml:1206. Property blocks: [Condition](#property-condition), [ConditionIrrigationCapacityExceeded](#property-conditionirrigationcapacityexceeded).

```xml
<Template>
  <Name>ConditionIrrigationCapacityExceeded</Name>
  <Properties>
    <Condition/>
    <ConditionIrrigationCapacityExceeded/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionisbuffed"></a>
<details>
<summary>ConditionIsBuffed — exact template property overrides</summary>

Source: templates.xml:1213. Property blocks: [Condition](#property-condition), [ObjectFilter](#property-objectfilter), [ConditionIsBuffed](#property-conditionisbuffed), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionIsBuffed</Name>
  <Properties>
    <Condition/>
    <ObjectFilter/>
    <ConditionIsBuffed/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditioniscampaign"></a>
<details>
<summary>ConditionIsCampaign — exact template property overrides</summary>

Source: templates.xml:1222. Property blocks: [ConditionPropsNegatable](#property-conditionpropsnegatable), [ConditionIsCampaign](#property-conditioniscampaign), [Condition](#property-condition).

```xml
<Template>
  <Name>ConditionIsCampaign</Name>
  <Properties>
    <ConditionPropsNegatable/>
    <ConditionIsCampaign/>
    <Condition/>
  </Properties>
</Template>
```

</details>

<a id="template-conditioniscraftinginprogress"></a>
<details>
<summary>ConditionIsCraftingInProgress — exact template property overrides</summary>

Source: templates.xml:1230. Property blocks: [Condition](#property-condition), [ConditionIsCraftingInProgress](#property-conditioniscraftinginprogress).

```xml
<Template>
  <Name>ConditionIsCraftingInProgress</Name>
  <Properties>
    <Condition/>
    <ConditionIsCraftingInProgress/>
  </Properties>
</Template>
```

</details>

<a id="template-conditioniscreativemode"></a>
<details>
<summary>ConditionIsCreativeMode — exact template property overrides</summary>

Source: templates.xml:1237. Property blocks: [ConditionPropsNegatable](#property-conditionpropsnegatable), [Condition](#property-condition), [ConditionIsCreativeMode](#property-conditioniscreativemode).

```xml
<Template>
  <Name>ConditionIsCreativeMode</Name>
  <Properties>
    <ConditionPropsNegatable/>
    <Condition/>
    <ConditionIsCreativeMode/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionisdlcactive"></a>
<details>
<summary>ConditionIsDLCActive — exact template property overrides</summary>

Source: templates.xml:1254. Property blocks: [Condition](#property-condition), [ConditionIsDLCActive](#property-conditionisdlcactive), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionIsDLCActive</Name>
  <Properties>
    <Condition/>
    <ConditionIsDLCActive/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionisdiscovered"></a>
<details>
<summary>ConditionIsDiscovered — exact template property overrides</summary>

Source: templates.xml:1245. Property blocks: [Condition](#property-condition), [ParticipantRelation](#property-participantrelation), [ConditionIsDiscovered](#property-conditionisdiscovered), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionIsDiscovered</Name>
  <Properties>
    <Condition/>
    <ParticipantRelation/>
    <ConditionIsDiscovered/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionisdocklandsexportpyramidfull"></a>
<details>
<summary>ConditionIsDocklandsExportPyramidFull — exact template property overrides</summary>

Source: templates.xml:1262. Property blocks: [Condition](#property-condition), [ConditionIsDocklandsExportPyramidFull](#property-conditionisdocklandsexportpyramidfull).

```xml
<Template>
  <Name>ConditionIsDocklandsExportPyramidFull</Name>
  <Properties>
    <Condition/>
    <ConditionIsDocklandsExportPyramidFull/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionisgamepadmode"></a>
<details>
<summary>ConditionIsGamepadMode — exact template property overrides</summary>

Source: templates.xml:1269. Property blocks: [Condition](#property-condition), [ConditionIsGamepadMode](#property-conditionisgamepadmode), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionIsGamepadMode</Name>
  <Properties>
    <Condition/>
    <ConditionIsGamepadMode/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionisindustrialized"></a>
<details>
<summary>ConditionIsIndustrialized — exact template property overrides</summary>

Source: templates.xml:1277. Property blocks: [Condition](#property-condition), [ConditionIsIndustrialized](#property-conditionisindustrialized), [ObjectFilter](#property-objectfilter).

```xml
<Template>
  <Name>ConditionIsIndustrialized</Name>
  <Properties>
    <Condition/>
    <ConditionIsIndustrialized/>
    <ObjectFilter/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionismultiplayer"></a>
<details>
<summary>ConditionIsMultiplayer — exact template property overrides</summary>

Source: templates.xml:1303. Property blocks: [Condition](#property-condition), [ConditionIsMultiplayer](#property-conditionismultiplayer), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionIsMultiplayer</Name>
  <Properties>
    <Condition/>
    <ConditionIsMultiplayer/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionisparticipantingame"></a>
<details>
<summary>ConditionIsParticipantInGame — exact template property overrides</summary>

Source: templates.xml:1311. Property blocks: [Condition](#property-condition), [ConditionIsParticipantInGame](#property-conditionisparticipantingame), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionIsParticipantInGame</Name>
  <Properties>
    <Condition/>
    <ConditionIsParticipantInGame/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionispaused"></a>
<details>
<summary>ConditionIsPaused — exact template property overrides</summary>

Source: templates.xml:1319. Property blocks: [Condition](#property-condition), [ConditionIsPaused](#property-conditionispaused), [ObjectFilter](#property-objectfilter).

```xml
<Template>
  <Name>ConditionIsPaused</Name>
  <Properties>
    <Condition/>
    <ConditionIsPaused/>
    <ObjectFilter/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionistutorial"></a>
<details>
<summary>ConditionIsTutorial — exact template property overrides</summary>

Source: templates.xml:1327. Property blocks: [Condition](#property-condition), [ConditionIsTutorial](#property-conditionistutorial), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionIsTutorial</Name>
  <Properties>
    <Condition/>
    <ConditionIsTutorial/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionislandsdiscovered"></a>
<details>
<summary>ConditionIslandsDiscovered — exact template property overrides</summary>

Source: templates.xml:1285. Property blocks: [Condition](#property-condition), [ConditionIslandsDiscovered](#property-conditionislandsdiscovered).

```xml
<Template>
  <Name>ConditionIslandsDiscovered</Name>
  <Properties>
    <Condition/>
    <ConditionIslandsDiscovered>
      <IslandsDiscoveredScope>Global</IslandsDiscoveredScope>
    </ConditionIslandsDiscovered>
  </Properties>
</Template>
```

</details>

<a id="template-conditionislandswithfertility"></a>
<details>
<summary>ConditionIslandsWithFertility — exact template property overrides</summary>

Source: templates.xml:1294. Property blocks: [Condition](#property-condition), [ConditionIslandsWithFertility](#property-conditionislandswithfertility).

```xml
<Template>
  <Name>ConditionIslandsWithFertility</Name>
  <Properties>
    <Condition/>
    <ConditionIslandsWithFertility>
      <IslandScope>Global</IslandScope>
    </ConditionIslandsWithFertility>
  </Properties>
</Template>
```

</details>

<a id="template-conditionmetagameloaded"></a>
<details>
<summary>ConditionMetagameLoaded — exact template property overrides</summary>

Source: templates.xml:1335. Property blocks: [Condition](#property-condition), [ConditionMetagameLoaded](#property-conditionmetagameloaded).

```xml
<Template>
  <Name>ConditionMetagameLoaded</Name>
  <Properties>
    <Condition/>
    <ConditionMetagameLoaded/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionmodulecount"></a>
<details>
<summary>ConditionModuleCount — exact template property overrides</summary>

Source: templates.xml:1342. Property blocks: [Condition](#property-condition), [ObjectFilter](#property-objectfilter), [ConditionModuleCount](#property-conditionmodulecount).

```xml
<Template>
  <Name>ConditionModuleCount</Name>
  <Properties>
    <Condition/>
    <ObjectFilter/>
    <ConditionModuleCount/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionmonoculture"></a>
<details>
<summary>ConditionMonoCulture — exact template property overrides</summary>

Source: templates.xml:1350. Property blocks: [Condition](#property-condition), [ConditionMonoCulture](#property-conditionmonoculture).

```xml
<Template>
  <Name>ConditionMonoCulture</Name>
  <Properties>
    <Condition/>
    <ConditionMonoCulture/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionmonumenteventactive"></a>
<details>
<summary>ConditionMonumentEventActive — exact template property overrides</summary>

Source: templates.xml:1357. Property blocks: [Condition](#property-condition), [ConditionMonumentEventsActive](#property-conditionmonumenteventsactive).

```xml
<Template>
  <Name>ConditionMonumentEventActive</Name>
  <Properties>
    <Condition/>
    <ConditionMonumentEventsActive/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionmonumentprogress"></a>
<details>
<summary>ConditionMonumentProgress — exact template property overrides</summary>

Source: templates.xml:1364. Property blocks: [Condition](#property-condition), [ConditionMonumentProgress](#property-conditionmonumentprogress), [ObjectFilter](#property-objectfilter).

```xml
<Template>
  <Name>ConditionMonumentProgress</Name>
  <Properties>
    <Condition/>
    <ConditionMonumentProgress/>
    <ObjectFilter/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionmovevehicle"></a>
<details>
<summary>ConditionMoveVehicle — exact template property overrides</summary>

Source: templates.xml:1372. Property blocks: [Condition](#property-condition), [ConditionMoveVehicle](#property-conditionmovevehicle), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings).

```xml
<Template>
  <Name>ConditionMoveVehicle</Name>
  <IsExpertTemplate>1</IsExpertTemplate>
  <Properties>
    <Condition/>
    <ConditionMoveVehicle>
      <MoveVehicleTargetDistance>20</MoveVehicleTargetDistance>
    </ConditionMoveVehicle>
    <ConditionPropsSessionSettings/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionmutualareainsubconditions"></a>
<details>
<summary>ConditionMutualAreaInSubconditions — exact template property overrides</summary>

Source: templates.xml:1383. Property blocks: [Condition](#property-condition), [ConditionMutualAreaInSubconditions](#property-conditionmutualareainsubconditions).

```xml
<Template>
  <Name>ConditionMutualAreaInSubconditions</Name>
  <Properties>
    <Condition/>
    <ConditionMutualAreaInSubconditions>
      <UseParentValues>1</UseParentValues>
    </ConditionMutualAreaInSubconditions>
  </Properties>
</Template>
```

</details>

<a id="template-conditionnewspaperpossible"></a>
<details>
<summary>ConditionNewspaperPossible — exact template property overrides</summary>

Source: templates.xml:1392. Property blocks: [Condition](#property-condition), [ConditionNewspaperPossible](#property-conditionnewspaperpossible).

```xml
<Template>
  <Name>ConditionNewspaperPossible</Name>
  <Properties>
    <Condition/>
    <ConditionNewspaperPossible/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionnewspaperpublished"></a>
<details>
<summary>ConditionNewspaperPublished — exact template property overrides</summary>

Source: templates.xml:1399. Property blocks: [Condition](#property-condition), [ConditionNewspaperPublished](#property-conditionnewspaperpublished).

```xml
<Template>
  <Name>ConditionNewspaperPublished</Name>
  <Properties>
    <Condition/>
    <ConditionNewspaperPublished/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionobjhpcheck"></a>
<details>
<summary>ConditionObjHPCheck — exact template property overrides</summary>

Source: templates.xml:1430. Property blocks: [Condition](#property-condition), [ConditionObjHPCheck](#property-conditionobjhpcheck).

```xml
<Template>
  <Name>ConditionObjHPCheck</Name>
  <Properties>
    <Condition/>
    <ConditionObjHPCheck/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionobjectposition"></a>
<details>
<summary>ConditionObjectPosition — exact template property overrides</summary>

Source: templates.xml:1406. Property blocks: [Condition](#property-condition), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings), [ConditionObjectPosition](#property-conditionobjectposition), [ObjectFilter](#property-objectfilter), [ObjectTargetFilter](#property-objecttargetfilter), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionObjectPosition</Name>
  <Properties>
    <Condition/>
    <ConditionPropsSessionSettings/>
    <ConditionObjectPosition>
      <ExpectObjectExists>1</ExpectObjectExists>
      <ExpectTargetExists>1</ExpectTargetExists>
    </ConditionObjectPosition>
    <ObjectFilter/>
    <ObjectTargetFilter/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionobjectselected"></a>
<details>
<summary>ConditionObjectSelected — exact template property overrides</summary>

Source: templates.xml:1420. Property blocks: [Condition](#property-condition), [ConditionObjectSelected](#property-conditionobjectselected), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings), [ObjectFilter](#property-objectfilter), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionObjectSelected</Name>
  <Properties>
    <Condition/>
    <ConditionObjectSelected/>
    <ConditionPropsSessionSettings/>
    <ObjectFilter/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionoverlapsaabb"></a>
<details>
<summary>ConditionOverlapsAABB — exact template property overrides</summary>

Source: templates.xml:1437. Property blocks: [Condition](#property-condition), [ConditionOverlapsAABB](#property-conditionoverlapsaabb), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionOverlapsAABB</Name>
  <Properties>
    <Condition/>
    <ConditionOverlapsAABB/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionpalaceitemequipbonusactive"></a>
<details>
<summary>ConditionPalaceItemEquipBonusActive — exact template property overrides</summary>

Source: templates.xml:1445. Property blocks: [Condition](#property-condition), [ConditionPalaceItemEquipBonusActive](#property-conditionpalaceitemequipbonusactive).

```xml
<Template>
  <Name>ConditionPalaceItemEquipBonusActive</Name>
  <Properties>
    <Condition/>
    <ConditionPalaceItemEquipBonusActive/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionpalaceunlocks"></a>
<details>
<summary>ConditionPalaceUnlocks — exact template property overrides</summary>

Source: templates.xml:1452. Property blocks: [Condition](#property-condition), [ConditionPalaceUnlocks](#property-conditionpalaceunlocks).

```xml
<Template>
  <Name>ConditionPalaceUnlocks</Name>
  <Properties>
    <Condition/>
    <ConditionPalaceUnlocks/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionphotographyobject"></a>
<details>
<summary>ConditionPhotographyObject — exact template property overrides</summary>

Source: templates.xml:1459. Property blocks: [Condition](#property-condition), [ConditionPhotographObject](#property-conditionphotographobject).

```xml
<Template>
  <Name>ConditionPhotographyObject</Name>
  <Properties>
    <Condition/>
    <ConditionPhotographObject/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionplayercounter"></a>
<details>
<summary>ConditionPlayerCounter — exact template property overrides</summary>

Source: templates.xml:1466. Property blocks: [Condition](#property-condition), [ConditionPlayerCounter](#property-conditionplayercounter).

```xml
<Template>
  <Name>ConditionPlayerCounter</Name>
  <IsExpertTemplate>1</IsExpertTemplate>
  <Properties>
    <Condition/>
    <ConditionPlayerCounter/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionproductcapacityreached"></a>
<details>
<summary>ConditionProductCapacityReached — exact template property overrides</summary>

Source: templates.xml:1474. Property blocks: [Condition](#property-condition), [ConditionProductCapacityReached](#property-conditionproductcapacityreached).

```xml
<Template>
  <Name>ConditionProductCapacityReached</Name>
  <Properties>
    <Condition/>
    <ConditionProductCapacityReached/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionproductivity"></a>
<details>
<summary>ConditionProductivity — exact template property overrides</summary>

Source: templates.xml:1481. Property blocks: [Condition](#property-condition), [ConditionProductivity](#property-conditionproductivity).

```xml
<Template>
  <Name>ConditionProductivity</Name>
  <Properties>
    <Condition/>
    <ConditionProductivity/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionquestpoolquestrunning"></a>
<details>
<summary>ConditionQuestPoolQuestRunning — exact template property overrides</summary>

Source: templates.xml:1488. Property blocks: [Condition](#property-condition), [ConditionQuestPoolQuestRunning](#property-conditionquestpoolquestrunning), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionQuestPoolQuestRunning</Name>
  <Properties>
    <Condition/>
    <ConditionQuestPoolQuestRunning/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionquestresolveconfirmation"></a>
<details>
<summary>ConditionQuestResolveConfirmation — exact template property overrides</summary>

Source: templates.xml:1496. Property blocks: [ConditionQuestResolveConfirmation](#property-conditionquestresolveconfirmation), [Condition](#property-condition), [ConditionQuestObjective](#property-conditionquestobjective).

```xml
<Template>
  <Name>ConditionQuestResolveConfirmation</Name>
  <Properties>
    <ConditionQuestResolveConfirmation/>
    <Condition/>
    <ConditionQuestObjective>
      <TextCombinedContextValue>12763</TextCombinedContextValue>
    </ConditionQuestObjective>
  </Properties>
</Template>
```

</details>

<a id="template-conditionqueststate"></a>
<details>
<summary>ConditionQuestState — exact template property overrides</summary>

Source: templates.xml:1506. Property blocks: [Condition](#property-condition), [ConditionQuestState](#property-conditionqueststate).

```xml
<Template>
  <Name>ConditionQuestState</Name>
  <Properties>
    <Condition/>
    <ConditionQuestState/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionreciperesearchcompleted"></a>
<details>
<summary>ConditionRecipeResearchCompleted — exact template property overrides</summary>

Source: templates.xml:1513. Property blocks: [Condition](#property-condition), [ConditionRecipeResearchCompleted](#property-conditionreciperesearchcompleted).

```xml
<Template>
  <Name>ConditionRecipeResearchCompleted</Name>
  <Properties>
    <Condition/>
    <ConditionRecipeResearchCompleted>
      <ResearchRangeOp>Any</ResearchRangeOp>
    </ConditionRecipeResearchCompleted>
  </Properties>
</Template>
```

</details>

<a id="template-conditionreputation"></a>
<details>
<summary>ConditionReputation — exact template property overrides</summary>

Source: templates.xml:1522. Property blocks: [Condition](#property-condition), [ConditionReputation](#property-conditionreputation), [ParticipantRelation](#property-participantrelation).

```xml
<Template>
  <Name>ConditionReputation</Name>
  <Properties>
    <Condition/>
    <ConditionReputation/>
    <ParticipantRelation/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionresearchpointlimitreached"></a>
<details>
<summary>ConditionResearchPointLimitReached — exact template property overrides</summary>

Source: templates.xml:1530. Property blocks: [Condition](#property-condition), [ConditionResearchPointLimitReached](#property-conditionresearchpointlimitreached).

```xml
<Template>
  <Name>ConditionResearchPointLimitReached</Name>
  <Properties>
    <Condition/>
    <ConditionResearchPointLimitReached/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionresidentsinbuilding"></a>
<details>
<summary>ConditionResidentsInBuilding — exact template property overrides</summary>

Source: templates.xml:1537. Property blocks: [Condition](#property-condition), [ObjectFilter](#property-objectfilter), [ConditionResidentsInBuilding](#property-conditionresidentsinbuilding).

```xml
<Template>
  <Name>ConditionResidentsInBuilding</Name>
  <Properties>
    <Condition/>
    <ObjectFilter/>
    <ConditionResidentsInBuilding/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionseason"></a>
<details>
<summary>ConditionSeason — exact template property overrides</summary>

Source: templates.xml:1545. Property blocks: [Condition](#property-condition), [ConditionSeason](#property-conditionseason).

```xml
<Template>
  <Name>ConditionSeason</Name>
  <Properties>
    <Condition/>
    <ConditionSeason/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionselectionhappinessdebuffactive"></a>
<details>
<summary>ConditionSelectionHappinessDebuffActive — exact template property overrides</summary>

Source: templates.xml:1552. Property blocks: [Condition](#property-condition), [ConditionSelectionHappinessDebuffActive](#property-conditionselectionhappinessdebuffactive).

```xml
<Template>
  <Name>ConditionSelectionHappinessDebuffActive</Name>
  <Properties>
    <Condition/>
    <ConditionSelectionHappinessDebuffActive/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionsessionloading"></a>
<details>
<summary>ConditionSessionLoading — exact template property overrides</summary>

Source: templates.xml:1559. Property blocks: [Condition](#property-condition), [ConditionSessionLoading](#property-conditionsessionloading), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings).

```xml
<Template>
  <Name>ConditionSessionLoading</Name>
  <Properties>
    <Condition/>
    <ConditionSessionLoading/>
    <ConditionPropsSessionSettings/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionshipsinrange"></a>
<details>
<summary>ConditionShipsInRange — exact template property overrides</summary>

Source: templates.xml:1567. Property blocks: [Condition](#property-condition), [ConditionShipsInRange](#property-conditionshipsinrange), [SessionFilter](#property-sessionfilter).

```xml
<Template>
  <Name>ConditionShipsInRange</Name>
  <Properties>
    <Condition/>
    <ConditionShipsInRange/>
    <SessionFilter>
      <AllowParentConditionSession>0</AllowParentConditionSession>
      <AllowProcessingSession>1</AllowProcessingSession>
    </SessionFilter>
  </Properties>
</Template>
```

</details>

<a id="template-conditionshipsownedinsession"></a>
<details>
<summary>ConditionShipsOwnedInSession — exact template property overrides</summary>

Source: templates.xml:1578. Property blocks: [Condition](#property-condition), [ConditionShipsOwnedInSession](#property-conditionshipsownedinsession).

```xml
<Template>
  <Name>ConditionShipsOwnedInSession</Name>
  <Properties>
    <Condition/>
    <ConditionShipsOwnedInSession/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionshipyardstate"></a>
<details>
<summary>ConditionShipyardState — exact template property overrides</summary>

Source: templates.xml:1585. Property blocks: [Condition](#property-condition), [ConditionShipyardState](#property-conditionshipyardstate).

```xml
<Template>
  <Name>ConditionShipyardState</Name>
  <Properties>
    <Condition/>
    <ConditionShipyardState/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionstarterobject"></a>
<details>
<summary>ConditionStarterObject — exact template property overrides</summary>

Source: templates.xml:1592. Property blocks: [Condition](#property-condition), [ConditionStarterObject](#property-conditionstarterobject), [ConditionQuestObjective](#property-conditionquestobjective), [ConditionPropsSessionSettings](#property-conditionpropssessionsettings).

```xml
<Template>
  <Name>ConditionStarterObject</Name>
  <Properties>
    <Condition/>
    <ConditionStarterObject>
      <DockingPlaceDistance>20</DockingPlaceDistance>
      <StarterObjectObject>
        <Template>ConditionObjectClientQuestObject</Template>
        <Values>
          <ConditionObjectClientQuestObject/>
          <ConditionScanner/>
          <ConditionObjectiveSignsAndFeedback/>
        </Values>
      </StarterObjectObject>
      <StarterObjectDockingPlace>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <ConditionObjectClientQuestObject/>
          <ConditionScanner/>
          <ConditionObjectiveSignsAndFeedback/>
        </Values>
      </StarterObjectDockingPlace>
    </ConditionStarterObject>
    <ConditionQuestObjective>
      <ObjectiveSignsAndFeedback>
        <Template>ConditionObjectiveSignsAndFeedback</Template>
        <Values>
          <ConditionObjectiveSignsAndFeedback>
            <Infolayer>500173</Infolayer>
          </ConditionObjectiveSignsAndFeedback>
        </Values>
      </ObjectiveSignsAndFeedback>
      <ObjectiveSuccessMessage>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <CharacterNotification/>
          <BaseNotification/>
          <NotificationSubtitle/>
        </Values>
      </ObjectiveSuccessMessage>
      <OnSuccessActions>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <ActionList/>
        </Values>
      </OnSuccessActions>
    </ConditionQuestObjective>
    <ConditionPropsSessionSettings/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionstaticresult"></a>
<details>
<summary>ConditionStaticResult — exact template property overrides</summary>

Source: templates.xml:1642. Property blocks: [Condition](#property-condition), [ConditionStaticResult](#property-conditionstaticresult).

```xml
<Template>
  <Name>ConditionStaticResult</Name>
  <Properties>
    <Condition/>
    <ConditionStaticResult/>
  </Properties>
</Template>
```

</details>

<a id="template-conditiontextpopupclosed"></a>
<details>
<summary>ConditionTextPopupClosed — exact template property overrides</summary>

Source: templates.xml:1649. Property blocks: [Condition](#property-condition), [ConditionTextPopupClosed](#property-conditiontextpopupclosed).

```xml
<Template>
  <Name>ConditionTextPopupClosed</Name>
  <Properties>
    <Condition/>
    <ConditionTextPopupClosed/>
  </Properties>
</Template>
```

</details>

<a id="template-conditiontextpopuppagesviewed"></a>
<details>
<summary>ConditionTextPopupPagesViewed — exact template property overrides</summary>

Source: templates.xml:1656. Property blocks: [Condition](#property-condition), [ConditionTextPopupPagesViewed](#property-conditiontextpopuppagesviewed).

```xml
<Template>
  <Name>ConditionTextPopupPagesViewed</Name>
  <Properties>
    <Condition/>
    <ConditionTextPopupPagesViewed/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionthreshold"></a>
<details>
<summary>ConditionThreshold — exact template property overrides</summary>

Source: templates.xml:1663. Property blocks: [Condition](#property-condition), [ConditionThreshold](#property-conditionthreshold).

```xml
<Template>
  <Name>ConditionThreshold</Name>
  <Properties>
    <Condition/>
    <ConditionThreshold/>
  </Properties>
</Template>
```

</details>

<a id="template-conditiontimepassed"></a>
<details>
<summary>ConditionTimePassed — exact template property overrides</summary>

Source: templates.xml:1670. Property blocks: [Condition](#property-condition), [ConditionTimePassed](#property-conditiontimepassed).

```xml
<Template>
  <Name>ConditionTimePassed</Name>
  <Properties>
    <Condition/>
    <ConditionTimePassed/>
  </Properties>
</Template>
```

</details>

<a id="template-conditiontimer"></a>
<details>
<summary>ConditionTimer — exact template property overrides</summary>

Source: templates.xml:1677. Property blocks: [Condition](#property-condition), [ConditionTimer](#property-conditiontimer).

```xml
<Template>
  <Name>ConditionTimer</Name>
  <IsExpertTemplate>1</IsExpertTemplate>
  <Properties>
    <Condition/>
    <ConditionTimer/>
  </Properties>
</Template>
```

</details>

<a id="template-conditiontraderoutecount"></a>
<details>
<summary>ConditionTradeRouteCount — exact template property overrides</summary>

Source: templates.xml:1685. Property blocks: [Condition](#property-condition), [ConditionTradeRouteCount](#property-conditiontraderoutecount).

```xml
<Template>
  <Name>ConditionTradeRouteCount</Name>
  <Properties>
    <Condition/>
    <ConditionTradeRouteCount/>
  </Properties>
</Template>
```

</details>

<a id="template-conditiontutorialinteraction"></a>
<details>
<summary>ConditionTutorialInteraction — exact template property overrides</summary>

Source: templates.xml:1692. Property blocks: [Condition](#property-condition), [ConditionTutorialInteraction](#property-conditiontutorialinteraction).

```xml
<Template>
  <Name>ConditionTutorialInteraction</Name>
  <Properties>
    <Condition/>
    <ConditionTutorialInteraction>
      <AllowedInputTypes>MouseKeyboard;Gamepad</AllowedInputTypes>
      <ObjectFilter>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <ObjectFilter/>
        </Values>
      </ObjectFilter>
    </ConditionTutorialInteraction>
  </Properties>
</Template>
```

</details>

<a id="template-conditionunlocked"></a>
<details>
<summary>ConditionUnlocked — exact template property overrides</summary>

Source: templates.xml:1707. Property blocks: [Condition](#property-condition), [ConditionUnlocked](#property-conditionunlocked), [ConditionPropsNegatable](#property-conditionpropsnegatable).

```xml
<Template>
  <Name>ConditionUnlocked</Name>
  <Properties>
    <Condition/>
    <ConditionUnlocked/>
    <ConditionPropsNegatable/>
  </Properties>
</Template>
```

</details>

<a id="template-conditionunlockedlist"></a>
<details>
<summary>ConditionUnlockedList — exact template property overrides</summary>

Source: templates.xml:1715. Property blocks: [Condition](#property-condition), [ConditionUnlockList](#property-conditionunlocklist).

```xml
<Template>
  <Name>ConditionUnlockedList</Name>
  <Properties>
    <Condition/>
    <ConditionUnlockList>
      <UnlockRangeOP>All</UnlockRangeOP>
    </ConditionUnlockList>
  </Properties>
</Template>
```

</details>

<a id="template-emptyautocreatevalue"></a>
<details>
<summary>EmptyAutoCreateValue — exact template property overrides</summary>

Source: templates.xml:3187. Property blocks: [EmptyAutoCreateValue](#property-emptyautocreatevalue).

```xml
<Template>
  <Name>EmptyAutoCreateValue</Name>
  <Properties>
    <EmptyAutoCreateValue/>
  </Properties>
</Template>
```

</details>

<a id="template-featureunlock"></a>
<details>
<summary>FeatureUnlock — exact template property overrides</summary>

Source: templates.xml:10070. Property blocks: [Standard](#property-standard), [Locked](#property-locked), [Trigger](#property-trigger), [TriggerSetup](#property-triggersetup).

```xml
<Template>
  <Name>FeatureUnlock</Name>
  <Properties>
    <Standard/>
    <Locked/>
    <Trigger>
      <TriggerCondition>
        <Template>ConditionAlwaysTrue</Template>
        <Values>
          <Condition/>
          <ConditionAlwaysTrue/>
        </Values>
      </TriggerCondition>
      <ResetTrigger>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <EmptyAutoCreateValue/>
        </Values>
      </ResetTrigger>
    </Trigger>
    <TriggerSetup>
      <AutoRegisterTrigger>1</AutoRegisterTrigger>
      <AutoSelfUnlock>1</AutoSelfUnlock>
      <UsedBySecondParties>1</UsedBySecondParties>
    </TriggerSetup>
  </Properties>
</Template>
```

</details>

<a id="template-trigger"></a>
<details>
<summary>Trigger — exact template property overrides</summary>

Source: templates.xml:3193. Property blocks: [Standard](#property-standard), [Trigger](#property-trigger), [TriggerSetup](#property-triggersetup).

```xml
<Template>
  <Name>Trigger</Name>
  <Properties>
    <Standard/>
    <Trigger>
      <TriggerCondition>
        <Template>ConditionAlwaysTrue</Template>
        <Values>
          <Condition/>
          <ConditionAlwaysTrue/>
        </Values>
      </TriggerCondition>
      <ResetTrigger>
        <IsBaseAutoCreateAsset>1</IsBaseAutoCreateAsset>
        <Values>
          <EmptyAutoCreateValue/>
        </Values>
      </ResetTrigger>
    </Trigger>
    <TriggerSetup>
      <AutoRegisterTrigger>1</AutoRegisterTrigger>
      <UsedBySecondParties>1</UsedBySecondParties>
    </TriggerSetup>
  </Properties>
</Template>
```

</details>

<a id="template-unlockableasset"></a>
<details>
<summary>UnlockableAsset — exact template property overrides</summary>

Source: templates.xml:10305. Property blocks: [Standard](#property-standard), [Locked](#property-locked).

```xml
<Template>
  <Name>UnlockableAsset</Name>
  <Properties>
    <Standard/>
    <Locked/>
  </Properties>
</Template>
```

</details>

<a id="native-dataset-index"></a>
### Native dataset index

All datasets referenced by the property appendix are included below. Entry names are XML tokens; their numeric IDs and source order are distinct. A token being present does not establish that its consumer works in every runtime context.

[AttractivityType](#dataset-attractivitytype), [CameraMovementAction](#dataset-cameramovementaction), [ComparisonOperator](#dataset-comparisonoperator), [ConditionResult](#dataset-conditionresult), [CorporationDifficulty](#dataset-corporationdifficulty), [CounterScope](#dataset-counterscope), [CounterValueType](#dataset-countervaluetype), [DCConstructionCostRefund](#dataset-dcconstructioncostrefund), [DCLossCondition](#dataset-dclosscondition), [DCOptionalQuestFrequency](#dataset-dcoptionalquestfrequency), [DCOptionalQuestRewards](#dataset-dcoptionalquestrewards), [DCRelocateBuildings](#dataset-dcrelocatebuildings), [DCRevenue](#dataset-dcrevenue), [DCStartCredits](#dataset-dcstartcredits), [DCStartShips](#dataset-dcstartships), [DCStartWithKontor](#dataset-dcstartwithkontor), [DiplomacyState](#dataset-diplomacystate), [ExportLevel](#dataset-exportlevel), [FestivalType](#dataset-festivaltype), [GUIEventType](#dataset-guieventtype), [GUIState](#dataset-guistate), [GamepadAction](#dataset-gamepadaction), [HappinessCategory](#dataset-happinesscategory), [HappinessState](#dataset-happinessstate), [IndustrializationType](#dataset-industrializationtype), [InputMode](#dataset-inputmode), [LockScope](#dataset-lockscope), [MinistryDecreeTier](#dataset-ministrydecreetier), [MutualAreaMask](#dataset-mutualareamask), [PalaceMinistryType](#dataset-palaceministrytype), [ParticipantID](#dataset-participantid), [PlayerCounter](#dataset-playercounter), [QuestJumpToButtonVisibility](#dataset-questjumptobuttonvisibility), [QuestState](#dataset-queststate), [RangeOperator](#dataset-rangeoperator), [ResearchFields](#dataset-researchfields), [ResourceType](#dataset-resourcetype), [SimpleEventType](#dataset-simpleeventtype), [SubConditionCompletionOrder](#dataset-subconditioncompletionorder), [TextPopupLayout](#dataset-textpopuplayout), [TradeRouteTransportationType](#dataset-traderoutetransportationtype), [Tristate](#dataset-tristate), [TutorialCondition](#dataset-tutorialcondition), [TutorialConditionScreenType](#dataset-tutorialconditionscreentype), [TutorialUiCategory](#dataset-tutorialuicategory), [TutorialUiHintAnchor](#dataset-tutorialuihintanchor), [TutorialUiHintColorType](#dataset-tutorialuihintcolortype), [TutorialUiHintEndCondition](#dataset-tutorialuihintendcondition), [TutorialUiHintType](#dataset-tutorialuihinttype), [Variables](#dataset-variables), [VersionType](#dataset-versiontype), [WinLoseState](#dataset-winlosestate)

<a id="dataset-attractivitytype"></a>
<details>
<summary>AttractivityType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:4915. Dataset Id=300.

| Token | Id | Native description |
| --- | --- | --- |
| `Culture` | 0 |  |
| `Monument` | 1 |  |
| `Ornament` | 2 |  |
| `Factory` | 3 |  |
| `Incident` | 4 |  |
| `War` | 5 |  |
| `Ruins` | 6 |  |
| `Nature` | 7 |  |
| `Military` | 8 |  |
| `MonumentEvent` | 9 |  |
| `NatureBonus` | 10 |  |
| `DisasterTourism` | 11 |  |
| `FestivalIncident` | 13 |  |
| `Landscaping` | 14 |  |
| `Cyclideon` | 16 |  |
| `Cheat` | 19 |  |
| `Palace` | 20 |  |
| `ParkBonus` | 21 |  |
| `Dockland` | 22 |  |
| `Ornament_XMasDeco` | 23 |  |
| `Ornament_AmusementPark` | 24 |  |
| `Ornament_CityLights` | 25 |  |
| `Ornament_PedestrianZone` | 26 |  |
| `Ornament_SeasonsPack` | 27 |  |
| `Ornament_IndustrialPack` | 28 |  |
| `Ornament_OldTown` | 29 |  |
| `Ornament_Beach` | 30 |  |
| `Ornament_DragonGarden` | 31 |  |
| `Ornament_Fiesta` | 32 |  |
| `Ornament_NationalPark` | 33 |  |
| `Ornament_Eldritch` | 34 |  |
| `Ornament_SteamPunk` | 35 |  |
| `Ornament_Pirate` | 36 |  |
| `Ornament_EndOfAnEra` | 38 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>AttractivityType</Name>
  <Id>300</Id>
  <Items>
    <Item>
      <Name>Culture</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Monument</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Ornament</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Factory</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Incident</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>War</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>Ruins</Name>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>Nature</Name>
      <Id>7</Id>
    </Item>
    <Item>
      <Name>Military</Name>
      <Id>8</Id>
    </Item>
    <Item>
      <Name>MonumentEvent</Name>
      <Id>9</Id>
    </Item>
    <Item>
      <Name>NatureBonus</Name>
      <Id>10</Id>
    </Item>
    <Item>
      <Name>DisasterTourism</Name>
      <Id>11</Id>
    </Item>
    <Item>
      <Name>FestivalIncident</Name>
      <Id>13</Id>
    </Item>
    <Item>
      <Name>Landscaping</Name>
      <Id>14</Id>
    </Item>
    <Item>
      <Name>Cyclideon</Name>
      <Id>16</Id>
    </Item>
    <Item>
      <Name>Cheat</Name>
      <Id>19</Id>
    </Item>
    <Item>
      <Name>Palace</Name>
      <Id>20</Id>
    </Item>
    <Item>
      <Name>ParkBonus</Name>
      <Id>21</Id>
    </Item>
    <Item>
      <Name>Dockland</Name>
      <Id>22</Id>
    </Item>
    <Item>
      <Name>Ornament_XMasDeco</Name>
      <Id>23</Id>
    </Item>
    <Item>
      <Name>Ornament_AmusementPark</Name>
      <Id>24</Id>
    </Item>
    <Item>
      <Name>Ornament_CityLights</Name>
      <Id>25</Id>
    </Item>
    <Item>
      <Name>Ornament_PedestrianZone</Name>
      <Id>26</Id>
    </Item>
    <Item>
      <Name>Ornament_SeasonsPack</Name>
      <Id>27</Id>
    </Item>
    <Item>
      <Name>Ornament_IndustrialPack</Name>
      <Id>28</Id>
    </Item>
    <Item>
      <Name>Ornament_OldTown</Name>
      <Id>29</Id>
    </Item>
    <Item>
      <Name>Ornament_Beach</Name>
      <Id>30</Id>
    </Item>
    <Item>
      <Name>Ornament_DragonGarden</Name>
      <Id>31</Id>
    </Item>
    <Item>
      <Name>Ornament_Fiesta</Name>
      <Id>32</Id>
    </Item>
    <Item>
      <Name>Ornament_NationalPark</Name>
      <Id>33</Id>
    </Item>
    <Item>
      <Name>Ornament_Eldritch</Name>
      <Id>34</Id>
    </Item>
    <Item>
      <Name>Ornament_SteamPunk</Name>
      <Id>35</Id>
    </Item>
    <Item>
      <Name>Ornament_Pirate</Name>
      <Id>36</Id>
    </Item>
    <Item>
      <Name>Ornament_EndOfAnEra</Name>
      <Id>38</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-cameramovementaction"></a>
<details>
<summary>CameraMovementAction — all tokens, IDs and native metadata</summary>

Source: datasets.xml:16940. Dataset Id=2093.

| Token | Id | Native description |
| --- | --- | --- |
| `PanNormal` | 0 |  |
| `PanFastMode` | 1 |  |
| `RotationYaw` | 3 |  |
| `Zoom` | 4 |  |
| `RotationPitch` | 6 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>CameraMovementAction</Name>
  <Id>2093</Id>
  <Items>
    <Item>
      <Name>PanNormal</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>PanFastMode</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>RotationYaw</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Zoom</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>RotationPitch</Name>
      <Id>6</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-comparisonoperator"></a>
<details>
<summary>ComparisonOperator — all tokens, IDs and native metadata</summary>

Source: datasets.xml:508. Dataset Id=259.

| Token | Id | Native description |
| --- | --- | --- |
| `AtLeast` | 0 | comparison operator: &gt;= |
| `AtMost` | 1 | comparison operator: &lt;= |
| `Equals` | 2 | comparison operator: == |
| `LessThan` | 3 | comparison operator: &lt; |
| `MoreThan` | 4 | comparison operator: &gt; |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>ComparisonOperator</Name>
  <Id>259</Id>
  <Items>
    <Item>
      <Name>AtLeast</Name>
      <Description>comparison operator: &gt;=</Description>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>AtMost</Name>
      <Description>comparison operator: &lt;=</Description>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Equals</Name>
      <Description>comparison operator: ==</Description>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>LessThan</Name>
      <Description>comparison operator: &lt;</Description>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>MoreThan</Name>
      <Description>comparison operator: &gt;</Description>
      <Id>4</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-conditionresult"></a>
<details>
<summary>ConditionResult — all tokens, IDs and native metadata</summary>

Source: datasets.xml:16966. Dataset Id=385.

| Token | Id | Native description |
| --- | --- | --- |
| `Success` | 0 |  |
| `Failed` | 1 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>ConditionResult</Name>
  <Id>385</Id>
  <Items>
    <Item>
      <Name>Success</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Failed</Name>
      <Id>1</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-corporationdifficulty"></a>
<details>
<summary>CorporationDifficulty — all tokens, IDs and native metadata</summary>

Source: datasets.xml:17684. Dataset Id=392.

| Token | Id | Native description |
| --- | --- | --- |
| `Easy` | 0 |  |
| `Normal` | 1 |  |
| `Hard` | 2 |  |
| `Classic` | 3 |  |
| `EasyMultiplayer` | 4 |  |
| `NormalMultiplayer` | 5 |  |
| `HardMultiplayer` | 6 |  |
| `Anarchist` | 7 |  |
| `EasyQuickMP` | 8 |  |
| `NormalQuickMP` | 9 |  |
| `HardQuickMP` | 10 |  |
| `ScenarioSelection` | 14 | Special difficulty settings used for loading the scenario selection world map |
| `ScenarioGGJ` | 11 |  |
| `Scenario02` | 13 |  |
| `Scenario03` | 15 |  |
| `Scenario04` | 16 |  |
| `CreativeMode` | 17 |  |
| `CreativeModeMultiplayer` | 18 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>CorporationDifficulty</Name>
  <Id>392</Id>
  <Items>
    <Item>
      <Name>Easy</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Normal</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Hard</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Classic</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>EasyMultiplayer</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>NormalMultiplayer</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>HardMultiplayer</Name>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>Anarchist</Name>
      <Id>7</Id>
    </Item>
    <Item>
      <Name>EasyQuickMP</Name>
      <Id>8</Id>
    </Item>
    <Item>
      <Name>NormalQuickMP</Name>
      <Id>9</Id>
    </Item>
    <Item>
      <Name>HardQuickMP</Name>
      <Id>10</Id>
    </Item>
    <Item>
      <Name>ScenarioSelection</Name>
      <Description>Special difficulty settings used for loading the scenario selection world map</Description>
      <Id>14</Id>
    </Item>
    <Item>
      <Name>ScenarioGGJ</Name>
      <Id>11</Id>
    </Item>
    <Item>
      <Name>Scenario02</Name>
      <Id>13</Id>
    </Item>
    <Item>
      <Name>Scenario03</Name>
      <Id>15</Id>
    </Item>
    <Item>
      <Name>Scenario04</Name>
      <Id>16</Id>
    </Item>
    <Item>
      <Name>CreativeMode</Name>
      <Id>17</Id>
    </Item>
    <Item>
      <Name>CreativeModeMultiplayer</Name>
      <Id>18</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-counterscope"></a>
<details>
<summary>CounterScope — all tokens, IDs and native metadata</summary>

Source: datasets.xml:11036. Dataset Id=333.

| Token | Id | Native description |
| --- | --- | --- |
| `Area` | 0 |  |
| `Session` | 1 |  |
| `Region` | 2 |  |
| `Global` | 3 |  |
| `Account` | 4 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>CounterScope</Name>
  <Id>333</Id>
  <Items>
    <Item>
      <Name>Area</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Session</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Region</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Global</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Account</Name>
      <Id>4</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-countervaluetype"></a>
<details>
<summary>CounterValueType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:11062. Dataset Id=334.

| Token | Id | Native description |
| --- | --- | --- |
| `Current` | 0 |  |
| `Min` | 1 |  |
| `Max` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>CounterValueType</Name>
  <Id>334</Id>
  <Items>
    <Item>
      <Name>Current</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Min</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Max</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-dcconstructioncostrefund"></a>
<details>
<summary>DCConstructionCostRefund — all tokens, IDs and native metadata</summary>

Source: datasets.xml:17763. Dataset Id=393.

| Token | Id | Native description |
| --- | --- | --- |
| `Full` | 0 |  |
| `Half` | 1 |  |
| `None` | 2 |  |
| `PayCredits` | 3 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>DCConstructionCostRefund</Name>
  <Id>393</Id>
  <Items>
    <Item>
      <Name>Full</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Half</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>None</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>PayCredits</Name>
      <Id>3</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-dclosscondition"></a>
<details>
<summary>DCLossCondition — all tokens, IDs and native metadata</summary>

Source: datasets.xml:17903. Dataset Id=399.

| Token | Id | Native description |
| --- | --- | --- |
| `BailoutWithSlowLiquidation` | 0 |  |
| `BailoutWithFastLiquidation` | 1 |  |
| `Bankrupt` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>DCLossCondition</Name>
  <Id>399</Id>
  <Items>
    <Item>
      <Name>BailoutWithSlowLiquidation</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>BailoutWithFastLiquidation</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Bankrupt</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-dcoptionalquestfrequency"></a>
<details>
<summary>DCOptionalQuestFrequency — all tokens, IDs and native metadata</summary>

Source: datasets.xml:17921. Dataset Id=403.

| Token | Id | Native description |
| --- | --- | --- |
| `Often` | 0 |  |
| `Normal` | 1 |  |
| `Rare` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>DCOptionalQuestFrequency</Name>
  <Id>403</Id>
  <Items>
    <Item>
      <Name>Often</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Normal</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Rare</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-dcoptionalquestrewards"></a>
<details>
<summary>DCOptionalQuestRewards — all tokens, IDs and native metadata</summary>

Source: datasets.xml:17939. Dataset Id=404.

| Token | Id | Native description |
| --- | --- | --- |
| `Plenty` | 0 |  |
| `Medium` | 1 |  |
| `Spare` | 2 |  |
| `PennyPinching` | 3 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>DCOptionalQuestRewards</Name>
  <Id>404</Id>
  <Items>
    <Item>
      <Name>Plenty</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Medium</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Spare</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>PennyPinching</Name>
      <Id>3</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-dcrelocatebuildings"></a>
<details>
<summary>DCRelocateBuildings — all tokens, IDs and native metadata</summary>

Source: datasets.xml:17983. Dataset Id=409.

| Token | Id | Native description |
| --- | --- | --- |
| `On` | 0 |  |
| `PayCredits` | 2 |  |
| `Off` | 1 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>DCRelocateBuildings</Name>
  <Id>409</Id>
  <Items>
    <Item>
      <Name>On</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>PayCredits</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Off</Name>
      <Id>1</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-dcrevenue"></a>
<details>
<summary>DCRevenue — all tokens, IDs and native metadata</summary>

Source: datasets.xml:18015. Dataset Id=410.

| Token | Id | Native description |
| --- | --- | --- |
| `Plenty` | 0 |  |
| `Medium` | 1 |  |
| `Spare` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>DCRevenue</Name>
  <Id>410</Id>
  <Items>
    <Item>
      <Name>Plenty</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Medium</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Spare</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-dcstartcredits"></a>
<details>
<summary>DCStartCredits — all tokens, IDs and native metadata</summary>

Source: datasets.xml:18055. Dataset Id=411.

| Token | Id | Native description |
| --- | --- | --- |
| `Plenty` | 0 |  |
| `Medium` | 1 |  |
| `Spare` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>DCStartCredits</Name>
  <Id>411</Id>
  <Items>
    <Item>
      <Name>Plenty</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Medium</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Spare</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-dcstartships"></a>
<details>
<summary>DCStartShips — all tokens, IDs and native metadata</summary>

Source: datasets.xml:18073. Dataset Id=1666.

| Token | Id | Native description |
| --- | --- | --- |
| `None` | 0 |  |
| `OneShip` | 1 |  |
| `TradeFleet` | 2 |  |
| `WarFleet` | 3 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>DCStartShips</Name>
  <Id>1666</Id>
  <Items>
    <Item>
      <Name>None</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>OneShip</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>TradeFleet</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>WarFleet</Name>
      <Id>3</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-dcstartwithkontor"></a>
<details>
<summary>DCStartWithKontor — all tokens, IDs and native metadata</summary>

Source: datasets.xml:18095. Dataset Id=1688.

| Token | Id | Native description |
| --- | --- | --- |
| `Off` | 0 |  |
| `Standard` | 1 |  |
| `Full` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>DCStartWithKontor</Name>
  <Id>1688</Id>
  <Items>
    <Item>
      <Name>Off</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Standard</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Full</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-diplomacystate"></a>
<details>
<summary>DiplomacyState — all tokens, IDs and native metadata</summary>

Source: datasets.xml:12696. Dataset Id=345.

| Token | Id | Native description |
| --- | --- | --- |
| `War` | 0 |  |
| `Peace` | 1 |  |
| `TradeRights` | 2 |  |
| `Alliance` | 3 |  |
| `CeaseFire` | 5 |  |
| `NonAttack` | 8 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>DiplomacyState</Name>
  <Id>345</Id>
  <Items>
    <Item>
      <Name>War</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Peace</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>TradeRights</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Alliance</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>CeaseFire</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>NonAttack</Name>
      <Id>8</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-exportlevel"></a>
<details>
<summary>ExportLevel — all tokens, IDs and native metadata</summary>

Source: datasets.xml:21614. Dataset Id=1905.

| Token | Id | Native description |
| --- | --- | --- |
| `Common` | 0 |  |
| `Uncommon` | 1 |  |
| `Rare` | 2 |  |
| `Epic` | 3 |  |
| `Legendary` | 4 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>ExportLevel</Name>
  <Id>1905</Id>
  <Items>
    <Item>
      <Name>Common</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Uncommon</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Rare</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Epic</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Legendary</Name>
      <Id>4</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-festivaltype"></a>
<details>
<summary>FestivalType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:860. Dataset Id=1754.

| Token | Id | Native description |
| --- | --- | --- |
| `BeerFestival` | 0 |  |
| `HarvestFestival` | 1 |  |
| `ArtsFestival` | 2 |  |
| `Commemoration` | 3 |  |
| `Carnival` | 4 |  |
| `AnarchyFest` | 5 |  |
| `SpiritualFestivalAfrica` | 36 |  |
| `HarvestFestivalAfrica` | 37 |  |
| `TradeFestivalAfrica` | 38 |  |
| `QueenParade` | 42 |  |
| `Stadium1` | 43 |  |
| `Stadium2` | 44 |  |
| `Stadium3` | 45 |  |
| `Stadium4` | 46 |  |
| `Stadium5` | 47 |  |
| `Stadium6` | 48 |  |
| `Stadium7` | 49 |  |
| `Stadium8` | 50 |  |
| `Stadium9` | 51 |  |
| `Stadium10` | 52 |  |
| `Stadium11` | 53 |  |
| `Stadium12` | 54 |  |
| `Stadium13` | 55 |  |
| `Stadium14` | 56 |  |
| `Stadium15` | 57 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>FestivalType</Name>
  <Id>1754</Id>
  <Items>
    <Item>
      <Name>BeerFestival</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>HarvestFestival</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>ArtsFestival</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Commemoration</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Carnival</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>AnarchyFest</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>SpiritualFestivalAfrica</Name>
      <Id>36</Id>
    </Item>
    <Item>
      <Name>HarvestFestivalAfrica</Name>
      <Id>37</Id>
    </Item>
    <Item>
      <Name>TradeFestivalAfrica</Name>
      <Id>38</Id>
    </Item>
    <Item>
      <Name>QueenParade</Name>
      <Id>42</Id>
    </Item>
    <Item>
      <Name>Stadium1</Name>
      <Id>43</Id>
    </Item>
    <Item>
      <Name>Stadium2</Name>
      <Id>44</Id>
    </Item>
    <Item>
      <Name>Stadium3</Name>
      <Id>45</Id>
    </Item>
    <Item>
      <Name>Stadium4</Name>
      <Id>46</Id>
    </Item>
    <Item>
      <Name>Stadium5</Name>
      <Id>47</Id>
    </Item>
    <Item>
      <Name>Stadium6</Name>
      <Id>48</Id>
    </Item>
    <Item>
      <Name>Stadium7</Name>
      <Id>49</Id>
    </Item>
    <Item>
      <Name>Stadium8</Name>
      <Id>50</Id>
    </Item>
    <Item>
      <Name>Stadium9</Name>
      <Id>51</Id>
    </Item>
    <Item>
      <Name>Stadium10</Name>
      <Id>52</Id>
    </Item>
    <Item>
      <Name>Stadium11</Name>
      <Id>53</Id>
    </Item>
    <Item>
      <Name>Stadium12</Name>
      <Id>54</Id>
    </Item>
    <Item>
      <Name>Stadium13</Name>
      <Id>55</Id>
    </Item>
    <Item>
      <Name>Stadium14</Name>
      <Id>56</Id>
    </Item>
    <Item>
      <Name>Stadium15</Name>
      <Id>57</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-guieventtype"></a>
<details>
<summary>GUIEventType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:17526. Dataset Id=1934.

| Token | Id | Native description |
| --- | --- | --- |
| `Enter` | 0 |  |
| `Leave` | 1 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>GUIEventType</Name>
  <Id>1934</Id>
  <Items>
    <Item>
      <Name>Enter</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Leave</Name>
      <Id>1</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-guistate"></a>
<details>
<summary>GUIState — all tokens, IDs and native metadata</summary>

Source: datasets.xml:6224. Dataset Id=309.

| Token | Id | Native description |
| --- | --- | --- |
| `Video` | 1 |  |
| `Title` | 2 |  |
| `ProfileSelection` | 3 |  |
| `CharacterNotification` | 4 |  |
| `ExpeditionEvent` | 16 |  |
| `ExpeditionOverview` | 5 |  |
| `Diplomacy` | 6 |  |
| `SessionTradeRouteOverview` | 7 |  |
| `Newspaper` | 8 |  |
| `WorldMap` | 10 |  |
| `CameraSequence` | 11 |  |
| `PostcardView` | 12 |  |
| `ResidentView` | 13 |  |
| `RotatingCameraView` | 14 |  |
| `ActiveTrade` | 15 |  |
| `TextPopup` | 17 |  |
| `VisitorHarbor` | 18 |  |
| `Minimap` | 19 |  |
| `ObjectmenuResidence` | 22 |  |
| `ObjectmenuProduction` | 23 |  |
| `Attractiveness` | 24 |  |
| `ObjectmenuMonumentEvent` | 25 |  |
| `CampaignNewspaper` | 27 |  |
| `QuestBook` | 28 |  |
| `QuestTracker` | 29 |  |
| `ObjectmenuMausoleum` | 32 |  |
| `NewspaperSpecialEdition` | 33 |  |
| `ObjectmenuForeign` | 34 |  |
| `IslandBar` | 35 |  |
| `ObjectMenuKontor` | 36 |  |
| `ObjectmenuMonument` | 37 |  |
| `TreasureMap` | 38 |  |
| `ChatNotifications` | 40 |  |
| `ObjectMenuPalace` | 42 |  |
| `ObjectMenuDepartment` | 43 |  |
| `ObjectMenuPump` | 45 |  |
| `Research` | 46 |  |
| `ObjectMenuResearch` | 50 |  |
| `ObjectMenuDockland` | 47 |  |
| `Docklands` | 48 |  |
| `Achievements` | 49 |  |
| `Monument` | 52 |  |
| `RecipeBuilding` | 53 |  |
| `MPLobbyCoop` | 56 |  |
| `Statistics` | 57 |  |
| `Influence` | 58 |  |
| `HostileTakeover` | 59 |  |
| `Workforce` | 60 |  |
| `IslandDetails` | 61 |  |
| `DecisionQuest` | 62 |  |
| `ObjectMenuTrader` | 63 |  |
| `ScenarioBook` | 64 |  |
| `PreVictory` | 66 |  |
| `ObjectmenuCraftingOldNate` | 67 |  |
| `CraftingPopup` | 68 |  |
| `ScenarioRuins` | 69 |  |
| `QuickNavigationMap` | 70 |  |
| `ObjectMenuCommuterHarbour` | 71 |  |
| `MonumentEvent` | 72 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>GUIState</Name>
  <Id>309</Id>
  <Items>
    <Item>
      <Name>Video</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Title</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>ProfileSelection</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>CharacterNotification</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>ExpeditionEvent</Name>
      <Id>16</Id>
    </Item>
    <Item>
      <Name>ExpeditionOverview</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>Diplomacy</Name>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>SessionTradeRouteOverview</Name>
      <Id>7</Id>
    </Item>
    <Item>
      <Name>Newspaper</Name>
      <Id>8</Id>
    </Item>
    <Item>
      <Name>WorldMap</Name>
      <Id>10</Id>
    </Item>
    <Item>
      <Name>CameraSequence</Name>
      <Id>11</Id>
    </Item>
    <Item>
      <Name>PostcardView</Name>
      <Id>12</Id>
    </Item>
    <Item>
      <Name>ResidentView</Name>
      <Id>13</Id>
    </Item>
    <Item>
      <Name>RotatingCameraView</Name>
      <Id>14</Id>
    </Item>
    <Item>
      <Name>ActiveTrade</Name>
      <Id>15</Id>
    </Item>
    <Item>
      <Name>TextPopup</Name>
      <Id>17</Id>
    </Item>
    <Item>
      <Name>VisitorHarbor</Name>
      <Id>18</Id>
    </Item>
    <Item>
      <Name>Minimap</Name>
      <Id>19</Id>
    </Item>
    <Item>
      <Name>ObjectmenuResidence</Name>
      <Id>22</Id>
    </Item>
    <Item>
      <Name>ObjectmenuProduction</Name>
      <Id>23</Id>
    </Item>
    <Item>
      <Name>Attractiveness</Name>
      <Id>24</Id>
    </Item>
    <Item>
      <Name>ObjectmenuMonumentEvent</Name>
      <Id>25</Id>
    </Item>
    <Item>
      <Name>CampaignNewspaper</Name>
      <Id>27</Id>
    </Item>
    <Item>
      <Name>QuestBook</Name>
      <Id>28</Id>
    </Item>
    <Item>
      <Name>QuestTracker</Name>
      <Id>29</Id>
    </Item>
    <Item>
      <Name>ObjectmenuMausoleum</Name>
      <Id>32</Id>
    </Item>
    <Item>
      <Name>NewspaperSpecialEdition</Name>
      <Id>33</Id>
    </Item>
    <Item>
      <Name>ObjectmenuForeign</Name>
      <Id>34</Id>
    </Item>
    <Item>
      <Name>IslandBar</Name>
      <Id>35</Id>
    </Item>
    <Item>
      <Name>ObjectMenuKontor</Name>
      <Id>36</Id>
    </Item>
    <Item>
      <Name>ObjectmenuMonument</Name>
      <Id>37</Id>
    </Item>
    <Item>
      <Name>TreasureMap</Name>
      <Id>38</Id>
    </Item>
    <Item>
      <Name>ChatNotifications</Name>
      <Id>40</Id>
    </Item>
    <Item>
      <Name>ObjectMenuPalace</Name>
      <Id>42</Id>
    </Item>
    <Item>
      <Name>ObjectMenuDepartment</Name>
      <Id>43</Id>
    </Item>
    <Item>
      <Name>ObjectMenuPump</Name>
      <Id>45</Id>
    </Item>
    <Item>
      <Name>Research</Name>
      <Id>46</Id>
    </Item>
    <Item>
      <Name>ObjectMenuResearch</Name>
      <Id>50</Id>
    </Item>
    <Item>
      <Name>ObjectMenuDockland</Name>
      <Id>47</Id>
    </Item>
    <Item>
      <Name>Docklands</Name>
      <Id>48</Id>
    </Item>
    <Item>
      <Name>Achievements</Name>
      <Id>49</Id>
    </Item>
    <Item>
      <Name>Monument</Name>
      <Id>52</Id>
    </Item>
    <Item>
      <Name>RecipeBuilding</Name>
      <Id>53</Id>
    </Item>
    <Item>
      <Name>MPLobbyCoop</Name>
      <Id>56</Id>
    </Item>
    <Item>
      <Name>Statistics</Name>
      <Id>57</Id>
    </Item>
    <Item>
      <Name>Influence</Name>
      <Id>58</Id>
    </Item>
    <Item>
      <Name>HostileTakeover</Name>
      <Id>59</Id>
    </Item>
    <Item>
      <Name>Workforce</Name>
      <Id>60</Id>
    </Item>
    <Item>
      <Name>IslandDetails</Name>
      <Id>61</Id>
    </Item>
    <Item>
      <Name>DecisionQuest</Name>
      <Id>62</Id>
    </Item>
    <Item>
      <Name>ObjectMenuTrader</Name>
      <Id>63</Id>
    </Item>
    <Item>
      <Name>ScenarioBook</Name>
      <Id>64</Id>
    </Item>
    <Item>
      <Name>PreVictory</Name>
      <Id>66</Id>
    </Item>
    <Item>
      <Name>ObjectmenuCraftingOldNate</Name>
      <Id>67</Id>
    </Item>
    <Item>
      <Name>CraftingPopup</Name>
      <Id>68</Id>
    </Item>
    <Item>
      <Name>ScenarioRuins</Name>
      <Id>69</Id>
    </Item>
    <Item>
      <Name>QuickNavigationMap</Name>
      <Id>70</Id>
    </Item>
    <Item>
      <Name>ObjectMenuCommuterHarbour</Name>
      <Id>71</Id>
    </Item>
    <Item>
      <Name>MonumentEvent</Name>
      <Id>72</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-gamepadaction"></a>
<details>
<summary>GamepadAction — all tokens, IDs and native metadata</summary>

Source: datasets.xml:21643. Dataset Id=1966.

| Token | Id | Native description |
| --- | --- | --- |
| `Blocked` | 856 |  |
| `ChangeTabLeft` | 0 |  |
| `ChangeTabRight` | 1 |  |
| `ChangeSubtabLeft` | 2 |  |
| `ChangeSubtabRight` | 3 |  |
| `ChangeTabLeftAlt` | 174 |  |
| `ChangeTabRightAlt` | 175 |  |
| `ComboBoxToggle` | 44 |  |
| `SuperButtonPress` | 723 |  |
| `SuperButtonRelease` | 724 |  |
| `PushFocus` | 118 |  |
| `PullFocus` | 119 |  |
| `CloseCancel` | 12 |  |
| `AnyKey` | 57 |  |
| `ScrollLeft` | 45 |  |
| `ScrollRight` | 46 |  |
| `ScrollUp` | 47 |  |
| `ScrollDown` | 48 |  |
| `BuildModePrimaryActionPress` | 725 |  |
| `BuildModePrimaryActionRelease` | 726 |  |
| `BuildModeSecondaryActionPress` | 727 |  |
| `BuildModeSecondaryActionRelease` | 728 |  |
| `BuildModeRotateActionPress` | 729 |  |
| `BuildModeRotateActionRelease` | 730 |  |
| `TargetManagerPrimaryActionPress` | 731 |  |
| `TargetManagerPrimaryActionRelease` | 732 |  |
| `TargetManagerSecondaryActionPress` | 733 |  |
| `TargetManagerSecondaryActionRelease` | 734 |  |
| `TargetManagerModifier` | 910 |  |
| `TargetManagerClearSelection` | 171 |  |
| `TargetManagerToggleNotification` | 173 |  |
| `ConstructionMenuToggleBlueprintMode` | 615 |  |
| `ConstructionRadialChangeContent` | 687 |  |
| `ConstructionRadialCategorySorting` | 111 |  |
| `ConstructionRadialBuildingPlace` | 112 |  |
| `ConstructionRadialBuildingCancel` | 113 |  |
| `ConstructionRadialBuildingRotate` | 641 |  |
| `CameraReset` | 139 |  |
| `CameraFastMove` | 104 |  |
| `CameraPitch` | 140 |  |
| `CameraNavigateToKontorOrNextOfSelection` | 147 |  |
| `IncreaseGameSpeed` | 27 |  |
| `DecreaseGameSpeed` | 26 |  |
| `FocusObjectMenu` | 36 |  |
| `IslandDetailsJumpToKontor` | 134 |  |
| `IslandDetailsRandomizeName` | 666 |  |
| `DiplomacyShowDetails` | 135 |  |
| `DiplomacyToggleStatesCharacters` | 138 |  |
| `DiplomacyShowTreaties` | 34 |  |
| `DiplomacyShowActions` | 35 |  |
| `DiplomacyComparison` | 170 |  |
| `DiplomacyHistory` | 171 |  |
| `TradeChangeAmount` | 136 |  |
| `TradeThrowOverboard` | 137 |  |
| `TradeDeleteGood` | 609 |  |
| `TradeAcceptAmountChange` | 610 |  |
| `TradeConfirmTrade` | 168 |  |
| `TradeAddRemove` | 987 |  |
| `OpenMetaMenuNavigation` | 14 |  |
| `OpenBuildTools` | 15 |  |
| `OpenConstructionMenu` | 166 |  |
| `OpenShipMenuRadial` | 154 |  |
| `QuickNavigationOpenState` | 169 |  |
| `QuickNavigationLeaveState` | 90 |  |
| `QuickNavigationShowPreviousSession` | 93 |  |
| `QuickNavigationShowNextSession` | 94 |  |
| `QuickNavigationTeleport` | 167 |  |
| `QuickNavigationZoomToWorldmap` | 969 |  |
| `DebugToggleCheatOverlay` | 960 |  |
| `DebugToggleCheatOverlayAlternative` | 961 |  |
| `DebugCheatOverlayFavouritesToggle` | 106 |  |
| `DebugToggleHideUI` | 962 |  |
| `DebugToggleHideUIAlternative` | 963 |  |
| `StrategicMapOpenFilters` | 141 |  |
| `StrategicMapClearAllFilters` | 142 |  |
| `StrategicMapResetZoom` | 644 |  |
| `StrategicMapShowPreviousSession` | 719 |  |
| `StrategicMapShowNextSession` | 720 |  |
| `SideNotificationFocus` | 643 |  |
| `InteractNotification` | 172 |  |
| `FocusTradeRouteMenu` | 646 |  |
| `FocusCharterRouteMenu` | 177 |  |
| `DeleteNotification` | 647 |  |
| `DeleteAllNotifications` | 708 |  |
| `LoadingPrevTip` | 167 |  |
| `LoadingNextTip` | 168 |  |
| `LoadingStart` | 169 |  |
| `ObjectMenuItemSocketing` | 738 |  |
| `ObjectMenuItemUnsocketing` | 739 |  |
| `ObjectMenuItemActivating` | 740 |  |
| `ObjectMenuIncreaseSliderValue` | 745 |  |
| `ObjectMenuDecreaseSliderValue` | 746 |  |
| `ObjectMenuOpenStatistics` | 741 |  |
| `ProductionOMOpenWorkforcePopup` | 747 |  |
| `ProductionOMOpenWorkforceScene` | 748 |  |
| `ProductionOMSaveWorkforcePopup` | 749 |  |
| `TradeRouteChangeStationOrder` | 145 |  |
| `TradeRouteOpenStationOptions` | 144 |  |
| `TradeRouteLoadGood` | 947 |  |
| `TradeRouteUnloadGood` | 948 |  |
| `TradeRouteEditGood` | 949 |  |
| `TradeRouteRemoveGood` | 205 |  |
| `TradeRoutesAddShip` | 956 |  |
| `TradeRouteRemoveShip` | 185 |  |
| `TradeRouteReplaceShip` | 950 |  |
| `TradeRoutePauseShip` | 186 |  |
| `TradeRouteDiscardCargo` | 187 |  |
| `TradeRouteToggleShipDetails` | 199 |  |
| `TradeRouteDeleteStation` | 143 |  |
| `TradeRouteLoadToAllSlots` | 717 |  |
| `TradeRouteUnloadToAllSlots` | 955 |  |
| `TradeRouteFocusStrategicMap` | 895 |  |
| `CharterRouteAcceptRoute` | 872 |  |
| `CharterRouteFocusStrategicMap` | 896 |  |
| `SystemPopupAccept` | 188 |  |
| `SystemPopupAcceptHold` | 912 |  |
| `SystemPopupAcceptAlt` | 913 |  |
| `SystemPopupAcceptAltHold` | 914 |  |
| `SystemPopupDecline` | 189 |  |
| `SystemPopupDeclineHold` | 926 |  |
| `SystemPopupRetry` | 933 |  |
| `DeleteExpedition` | 193 |  |
| `HighlightSpeedBar` | 640 |  |
| `ShipMenuSelectShip` | 194 |  |
| `ShipMenuMultiSelectShip` | 195 |  |
| `ShipMenuClearSelection` | 166 |  |
| `ShipMenuCreateGroup` | 176 |  |
| `ShipMenuClearGroup` | 204 |  |
| `ShipMenuFocusObjectMenu` | 212 |  |
| `ShipMenuJumpToShip` | 649 |  |
| `ShipMenuSelectAndJumpToShip` | 928 |  |
| `ShipMenuMultiSelectAndJumpToShip` | 929 |  |
| `ShipOMActivateItem` | 650 |  |
| `ShipOMOpenTransfer` | 651 |  |
| `ShipOMSwapItem` | 652 |  |
| `ShipOMThrowOverboard` | 653 |  |
| `DiscardExpedition` | 611 |  |
| `ToggleBuildToolMode` | 613 |  |
| `SharesAccept` | 622 |  |
| `SharesDecline` | 623 |  |
| `SharesNavigation` | 986 |  |
| `SharesSelect` | 985 |  |
| `NewspaperEnterEdit` | 624 |  |
| `NewspaperUndoArticleChanges` | 625 |  |
| `NewspaperMarkAchiveAsFavorite` | 626 |  |
| `NewspaperOpenAutoPublishPopup` | 756 |  |
| `NewspaperPublish` | 737 |  |
| `NewspaperToggleAutoPublish` | 757 |  |
| `MonumentTogglePhase` | 174 |  |
| `MonumentEventShowDetails` | 661 |  |
| `MonumentEventCancelExhibition` | 664 |  |
| `MonumentEventCollectReward` | 663 |  |
| `AcceptTime` | 627 |  |
| `SetTimeUp` | 628 |  |
| `SetTimeDown` | 629 |  |
| `SetTimeLeft` | 630 |  |
| `SetTimeRight` | 631 |  |
| `EnterShipSelectionBrushMode` | 117 |  |
| `DeleteQuest` | 126 |  |
| `TooltipChangeTabLeft` | 122 |  |
| `TooltipChangeTabRight` | 123 |  |
| `FocusMapFromTradeRouteOverview` | 127 |  |
| `FocusTradeRouteOverviewFromMap` | 128 |  |
| `Quicksave` | 149 |  |
| `DeleteProfileorSaves` | 150 |  |
| `HoldAtoDelete` | 151 |  |
| `BtnQuestbookPopupPageLeft` | 156 |  |
| `BtnQuestbookPopupPageRight` | 157 |  |
| `OpenQuestBookFromQuest` | 158 |  |
| `JumpToQuestLocation` | 164 |  |
| `MultiselectIslandListItem` | 160 |  |
| `OpenItemFilters` | 161 |  |
| `ItemFiltersOpenKeyboard` | 943 |  |
| `ItemFiltersClear` | 163 |  |
| `StatisticsCompareItem` | 844 |  |
| `StatisticsCancelCompareItem` | 845 |  |
| `StatisticsCycleProductionInformationType` | 846 |  |
| `StatisticsShowProductionHelp` | 847 |  |
| `OpenDiplomaticInformation` | 179 |  |
| `CloseDiplomaticInformation` | 180 |  |
| `ShipyardOMSetRallyPoint` | 711 |  |
| `ShipyardOMRemoveFromQueue` | 712 |  |
| `VisitorOpenAttractiveness` | 654 |  |
| `EnterPhotoMode` | 655 |  |
| `TogglePauseMenu` | 656 |  |
| `MainDiplomaticMiniResponse` | 660 |  |
| `OpenIslandList` | 667 |  |
| `CloseIslandList` | 668 |  |
| `CloseAndSave` | 673 |  |
| `ClearValueModification` | 674 |  |
| `UnfocusQuestTracker` | 675 |  |
| `ScreenCaptureTakePhoto` | 688 |  |
| `ScreenCaptureSubmitPhoto` | 689 |  |
| `CulturalBuildingUnsocketItem` | 690 |  |
| `CreateGameExit` | 691 |  |
| `CreateGameChangeName` | 692 |  |
| `CreateGameRandomName` | 693 |  |
| `CreateGameContinue` | 694 |  |
| `CreateGameBack` | 716 |  |
| `CreateGameOpenConnectOverlay` | 990 |  |
| `ProfileChangeColorLeft` | 703 |  |
| `ProfileChangeColorRight` | 704 |  |
| `OpenArchiveFilter` | 707 |  |
| `TradeRouteOverviewResetFilter` | 965 |  |
| `RouteOverviewRename` | 713 |  |
| `RouteOverviewMoveToGroup` | 714 |  |
| `RouteOverviewDelete` | 715 |  |
| `QuickSelectNewIslandHarbourBlueprint` | 892 |  |
| `CustomizeModeNavigateLeft` | 750 |  |
| `CustomizeModeNavigateRight` | 751 |  |
| `CustomizeModeCopy` | 752 |  |
| `CustomizeModePaste` | 753 |  |
| `CustomizeModeChangeName` | 754 |  |
| `CustomizeModeRandomizeName` | 755 |  |
| `CustomizeModeOpenConnectOverlay` | 989 |  |
| `VideoSkipCutscene` | 851 |  |
| `TrackQuest` | 849 |  |
| `AdvancedDifficultyStartGame` | 852 |  |
| `AdvancedDifficultyRandomize` | 853 |  |
| `AdvancedDifficultyEditPreset` | 854 |  |
| `AdvancedDifficultyRemoveCharacter` | 855 |  |
| `AdvancedDifficultyDeletePreset` | 865 |  |
| `AdvancedDifficultyBack` | 873 |  |
| `AdvancedDifficultyMPConfirm` | 934 |  |
| `MPLobbyManageMode` | 932 |  |
| `MPLobbyKick` | 857 |  |
| `MPLobbySwap` | 858 |  |
| `MPLobbyEditProfile` | 859 |  |
| `MPLobbyEditAI` | 930 |  |
| `MPLobbyRemoveAI` | 860 |  |
| `MPLobbyGameSettings` | 861 |  |
| `MPLobbyAddPlayers` | 862 |  |
| `MPLobbyAddAI` | 890 |  |
| `MPLobbyInvite` | 863 |  |
| `MPLobbyCancelInvite` | 871 |  |
| `MPLobbyProfileCustomizationConfirm` | 887 |  |
| `MPLobbyFirstPartyProfileInfo` | 931 |  |
| `MpLobbyInviteAnother` | 937 |  |
| `MpLobbyReinvitePlayer` | 938 |  |
| `MpLobbyReinviteAll` | 954 |  |
| `MPLobbyStartGame` | 870 |  |
| `OpenStaticHelp` | 864 |  |
| `StaticHelpSelectTagList` | 880 |  |
| `DLCPromotionAddKey` | 881 |  |
| `DLCPromotionBuyCDLC` | 874 |  |
| `QuestBookToDetails` | 878 |  |
| `QuestBookToQuestList` | 879 |  |
| `OpenQuesttrackerOrArchive` | 893 |  |
| `ArchiveToQuesttracker` | 894 |  |
| `TitleSceneSwitchProfile` | 909 |  |
| `ResidentViewLeaveView` | 897 |  |
| `ResidentViewInteract` | 898 |  |
| `ResidentViewStopInteraction` | 899 |  |
| `ResidentViewHonk` | 900 |  |
| `ResidentViewRun` | 901 |  |
| `ResidentViewJump` | 902 |  |
| `ResidentViewRocketJump` | 903 |  |
| `ResidentViewFeedbackKill` | 922 |  |
| `ResidentViewFeedbackFollow` | 923 |  |
| `ResidentViewFeedbackPray` | 904 |  |
| `ResidentViewFeedbackChaseAway` | 924 |  |
| `ResidentViewSpawnKonfetti` | 905 |  |
| `ResidentViewSpawnWater` | 906 |  |
| `ResidentViewSpawnFireworks` | 907 |  |
| `ResidentViewToggleRain` | 908 |  |
| `ResidentViewToggleSnow` | 925 |  |
| `ToggleCameraModifier` | 911 |  |
| `SpecialNewspaperConfirm` | 951 |  |
| `CrossSaveUpload` | 944 |  |
| `CrossSaveDownload` | 945 |  |
| `ConnectNotificationOpenOverlay` | 946 |  |
| `MPNotificationOnlineMode` | 995 |  |
| `OptionNavigateUp` | 957 |  |
| `OptionNavigateDown` | 958 |  |
| `OptionInteract` | 959 |  |
| `DayTimeCycleToggle` | 964 |  |
| `ExpeditionEventOpenShipMenu` | 970 |  |
| `ExpeditionEventFinishGoodTransfer` | 971 |  |
| `ExpeditionEventRefuseGoodTransfer` | 972 |  |
| `ExpeditionEventAbandonReward` | 973 |  |
| `ExpeditionEventSelect` | 974 |  |
| `ExpeditionEventConfirmReward` | 975 |  |
| `ExpeditionEventConfirmEndResult` | 976 |  |
| `ExpeditionEventChangeTradeAmount` | 977 |  |
| `ExpeditionOverviewToExpeditionList` | 978 |  |
| `ExpeditionOverviewSelectExpedition` | 979 |  |
| `ExpeditionOverviewInspectDetails` | 980 |  |
| `ExpeditionOverviewDeleteExpedition` | 981 |  |
| `ExpeditionOverviewToggleShipDetails` | 982 |  |
| `ExpeditionOverviewUnassignShip` | 983 |  |
| `ExpeditionOverviewJumpToShip` | 984 |  |
| `ExpeditionPreparationStartExpedition` | 992 |  |
| `ExpeditionPreparationExchange` | 993 |  |
| `StartHostileTakeover` | 988 |  |
| `OpenPlayerProfile` | 994 |  |
| `DesyncRecover` | 996 |  |
| `DesyncShowLog` | 997 |  |
| `DesyncBackToTitle` | 998 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>GamepadAction</Name>
  <Id>1966</Id>
  <Items>
    <Item>
      <Name>Blocked</Name>
      <Id>856</Id>
    </Item>
    <Item>
      <Name>ChangeTabLeft</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>ChangeTabRight</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>ChangeSubtabLeft</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>ChangeSubtabRight</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>ChangeTabLeftAlt</Name>
      <Id>174</Id>
    </Item>
    <Item>
      <Name>ChangeTabRightAlt</Name>
      <Id>175</Id>
    </Item>
    <Item>
      <Name>ComboBoxToggle</Name>
      <Id>44</Id>
    </Item>
    <Item>
      <Name>SuperButtonPress</Name>
      <Id>723</Id>
    </Item>
    <Item>
      <Name>SuperButtonRelease</Name>
      <Id>724</Id>
    </Item>
    <Item>
      <Name>PushFocus</Name>
      <Id>118</Id>
    </Item>
    <Item>
      <Name>PullFocus</Name>
      <Id>119</Id>
    </Item>
    <Item>
      <Name>CloseCancel</Name>
      <Id>12</Id>
    </Item>
    <Item>
      <Name>AnyKey</Name>
      <Id>57</Id>
    </Item>
    <Item>
      <Name>ScrollLeft</Name>
      <Id>45</Id>
    </Item>
    <Item>
      <Name>ScrollRight</Name>
      <Id>46</Id>
    </Item>
    <Item>
      <Name>ScrollUp</Name>
      <Id>47</Id>
    </Item>
    <Item>
      <Name>ScrollDown</Name>
      <Id>48</Id>
    </Item>
    <Item>
      <Name>BuildModePrimaryActionPress</Name>
      <Id>725</Id>
    </Item>
    <Item>
      <Name>BuildModePrimaryActionRelease</Name>
      <Id>726</Id>
    </Item>
    <Item>
      <Name>BuildModeSecondaryActionPress</Name>
      <Id>727</Id>
    </Item>
    <Item>
      <Name>BuildModeSecondaryActionRelease</Name>
      <Id>728</Id>
    </Item>
    <Item>
      <Name>BuildModeRotateActionPress</Name>
      <Id>729</Id>
    </Item>
    <Item>
      <Name>BuildModeRotateActionRelease</Name>
      <Id>730</Id>
    </Item>
    <Item>
      <Name>TargetManagerPrimaryActionPress</Name>
      <Id>731</Id>
    </Item>
    <Item>
      <Name>TargetManagerPrimaryActionRelease</Name>
      <Id>732</Id>
    </Item>
    <Item>
      <Name>TargetManagerSecondaryActionPress</Name>
      <Id>733</Id>
    </Item>
    <Item>
      <Name>TargetManagerSecondaryActionRelease</Name>
      <Id>734</Id>
    </Item>
    <Item>
      <Name>TargetManagerModifier</Name>
      <Id>910</Id>
    </Item>
    <Item>
      <Name>TargetManagerClearSelection</Name>
      <Id>171</Id>
    </Item>
    <Item>
      <Name>TargetManagerToggleNotification</Name>
      <Id>173</Id>
    </Item>
    <Item>
      <Name>ConstructionMenuToggleBlueprintMode</Name>
      <Id>615</Id>
    </Item>
    <Item>
      <Name>ConstructionRadialChangeContent</Name>
      <Id>687</Id>
    </Item>
    <Item>
      <Name>ConstructionRadialCategorySorting</Name>
      <Id>111</Id>
    </Item>
    <Item>
      <Name>ConstructionRadialBuildingPlace</Name>
      <Id>112</Id>
    </Item>
    <Item>
      <Name>ConstructionRadialBuildingCancel</Name>
      <Id>113</Id>
    </Item>
    <Item>
      <Name>ConstructionRadialBuildingRotate</Name>
      <Id>641</Id>
    </Item>
    <Item>
      <Name>CameraReset</Name>
      <Id>139</Id>
    </Item>
    <Item>
      <Name>CameraFastMove</Name>
      <Id>104</Id>
    </Item>
    <Item>
      <Name>CameraPitch</Name>
      <Id>140</Id>
    </Item>
    <Item>
      <Name>CameraNavigateToKontorOrNextOfSelection</Name>
      <Id>147</Id>
    </Item>
    <Item>
      <Name>IncreaseGameSpeed</Name>
      <Id>27</Id>
    </Item>
    <Item>
      <Name>DecreaseGameSpeed</Name>
      <Id>26</Id>
    </Item>
    <Item>
      <Name>FocusObjectMenu</Name>
      <Id>36</Id>
    </Item>
    <Item>
      <Name>IslandDetailsJumpToKontor</Name>
      <Id>134</Id>
    </Item>
    <Item>
      <Name>IslandDetailsRandomizeName</Name>
      <Id>666</Id>
    </Item>
    <Item>
      <Name>DiplomacyShowDetails</Name>
      <Id>135</Id>
    </Item>
    <Item>
      <Name>DiplomacyToggleStatesCharacters</Name>
      <Id>138</Id>
    </Item>
    <Item>
      <Name>DiplomacyShowTreaties</Name>
      <Id>34</Id>
    </Item>
    <Item>
      <Name>DiplomacyShowActions</Name>
      <Id>35</Id>
    </Item>
    <Item>
      <Name>DiplomacyComparison</Name>
      <Id>170</Id>
    </Item>
    <Item>
      <Name>DiplomacyHistory</Name>
      <Id>171</Id>
    </Item>
    <Item>
      <Name>TradeChangeAmount</Name>
      <Id>136</Id>
    </Item>
    <Item>
      <Name>TradeThrowOverboard</Name>
      <Id>137</Id>
    </Item>
    <Item>
      <Name>TradeDeleteGood</Name>
      <Id>609</Id>
    </Item>
    <Item>
      <Name>TradeAcceptAmountChange</Name>
      <Id>610</Id>
    </Item>
    <Item>
      <Name>TradeConfirmTrade</Name>
      <Id>168</Id>
    </Item>
    <Item>
      <Name>TradeAddRemove</Name>
      <Id>987</Id>
    </Item>
    <Item>
      <Name>OpenMetaMenuNavigation</Name>
      <Id>14</Id>
    </Item>
    <Item>
      <Name>OpenBuildTools</Name>
      <Id>15</Id>
    </Item>
    <Item>
      <Name>OpenConstructionMenu</Name>
      <Id>166</Id>
    </Item>
    <Item>
      <Name>OpenShipMenuRadial</Name>
      <Id>154</Id>
    </Item>
    <Item>
      <Name>QuickNavigationOpenState</Name>
      <Id>169</Id>
    </Item>
    <Item>
      <Name>QuickNavigationLeaveState</Name>
      <Id>90</Id>
    </Item>
    <Item>
      <Name>QuickNavigationShowPreviousSession</Name>
      <Id>93</Id>
    </Item>
    <Item>
      <Name>QuickNavigationShowNextSession</Name>
      <Id>94</Id>
    </Item>
    <Item>
      <Name>QuickNavigationTeleport</Name>
      <Id>167</Id>
    </Item>
    <Item>
      <Name>QuickNavigationZoomToWorldmap</Name>
      <Id>969</Id>
    </Item>
    <Item>
      <Name>DebugToggleCheatOverlay</Name>
      <Id>960</Id>
    </Item>
    <Item>
      <Name>DebugToggleCheatOverlayAlternative</Name>
      <Id>961</Id>
    </Item>
    <Item>
      <Name>DebugCheatOverlayFavouritesToggle</Name>
      <Id>106</Id>
    </Item>
    <Item>
      <Name>DebugToggleHideUI</Name>
      <Id>962</Id>
    </Item>
    <Item>
      <Name>DebugToggleHideUIAlternative</Name>
      <Id>963</Id>
    </Item>
    <Item>
      <Name>StrategicMapOpenFilters</Name>
      <Id>141</Id>
    </Item>
    <Item>
      <Name>StrategicMapClearAllFilters</Name>
      <Id>142</Id>
    </Item>
    <Item>
      <Name>StrategicMapResetZoom</Name>
      <Id>644</Id>
    </Item>
    <Item>
      <Name>StrategicMapShowPreviousSession</Name>
      <Id>719</Id>
    </Item>
    <Item>
      <Name>StrategicMapShowNextSession</Name>
      <Id>720</Id>
    </Item>
    <Item>
      <Name>SideNotificationFocus</Name>
      <Id>643</Id>
    </Item>
    <Item>
      <Name>InteractNotification</Name>
      <Id>172</Id>
    </Item>
    <Item>
      <Name>FocusTradeRouteMenu</Name>
      <Id>646</Id>
    </Item>
    <Item>
      <Name>FocusCharterRouteMenu</Name>
      <Id>177</Id>
    </Item>
    <Item>
      <Name>DeleteNotification</Name>
      <Id>647</Id>
    </Item>
    <Item>
      <Name>DeleteAllNotifications</Name>
      <Id>708</Id>
    </Item>
    <Item>
      <Name>LoadingPrevTip</Name>
      <Id>167</Id>
    </Item>
    <Item>
      <Name>LoadingNextTip</Name>
      <Id>168</Id>
    </Item>
    <Item>
      <Name>LoadingStart</Name>
      <Id>169</Id>
    </Item>
    <Item>
      <Name>ObjectMenuItemSocketing</Name>
      <Id>738</Id>
    </Item>
    <Item>
      <Name>ObjectMenuItemUnsocketing</Name>
      <Id>739</Id>
    </Item>
    <Item>
      <Name>ObjectMenuItemActivating</Name>
      <Id>740</Id>
    </Item>
    <Item>
      <Name>ObjectMenuIncreaseSliderValue</Name>
      <Id>745</Id>
    </Item>
    <Item>
      <Name>ObjectMenuDecreaseSliderValue</Name>
      <Id>746</Id>
    </Item>
    <Item>
      <Name>ObjectMenuOpenStatistics</Name>
      <Id>741</Id>
    </Item>
    <Item>
      <Name>ProductionOMOpenWorkforcePopup</Name>
      <Id>747</Id>
    </Item>
    <Item>
      <Name>ProductionOMOpenWorkforceScene</Name>
      <Id>748</Id>
    </Item>
    <Item>
      <Name>ProductionOMSaveWorkforcePopup</Name>
      <Id>749</Id>
    </Item>
    <Item>
      <Name>TradeRouteChangeStationOrder</Name>
      <Id>145</Id>
    </Item>
    <Item>
      <Name>TradeRouteOpenStationOptions</Name>
      <Id>144</Id>
    </Item>
    <Item>
      <Name>TradeRouteLoadGood</Name>
      <Id>947</Id>
    </Item>
    <Item>
      <Name>TradeRouteUnloadGood</Name>
      <Id>948</Id>
    </Item>
    <Item>
      <Name>TradeRouteEditGood</Name>
      <Id>949</Id>
    </Item>
    <Item>
      <Name>TradeRouteRemoveGood</Name>
      <Id>205</Id>
    </Item>
    <Item>
      <Name>TradeRoutesAddShip</Name>
      <Id>956</Id>
    </Item>
    <Item>
      <Name>TradeRouteRemoveShip</Name>
      <Id>185</Id>
    </Item>
    <Item>
      <Name>TradeRouteReplaceShip</Name>
      <Id>950</Id>
    </Item>
    <Item>
      <Name>TradeRoutePauseShip</Name>
      <Id>186</Id>
    </Item>
    <Item>
      <Name>TradeRouteDiscardCargo</Name>
      <Id>187</Id>
    </Item>
    <Item>
      <Name>TradeRouteToggleShipDetails</Name>
      <Id>199</Id>
    </Item>
    <Item>
      <Name>TradeRouteDeleteStation</Name>
      <Id>143</Id>
    </Item>
    <Item>
      <Name>TradeRouteLoadToAllSlots</Name>
      <Id>717</Id>
    </Item>
    <Item>
      <Name>TradeRouteUnloadToAllSlots</Name>
      <Id>955</Id>
    </Item>
    <Item>
      <Name>TradeRouteFocusStrategicMap</Name>
      <Id>895</Id>
    </Item>
    <Item>
      <Name>CharterRouteAcceptRoute</Name>
      <Id>872</Id>
    </Item>
    <Item>
      <Name>CharterRouteFocusStrategicMap</Name>
      <Id>896</Id>
    </Item>
    <Item>
      <Name>SystemPopupAccept</Name>
      <Id>188</Id>
    </Item>
    <Item>
      <Name>SystemPopupAcceptHold</Name>
      <Id>912</Id>
    </Item>
    <Item>
      <Name>SystemPopupAcceptAlt</Name>
      <Id>913</Id>
    </Item>
    <Item>
      <Name>SystemPopupAcceptAltHold</Name>
      <Id>914</Id>
    </Item>
    <Item>
      <Name>SystemPopupDecline</Name>
      <Id>189</Id>
    </Item>
    <Item>
      <Name>SystemPopupDeclineHold</Name>
      <Id>926</Id>
    </Item>
    <Item>
      <Name>SystemPopupRetry</Name>
      <Id>933</Id>
    </Item>
    <Item>
      <Name>DeleteExpedition</Name>
      <Id>193</Id>
    </Item>
    <Item>
      <Name>HighlightSpeedBar</Name>
      <Id>640</Id>
    </Item>
    <Item>
      <Name>ShipMenuSelectShip</Name>
      <Id>194</Id>
    </Item>
    <Item>
      <Name>ShipMenuMultiSelectShip</Name>
      <Id>195</Id>
    </Item>
    <Item>
      <Name>ShipMenuClearSelection</Name>
      <Id>166</Id>
    </Item>
    <Item>
      <Name>ShipMenuCreateGroup</Name>
      <Id>176</Id>
    </Item>
    <Item>
      <Name>ShipMenuClearGroup</Name>
      <Id>204</Id>
    </Item>
    <Item>
      <Name>ShipMenuFocusObjectMenu</Name>
      <Id>212</Id>
    </Item>
    <Item>
      <Name>ShipMenuJumpToShip</Name>
      <Id>649</Id>
    </Item>
    <Item>
      <Name>ShipMenuSelectAndJumpToShip</Name>
      <Id>928</Id>
    </Item>
    <Item>
      <Name>ShipMenuMultiSelectAndJumpToShip</Name>
      <Id>929</Id>
    </Item>
    <Item>
      <Name>ShipOMActivateItem</Name>
      <Id>650</Id>
    </Item>
    <Item>
      <Name>ShipOMOpenTransfer</Name>
      <Id>651</Id>
    </Item>
    <Item>
      <Name>ShipOMSwapItem</Name>
      <Id>652</Id>
    </Item>
    <Item>
      <Name>ShipOMThrowOverboard</Name>
      <Id>653</Id>
    </Item>
    <Item>
      <Name>DiscardExpedition</Name>
      <Id>611</Id>
    </Item>
    <Item>
      <Name>ToggleBuildToolMode</Name>
      <Id>613</Id>
    </Item>
    <Item>
      <Name>SharesAccept</Name>
      <Id>622</Id>
    </Item>
    <Item>
      <Name>SharesDecline</Name>
      <Id>623</Id>
    </Item>
    <Item>
      <Name>SharesNavigation</Name>
      <Id>986</Id>
    </Item>
    <Item>
      <Name>SharesSelect</Name>
      <Id>985</Id>
    </Item>
    <Item>
      <Name>NewspaperEnterEdit</Name>
      <Id>624</Id>
    </Item>
    <Item>
      <Name>NewspaperUndoArticleChanges</Name>
      <Id>625</Id>
    </Item>
    <Item>
      <Name>NewspaperMarkAchiveAsFavorite</Name>
      <Id>626</Id>
    </Item>
    <Item>
      <Name>NewspaperOpenAutoPublishPopup</Name>
      <Id>756</Id>
    </Item>
    <Item>
      <Name>NewspaperPublish</Name>
      <Id>737</Id>
    </Item>
    <Item>
      <Name>NewspaperToggleAutoPublish</Name>
      <Id>757</Id>
    </Item>
    <Item>
      <Name>MonumentTogglePhase</Name>
      <Id>174</Id>
    </Item>
    <Item>
      <Name>MonumentEventShowDetails</Name>
      <Id>661</Id>
    </Item>
    <Item>
      <Name>MonumentEventCancelExhibition</Name>
      <Id>664</Id>
    </Item>
    <Item>
      <Name>MonumentEventCollectReward</Name>
      <Id>663</Id>
    </Item>
    <Item>
      <Name>AcceptTime</Name>
      <Id>627</Id>
    </Item>
    <Item>
      <Name>SetTimeUp</Name>
      <Id>628</Id>
    </Item>
    <Item>
      <Name>SetTimeDown</Name>
      <Id>629</Id>
    </Item>
    <Item>
      <Name>SetTimeLeft</Name>
      <Id>630</Id>
    </Item>
    <Item>
      <Name>SetTimeRight</Name>
      <Id>631</Id>
    </Item>
    <Item>
      <Name>EnterShipSelectionBrushMode</Name>
      <Id>117</Id>
    </Item>
    <Item>
      <Name>DeleteQuest</Name>
      <Id>126</Id>
    </Item>
    <Item>
      <Name>TooltipChangeTabLeft</Name>
      <Id>122</Id>
    </Item>
    <Item>
      <Name>TooltipChangeTabRight</Name>
      <Id>123</Id>
    </Item>
    <Item>
      <Name>FocusMapFromTradeRouteOverview</Name>
      <Id>127</Id>
    </Item>
    <Item>
      <Name>FocusTradeRouteOverviewFromMap</Name>
      <Id>128</Id>
    </Item>
    <Item>
      <Name>Quicksave</Name>
      <Id>149</Id>
    </Item>
    <Item>
      <Name>DeleteProfileorSaves</Name>
      <Id>150</Id>
    </Item>
    <Item>
      <Name>HoldAtoDelete</Name>
      <Id>151</Id>
    </Item>
    <Item>
      <Name>BtnQuestbookPopupPageLeft</Name>
      <Id>156</Id>
    </Item>
    <Item>
      <Name>BtnQuestbookPopupPageRight</Name>
      <Id>157</Id>
    </Item>
    <Item>
      <Name>OpenQuestBookFromQuest</Name>
      <Id>158</Id>
    </Item>
    <Item>
      <Name>JumpToQuestLocation</Name>
      <Id>164</Id>
    </Item>
    <Item>
      <Name>MultiselectIslandListItem</Name>
      <Id>160</Id>
    </Item>
    <Item>
      <Name>OpenItemFilters</Name>
      <Id>161</Id>
    </Item>
    <Item>
      <Name>ItemFiltersOpenKeyboard</Name>
      <Id>943</Id>
    </Item>
    <Item>
      <Name>ItemFiltersClear</Name>
      <Id>163</Id>
    </Item>
    <Item>
      <Name>StatisticsCompareItem</Name>
      <Id>844</Id>
    </Item>
    <Item>
      <Name>StatisticsCancelCompareItem</Name>
      <Id>845</Id>
    </Item>
    <Item>
      <Name>StatisticsCycleProductionInformationType</Name>
      <Id>846</Id>
    </Item>
    <Item>
      <Name>StatisticsShowProductionHelp</Name>
      <Id>847</Id>
    </Item>
    <Item>
      <Name>OpenDiplomaticInformation</Name>
      <Id>179</Id>
    </Item>
    <Item>
      <Name>CloseDiplomaticInformation</Name>
      <Id>180</Id>
    </Item>
    <Item>
      <Name>ShipyardOMSetRallyPoint</Name>
      <Id>711</Id>
    </Item>
    <Item>
      <Name>ShipyardOMRemoveFromQueue</Name>
      <Id>712</Id>
    </Item>
    <Item>
      <Name>VisitorOpenAttractiveness</Name>
      <Id>654</Id>
    </Item>
    <Item>
      <Name>EnterPhotoMode</Name>
      <Id>655</Id>
    </Item>
    <Item>
      <Name>TogglePauseMenu</Name>
      <Id>656</Id>
    </Item>
    <Item>
      <Name>MainDiplomaticMiniResponse</Name>
      <Id>660</Id>
    </Item>
    <Item>
      <Name>OpenIslandList</Name>
      <Id>667</Id>
    </Item>
    <Item>
      <Name>CloseIslandList</Name>
      <Id>668</Id>
    </Item>
    <Item>
      <Name>CloseAndSave</Name>
      <Id>673</Id>
    </Item>
    <Item>
      <Name>ClearValueModification</Name>
      <Id>674</Id>
    </Item>
    <Item>
      <Name>UnfocusQuestTracker</Name>
      <Id>675</Id>
    </Item>
    <Item>
      <Name>ScreenCaptureTakePhoto</Name>
      <Id>688</Id>
    </Item>
    <Item>
      <Name>ScreenCaptureSubmitPhoto</Name>
      <Id>689</Id>
    </Item>
    <Item>
      <Name>CulturalBuildingUnsocketItem</Name>
      <Id>690</Id>
    </Item>
    <Item>
      <Name>CreateGameExit</Name>
      <Id>691</Id>
    </Item>
    <Item>
      <Name>CreateGameChangeName</Name>
      <Id>692</Id>
    </Item>
    <Item>
      <Name>CreateGameRandomName</Name>
      <Id>693</Id>
    </Item>
    <Item>
      <Name>CreateGameContinue</Name>
      <Id>694</Id>
    </Item>
    <Item>
      <Name>CreateGameBack</Name>
      <Id>716</Id>
    </Item>
    <Item>
      <Name>CreateGameOpenConnectOverlay</Name>
      <Id>990</Id>
    </Item>
    <Item>
      <Name>ProfileChangeColorLeft</Name>
      <Id>703</Id>
    </Item>
    <Item>
      <Name>ProfileChangeColorRight</Name>
      <Id>704</Id>
    </Item>
    <Item>
      <Name>OpenArchiveFilter</Name>
      <Id>707</Id>
    </Item>
    <Item>
      <Name>TradeRouteOverviewResetFilter</Name>
      <Id>965</Id>
    </Item>
    <Item>
      <Name>RouteOverviewRename</Name>
      <Id>713</Id>
    </Item>
    <Item>
      <Name>RouteOverviewMoveToGroup</Name>
      <Id>714</Id>
    </Item>
    <Item>
      <Name>RouteOverviewDelete</Name>
      <Id>715</Id>
    </Item>
    <Item>
      <Name>QuickSelectNewIslandHarbourBlueprint</Name>
      <Id>892</Id>
    </Item>
    <Item>
      <Name>CustomizeModeNavigateLeft</Name>
      <Id>750</Id>
    </Item>
    <Item>
      <Name>CustomizeModeNavigateRight</Name>
      <Id>751</Id>
    </Item>
    <Item>
      <Name>CustomizeModeCopy</Name>
      <Id>752</Id>
    </Item>
    <Item>
      <Name>CustomizeModePaste</Name>
      <Id>753</Id>
    </Item>
    <Item>
      <Name>CustomizeModeChangeName</Name>
      <Id>754</Id>
    </Item>
    <Item>
      <Name>CustomizeModeRandomizeName</Name>
      <Id>755</Id>
    </Item>
    <Item>
      <Name>CustomizeModeOpenConnectOverlay</Name>
      <Id>989</Id>
    </Item>
    <Item>
      <Name>VideoSkipCutscene</Name>
      <Id>851</Id>
    </Item>
    <Item>
      <Name>TrackQuest</Name>
      <Id>849</Id>
    </Item>
    <Item>
      <Name>AdvancedDifficultyStartGame</Name>
      <Id>852</Id>
    </Item>
    <Item>
      <Name>AdvancedDifficultyRandomize</Name>
      <Id>853</Id>
    </Item>
    <Item>
      <Name>AdvancedDifficultyEditPreset</Name>
      <Id>854</Id>
    </Item>
    <Item>
      <Name>AdvancedDifficultyRemoveCharacter</Name>
      <Id>855</Id>
    </Item>
    <Item>
      <Name>AdvancedDifficultyDeletePreset</Name>
      <Id>865</Id>
    </Item>
    <Item>
      <Name>AdvancedDifficultyBack</Name>
      <Id>873</Id>
    </Item>
    <Item>
      <Name>AdvancedDifficultyMPConfirm</Name>
      <Id>934</Id>
    </Item>
    <Item>
      <Name>MPLobbyManageMode</Name>
      <Id>932</Id>
    </Item>
    <Item>
      <Name>MPLobbyKick</Name>
      <Id>857</Id>
    </Item>
    <Item>
      <Name>MPLobbySwap</Name>
      <Id>858</Id>
    </Item>
    <Item>
      <Name>MPLobbyEditProfile</Name>
      <Id>859</Id>
    </Item>
    <Item>
      <Name>MPLobbyEditAI</Name>
      <Id>930</Id>
    </Item>
    <Item>
      <Name>MPLobbyRemoveAI</Name>
      <Id>860</Id>
    </Item>
    <Item>
      <Name>MPLobbyGameSettings</Name>
      <Id>861</Id>
    </Item>
    <Item>
      <Name>MPLobbyAddPlayers</Name>
      <Id>862</Id>
    </Item>
    <Item>
      <Name>MPLobbyAddAI</Name>
      <Id>890</Id>
    </Item>
    <Item>
      <Name>MPLobbyInvite</Name>
      <Id>863</Id>
    </Item>
    <Item>
      <Name>MPLobbyCancelInvite</Name>
      <Id>871</Id>
    </Item>
    <Item>
      <Name>MPLobbyProfileCustomizationConfirm</Name>
      <Id>887</Id>
    </Item>
    <Item>
      <Name>MPLobbyFirstPartyProfileInfo</Name>
      <Id>931</Id>
    </Item>
    <Item>
      <Name>MpLobbyInviteAnother</Name>
      <Id>937</Id>
    </Item>
    <Item>
      <Name>MpLobbyReinvitePlayer</Name>
      <Id>938</Id>
    </Item>
    <Item>
      <Name>MpLobbyReinviteAll</Name>
      <Id>954</Id>
    </Item>
    <Item>
      <Name>MPLobbyStartGame</Name>
      <Id>870</Id>
    </Item>
    <Item>
      <Name>OpenStaticHelp</Name>
      <Id>864</Id>
    </Item>
    <Item>
      <Name>StaticHelpSelectTagList</Name>
      <Id>880</Id>
    </Item>
    <Item>
      <Name>DLCPromotionAddKey</Name>
      <Id>881</Id>
    </Item>
    <Item>
      <Name>DLCPromotionBuyCDLC</Name>
      <Id>874</Id>
    </Item>
    <Item>
      <Name>QuestBookToDetails</Name>
      <Id>878</Id>
    </Item>
    <Item>
      <Name>QuestBookToQuestList</Name>
      <Id>879</Id>
    </Item>
    <Item>
      <Name>OpenQuesttrackerOrArchive</Name>
      <Id>893</Id>
    </Item>
    <Item>
      <Name>ArchiveToQuesttracker</Name>
      <Id>894</Id>
    </Item>
    <Item>
      <Name>TitleSceneSwitchProfile</Name>
      <Id>909</Id>
    </Item>
    <Item>
      <Name>ResidentViewLeaveView</Name>
      <Id>897</Id>
    </Item>
    <Item>
      <Name>ResidentViewInteract</Name>
      <Id>898</Id>
    </Item>
    <Item>
      <Name>ResidentViewStopInteraction</Name>
      <Id>899</Id>
    </Item>
    <Item>
      <Name>ResidentViewHonk</Name>
      <Id>900</Id>
    </Item>
    <Item>
      <Name>ResidentViewRun</Name>
      <Id>901</Id>
    </Item>
    <Item>
      <Name>ResidentViewJump</Name>
      <Id>902</Id>
    </Item>
    <Item>
      <Name>ResidentViewRocketJump</Name>
      <Id>903</Id>
    </Item>
    <Item>
      <Name>ResidentViewFeedbackKill</Name>
      <Id>922</Id>
    </Item>
    <Item>
      <Name>ResidentViewFeedbackFollow</Name>
      <Id>923</Id>
    </Item>
    <Item>
      <Name>ResidentViewFeedbackPray</Name>
      <Id>904</Id>
    </Item>
    <Item>
      <Name>ResidentViewFeedbackChaseAway</Name>
      <Id>924</Id>
    </Item>
    <Item>
      <Name>ResidentViewSpawnKonfetti</Name>
      <Id>905</Id>
    </Item>
    <Item>
      <Name>ResidentViewSpawnWater</Name>
      <Id>906</Id>
    </Item>
    <Item>
      <Name>ResidentViewSpawnFireworks</Name>
      <Id>907</Id>
    </Item>
    <Item>
      <Name>ResidentViewToggleRain</Name>
      <Id>908</Id>
    </Item>
    <Item>
      <Name>ResidentViewToggleSnow</Name>
      <Id>925</Id>
    </Item>
    <Item>
      <Name>ToggleCameraModifier</Name>
      <Id>911</Id>
    </Item>
    <Item>
      <Name>SpecialNewspaperConfirm</Name>
      <Id>951</Id>
    </Item>
    <Item>
      <Name>CrossSaveUpload</Name>
      <Id>944</Id>
    </Item>
    <Item>
      <Name>CrossSaveDownload</Name>
      <Id>945</Id>
    </Item>
    <Item>
      <Name>ConnectNotificationOpenOverlay</Name>
      <Id>946</Id>
    </Item>
    <Item>
      <Name>MPNotificationOnlineMode</Name>
      <Id>995</Id>
    </Item>
    <Item>
      <Name>OptionNavigateUp</Name>
      <Id>957</Id>
    </Item>
    <Item>
      <Name>OptionNavigateDown</Name>
      <Id>958</Id>
    </Item>
    <Item>
      <Name>OptionInteract</Name>
      <Id>959</Id>
    </Item>
    <Item>
      <Name>DayTimeCycleToggle</Name>
      <Id>964</Id>
    </Item>
    <Item>
      <Name>ExpeditionEventOpenShipMenu</Name>
      <Id>970</Id>
    </Item>
    <Item>
      <Name>ExpeditionEventFinishGoodTransfer</Name>
      <Id>971</Id>
    </Item>
    <Item>
      <Name>ExpeditionEventRefuseGoodTransfer</Name>
      <Id>972</Id>
    </Item>
    <Item>
      <Name>ExpeditionEventAbandonReward</Name>
      <Id>973</Id>
    </Item>
    <Item>
      <Name>ExpeditionEventSelect</Name>
      <Id>974</Id>
    </Item>
    <Item>
      <Name>ExpeditionEventConfirmReward</Name>
      <Id>975</Id>
    </Item>
    <Item>
      <Name>ExpeditionEventConfirmEndResult</Name>
      <Id>976</Id>
    </Item>
    <Item>
      <Name>ExpeditionEventChangeTradeAmount</Name>
      <Id>977</Id>
    </Item>
    <Item>
      <Name>ExpeditionOverviewToExpeditionList</Name>
      <Id>978</Id>
    </Item>
    <Item>
      <Name>ExpeditionOverviewSelectExpedition</Name>
      <Id>979</Id>
    </Item>
    <Item>
      <Name>ExpeditionOverviewInspectDetails</Name>
      <Id>980</Id>
    </Item>
    <Item>
      <Name>ExpeditionOverviewDeleteExpedition</Name>
      <Id>981</Id>
    </Item>
    <Item>
      <Name>ExpeditionOverviewToggleShipDetails</Name>
      <Id>982</Id>
    </Item>
    <Item>
      <Name>ExpeditionOverviewUnassignShip</Name>
      <Id>983</Id>
    </Item>
    <Item>
      <Name>ExpeditionOverviewJumpToShip</Name>
      <Id>984</Id>
    </Item>
    <Item>
      <Name>ExpeditionPreparationStartExpedition</Name>
      <Id>992</Id>
    </Item>
    <Item>
      <Name>ExpeditionPreparationExchange</Name>
      <Id>993</Id>
    </Item>
    <Item>
      <Name>StartHostileTakeover</Name>
      <Id>988</Id>
    </Item>
    <Item>
      <Name>OpenPlayerProfile</Name>
      <Id>994</Id>
    </Item>
    <Item>
      <Name>DesyncRecover</Name>
      <Id>996</Id>
    </Item>
    <Item>
      <Name>DesyncShowLog</Name>
      <Id>997</Id>
    </Item>
    <Item>
      <Name>DesyncBackToTitle</Name>
      <Id>998</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-happinesscategory"></a>
<details>
<summary>HappinessCategory — all tokens, IDs and native metadata</summary>

Source: datasets.xml:1016. Dataset Id=1925.

| Token | Id | Native description |
| --- | --- | --- |
| `WorkingConditions` | 0 |  |
| `Pollution` | 1 |  |
| `Needs` | 2 |  |
| `War` | 3 |  |
| `Newspaper` | 4 |  |
| `Hotspots` | 5 |  |
| `Attractiveness` | 6 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>HappinessCategory</Name>
  <Id>1925</Id>
  <Items>
    <Item>
      <Name>WorkingConditions</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Pollution</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Needs</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>War</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Newspaper</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>Hotspots</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>Attractiveness</Name>
      <Id>6</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-happinessstate"></a>
<details>
<summary>HappinessState — all tokens, IDs and native metadata</summary>

Source: datasets.xml:1064. Dataset Id=1727.

| Token | Id | Native description |
| --- | --- | --- |
| `Angry` | 0 |  |
| `Unhappy` | 1 |  |
| `Neutral` | 2 |  |
| `Happy` | 3 |  |
| `Euphoric` | 4 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>HappinessState</Name>
  <Id>1727</Id>
  <Items>
    <Item>
      <Name>Angry</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Unhappy</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Neutral</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Happy</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Euphoric</Name>
      <Id>4</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-industrializationtype"></a>
<details>
<summary>IndustrializationType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:19690. Dataset Id=1874.

| Token | Id | Native description |
| --- | --- | --- |
| `Powerplant` | 0 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>IndustrializationType</Name>
  <Id>1874</Id>
  <Description>Dataset describing the type of buff that should be applied to targets</Description>
  <Items>
    <Item>
      <Name>Powerplant</Name>
      <Id>0</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-inputmode"></a>
<details>
<summary>InputMode — all tokens, IDs and native metadata</summary>

Source: datasets.xml:1466. Dataset Id=2091.

| Token | Id | Native description |
| --- | --- | --- |
| `MouseKeyboard` | 0 |  |
| `Gamepad` | 1 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>InputMode</Name>
  <Id>2091</Id>
  <Items>
    <Item>
      <Name>MouseKeyboard</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Gamepad</Name>
      <Id>1</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-lockscope"></a>
<details>
<summary>LockScope — all tokens, IDs and native metadata</summary>

Source: datasets.xml:1512. Dataset Id=1742.

| Token | Id | Native description |
| --- | --- | --- |
| `Account` | 0 |  |
| `MetaGame` | 1 |  |
| `Participant` | 2 |  |
| `GGJ` | 3 |  |
| `CrossPlatform` | 4 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>LockScope</Name>
  <Id>1742</Id>
  <Items>
    <Item>
      <Name>Account</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>MetaGame</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Participant</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>GGJ</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>CrossPlatform</Name>
      <Id>4</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-ministrydecreetier"></a>
<details>
<summary>MinistryDecreeTier — all tokens, IDs and native metadata</summary>

Source: datasets.xml:18885. Dataset Id=1870.

| Token | Id | Native description |
| --- | --- | --- |
| `Tier1Decree` | 0 |  |
| `Tier2Decree` | 1 |  |
| `Tier3Decree` | 2 |  |
| `Tier4Decree` | 3 |  |
| `Tier5Decree` | 4 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>MinistryDecreeTier</Name>
  <Id>1870</Id>
  <Items>
    <Item>
      <Name>Tier1Decree</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Tier2Decree</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Tier3Decree</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Tier4Decree</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Tier5Decree</Name>
      <Id>4</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-mutualareamask"></a>
<details>
<summary>MutualAreaMask — all tokens, IDs and native metadata</summary>

Source: datasets.xml:17576. Dataset Id=1811.

| Token | Id | Native description |
| --- | --- | --- |
| `MostPopulatedArea` | 0 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>MutualAreaMask</Name>
  <Id>1811</Id>
  <Description>Only the area with the highest population of all tiers summed up will be chosen</Description>
  <Items>
    <Item>
      <Name>MostPopulatedArea</Name>
      <Id>0</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-palaceministrytype"></a>
<details>
<summary>PalaceMinistryType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:18974. Dataset Id=1869.

| Token | Id | Native description |
| --- | --- | --- |
| `City` | 0 |  |
| `Culture` | 1 |  |
| `Productivity` | 2 |  |
| `Service` | 3 |  |
| `Harbor` | 4 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>PalaceMinistryType</Name>
  <Id>1869</Id>
  <Items>
    <Item>
      <Name>City</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Culture</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Productivity</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Service</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Harbor</Name>
      <Id>4</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-participantid"></a>
<details>
<summary>ParticipantID — all tokens, IDs and native metadata</summary>

Source: datasets.xml:12956. Dataset Id=349.

| Token | Id | Native description |
| --- | --- | --- |
| `Human0` | 0 |  |
| `Human1` | 1 |  |
| `Human2` | 2 |  |
| `Human3` | 3 |  |
| `Human4` | 4 |  |
| `Human5` | 5 |  |
| `Human6` | 6 |  |
| `Human7` | 7 |  |
| `Neutral` | 8 |  |
| `General_Enemy` | 9 |  |
| `Test_Doedel` | 10 |  |
| `Advisor_01_Hannah` | 11 |  |
| `Advisor_01_Hannah_BlackDress` | 69 |  |
| `Advisor_02_Aahrant` | 12 |  |
| `Third_enemy_01_Grant` | 13 |  |
| `Third_party_01_Queen` | 15 |  |
| `Third_party_02_Blake` | 16 |  |
| `Third_party_03_Pirate_Harlow` | 17 |  |
| `Third_party_04_Pirate_LaFortune` | 18 |  |
| `Third_party_05_Sarmento` | 19 |  |
| `Third_party_05b_Sarmento_Prosperity_Campaign` | 62 |  |
| `Third_party_05c_Sarmento_Attackable_Campaign` | 63 |  |
| `Third_party_06_Nate` | 20 |  |
| `Third_party_07_Jailor_Bleakworth` | 21 |  |
| `Third_party_08_Kahina` | 22 |  |
| `Second_ai_01_Jorgensen` | 23 |  |
| `Second_ai_02_Qing` | 24 |  |
| `Second_ai_03_Wibblesock` | 25 |  |
| `Second_ai_04_Smith` | 26 |  |
| `Second_ai_05_OMara` | 27 |  |
| `Second_ai_06_Gasparov` | 29 |  |
| `Second_ai_07_von_Malching` | 28 |  |
| `Second_ai_08_Gravez` | 30 |  |
| `Second_ai_09_Silva` | 31 |  |
| `Second_ai_10_Hunt` | 32 |  |
| `Resident_tier01` | 33 |  |
| `Resident_tier02` | 34 |  |
| `Resident_tier03` | 35 |  |
| `Resident_tier04` | 36 |  |
| `Resident_tier05` | 37 |  |
| `Captain` | 38 |  |
| `Visitor` | 39 |  |
| `Editor` | 40 |  |
| `Event_character_01_Arctic` | 41 |  |
| `Campaign_character_01_demolition_expert` | 42 |  |
| `Campaign_character_02_pyrophorian_red` | 45 |  |
| `Campaign_character_02_pyrophorian_red_blinded` | 51 |  |
| `Campaign_character_03_pyrophorian_silver` | 48 |  |
| `Campaign_character_04_pyrophorian_gold` | 47 |  |
| `Campaign_character_07_magistrate` | 46 |  |
| `Campaign_character_08_cousin_female` | 49 |  |
| `Campaign_character_09_cousin_male` | 50 |  |
| `Campaign_character_10_SA_ticketseller` | 52 |  |
| `SA_Resident_tier01` | 53 |  |
| `SA_Resident_tier02` | 54 |  |
| `SA_Resident_tier01_atWork` | 55 |  |
| `SA_Resident_tier02_atWork` | 56 |  |
| `Resident_tier01_atWork` | 57 |  |
| `Resident_tier02_atWork` | 58 |  |
| `Resident_tier03_atWork` | 59 |  |
| `Resident_tier04_atWork` | 60 |  |
| `Resident_tier05_atWork` | 61 |  |
| `Workforce_Commuter_Captain` | 64 |  |
| `Campaign_character_04b_pyrophorian_gold_nonattackable` | 70 |  |
| `Second_ai_11_Mercier` | 72 |  |
| `Third_party_09_Vasco_Silva` | 73 |  |
| `Mercier_DeserterWorker` | 74 |  |
| `Arctic_Resident_tier01` | 81 |  |
| `Arctic_Resident_tier02` | 82 |  |
| `Arctic_Resident_tier01_atWork` | 83 |  |
| `Arctic_Resident_tier02_atWork` | 84 |  |
| `Arctic_LadyFaithful` | 85 |  |
| `Arctic_Inuit` | 86 |  |
| `Arctic_SirJohn` | 88 |  |
| `Third_party_02b_Blake_AttacksPirate` | 87 |  |
| `Africa_Resident_tier01` | 89 |  |
| `Africa_Resident_tier02` | 90 |  |
| `Africa_Kyria` | 91 |  |
| `Third_party_06b_Nate_Arctic` | 93 |  |
| `Africa_Resident_tier03` | 96 |  |
| `Africa_Ketema` | 97 |  |
| `Africa_Biniam` | 103 |  |
| `Africa_Blake` | 98 |  |
| `Africa_Kidusi` | 99 |  |
| `Africa_Angereb` | 100 |  |
| `Africa_Waha` | 101 |  |
| `Africa_Goat` | 104 |  |
| `Africa_Zebra` | 105 |  |
| `Africa_Hyena` | 106 |  |
| `Africa_Hippopotamus` | 107 |  |
| `Africa_Cheetah` | 108 |  |
| `Africa_Lion` | 109 |  |
| `Africa_Nomads` | 110 |  |
| `Africa_KetemaFake` | 111 |  |
| `Africa_Building` | 112 |  |
| `Void_Trader` | 114 |  |
| `Resident_Tourist` | 115 |  |
| `Resident_Tourist_atWork` | 116 |  |
| `HighLife_Donald` | 117 |  |
| `HighLife_JennyEng` | 118 |  |
| `HighLife_JennyWorker` | 119 |  |
| `HighLife_William` | 120 |  |
| `GGJ_Isabel` | 121 |  |
| `GGJ_OldNate` | 122 |  |
| `GGJ_SA_ResidentTier01` | 123 |  |
| `GGJ_SA_ResidentTier01_AtWork` | 124 |  |
| `GGJ_SA_ResidentTier02` | 125 |  |
| `GGJ_SA_ResidentTier02_AtWork` | 126 |  |
| `GGJ_Yaosca` | 127 |  |
| `GGJ_Pyrphorian` | 128 |  |
| `GGJ_Fisherman` | 129 |  |
| `GGJ_Maya` | 131 |  |
| `Scenario02_Vasco` | 132 |  |
| `Scenario02_Actuary` | 133 |  |
| `Scenario02_Questgiver` | 134 |  |
| `Paloma` | 135 |  |
| `Scenario3_Paloma` | 136 |  |
| `Scenario3_Editor` | 137 |  |
| `Scenario3_Challenger1` | 138 |  |
| `Scenario3_Challenger2` | 139 |  |
| `Scenario3_Challenger3` | 140 |  |
| `Scenario3_Challenger4` | 141 |  |
| `Scenario3_Challenger5` | 142 |  |
| `Scenario3_Challenger6` | 143 |  |
| `Scenario3_Challenger7` | 144 |  |
| `Scenario3_Challenger8` | 145 |  |
| `Scenario3_Challenger9` | 146 |  |
| `Scenario3_Challenger10` | 147 |  |
| `Scenario3_Challenger11` | 148 |  |
| `Scenario3_Challenger12` | 149 |  |
| `Scenario3_Queen` | 150 |  |
| `Scenario3_Mercier` | 151 |  |
| `Scenario3_Bente` | 152 |  |
| `Scenario3_Fortune` | 153 |  |
| `Scenario3_Nate` | 154 |  |
| `Scenario3_Mara` | 155 |  |
| `Scenario3_Eli` | 156 |  |
| `Scenario3_Ketema` | 157 |  |
| `Scenario3_Archie` | 158 |  |
| `Scenario_Item_Trader` | 160 |  |
| `Scenario4_Kahina` | 161 |  |
| `SA_Resident_tier03` | 162 |  |
| `SA_Resident_tier03_atWork` | 163 |  |
| `Scenario4_Trader_Hunt` | 164 |  |
| `Scenario4_Trader_Malching` | 165 |  |
| `Scenario4_Trader_DaSilva` | 166 |  |
| `Scenario4_Trader_Yaosca` | 167 |  |
| `Scenario4_Trader_Paloma` | 168 |  |
| `Scenario4_Book` | 170 |  |
| `Mod1` | 171 |  |
| `Mod2` | 172 |  |
| `Mod3` | 173 |  |
| `Mod4` | 174 |  |
| `Mod5` | 175 |  |
| `Mod6` | 176 |  |
| `Mod7` | 177 |  |
| `Mod8` | 178 |  |
| `Mod9` | 179 |  |
| `Mod10` | 180 |  |
| `Mod11` | 181 |  |
| `Mod12` | 182 |  |
| `Mod13` | 183 |  |
| `Mod14` | 184 |  |
| `Mod15` | 185 |  |
| `Mod16` | 186 |  |
| `Mod17` | 187 |  |
| `Mod18` | 188 |  |
| `Mod19` | 189 |  |
| `Mod20` | 190 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>ParticipantID</Name>
  <Id>349</Id>
  <Description>DO NOT CHANGE ORDER! Enumeration of all possible participants. H0 - H7 are reserved for Human (Multi-)Players.</Description>
  <Items>
    <Item>
      <Name>Human0</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Human1</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Human2</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Human3</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Human4</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>Human5</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>Human6</Name>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>Human7</Name>
      <Id>7</Id>
    </Item>
    <Item>
      <Name>Neutral</Name>
      <Id>8</Id>
    </Item>
    <Item>
      <Name>General_Enemy</Name>
      <Id>9</Id>
    </Item>
    <Item>
      <Name>Test_Doedel</Name>
      <Id>10</Id>
    </Item>
    <Item>
      <Name>Advisor_01_Hannah</Name>
      <Id>11</Id>
    </Item>
    <Item>
      <Name>Advisor_01_Hannah_BlackDress</Name>
      <Id>69</Id>
    </Item>
    <Item>
      <Name>Advisor_02_Aahrant</Name>
      <Id>12</Id>
    </Item>
    <Item>
      <Name>Third_enemy_01_Grant</Name>
      <Id>13</Id>
    </Item>
    <Item>
      <Name>Third_party_01_Queen</Name>
      <Id>15</Id>
    </Item>
    <Item>
      <Name>Third_party_02_Blake</Name>
      <Id>16</Id>
    </Item>
    <Item>
      <Name>Third_party_03_Pirate_Harlow</Name>
      <Id>17</Id>
    </Item>
    <Item>
      <Name>Third_party_04_Pirate_LaFortune</Name>
      <Id>18</Id>
    </Item>
    <Item>
      <Name>Third_party_05_Sarmento</Name>
      <Id>19</Id>
    </Item>
    <Item>
      <Name>Third_party_05b_Sarmento_Prosperity_Campaign</Name>
      <Id>62</Id>
    </Item>
    <Item>
      <Name>Third_party_05c_Sarmento_Attackable_Campaign</Name>
      <Id>63</Id>
    </Item>
    <Item>
      <Name>Third_party_06_Nate</Name>
      <Id>20</Id>
    </Item>
    <Item>
      <Name>Third_party_07_Jailor_Bleakworth</Name>
      <Id>21</Id>
    </Item>
    <Item>
      <Name>Third_party_08_Kahina</Name>
      <Id>22</Id>
    </Item>
    <Item>
      <Name>Second_ai_01_Jorgensen</Name>
      <Id>23</Id>
    </Item>
    <Item>
      <Name>Second_ai_02_Qing</Name>
      <Id>24</Id>
    </Item>
    <Item>
      <Name>Second_ai_03_Wibblesock</Name>
      <Id>25</Id>
    </Item>
    <Item>
      <Name>Second_ai_04_Smith</Name>
      <Id>26</Id>
    </Item>
    <Item>
      <Name>Second_ai_05_OMara</Name>
      <Id>27</Id>
    </Item>
    <Item>
      <Name>Second_ai_06_Gasparov</Name>
      <Id>29</Id>
    </Item>
    <Item>
      <Name>Second_ai_07_von_Malching</Name>
      <Id>28</Id>
    </Item>
    <Item>
      <Name>Second_ai_08_Gravez</Name>
      <Id>30</Id>
    </Item>
    <Item>
      <Name>Second_ai_09_Silva</Name>
      <Id>31</Id>
    </Item>
    <Item>
      <Name>Second_ai_10_Hunt</Name>
      <Id>32</Id>
    </Item>
    <Item>
      <Name>Resident_tier01</Name>
      <Id>33</Id>
    </Item>
    <Item>
      <Name>Resident_tier02</Name>
      <Id>34</Id>
    </Item>
    <Item>
      <Name>Resident_tier03</Name>
      <Id>35</Id>
    </Item>
    <Item>
      <Name>Resident_tier04</Name>
      <Id>36</Id>
    </Item>
    <Item>
      <Name>Resident_tier05</Name>
      <Id>37</Id>
    </Item>
    <Item>
      <Name>Captain</Name>
      <Id>38</Id>
    </Item>
    <Item>
      <Name>Visitor</Name>
      <Id>39</Id>
    </Item>
    <Item>
      <Name>Editor</Name>
      <Id>40</Id>
    </Item>
    <Item>
      <Name>Event_character_01_Arctic</Name>
      <Id>41</Id>
    </Item>
    <Item>
      <Name>Campaign_character_01_demolition_expert</Name>
      <Id>42</Id>
    </Item>
    <Item>
      <Name>Campaign_character_02_pyrophorian_red</Name>
      <Id>45</Id>
    </Item>
    <Item>
      <Name>Campaign_character_02_pyrophorian_red_blinded</Name>
      <Id>51</Id>
    </Item>
    <Item>
      <Name>Campaign_character_03_pyrophorian_silver</Name>
      <Id>48</Id>
    </Item>
    <Item>
      <Name>Campaign_character_04_pyrophorian_gold</Name>
      <Id>47</Id>
    </Item>
    <Item>
      <Name>Campaign_character_07_magistrate</Name>
      <Id>46</Id>
    </Item>
    <Item>
      <Name>Campaign_character_08_cousin_female</Name>
      <Id>49</Id>
    </Item>
    <Item>
      <Name>Campaign_character_09_cousin_male</Name>
      <Id>50</Id>
    </Item>
    <Item>
      <Name>Campaign_character_10_SA_ticketseller</Name>
      <Id>52</Id>
    </Item>
    <Item>
      <Name>SA_Resident_tier01</Name>
      <Id>53</Id>
    </Item>
    <Item>
      <Name>SA_Resident_tier02</Name>
      <Id>54</Id>
    </Item>
    <Item>
      <Name>SA_Resident_tier01_atWork</Name>
      <Id>55</Id>
    </Item>
    <Item>
      <Name>SA_Resident_tier02_atWork</Name>
      <Id>56</Id>
    </Item>
    <Item>
      <Name>Resident_tier01_atWork</Name>
      <Id>57</Id>
    </Item>
    <Item>
      <Name>Resident_tier02_atWork</Name>
      <Id>58</Id>
    </Item>
    <Item>
      <Name>Resident_tier03_atWork</Name>
      <Id>59</Id>
    </Item>
    <Item>
      <Name>Resident_tier04_atWork</Name>
      <Id>60</Id>
    </Item>
    <Item>
      <Name>Resident_tier05_atWork</Name>
      <Id>61</Id>
    </Item>
    <Item>
      <Name>Workforce_Commuter_Captain</Name>
      <Id>64</Id>
    </Item>
    <Item>
      <Name>Campaign_character_04b_pyrophorian_gold_nonattackable</Name>
      <Id>70</Id>
    </Item>
    <Item>
      <Name>Second_ai_11_Mercier</Name>
      <Id>72</Id>
    </Item>
    <Item>
      <Name>Third_party_09_Vasco_Silva</Name>
      <Id>73</Id>
    </Item>
    <Item>
      <Name>Mercier_DeserterWorker</Name>
      <Id>74</Id>
    </Item>
    <Item>
      <Name>Arctic_Resident_tier01</Name>
      <Id>81</Id>
    </Item>
    <Item>
      <Name>Arctic_Resident_tier02</Name>
      <Id>82</Id>
    </Item>
    <Item>
      <Name>Arctic_Resident_tier01_atWork</Name>
      <Id>83</Id>
    </Item>
    <Item>
      <Name>Arctic_Resident_tier02_atWork</Name>
      <Id>84</Id>
    </Item>
    <Item>
      <Name>Arctic_LadyFaithful</Name>
      <Id>85</Id>
    </Item>
    <Item>
      <Name>Arctic_Inuit</Name>
      <Id>86</Id>
    </Item>
    <Item>
      <Name>Arctic_SirJohn</Name>
      <Id>88</Id>
    </Item>
    <Item>
      <Name>Third_party_02b_Blake_AttacksPirate</Name>
      <Id>87</Id>
    </Item>
    <Item>
      <Name>Africa_Resident_tier01</Name>
      <Id>89</Id>
    </Item>
    <Item>
      <Name>Africa_Resident_tier02</Name>
      <Id>90</Id>
    </Item>
    <Item>
      <Name>Africa_Kyria</Name>
      <Id>91</Id>
    </Item>
    <Item>
      <Name>Third_party_06b_Nate_Arctic</Name>
      <Id>93</Id>
    </Item>
    <Item>
      <Name>Africa_Resident_tier03</Name>
      <Id>96</Id>
    </Item>
    <Item>
      <Name>Africa_Ketema</Name>
      <Id>97</Id>
    </Item>
    <Item>
      <Name>Africa_Biniam</Name>
      <Id>103</Id>
    </Item>
    <Item>
      <Name>Africa_Blake</Name>
      <Id>98</Id>
    </Item>
    <Item>
      <Name>Africa_Kidusi</Name>
      <Id>99</Id>
    </Item>
    <Item>
      <Name>Africa_Angereb</Name>
      <Id>100</Id>
    </Item>
    <Item>
      <Name>Africa_Waha</Name>
      <Id>101</Id>
    </Item>
    <Item>
      <Name>Africa_Goat</Name>
      <Id>104</Id>
    </Item>
    <Item>
      <Name>Africa_Zebra</Name>
      <Id>105</Id>
    </Item>
    <Item>
      <Name>Africa_Hyena</Name>
      <Id>106</Id>
    </Item>
    <Item>
      <Name>Africa_Hippopotamus</Name>
      <Id>107</Id>
    </Item>
    <Item>
      <Name>Africa_Cheetah</Name>
      <Id>108</Id>
    </Item>
    <Item>
      <Name>Africa_Lion</Name>
      <Id>109</Id>
    </Item>
    <Item>
      <Name>Africa_Nomads</Name>
      <Id>110</Id>
    </Item>
    <Item>
      <Name>Africa_KetemaFake</Name>
      <Id>111</Id>
    </Item>
    <Item>
      <Name>Africa_Building</Name>
      <Id>112</Id>
    </Item>
    <Item>
      <Name>Void_Trader</Name>
      <Id>114</Id>
    </Item>
    <Item>
      <Name>Resident_Tourist</Name>
      <Id>115</Id>
    </Item>
    <Item>
      <Name>Resident_Tourist_atWork</Name>
      <Id>116</Id>
    </Item>
    <Item>
      <Name>HighLife_Donald</Name>
      <Id>117</Id>
    </Item>
    <Item>
      <Name>HighLife_JennyEng</Name>
      <Id>118</Id>
    </Item>
    <Item>
      <Name>HighLife_JennyWorker</Name>
      <Id>119</Id>
    </Item>
    <Item>
      <Name>HighLife_William</Name>
      <Id>120</Id>
    </Item>
    <Item>
      <Name>GGJ_Isabel</Name>
      <Id>121</Id>
    </Item>
    <Item>
      <Name>GGJ_OldNate</Name>
      <Id>122</Id>
    </Item>
    <Item>
      <Name>GGJ_SA_ResidentTier01</Name>
      <Id>123</Id>
    </Item>
    <Item>
      <Name>GGJ_SA_ResidentTier01_AtWork</Name>
      <Id>124</Id>
    </Item>
    <Item>
      <Name>GGJ_SA_ResidentTier02</Name>
      <Id>125</Id>
    </Item>
    <Item>
      <Name>GGJ_SA_ResidentTier02_AtWork</Name>
      <Id>126</Id>
    </Item>
    <Item>
      <Name>GGJ_Yaosca</Name>
      <Id>127</Id>
    </Item>
    <Item>
      <Name>GGJ_Pyrphorian</Name>
      <Id>128</Id>
    </Item>
    <Item>
      <Name>GGJ_Fisherman</Name>
      <Id>129</Id>
    </Item>
    <Item>
      <Name>GGJ_Maya</Name>
      <Id>131</Id>
    </Item>
    <Item>
      <Name>Scenario02_Vasco</Name>
      <Id>132</Id>
    </Item>
    <Item>
      <Name>Scenario02_Actuary</Name>
      <Id>133</Id>
    </Item>
    <Item>
      <Name>Scenario02_Questgiver</Name>
      <Id>134</Id>
    </Item>
    <Item>
      <Name>Paloma</Name>
      <Id>135</Id>
    </Item>
    <Item>
      <Name>Scenario3_Paloma</Name>
      <Id>136</Id>
    </Item>
    <Item>
      <Name>Scenario3_Editor</Name>
      <Id>137</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger1</Name>
      <Id>138</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger2</Name>
      <Id>139</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger3</Name>
      <Id>140</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger4</Name>
      <Id>141</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger5</Name>
      <Id>142</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger6</Name>
      <Id>143</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger7</Name>
      <Id>144</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger8</Name>
      <Id>145</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger9</Name>
      <Id>146</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger10</Name>
      <Id>147</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger11</Name>
      <Id>148</Id>
    </Item>
    <Item>
      <Name>Scenario3_Challenger12</Name>
      <Id>149</Id>
    </Item>
    <Item>
      <Name>Scenario3_Queen</Name>
      <Id>150</Id>
    </Item>
    <Item>
      <Name>Scenario3_Mercier</Name>
      <Id>151</Id>
    </Item>
    <Item>
      <Name>Scenario3_Bente</Name>
      <Id>152</Id>
    </Item>
    <Item>
      <Name>Scenario3_Fortune</Name>
      <Id>153</Id>
    </Item>
    <Item>
      <Name>Scenario3_Nate</Name>
      <Id>154</Id>
    </Item>
    <Item>
      <Name>Scenario3_Mara</Name>
      <Id>155</Id>
    </Item>
    <Item>
      <Name>Scenario3_Eli</Name>
      <Id>156</Id>
    </Item>
    <Item>
      <Name>Scenario3_Ketema</Name>
      <Id>157</Id>
    </Item>
    <Item>
      <Name>Scenario3_Archie</Name>
      <Id>158</Id>
    </Item>
    <Item>
      <Name>Scenario_Item_Trader</Name>
      <Id>160</Id>
    </Item>
    <Item>
      <Name>Scenario4_Kahina</Name>
      <Id>161</Id>
    </Item>
    <Item>
      <Name>SA_Resident_tier03</Name>
      <Id>162</Id>
    </Item>
    <Item>
      <Name>SA_Resident_tier03_atWork</Name>
      <Id>163</Id>
    </Item>
    <Item>
      <Name>Scenario4_Trader_Hunt</Name>
      <Id>164</Id>
    </Item>
    <Item>
      <Name>Scenario4_Trader_Malching</Name>
      <Id>165</Id>
    </Item>
    <Item>
      <Name>Scenario4_Trader_DaSilva</Name>
      <Id>166</Id>
    </Item>
    <Item>
      <Name>Scenario4_Trader_Yaosca</Name>
      <Id>167</Id>
    </Item>
    <Item>
      <Name>Scenario4_Trader_Paloma</Name>
      <Id>168</Id>
    </Item>
    <Item>
      <Name>Scenario4_Book</Name>
      <Id>170</Id>
    </Item>
    <Item>
      <Name>Mod1</Name>
      <Id>171</Id>
    </Item>
    <Item>
      <Name>Mod2</Name>
      <Id>172</Id>
    </Item>
    <Item>
      <Name>Mod3</Name>
      <Id>173</Id>
    </Item>
    <Item>
      <Name>Mod4</Name>
      <Id>174</Id>
    </Item>
    <Item>
      <Name>Mod5</Name>
      <Id>175</Id>
    </Item>
    <Item>
      <Name>Mod6</Name>
      <Id>176</Id>
    </Item>
    <Item>
      <Name>Mod7</Name>
      <Id>177</Id>
    </Item>
    <Item>
      <Name>Mod8</Name>
      <Id>178</Id>
    </Item>
    <Item>
      <Name>Mod9</Name>
      <Id>179</Id>
    </Item>
    <Item>
      <Name>Mod10</Name>
      <Id>180</Id>
    </Item>
    <Item>
      <Name>Mod11</Name>
      <Id>181</Id>
    </Item>
    <Item>
      <Name>Mod12</Name>
      <Id>182</Id>
    </Item>
    <Item>
      <Name>Mod13</Name>
      <Id>183</Id>
    </Item>
    <Item>
      <Name>Mod14</Name>
      <Id>184</Id>
    </Item>
    <Item>
      <Name>Mod15</Name>
      <Id>185</Id>
    </Item>
    <Item>
      <Name>Mod16</Name>
      <Id>186</Id>
    </Item>
    <Item>
      <Name>Mod17</Name>
      <Id>187</Id>
    </Item>
    <Item>
      <Name>Mod18</Name>
      <Id>188</Id>
    </Item>
    <Item>
      <Name>Mod19</Name>
      <Id>189</Id>
    </Item>
    <Item>
      <Name>Mod20</Name>
      <Id>190</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-playercounter"></a>
<details>
<summary>PlayerCounter — all tokens, IDs and native metadata</summary>

Source: datasets.xml:11080. Dataset Id=335.

| Token | Id | Native description |
| --- | --- | --- |
| `ObjectBuilt` | 0 | Context: ObjectGUID |
| `TradeProductBought` | 1 |  |
| `TradeProductSold` | 2 |  |
| `PopulationByLevel` | 3 |  |
| `PopulationByGroup` | 4 |  |
| `PopulationTotal` | 5 |  |
| `GoodsInStock` | 6 |  |
| `ObjectDestroyed` | 7 |  |
| `ObjectLost` | 8 |  |
| `StreetConnection` | 9 |  |
| `NoStreetConnection` | 10 |  |
| `AchievementPoints` | 11 |  |
| `CorporationLevel` | 12 |  |
| `BuildingsMoved` | 13 |  |
| `IslandSettled` | 14 |  |
| `BuildingsDemolished` | 15 |  |
| `MaxAchievementPoints` | 16 |  |
| `MaxCityStatus` | 17 |  |
| `QuestCalled` | 18 |  |
| `QuestEnded` | 19 |  |
| `QuestSolved` | 20 |  |
| `QuestAbortedManually` | 21 |  |
| `BankruptCounter` | 22 |  |
| `PopulationHappinessByLevel` | 23 |  |
| `PopulationHappinessByGroup` | 24 |  |
| `PopulationHappinessTotal` | 25 |  |
| `PopulationSatisfactionByGood` | 26 |  |
| `InfectedObjects` | 27 |  |
| `IncidentChance` | 28 | The chance for a given incident in the range [0, 100] |
| `WorkingConditions` | 29 | The working condition setting in a range of [-100, 100] |
| `MoneyBalance` | 30 |  |
| `ExpeditionSolved` | 31 |  |
| `ExpeditionFailed` | 33 |  |
| `ExpeditionReturnedEarly` | 40 |  |
| `CollectablesCollected` | 35 |  |
| `PassiveTradeBalance` | 36 |  |
| `CampaignRuinRemoved` | 37 |  |
| `ShipsSoldToParticipant` | 39 |  |
| `ParticipantDefeated` | 51 | Context: profile GUID |
| `NewspaperArticlePublished` | 52 |  |
| `QuestPoolQuestsSolved` | 53 |  |
| `ReputationWithParticipant` | 54 | Context: Profile GUID |
| `DivingBellUsed` | 55 |  |
| `ItemSetsActive` | 56 | Context: Itemset GUID |
| `Attractiveness` | 58 | No Context |
| `IncidentActive` | 61 |  |
| `CanalTilesFilled` | 62 |  |
| `ObjectWatered` | 63 |  |
| `MajorDiscoveryResearched` | 65 | Context: Major Discovery GUID |
| `ItemsResearched` | 67 | Context: Item GUID |
| `ObjectWateredInclFutureIrrigation` | 68 |  |
| `CanalTilesNotConnected` | 69 |  |
| `ItemsDonated` | 70 |  |
| `MilitaryStrength` | 71 |  |
| `QuestFailed` | 72 |  |
| `ActiveTradeContracts` | 73 |  |
| `ExportedGoodAmount` | 74 |  |
| `ImportedGoodAmount` | 76 |  |
| `ResidencesWithHighestGoodView` | 87 |  |
| `EcoQualityWater` | 88 |  |
| `EcoQualitySoil` | 89 |  |
| `EcoQualityAir` | 90 |  |
| `Forestation` | 91 |  |
| `EcoQualityDeltaWater` | 92 |  |
| `EcoQualityDeltaSoil` | 93 |  |
| `EcoQualityDeltaAir` | 94 |  |
| `RuinCount` | 95 |  |
| `ItemCrafted` | 96 |  |
| `IslandHealth` | 97 |  |
| `ProducedSilver` | 98 |  |
| `IrrigatedTiles` | 99 |  |
| `PopulationTotalAccount` | 100 |  |
| `InvestorResidences` | 101 |  |
| `MonumentEventsFinished` | 102 |  |
| `GamepadActionsConsumed` | 103 |  |
| `DropActionsPerformed` | 104 |  |
| `TradeMoneyEarned` | 105 |  |
| `TradeMoneyPayed` | 106 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>PlayerCounter</Name>
  <Id>335</Id>
  <Items>
    <Item>
      <Name>ObjectBuilt</Name>
      <Description>Context: ObjectGUID</Description>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>TradeProductBought</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>TradeProductSold</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>PopulationByLevel</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>PopulationByGroup</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>PopulationTotal</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>GoodsInStock</Name>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>ObjectDestroyed</Name>
      <Id>7</Id>
    </Item>
    <Item>
      <Name>ObjectLost</Name>
      <Id>8</Id>
    </Item>
    <Item>
      <Name>StreetConnection</Name>
      <Id>9</Id>
    </Item>
    <Item>
      <Name>NoStreetConnection</Name>
      <Id>10</Id>
    </Item>
    <Item>
      <Name>AchievementPoints</Name>
      <Id>11</Id>
    </Item>
    <Item>
      <Name>CorporationLevel</Name>
      <Id>12</Id>
    </Item>
    <Item>
      <Name>BuildingsMoved</Name>
      <Id>13</Id>
    </Item>
    <Item>
      <Name>IslandSettled</Name>
      <Id>14</Id>
    </Item>
    <Item>
      <Name>BuildingsDemolished</Name>
      <Id>15</Id>
    </Item>
    <Item>
      <Name>MaxAchievementPoints</Name>
      <Id>16</Id>
    </Item>
    <Item>
      <Name>MaxCityStatus</Name>
      <Id>17</Id>
    </Item>
    <Item>
      <Name>QuestCalled</Name>
      <Id>18</Id>
    </Item>
    <Item>
      <Name>QuestEnded</Name>
      <Id>19</Id>
    </Item>
    <Item>
      <Name>QuestSolved</Name>
      <Id>20</Id>
    </Item>
    <Item>
      <Name>QuestAbortedManually</Name>
      <Id>21</Id>
    </Item>
    <Item>
      <Name>BankruptCounter</Name>
      <Id>22</Id>
    </Item>
    <Item>
      <Name>PopulationHappinessByLevel</Name>
      <Id>23</Id>
    </Item>
    <Item>
      <Name>PopulationHappinessByGroup</Name>
      <Id>24</Id>
    </Item>
    <Item>
      <Name>PopulationHappinessTotal</Name>
      <Id>25</Id>
    </Item>
    <Item>
      <Name>PopulationSatisfactionByGood</Name>
      <Id>26</Id>
    </Item>
    <Item>
      <Name>InfectedObjects</Name>
      <Id>27</Id>
    </Item>
    <Item>
      <Name>IncidentChance</Name>
      <Description>The chance for a given incident in the range [0, 100]</Description>
      <Id>28</Id>
    </Item>
    <Item>
      <Name>WorkingConditions</Name>
      <Description>The working condition setting in a range of [-100, 100]</Description>
      <Id>29</Id>
    </Item>
    <Item>
      <Name>MoneyBalance</Name>
      <Id>30</Id>
    </Item>
    <Item>
      <Name>ExpeditionSolved</Name>
      <Id>31</Id>
    </Item>
    <Item>
      <Name>ExpeditionFailed</Name>
      <Id>33</Id>
    </Item>
    <Item>
      <Name>ExpeditionReturnedEarly</Name>
      <Id>40</Id>
    </Item>
    <Item>
      <Name>CollectablesCollected</Name>
      <Id>35</Id>
    </Item>
    <Item>
      <Name>PassiveTradeBalance</Name>
      <Id>36</Id>
    </Item>
    <Item>
      <Name>CampaignRuinRemoved</Name>
      <Id>37</Id>
    </Item>
    <Item>
      <Name>ShipsSoldToParticipant</Name>
      <Id>39</Id>
    </Item>
    <Item>
      <Name>ParticipantDefeated</Name>
      <Description>Context: profile GUID</Description>
      <Id>51</Id>
    </Item>
    <Item>
      <Name>NewspaperArticlePublished</Name>
      <Id>52</Id>
    </Item>
    <Item>
      <Name>QuestPoolQuestsSolved</Name>
      <Id>53</Id>
    </Item>
    <Item>
      <Name>ReputationWithParticipant</Name>
      <Description>Context: Profile GUID</Description>
      <Id>54</Id>
    </Item>
    <Item>
      <Name>DivingBellUsed</Name>
      <Id>55</Id>
    </Item>
    <Item>
      <Name>ItemSetsActive</Name>
      <Description>Context: Itemset GUID</Description>
      <Id>56</Id>
    </Item>
    <Item>
      <Name>Attractiveness</Name>
      <Description>No Context</Description>
      <Id>58</Id>
    </Item>
    <Item>
      <Name>IncidentActive</Name>
      <Id>61</Id>
    </Item>
    <Item>
      <Name>CanalTilesFilled</Name>
      <Id>62</Id>
    </Item>
    <Item>
      <Name>ObjectWatered</Name>
      <Id>63</Id>
    </Item>
    <Item>
      <Name>MajorDiscoveryResearched</Name>
      <Description>Context: Major Discovery GUID</Description>
      <Id>65</Id>
    </Item>
    <Item>
      <Name>ItemsResearched</Name>
      <Description>Context: Item GUID</Description>
      <Id>67</Id>
    </Item>
    <Item>
      <Name>ObjectWateredInclFutureIrrigation</Name>
      <Id>68</Id>
    </Item>
    <Item>
      <Name>CanalTilesNotConnected</Name>
      <Id>69</Id>
    </Item>
    <Item>
      <Name>ItemsDonated</Name>
      <Id>70</Id>
    </Item>
    <Item>
      <Name>MilitaryStrength</Name>
      <Id>71</Id>
    </Item>
    <Item>
      <Name>QuestFailed</Name>
      <Id>72</Id>
    </Item>
    <Item>
      <Name>ActiveTradeContracts</Name>
      <Id>73</Id>
    </Item>
    <Item>
      <Name>ExportedGoodAmount</Name>
      <Id>74</Id>
    </Item>
    <Item>
      <Name>ImportedGoodAmount</Name>
      <Id>76</Id>
    </Item>
    <Item>
      <Name>ResidencesWithHighestGoodView</Name>
      <Id>87</Id>
    </Item>
    <Item>
      <Name>EcoQualityWater</Name>
      <Id>88</Id>
    </Item>
    <Item>
      <Name>EcoQualitySoil</Name>
      <Id>89</Id>
    </Item>
    <Item>
      <Name>EcoQualityAir</Name>
      <Id>90</Id>
    </Item>
    <Item>
      <Name>Forestation</Name>
      <Id>91</Id>
    </Item>
    <Item>
      <Name>EcoQualityDeltaWater</Name>
      <Id>92</Id>
    </Item>
    <Item>
      <Name>EcoQualityDeltaSoil</Name>
      <Id>93</Id>
    </Item>
    <Item>
      <Name>EcoQualityDeltaAir</Name>
      <Id>94</Id>
    </Item>
    <Item>
      <Name>RuinCount</Name>
      <Id>95</Id>
    </Item>
    <Item>
      <Name>ItemCrafted</Name>
      <Id>96</Id>
    </Item>
    <Item>
      <Name>IslandHealth</Name>
      <Id>97</Id>
    </Item>
    <Item>
      <Name>ProducedSilver</Name>
      <Id>98</Id>
    </Item>
    <Item>
      <Name>IrrigatedTiles</Name>
      <Id>99</Id>
    </Item>
    <Item>
      <Name>PopulationTotalAccount</Name>
      <Id>100</Id>
    </Item>
    <Item>
      <Name>InvestorResidences</Name>
      <Id>101</Id>
    </Item>
    <Item>
      <Name>MonumentEventsFinished</Name>
      <Id>102</Id>
    </Item>
    <Item>
      <Name>GamepadActionsConsumed</Name>
      <Id>103</Id>
    </Item>
    <Item>
      <Name>DropActionsPerformed</Name>
      <Id>104</Id>
    </Item>
    <Item>
      <Name>TradeMoneyEarned</Name>
      <Id>105</Id>
    </Item>
    <Item>
      <Name>TradeMoneyPayed</Name>
      <Id>106</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-questjumptobuttonvisibility"></a>
<details>
<summary>QuestJumpToButtonVisibility — all tokens, IDs and native metadata</summary>

Source: datasets.xml:16360. Dataset Id=1713.

| Token | Id | Native description |
| --- | --- | --- |
| `Show` | 0 |  |
| `ShowOnlyFakePings` | 2 |  |
| `Hide` | 1 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>QuestJumpToButtonVisibility</Name>
  <Id>1713</Id>
  <Items>
    <Item>
      <Name>Show</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>ShowOnlyFakePings</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Hide</Name>
      <Id>1</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-queststate"></a>
<details>
<summary>QuestState — all tokens, IDs and native metadata</summary>

Source: datasets.xml:16479. Dataset Id=382.

| Token | Id | Native description |
| --- | --- | --- |
| `Triggered` | 0 | quest was called out but is not doing anything yet |
| `Active` | 2 | quest is active and running. the quest is visible in the quest tracker. |
| `Reachable` | 3 | quest goals reached but the rewards have to be collected in the assignment center |
| `Reached` | 4 | quest successfully solved |
| `Failed` | 5 | quest failed |
| `AbortedAutomatically` | 6 | quest aborted automatically |
| `AbortedManually` | 7 | quest aborted by the user |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>QuestState</Name>
  <Id>382</Id>
  <Description>All quest states have to be in order, from beginning of the quest to the end</Description>
  <Items>
    <Item>
      <Name>Triggered</Name>
      <Description>quest was called out but is not doing anything yet</Description>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Active</Name>
      <Description>quest is active and running. the quest is visible in the quest tracker.</Description>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Reachable</Name>
      <Description>quest goals reached but the rewards have to be collected in the assignment center</Description>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Reached</Name>
      <Description>quest successfully solved</Description>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>Failed</Name>
      <Description>quest failed</Description>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>AbortedAutomatically</Name>
      <Description>quest aborted automatically</Description>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>AbortedManually</Name>
      <Description>quest aborted by the user</Description>
      <Id>7</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-rangeoperator"></a>
<details>
<summary>RangeOperator — all tokens, IDs and native metadata</summary>

Source: datasets.xml:1909. Dataset Id=278.

| Token | Id | Native description |
| --- | --- | --- |
| `None` | 0 |  |
| `Any` | 1 |  |
| `All` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>RangeOperator</Name>
  <Id>278</Id>
  <Items>
    <Item>
      <Name>None</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Any</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>All</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-researchfields"></a>
<details>
<summary>ResearchFields — all tokens, IDs and native metadata</summary>

Source: datasets.xml:21572. Dataset Id=1885.

| Token | Id | Native description |
| --- | --- | --- |
| `Culture` | 0 |  |
| `Technology` | 1 |  |
| `Talent` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>ResearchFields</Name>
  <Id>1885</Id>
  <Items>
    <Item>
      <Name>Culture</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Technology</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Talent</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-resourcetype"></a>
<details>
<summary>ResourceType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:2129. Dataset Id=1982.

| Token | Id | Native description |
| --- | --- | --- |
| `None` | 0 |  |
| `Fish` | 1 |  |
| `Clay` | 2 |  |
| `Iron` | 3 |  |
| `Coal` | 4 |  |
| `Copper` | 5 |  |
| `Limestone` | 6 |  |
| `Oil` | 7 |  |
| `SAGas` | 8 |  |
| `Bauxite` | 9 |  |
| `Minerals` | 10 |  |
| `Gold` | 11 |  |
| `SA04` | 12 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>ResourceType</Name>
  <Id>1982</Id>
  <Items>
    <Item>
      <Name>None</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Fish</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Clay</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Iron</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Coal</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>Copper</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>Limestone</Name>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>Oil</Name>
      <Id>7</Id>
    </Item>
    <Item>
      <Name>SAGas</Name>
      <Id>8</Id>
    </Item>
    <Item>
      <Name>Bauxite</Name>
      <Id>9</Id>
    </Item>
    <Item>
      <Name>Minerals</Name>
      <Id>10</Id>
    </Item>
    <Item>
      <Name>Gold</Name>
      <Id>11</Id>
    </Item>
    <Item>
      <Name>SA04</Name>
      <Id>12</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-simpleeventtype"></a>
<details>
<summary>SimpleEventType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:2779. Dataset Id=284.

| Token | Id | Native description |
| --- | --- | --- |
| `CriticalError` | 0 |  |
| `NonCriticalError` | 1 |  |
| `OnetimeCallback` | 2 |  |
| `ProfileLoaded` | 5 |  |
| `DataUnload` | 6 |  |
| `DataReload` | 7 |  |
| `SessionLoad` | 8 | Needs context: GUID of the session |
| `SessionLoaded` | 9 | Signals that a single session is loaded |
| `MetaGameLoaded` | 11 | Signals that all sessions of this game are loaded and the meta game is now prepared to start |
| `SessionUnloaded` | 12 |  |
| `MetaGameUnloaded` | 83 |  |
| `SessionEnter` | 13 | Needs context: GUID of the session |
| `SessionLeave` | 14 |  |
| `AccountAssetCreated` | 15 |  |
| `AccountAssetRemoved` | 16 |  |
| `CorporationAssetCreated` | 18 |  |
| `CorporationAssetRemoved` | 19 |  |
| `CorporationAssetWatcherDone` | 20 |  |
| `CorporationLevelUp` | 21 |  |
| `QuestStarted` | 22 | Needs context: QuestGUID |
| `QuestResolved` | 23 | Needs context: QuestGUID |
| `QuestSuccessfullyResolved` | 24 |  |
| `QuestStateChanged` | 25 |  |
| `QuestObjectCollected` | 26 | Needs context: id of the quest that waits for the objects to be collected |
| `QuestTargetReached` | 27 |  |
| `QuestConfirmationAccepted` | 28 |  |
| `ObjectSelected` | 29 | Needs context: GUID of the object |
| `ObjectBuilt` | 30 |  |
| `ObjectDestroyed` | 31 |  |
| `ObjectGUIDChanged` | 32 | Needs context: new GUID of the object |
| `GUIDUnlocked` | 33 | Needs context: any GUID |
| `CameraSequenceEnd` | 36 |  |
| `ChangeSelection` | 40 |  |
| `InteractionStarted` | 42 |  |
| `InteractionCompleted` | 43 |  |
| `ObjectAttached` | 44 |  |
| `ObjectDropped` | 45 |  |
| `UbiservicesNewsReceived` | 46 |  |
| `ParticipantMessage` | 48 |  |
| `MetaParticipantCreated` | 49 |  |
| `SessionParticipantCreated` | 97 |  |
| `ResolverUnitAvailable` | 50 |  |
| `IncidentSpreaded` | 51 |  |
| `NotificationTriggered` | 52 |  |
| `NotificationRemoved` | 53 |  |
| `ModuleAdded` | 54 |  |
| `ModuleRemoved` | 55 |  |
| `EnterUIState` | 56 |  |
| `LeaveUIState` | 57 | Triggered as soon as the UI is completely left, so after a potential close transition is finished (also check the CloseUIState Event) |
| `CloseUIState` | 136 | Close UIState happens before a potential close transition starts (also check the LeaveUIState Event) |
| `DragOperationInProgress` | 58 |  |
| `ItemEquipmentChanged` | 59 |  |
| `NewspaperEditNotificationClicked` | 60 |  |
| `NewspaperAddArticle` | 61 |  |
| `NewspaperMinIntervalEnded` | 139 |  |
| `NewspaperIntervalEnded` | 62 |  |
| `NewspaperIntervalStarted` | 63 |  |
| `NewspaperPublished` | 112 |  |
| `MPSessionEvent` | 64 |  |
| `MPPeerEvent` | 65 |  |
| `MPDeSyncDetected` | 66 |  |
| `IslandSettled` | 67 |  |
| `IslandUnsettled` | 68 |  |
| `GameObjectSold` | 69 |  |
| `ExpeditionStatusChanged` | 71 |  |
| `DiplomaticRelationChanged` | 72 |  |
| `RuinStateEntered` | 73 |  |
| `IniFileChanged` | 75 |  |
| `IncidentStarted` | 76 |  |
| `IncidentEscalated` | 77 |  |
| `IncidentResolved` | 78 |  |
| `IncidentSpecialActionTriggered` | 79 |  |
| `TutorialSystemStateChanged` | 80 |  |
| `GameEnded` | 81 |  |
| `IncidentHealingUnitSent` | 82 |  |
| `TradeRouteCreated` | 84 |  |
| `MonumentEventActive` | 85 |  |
| `MonumentEventEnded` | 86 |  |
| `OnlineStateChanged` | 87 |  |
| `MonumentConstructionUpdate` | 88 |  |
| `TransferChanged` | 89 |  |
| `MPTransmissionEvent` | 90 |  |
| `MovieFinished` | 91 |  |
| `UplayActionUnlocked` | 92 | Event that is fired when a uplay action was unlocked |
| `UplayRewardUnlocked` | 93 | Event that is fired when a uplay reward was redeemed |
| `NotificationSideArchiveAdded` | 94 |  |
| `NotificationSideArchiveRemoved` | 95 |  |
| `NotificationOnScreenAdded` | 98 |  |
| `ScreenshotTaken` | 100 |  |
| `NotificationOnScreenRemoved` | 99 |  |
| `FightChanged` | 102 |  |
| `ItemActionCompleted` | 101 | Event that is fired when an item action has been successfully completed |
| `ShortcutChanged` | 104 |  |
| `GraphicAdapterChanged` | 131 |  |
| `WorldMapClick` | 106 |  |
| `AssetFileChanged` | 110 |  |
| `PirateResettled` | 113 |  |
| `ShareTraded` | 114 |  |
| `HostileTakeoverCompleted` | 115 |  |
| `IslandWarStarted` | 116 |  |
| `IslandWarEnded` | 117 |  |
| `IslandWarMoraleChanged` | 133 |  |
| `CameraControlSwitched` | 119 |  |
| `RuinStateEnded` | 120 |  |
| `BlueprintStateChanged` | 121 |  |
| `WindowSizeChanged` | 122 |  |
| `IncidentInfected` | 123 |  |
| `MetaParticipantRemoved` | 124 |  |
| `SessionParticipantRemoved` | 125 |  |
| `TradeRouteAdded` | 126 |  |
| `UbiservicesRewardsReceived` | 127 |  |
| `UbiservicesActionsReceived` | 128 |  |
| `GUIDLocked` | 129 |  |
| `UbiservicesBadgesReceived` | 132 |  |
| `IslandDiscovered` | 134 |  |
| `BuildingDecorationAdded` | 137 |  |
| `BuildingDecorationRemoved` | 138 |  |
| `DivingBellUsed` | 140 |  |
| `DiscoveryEvent` | 143 |  |
| `MPTransmissionSenderEvent` | 144 |  |
| `ModuleAdditionalAdded` | 147 |  |
| `ModuleAdditionalRemoved` | 148 |  |
| `MonumentEventPreparationStarted` | 149 |  |
| `MonumentEventRewardCollected` | 150 |  |
| `FutureIrrigationChanged` | 151 |  |
| `ResearchCenterCraftingFinished` | 152 |  |
| `ResearchCenterCraftingStarted` | 153 |  |
| `GGJAccountAssetCreated` | 154 |  |
| `GGJAccountAssetRemoved` | 155 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>SimpleEventType</Name>
  <Id>284</Id>
  <Items>
    <Item>
      <Name>CriticalError</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>NonCriticalError</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>OnetimeCallback</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>ProfileLoaded</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>DataUnload</Name>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>DataReload</Name>
      <Id>7</Id>
    </Item>
    <Item>
      <Name>SessionLoad</Name>
      <Description>Needs context: GUID of the session</Description>
      <Id>8</Id>
    </Item>
    <Item>
      <Name>SessionLoaded</Name>
      <Description>Signals that a single session is loaded</Description>
      <Id>9</Id>
    </Item>
    <Item>
      <Name>MetaGameLoaded</Name>
      <Description>Signals that all sessions of this game are loaded and the meta game is now prepared to start</Description>
      <Id>11</Id>
    </Item>
    <Item>
      <Name>SessionUnloaded</Name>
      <Id>12</Id>
    </Item>
    <Item>
      <Name>MetaGameUnloaded</Name>
      <Id>83</Id>
    </Item>
    <Item>
      <Name>SessionEnter</Name>
      <Description>Needs context: GUID of the session</Description>
      <Id>13</Id>
    </Item>
    <Item>
      <Name>SessionLeave</Name>
      <Id>14</Id>
    </Item>
    <Item>
      <Name>AccountAssetCreated</Name>
      <Id>15</Id>
    </Item>
    <Item>
      <Name>AccountAssetRemoved</Name>
      <Id>16</Id>
    </Item>
    <Item>
      <Name>CorporationAssetCreated</Name>
      <Id>18</Id>
    </Item>
    <Item>
      <Name>CorporationAssetRemoved</Name>
      <Id>19</Id>
    </Item>
    <Item>
      <Name>CorporationAssetWatcherDone</Name>
      <Id>20</Id>
    </Item>
    <Item>
      <Name>CorporationLevelUp</Name>
      <Id>21</Id>
    </Item>
    <Item>
      <Name>QuestStarted</Name>
      <Description>Needs context: QuestGUID</Description>
      <Id>22</Id>
    </Item>
    <Item>
      <Name>QuestResolved</Name>
      <Description>Needs context: QuestGUID</Description>
      <Id>23</Id>
    </Item>
    <Item>
      <Name>QuestSuccessfullyResolved</Name>
      <Id>24</Id>
    </Item>
    <Item>
      <Name>QuestStateChanged</Name>
      <Id>25</Id>
    </Item>
    <Item>
      <Name>QuestObjectCollected</Name>
      <Description>Needs context: id of the quest that waits for the objects to be collected</Description>
      <Id>26</Id>
    </Item>
    <Item>
      <Name>QuestTargetReached</Name>
      <Id>27</Id>
    </Item>
    <Item>
      <Name>QuestConfirmationAccepted</Name>
      <Id>28</Id>
    </Item>
    <Item>
      <Name>ObjectSelected</Name>
      <Description>Needs context: GUID of the object</Description>
      <Id>29</Id>
    </Item>
    <Item>
      <Name>ObjectBuilt</Name>
      <Id>30</Id>
    </Item>
    <Item>
      <Name>ObjectDestroyed</Name>
      <Id>31</Id>
    </Item>
    <Item>
      <Name>ObjectGUIDChanged</Name>
      <Description>Needs context: new GUID of the object</Description>
      <Id>32</Id>
    </Item>
    <Item>
      <Name>GUIDUnlocked</Name>
      <Description>Needs context: any GUID</Description>
      <Id>33</Id>
    </Item>
    <Item>
      <Name>CameraSequenceEnd</Name>
      <Id>36</Id>
    </Item>
    <Item>
      <Name>ChangeSelection</Name>
      <Id>40</Id>
    </Item>
    <Item>
      <Name>InteractionStarted</Name>
      <Id>42</Id>
    </Item>
    <Item>
      <Name>InteractionCompleted</Name>
      <Id>43</Id>
    </Item>
    <Item>
      <Name>ObjectAttached</Name>
      <Id>44</Id>
    </Item>
    <Item>
      <Name>ObjectDropped</Name>
      <Id>45</Id>
    </Item>
    <Item>
      <Name>UbiservicesNewsReceived</Name>
      <Id>46</Id>
    </Item>
    <Item>
      <Name>ParticipantMessage</Name>
      <Id>48</Id>
    </Item>
    <Item>
      <Name>MetaParticipantCreated</Name>
      <Id>49</Id>
    </Item>
    <Item>
      <Name>SessionParticipantCreated</Name>
      <Id>97</Id>
    </Item>
    <Item>
      <Name>ResolverUnitAvailable</Name>
      <Id>50</Id>
    </Item>
    <Item>
      <Name>IncidentSpreaded</Name>
      <Id>51</Id>
    </Item>
    <Item>
      <Name>NotificationTriggered</Name>
      <Id>52</Id>
    </Item>
    <Item>
      <Name>NotificationRemoved</Name>
      <Id>53</Id>
    </Item>
    <Item>
      <Name>ModuleAdded</Name>
      <Id>54</Id>
    </Item>
    <Item>
      <Name>ModuleRemoved</Name>
      <Id>55</Id>
    </Item>
    <Item>
      <Name>EnterUIState</Name>
      <Id>56</Id>
    </Item>
    <Item>
      <Name>LeaveUIState</Name>
      <Description>Triggered as soon as the UI is completely left, so after a potential close transition is finished (also check the CloseUIState Event)</Description>
      <Id>57</Id>
    </Item>
    <Item>
      <Name>CloseUIState</Name>
      <Description>Close UIState happens before a potential close transition starts (also check the LeaveUIState Event)</Description>
      <Id>136</Id>
    </Item>
    <Item>
      <Name>DragOperationInProgress</Name>
      <Id>58</Id>
    </Item>
    <Item>
      <Name>ItemEquipmentChanged</Name>
      <Id>59</Id>
    </Item>
    <Item>
      <Name>NewspaperEditNotificationClicked</Name>
      <Id>60</Id>
    </Item>
    <Item>
      <Name>NewspaperAddArticle</Name>
      <Id>61</Id>
    </Item>
    <Item>
      <Name>NewspaperMinIntervalEnded</Name>
      <Id>139</Id>
    </Item>
    <Item>
      <Name>NewspaperIntervalEnded</Name>
      <Id>62</Id>
    </Item>
    <Item>
      <Name>NewspaperIntervalStarted</Name>
      <Id>63</Id>
    </Item>
    <Item>
      <Name>NewspaperPublished</Name>
      <Id>112</Id>
    </Item>
    <Item>
      <Name>MPSessionEvent</Name>
      <Id>64</Id>
    </Item>
    <Item>
      <Name>MPPeerEvent</Name>
      <Id>65</Id>
    </Item>
    <Item>
      <Name>MPDeSyncDetected</Name>
      <Id>66</Id>
    </Item>
    <Item>
      <Name>IslandSettled</Name>
      <Id>67</Id>
    </Item>
    <Item>
      <Name>IslandUnsettled</Name>
      <Id>68</Id>
    </Item>
    <Item>
      <Name>GameObjectSold</Name>
      <Id>69</Id>
    </Item>
    <Item>
      <Name>ExpeditionStatusChanged</Name>
      <Id>71</Id>
    </Item>
    <Item>
      <Name>DiplomaticRelationChanged</Name>
      <Id>72</Id>
    </Item>
    <Item>
      <Name>RuinStateEntered</Name>
      <Id>73</Id>
    </Item>
    <Item>
      <Name>IniFileChanged</Name>
      <Id>75</Id>
    </Item>
    <Item>
      <Name>IncidentStarted</Name>
      <Id>76</Id>
    </Item>
    <Item>
      <Name>IncidentEscalated</Name>
      <Id>77</Id>
    </Item>
    <Item>
      <Name>IncidentResolved</Name>
      <Id>78</Id>
    </Item>
    <Item>
      <Name>IncidentSpecialActionTriggered</Name>
      <Id>79</Id>
    </Item>
    <Item>
      <Name>TutorialSystemStateChanged</Name>
      <Id>80</Id>
    </Item>
    <Item>
      <Name>GameEnded</Name>
      <Id>81</Id>
    </Item>
    <Item>
      <Name>IncidentHealingUnitSent</Name>
      <Id>82</Id>
    </Item>
    <Item>
      <Name>TradeRouteCreated</Name>
      <Id>84</Id>
    </Item>
    <Item>
      <Name>MonumentEventActive</Name>
      <Id>85</Id>
    </Item>
    <Item>
      <Name>MonumentEventEnded</Name>
      <Id>86</Id>
    </Item>
    <Item>
      <Name>OnlineStateChanged</Name>
      <Id>87</Id>
    </Item>
    <Item>
      <Name>MonumentConstructionUpdate</Name>
      <Id>88</Id>
    </Item>
    <Item>
      <Name>TransferChanged</Name>
      <Id>89</Id>
    </Item>
    <Item>
      <Name>MPTransmissionEvent</Name>
      <Id>90</Id>
    </Item>
    <Item>
      <Name>MovieFinished</Name>
      <Id>91</Id>
    </Item>
    <Item>
      <Name>UplayActionUnlocked</Name>
      <Description>Event that is fired when a uplay action was unlocked</Description>
      <Id>92</Id>
    </Item>
    <Item>
      <Name>UplayRewardUnlocked</Name>
      <Description>Event that is fired when a uplay reward was redeemed</Description>
      <Id>93</Id>
    </Item>
    <Item>
      <Name>NotificationSideArchiveAdded</Name>
      <Id>94</Id>
    </Item>
    <Item>
      <Name>NotificationSideArchiveRemoved</Name>
      <Id>95</Id>
    </Item>
    <Item>
      <Name>NotificationOnScreenAdded</Name>
      <Id>98</Id>
    </Item>
    <Item>
      <Name>ScreenshotTaken</Name>
      <Id>100</Id>
    </Item>
    <Item>
      <Name>NotificationOnScreenRemoved</Name>
      <Id>99</Id>
    </Item>
    <Item>
      <Name>FightChanged</Name>
      <Id>102</Id>
    </Item>
    <Item>
      <Name>ItemActionCompleted</Name>
      <Description>Event that is fired when an item action has been successfully completed</Description>
      <Id>101</Id>
    </Item>
    <Item>
      <Name>ShortcutChanged</Name>
      <Id>104</Id>
    </Item>
    <Item>
      <Name>GraphicAdapterChanged</Name>
      <Id>131</Id>
    </Item>
    <Item>
      <Name>WorldMapClick</Name>
      <Id>106</Id>
    </Item>
    <Item>
      <Name>AssetFileChanged</Name>
      <Id>110</Id>
    </Item>
    <Item>
      <Name>PirateResettled</Name>
      <Id>113</Id>
    </Item>
    <Item>
      <Name>ShareTraded</Name>
      <Id>114</Id>
    </Item>
    <Item>
      <Name>HostileTakeoverCompleted</Name>
      <Id>115</Id>
    </Item>
    <Item>
      <Name>IslandWarStarted</Name>
      <Id>116</Id>
    </Item>
    <Item>
      <Name>IslandWarEnded</Name>
      <Id>117</Id>
    </Item>
    <Item>
      <Name>IslandWarMoraleChanged</Name>
      <Id>133</Id>
    </Item>
    <Item>
      <Name>CameraControlSwitched</Name>
      <Id>119</Id>
    </Item>
    <Item>
      <Name>RuinStateEnded</Name>
      <Id>120</Id>
    </Item>
    <Item>
      <Name>BlueprintStateChanged</Name>
      <Id>121</Id>
    </Item>
    <Item>
      <Name>WindowSizeChanged</Name>
      <Id>122</Id>
    </Item>
    <Item>
      <Name>IncidentInfected</Name>
      <Id>123</Id>
    </Item>
    <Item>
      <Name>MetaParticipantRemoved</Name>
      <Id>124</Id>
    </Item>
    <Item>
      <Name>SessionParticipantRemoved</Name>
      <Id>125</Id>
    </Item>
    <Item>
      <Name>TradeRouteAdded</Name>
      <Id>126</Id>
    </Item>
    <Item>
      <Name>UbiservicesRewardsReceived</Name>
      <Id>127</Id>
    </Item>
    <Item>
      <Name>UbiservicesActionsReceived</Name>
      <Id>128</Id>
    </Item>
    <Item>
      <Name>GUIDLocked</Name>
      <Id>129</Id>
    </Item>
    <Item>
      <Name>UbiservicesBadgesReceived</Name>
      <Id>132</Id>
    </Item>
    <Item>
      <Name>IslandDiscovered</Name>
      <Id>134</Id>
    </Item>
    <Item>
      <Name>BuildingDecorationAdded</Name>
      <Id>137</Id>
    </Item>
    <Item>
      <Name>BuildingDecorationRemoved</Name>
      <Id>138</Id>
    </Item>
    <Item>
      <Name>DivingBellUsed</Name>
      <Id>140</Id>
    </Item>
    <Item>
      <Name>DiscoveryEvent</Name>
      <Id>143</Id>
    </Item>
    <Item>
      <Name>MPTransmissionSenderEvent</Name>
      <Id>144</Id>
    </Item>
    <Item>
      <Name>ModuleAdditionalAdded</Name>
      <Id>147</Id>
    </Item>
    <Item>
      <Name>ModuleAdditionalRemoved</Name>
      <Id>148</Id>
    </Item>
    <Item>
      <Name>MonumentEventPreparationStarted</Name>
      <Id>149</Id>
    </Item>
    <Item>
      <Name>MonumentEventRewardCollected</Name>
      <Id>150</Id>
    </Item>
    <Item>
      <Name>FutureIrrigationChanged</Name>
      <Id>151</Id>
    </Item>
    <Item>
      <Name>ResearchCenterCraftingFinished</Name>
      <Id>152</Id>
    </Item>
    <Item>
      <Name>ResearchCenterCraftingStarted</Name>
      <Id>153</Id>
    </Item>
    <Item>
      <Name>GGJAccountAssetCreated</Name>
      <Id>154</Id>
    </Item>
    <Item>
      <Name>GGJAccountAssetRemoved</Name>
      <Id>155</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-subconditioncompletionorder"></a>
<details>
<summary>SubConditionCompletionOrder — all tokens, IDs and native metadata</summary>

Source: datasets.xml:17631. Dataset Id=390.

| Token | Id | Native description |
| --- | --- | --- |
| `Parallel` | 0 |  |
| `Linear` | 1 |  |
| `MutuallyExclusive` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>SubConditionCompletionOrder</Name>
  <Id>390</Id>
  <Items>
    <Item>
      <Name>Parallel</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Linear</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>MutuallyExclusive</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-textpopuplayout"></a>
<details>
<summary>TextPopupLayout — all tokens, IDs and native metadata</summary>

Source: datasets.xml:8735. Dataset Id=1698.

| Token | Id | Native description |
| --- | --- | --- |
| `Letter` | 0 |  |
| `DiaryPage1` | 1 |  |
| `DiaryPage2` | 2 |  |
| `DiaryPage3` | 3 |  |
| `LetterThreat` | 4 |  |
| `LetterQuest` | 5 |  |
| `NadaskyJournal1` | 9 |  |
| `NadaskyJournal2` | 10 |  |
| `NadaskyJournal3` | 11 |  |
| `RichardsonLog` | 12 |  |
| `VascoContract` | 13 |  |
| `JohnsNotes1` | 14 |  |
| `JohnsNotes2` | 15 |  |
| `JohnsNotes3` | 16 |  |
| `JohnsNotes4` | 17 |  |
| `JohnsNotes5` | 18 |  |
| `JohnsNotes6` | 19 |  |
| `WidlifeWolfSketch` | 21 |  |
| `WidlifeMooseSketch` | 22 |  |
| `WidlifeBearSketch` | 23 |  |
| `JohnsLogbook` | 24 |  |
| `ResearchCenterAccepted` | 25 |  |
| `ResearchCenterRejected1` | 26 |  |
| `ResearchCenterRejected2` | 27 |  |
| `MilitaryLogs` | 28 |  |
| `EnbesanHistory1` | 29 |  |
| `EnbesanHistory2` | 30 |  |
| `EnbesanHistory3` | 31 |  |
| `EnbesanHistory4` | 32 |  |
| `EnbesanHistory5` | 33 |  |
| `EnbesanHistory6` | 43 |  |
| `EnbesanHistory7` | 44 |  |
| `EnbesanHistory8` | 46 |  |
| `EnbesanHistory9` | 47 |  |
| `KiryasJournal1` | 34 |  |
| `KiryasJournal2` | 35 |  |
| `KiryasJournal3` | 36 |  |
| `BeekeeperList` | 38 |  |
| `CartographyArch` | 39 |  |
| `CartographyGraveyard` | 40 |  |
| `CartographyPrideRock` | 41 |  |
| `CartographyWaterfall` | 42 |  |
| `TextBook` | 48 |  |
| `QueensLetter` | 51 |  |
| `RomanceLetter` | 52 |  |
| `ParaventPoster` | 53 |  |
| `TowerOfBabel` | 54 |  |
| `CollosusFeet` | 55 |  |
| `TarotCard` | 56 |  |
| `RansomNote` | 57 |  |
| `GoneSister1` | 58 |  |
| `GoneSister2` | 59 |  |
| `GoneSister3` | 60 |  |
| `GoneSister4` | 61 |  |
| `LeadingToTheBrother` | 62 |  |
| `PalomaEnding01` | 63 |  |
| `PalomaEnding02` | 64 |  |
| `PalomaEnding03` | 65 |  |
| `Postcard01` | 66 |  |
| `Postcard02` | 67 |  |
| `Postcard03` | 68 |  |
| `Postcard04` | 69 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>TextPopupLayout</Name>
  <Id>1698</Id>
  <Items>
    <Item>
      <Name>Letter</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>DiaryPage1</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>DiaryPage2</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>DiaryPage3</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>LetterThreat</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>LetterQuest</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>NadaskyJournal1</Name>
      <Id>9</Id>
    </Item>
    <Item>
      <Name>NadaskyJournal2</Name>
      <Id>10</Id>
    </Item>
    <Item>
      <Name>NadaskyJournal3</Name>
      <Id>11</Id>
    </Item>
    <Item>
      <Name>RichardsonLog</Name>
      <Id>12</Id>
    </Item>
    <Item>
      <Name>VascoContract</Name>
      <Id>13</Id>
    </Item>
    <Item>
      <Name>JohnsNotes1</Name>
      <Id>14</Id>
    </Item>
    <Item>
      <Name>JohnsNotes2</Name>
      <Id>15</Id>
    </Item>
    <Item>
      <Name>JohnsNotes3</Name>
      <Id>16</Id>
    </Item>
    <Item>
      <Name>JohnsNotes4</Name>
      <Id>17</Id>
    </Item>
    <Item>
      <Name>JohnsNotes5</Name>
      <Id>18</Id>
    </Item>
    <Item>
      <Name>JohnsNotes6</Name>
      <Id>19</Id>
    </Item>
    <Item>
      <Name>WidlifeWolfSketch</Name>
      <Id>21</Id>
    </Item>
    <Item>
      <Name>WidlifeMooseSketch</Name>
      <Id>22</Id>
    </Item>
    <Item>
      <Name>WidlifeBearSketch</Name>
      <Id>23</Id>
    </Item>
    <Item>
      <Name>JohnsLogbook</Name>
      <Id>24</Id>
    </Item>
    <Item>
      <Name>ResearchCenterAccepted</Name>
      <Id>25</Id>
    </Item>
    <Item>
      <Name>ResearchCenterRejected1</Name>
      <Id>26</Id>
    </Item>
    <Item>
      <Name>ResearchCenterRejected2</Name>
      <Id>27</Id>
    </Item>
    <Item>
      <Name>MilitaryLogs</Name>
      <Id>28</Id>
    </Item>
    <Item>
      <Name>EnbesanHistory1</Name>
      <Id>29</Id>
    </Item>
    <Item>
      <Name>EnbesanHistory2</Name>
      <Id>30</Id>
    </Item>
    <Item>
      <Name>EnbesanHistory3</Name>
      <Id>31</Id>
    </Item>
    <Item>
      <Name>EnbesanHistory4</Name>
      <Id>32</Id>
    </Item>
    <Item>
      <Name>EnbesanHistory5</Name>
      <Id>33</Id>
    </Item>
    <Item>
      <Name>EnbesanHistory6</Name>
      <Id>43</Id>
    </Item>
    <Item>
      <Name>EnbesanHistory7</Name>
      <Id>44</Id>
    </Item>
    <Item>
      <Name>EnbesanHistory8</Name>
      <Id>46</Id>
    </Item>
    <Item>
      <Name>EnbesanHistory9</Name>
      <Id>47</Id>
    </Item>
    <Item>
      <Name>KiryasJournal1</Name>
      <Id>34</Id>
    </Item>
    <Item>
      <Name>KiryasJournal2</Name>
      <Id>35</Id>
    </Item>
    <Item>
      <Name>KiryasJournal3</Name>
      <Id>36</Id>
    </Item>
    <Item>
      <Name>BeekeeperList</Name>
      <Id>38</Id>
    </Item>
    <Item>
      <Name>CartographyArch</Name>
      <Id>39</Id>
    </Item>
    <Item>
      <Name>CartographyGraveyard</Name>
      <Id>40</Id>
    </Item>
    <Item>
      <Name>CartographyPrideRock</Name>
      <Id>41</Id>
    </Item>
    <Item>
      <Name>CartographyWaterfall</Name>
      <Id>42</Id>
    </Item>
    <Item>
      <Name>TextBook</Name>
      <Id>48</Id>
    </Item>
    <Item>
      <Name>QueensLetter</Name>
      <Id>51</Id>
    </Item>
    <Item>
      <Name>RomanceLetter</Name>
      <Id>52</Id>
    </Item>
    <Item>
      <Name>ParaventPoster</Name>
      <Id>53</Id>
    </Item>
    <Item>
      <Name>TowerOfBabel</Name>
      <Id>54</Id>
    </Item>
    <Item>
      <Name>CollosusFeet</Name>
      <Id>55</Id>
    </Item>
    <Item>
      <Name>TarotCard</Name>
      <Id>56</Id>
    </Item>
    <Item>
      <Name>RansomNote</Name>
      <Id>57</Id>
    </Item>
    <Item>
      <Name>GoneSister1</Name>
      <Id>58</Id>
    </Item>
    <Item>
      <Name>GoneSister2</Name>
      <Id>59</Id>
    </Item>
    <Item>
      <Name>GoneSister3</Name>
      <Id>60</Id>
    </Item>
    <Item>
      <Name>GoneSister4</Name>
      <Id>61</Id>
    </Item>
    <Item>
      <Name>LeadingToTheBrother</Name>
      <Id>62</Id>
    </Item>
    <Item>
      <Name>PalomaEnding01</Name>
      <Id>63</Id>
    </Item>
    <Item>
      <Name>PalomaEnding02</Name>
      <Id>64</Id>
    </Item>
    <Item>
      <Name>PalomaEnding03</Name>
      <Id>65</Id>
    </Item>
    <Item>
      <Name>Postcard01</Name>
      <Id>66</Id>
    </Item>
    <Item>
      <Name>Postcard02</Name>
      <Id>67</Id>
    </Item>
    <Item>
      <Name>Postcard03</Name>
      <Id>68</Id>
    </Item>
    <Item>
      <Name>Postcard04</Name>
      <Id>69</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-traderoutetransportationtype"></a>
<details>
<summary>TradeRouteTransportationType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:3655. Dataset Id=1699.

| Token | Id | Native description |
| --- | --- | --- |
| `Normal` | 0 |  |
| `Charter` | 1 |  |
| `Oil` | 3 |  |
| `Mail` | 4 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>TradeRouteTransportationType</Name>
  <Id>1699</Id>
  <Items>
    <Item>
      <Name>Normal</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Charter</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Oil</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Mail</Name>
      <Id>4</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-tristate"></a>
<details>
<summary>Tristate — all tokens, IDs and native metadata</summary>

Source: datasets.xml:17663. Dataset Id=1938.

| Token | Id | Native description |
| --- | --- | --- |
| `DontCare` | 0 |  |
| `True` | 1 |  |
| `False` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>Tristate</Name>
  <Id>1938</Id>
  <Items>
    <Item>
      <Name>DontCare</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>True</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>False</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-tutorialcondition"></a>
<details>
<summary>TutorialCondition — all tokens, IDs and native metadata</summary>

Source: datasets.xml:9075. Dataset Id=1734.

| Token | Id | Native description |
| --- | --- | --- |
| `Click` | 0 |  |
| `Hover` | 1 |  |
| `Selected` | 2 |  |
| `HintClosed` | 4 |  |
| `AutoCompleteTimer` | 5 |  |
| `Visibility` | 7 |  |
| `ScreenOpened` | 8 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>TutorialCondition</Name>
  <Id>1734</Id>
  <Items>
    <Item>
      <Name>Click</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Hover</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Selected</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>HintClosed</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>AutoCompleteTimer</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>Visibility</Name>
      <Id>7</Id>
    </Item>
    <Item>
      <Name>ScreenOpened</Name>
      <Id>8</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-tutorialconditionscreentype"></a>
<details>
<summary>TutorialConditionScreenType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:9273. Dataset Id=2099.

| Token | Id | Native description |
| --- | --- | --- |
| `ConstructionMenu` | 0 |  |
| `QuickToolsMenu` | 1 |  |
| `MetaNavigationMenu` | 2 |  |
| `ShipMenu` | 3 |  |
| `QuickNavigation` | 4 |  |
| `AttractivenessPopup` | 5 |  |
| `WorkforceMenu` | 6 |  |
| `IslandDetails` | 7 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>TutorialConditionScreenType</Name>
  <Id>2099</Id>
  <Items>
    <Item>
      <Name>ConstructionMenu</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>QuickToolsMenu</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>MetaNavigationMenu</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>ShipMenu</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>QuickNavigation</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>AttractivenessPopup</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>WorkforceMenu</Name>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>IslandDetails</Name>
      <Id>7</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-tutorialuicategory"></a>
<details>
<summary>TutorialUiCategory — all tokens, IDs and native metadata</summary>

Source: datasets.xml:22931. Dataset Id=1733.

| Token | Id | Native description |
| --- | --- | --- |
| `ConstructionMenu` | 0 |  |
| `IslandBar` | 1 |  |
| `SessionScene` | 2 |  |
| `OMProduction` | 3 |  |
| `ResourceBar` | 4 |  |
| `NotificationArchive` | 5 |  |
| `OMResidence` | 6 |  |
| `OMShip` | 7 |  |
| `Kontor` | 8 |  |
| `Workforce` | 9 |  |
| `Zoo` | 10 |  |
| `CityInstitution` | 14 |  |
| `Warehouse` | 15 |  |
| `ProductionChain` | 16 |  |
| `RightClickMenu` | 17 |  |
| `Worldmap` | 18 |  |
| `OMMarketplace` | 20 |  |
| `OMPalace` | 21 |  |
| `PalaceOverview` | 22 |  |
| `OMDepartment` | 23 |  |
| `ResearchCentre` | 24 |  |
| `Expedition` | 25 |  |
| `OMGuildHouse` | 26 |  |
| `OMDocklands` | 27 |  |
| `Docklands` | 28 |  |
| `SettleIsland` | 29 |  |
| `RecipeBuilding` | 30 |  |
| `QuickNavigationMap` | 34 |  |
| `MetaNavigation` | 35 |  |
| `QuickTools` | 36 |  |
| `AirshipPlatform` | 44 |  |
| `ItemTransferModule` | 45 |  |
| `PostModule` | 46 |  |
| `PassangerModule` | 47 |  |
| `OMAirship` | 48 |  |
| `TradeRoutes` | 49 |  |
| `OMMine` | 50 |  |
| `OMHangar` | 61 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>TutorialUiCategory</Name>
  <Id>1733</Id>
  <Items>
    <Item>
      <Name>ConstructionMenu</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>IslandBar</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>SessionScene</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>OMProduction</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>ResourceBar</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>NotificationArchive</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>OMResidence</Name>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>OMShip</Name>
      <Id>7</Id>
    </Item>
    <Item>
      <Name>Kontor</Name>
      <Id>8</Id>
    </Item>
    <Item>
      <Name>Workforce</Name>
      <Id>9</Id>
    </Item>
    <Item>
      <Name>Zoo</Name>
      <Id>10</Id>
    </Item>
    <Item>
      <Name>CityInstitution</Name>
      <Id>14</Id>
    </Item>
    <Item>
      <Name>Warehouse</Name>
      <Id>15</Id>
    </Item>
    <Item>
      <Name>ProductionChain</Name>
      <Id>16</Id>
    </Item>
    <Item>
      <Name>RightClickMenu</Name>
      <Id>17</Id>
    </Item>
    <Item>
      <Name>Worldmap</Name>
      <Id>18</Id>
    </Item>
    <Item>
      <Name>OMMarketplace</Name>
      <Id>20</Id>
    </Item>
    <Item>
      <Name>OMPalace</Name>
      <Id>21</Id>
    </Item>
    <Item>
      <Name>PalaceOverview</Name>
      <Id>22</Id>
    </Item>
    <Item>
      <Name>OMDepartment</Name>
      <Id>23</Id>
    </Item>
    <Item>
      <Name>ResearchCentre</Name>
      <Id>24</Id>
    </Item>
    <Item>
      <Name>Expedition</Name>
      <Id>25</Id>
    </Item>
    <Item>
      <Name>OMGuildHouse</Name>
      <Id>26</Id>
    </Item>
    <Item>
      <Name>OMDocklands</Name>
      <Id>27</Id>
    </Item>
    <Item>
      <Name>Docklands</Name>
      <Id>28</Id>
    </Item>
    <Item>
      <Name>SettleIsland</Name>
      <Id>29</Id>
    </Item>
    <Item>
      <Name>RecipeBuilding</Name>
      <Id>30</Id>
    </Item>
    <Item>
      <Name>QuickNavigationMap</Name>
      <Id>34</Id>
    </Item>
    <Item>
      <Name>MetaNavigation</Name>
      <Id>35</Id>
    </Item>
    <Item>
      <Name>QuickTools</Name>
      <Id>36</Id>
    </Item>
    <Item>
      <Name>AirshipPlatform</Name>
      <Id>44</Id>
    </Item>
    <Item>
      <Name>ItemTransferModule</Name>
      <Id>45</Id>
    </Item>
    <Item>
      <Name>PostModule</Name>
      <Id>46</Id>
    </Item>
    <Item>
      <Name>PassangerModule</Name>
      <Id>47</Id>
    </Item>
    <Item>
      <Name>OMAirship</Name>
      <Id>48</Id>
    </Item>
    <Item>
      <Name>TradeRoutes</Name>
      <Id>49</Id>
    </Item>
    <Item>
      <Name>OMMine</Name>
      <Id>50</Id>
    </Item>
    <Item>
      <Name>OMHangar</Name>
      <Id>61</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-tutorialuihintanchor"></a>
<details>
<summary>TutorialUiHintAnchor — all tokens, IDs and native metadata</summary>

Source: datasets.xml:9109. Dataset Id=1737.

| Token | Id | Native description |
| --- | --- | --- |
| `Top` | 0 |  |
| `Left` | 1 |  |
| `Right` | 4 |  |
| `Bottom` | 3 |  |
| `TopRight` | 5 |  |
| `BottomRight` | 6 |  |
| `BottomLeft` | 7 |  |
| `TopLeft` | 8 |  |
| `AutoDetectionInnerCircle` | 9 |  |
| `AutoDetectionOuterCircle` | 10 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>TutorialUiHintAnchor</Name>
  <Id>1737</Id>
  <Items>
    <Item>
      <Name>Top</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Left</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Right</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>Bottom</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>TopRight</Name>
      <Id>5</Id>
    </Item>
    <Item>
      <Name>BottomRight</Name>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>BottomLeft</Name>
      <Id>7</Id>
    </Item>
    <Item>
      <Name>TopLeft</Name>
      <Id>8</Id>
    </Item>
    <Item>
      <Name>AutoDetectionInnerCircle</Name>
      <Id>9</Id>
    </Item>
    <Item>
      <Name>AutoDetectionOuterCircle</Name>
      <Id>10</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-tutorialuihintcolortype"></a>
<details>
<summary>TutorialUiHintColorType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:9155. Dataset Id=1824.

| Token | Id | Native description |
| --- | --- | --- |
| `Info` | 0 |  |
| `Quest` | 1 |  |
| `Anarchist` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>TutorialUiHintColorType</Name>
  <Id>1824</Id>
  <Items>
    <Item>
      <Name>Info</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Quest</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Anarchist</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-tutorialuihintendcondition"></a>
<details>
<summary>TutorialUiHintEndCondition — all tokens, IDs and native metadata</summary>

Source: datasets.xml:9173. Dataset Id=1794.

| Token | Id | Native description |
| --- | --- | --- |
| `None` | 0 |  |
| `Selection` | 1 |  |
| `Time` | 2 |  |
| `Deselection` | 4 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>TutorialUiHintEndCondition</Name>
  <Id>1794</Id>
  <Items>
    <Item>
      <Name>None</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Selection</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Time</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Deselection</Name>
      <Id>4</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-tutorialuihinttype"></a>
<details>
<summary>TutorialUiHintType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:9195. Dataset Id=1745.

| Token | Id | Native description |
| --- | --- | --- |
| `None` | 0 |  |
| `UIElement` | 1 |  |
| `Object` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>TutorialUiHintType</Name>
  <Id>1745</Id>
  <Items>
    <Item>
      <Name>None</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>UIElement</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Object</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-variables"></a>
<details>
<summary>Variables — all tokens, IDs and native metadata</summary>

Source: datasets.xml:3821. Dataset Id=1807.

| Token | Id | Native description |
| --- | --- | --- |
| `Mercier_ARQTriggerChance` | 0 |  |
| `Mercier_ARQDelayTimer` | 1 |  |
| `Mercier_ARQQuestTypeChance` | 2 |  |
| `Mercier_PropagandaQuestChance` | 3 |  |
| `Mercier_DeserterDelayTimer` | 4 |  |
| `AnarchyFestivalWeight` | 6 | Additional weight for the Anarchy festival |
| `Mercier_DeserterReactionNotiChance` | 7 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>Variables</Name>
  <Id>1807</Id>
  <Items>
    <Item>
      <Name>Mercier_ARQTriggerChance</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Mercier_ARQDelayTimer</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Mercier_ARQQuestTypeChance</Name>
      <Id>2</Id>
    </Item>
    <Item>
      <Name>Mercier_PropagandaQuestChance</Name>
      <Id>3</Id>
    </Item>
    <Item>
      <Name>Mercier_DeserterDelayTimer</Name>
      <Id>4</Id>
    </Item>
    <Item>
      <Name>AnarchyFestivalWeight</Name>
      <Description>Additional weight for the Anarchy festival</Description>
      <Id>6</Id>
    </Item>
    <Item>
      <Name>Mercier_DeserterReactionNotiChance</Name>
      <Id>7</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-versiontype"></a>
<details>
<summary>VersionType — all tokens, IDs and native metadata</summary>

Source: datasets.xml:3884. Dataset Id=1912.

| Token | Id | Native description |
| --- | --- | --- |
| `main` | 0 |  |
| `dm` | 1 |  |
| `dlc01` | 2 |  |
| `dlc02` | 3 |  |
| `dlc03` | 4 |  |
| `dlc04` | 5 |  |
| `dlc05` | 6 |  |
| `dlc06` | 7 |  |
| `dlc07` | 8 |  |
| `dlc08` | 9 |  |
| `dlc09` | 10 |  |
| `cdlc01` | 11 |  |
| `cdlc02` | 12 |  |
| `cdlc03` | 13 |  |
| `cdlc04` | 18 |  |
| `cdlc05` | 19 |  |
| `cdlc06` | 20 |  |
| `cdlc07` | 21 |  |
| `dlc10` | 14 |  |
| `cdlc08` | 22 |  |
| `dlc11` | 15 |  |
| `dlc12` | 16 |  |
| `console` | 23 |  |
| `cdlc09` | 24 |  |
| `cdlc10` | 25 |  |
| `jp` | 26 |  |
| `cdlc11` | 26 |  |
| `cdlc12` | 27 |  |
| `test` | 17 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>VersionType</Name>
  <Id>1912</Id>
  <Description>The order of the entries needs to be the order of the Releases!</Description>
  <Items>
    <Item>
      <Name>main</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>dm</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>dlc01</Name>
      <Id>2</Id>
      <ImagePath>data/ui/2kimages/main/3dicons/icon_dlc_sunken_treasure_256.png</ImagePath>
    </Item>
    <Item>
      <Name>dlc02</Name>
      <Id>3</Id>
      <ImagePath>data/ui/2kimages/main/3dicons/icon_dlc_botanica_256.png</ImagePath>
    </Item>
    <Item>
      <Name>dlc03</Name>
      <Id>4</Id>
      <ImagePath>data/ui/2kimages/main/3dicons/icon_dlc_passage_256.png</ImagePath>
    </Item>
    <Item>
      <Name>dlc04</Name>
      <Id>5</Id>
      <ImagePath>data/ui/2kimages/main/3dicons/icon_dlc_palace_256.png</ImagePath>
    </Item>
    <Item>
      <Name>dlc05</Name>
      <Id>6</Id>
      <ImagePath>data/ui/2kimages/main/3dicons/icon_dlc_bright_harvest_256.png</ImagePath>
    </Item>
    <Item>
      <Name>dlc06</Name>
      <Id>7</Id>
      <ImagePath>data/ui/2kimages/main/3dicons/icon_dlc_land_of_lions_256.png</ImagePath>
    </Item>
    <Item>
      <Name>dlc07</Name>
      <Id>8</Id>
      <ImagePath>data/ui/2kimages/main/3dicons/icon_kontor_main.png</ImagePath>
    </Item>
    <Item>
      <Name>dlc08</Name>
      <Id>9</Id>
    </Item>
    <Item>
      <Name>dlc09</Name>
      <Id>10</Id>
    </Item>
    <Item>
      <Name>cdlc01</Name>
      <Id>11</Id>
      <ImagePath>data/ui/2kimages/main/3dicons/icon_ornament_christmas.png</ImagePath>
    </Item>
    <Item>
      <Name>cdlc02</Name>
      <Id>12</Id>
      <ImagePath>data/ui/2kimages/main/3dicons/ornaments/cosmetic_dlc02/icon_ferris_wheel.png</ImagePath>
    </Item>
    <Item>
      <Name>cdlc03</Name>
      <Id>13</Id>
      <ImagePath>data/ui/2kimages/main/3dicons/icon_light_bulb.png</ImagePath>
    </Item>
    <Item>
      <Name>cdlc04</Name>
      <Id>18</Id>
    </Item>
    <Item>
      <Name>cdlc05</Name>
      <Id>19</Id>
    </Item>
    <Item>
      <Name>cdlc06</Name>
      <Id>20</Id>
    </Item>
    <Item>
      <Name>cdlc07</Name>
      <Id>21</Id>
    </Item>
    <Item>
      <Name>dlc10</Name>
      <Id>14</Id>
    </Item>
    <Item>
      <Name>cdlc08</Name>
      <Id>22</Id>
    </Item>
    <Item>
      <Name>dlc11</Name>
      <Id>15</Id>
    </Item>
    <Item>
      <Name>dlc12</Name>
      <Id>16</Id>
    </Item>
    <Item>
      <Name>console</Name>
      <Id>23</Id>
    </Item>
    <Item>
      <Name>cdlc09</Name>
      <Id>24</Id>
    </Item>
    <Item>
      <Name>cdlc10</Name>
      <Id>25</Id>
    </Item>
    <Item>
      <Name>jp</Name>
      <Id>26</Id>
    </Item>
    <Item>
      <Name>cdlc11</Name>
      <Id>26</Id>
    </Item>
    <Item>
      <Name>cdlc12</Name>
      <Id>27</Id>
    </Item>
    <Item>
      <Name>test</Name>
      <Id>17</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="dataset-winlosestate"></a>
<details>
<summary>WinLoseState — all tokens, IDs and native metadata</summary>

Source: datasets.xml:4065. Dataset Id=1771.

| Token | Id | Native description |
| --- | --- | --- |
| `Win` | 0 |  |
| `Lose` | 1 |  |
| `Defeat` | 2 |  |

<details>
<summary>Exact native dataset definition</summary>

```xml
<DataSet>
  <Name>WinLoseState</Name>
  <Id>1771</Id>
  <Items>
    <Item>
      <Name>Win</Name>
      <Id>0</Id>
    </Item>
    <Item>
      <Name>Lose</Name>
      <Id>1</Id>
    </Item>
    <Item>
      <Name>Defeat</Name>
      <Id>2</Id>
    </Item>
  </Items>
</DataSet>
```

</details>

</details>

<a id="sources"></a>
## 18. Sources, uncertainty and validation

This guide combines local vanilla exports, Serp's original notes and mod comments, the six source integrations described above, and direct author clarifications on 2026-10-03. Everything needed to read the guide is included here; the original mods are examples with their own runtime dependencies, not standalone installable recipes. Original mod code and helpful comments were not changed.

### Evidence and provenance

Optional public sources for the original examples and shared helpers: [Serpens66 / Anno-1800-Mods](https://github.com/Serpens66/Anno-1800-Mods) and [Serpens66 / Anno-1800-SharedMods-for-Modders-](https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-). You do not need to open either repository to follow the explanations, examples or native reference appendix in this guide. Their current contents can differ from the locally reviewed versions stated here.

Vanilla templates establish property membership and embedded defaults. Property definitions establish field types, nested shape, allowed references and datasets. Concrete assets establish real identities, overrides and base chains. They do not expose every engine algorithm. Author observations and clarifications are identified separately, with probable or unresolved claims kept qualified.

The opening example is native asset 130221. Its population context 15000003, every unlock/unhide target, their base chains and trigger contracts were checked against the current exports. The later native catalogue preserves source lines and sample owner GUIDs; those lines are specific to the captured revision. The six mod examples describe their helper versions and callers/consumers in section 15.

<a id="vanilla-audit"></a>
### How to audit a new trigger feature

1. In assets.xml, find an actual asset using the desired condition/action. Read the whole owning tree, not just a matching property name.
2. In templates.xml, resolve its owning and embedded templates. Record their property membership and overrides, including IsBaseAutoCreateAsset.
3. In properties-toolone.xml, inspect every relevant field's type, nested Items, allowed template/property/asset targets, datasets and descriptions. Schema text is intent, not runtime proof.
4. In properties.xml, inspect property and container defaults. Apply concrete asset/base overrides and concrete template overrides before drawing conclusions from generic defaults.
5. In datasets.xml, verify serialized token spelling and IDs. Do not invent a similar-sounding event or comparison token.
6. Follow BaseAssetGUID chains, counter context GUIDs, pool members, participant/session identities and action resources. Check the actual downstream consumers or caller that registers the trigger.
7. If names or UI expressions matter, verify export.xml and the relevant texts files rather than guessing from a GUID. For scripts/helpers, verify the loaded package version, script contents, initialization and command synchronization category.
8. Separate structural evidence, tested observations and inference. Keep any unknown runtime boundary visible and do not silently substitute an assumption.

The 91-condition appendix is a structural reference. It does not complete the gameplay audit for every achievement, quest, spawning, graphics or object system represented by its native examples. Repeat the relevant audit when a new design uses another consumer or a changed source revision.

### Captured vanilla revisions

These hashes identify the exports used for the source checks; they are provenance, not a claim about all installed game builds.

| Vanilla file | SHA-256 |
| --- | --- |
| assets.xml | `08b6cc7023aa1d834f2e6c2042848a3b3e2f13fcc44735a6248f6b6622d42c6a` |
| templates.xml | `099e887c72f97e3a443944e90d45ea544a3d83dd3dd440bf1e420ed709a187f8` |
| properties-toolone.xml | `bf8b81d19a54ab1e7086bc7d47e0239857335422cec6e299b527ef77d462593b` |
| properties.xml | `a9d10e0c450908ab8f7fb15d29852996a912eea536ccda7855f175cfd972c200` |
| datasets.xml | `814e866f3bd38b271e0aa4fa91a1080e9e64121d54431d98c74d916739c30a48` |

### What remains uncertain

Optional descendants and MutualArea simultaneous behavior are **very likely**, not absolutely certain. Timer restart and positive ThresholdDuration values/units remain **probable**. Main-condition IsOptional and conditional ForceBuild MP usability are author assessments. Direct self-registration, minimum quest-linking flags, attractiveness interpretation and the cause of possible two-pass third-party inventory insertion remain unresolved. QuestStarted's pool/action distinction is a reasoned hypothesis. CorporationDifficulty probably fails in MP.

All submitted questions have replies; a reply stating “no newer findings” does not turn an uncertain mechanism into a confirmed recipe. Original contradictory comments remain available as evidence. A future source revision or relevant game observation may require revisiting the corresponding paragraph.

### What offline validation establishes

The guide's complete ModOps are checked for native template/property/field membership, dataset tokens, GUID substitution and preservation of their insertion anchor and payload by the installed Anno 1800 XML evaluator. This file is also checked for well-formed XML blocks, collapsible code blocks, working links/anchors, complete catalogue coverage, UTF-8 and CRLF.

These checks do **not** run gameplay conditions, Lua game APIs, the shared dependency selector, save migrations or multiplayer timing. They do not certify all mods or all 91 condition consumers. Use the source audit and an appropriate runtime test when a new design relies on behavior beyond the reviewed findings.
