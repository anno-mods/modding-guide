# Fc Files 

- I assume you converted the Fc File using FileDBReader using: 

```
FileDBReader fctohex -f <file> -i FcFile.xml -d -y
```

That way, you'll be able to read everything in well-formed xml in a text editor. 

## Terminology

- `Dummy`: A fixed Position and Rotation
- `DummyGroup` : A collection of Dummies and SubGroups
- `Feedback Definition` or `Actor` : An Actor that can have multiple defined behaviors. It can pick either one or no Behavior to play.
- `Spline`: A Curve in 3D Space.
- `Actor Sequence` : Single Behavior of an Actor, consisting of Intro, Running and Outro. During an Actor Sequence, the Actor plays one or multiple `Actions`, using `Dummies` for Positioning.
- `Action` : A Single Action like "walk from A to B" or "Fadeout"
- `Object Sequence` : The State of the entire Game Object. 
- `Sequence` : A Sequence as used in a CFG file.

> Pay attention to the different types of Sequences. all of them are important, but all of them are fundamentally different things.

# How does the Game play Object Sequences?

- The fc's Object Sequences are in no way related to CFG Sequences. Object Sequences are a complete parallel society. That's it, that's the entire basic explanation.
- So, what happens instead? The game can play 8 different Object Sequences for any Object, of which only two are really important. 

Here is the corresponding Dataset, as Object Sequences have a bit of relevance in the assets as well: 

```XML
<DataSet>
      <Name>FeedbackSequenceType</Name>
      <Id>262</Id>
      <Items>
        <Item>
          <Name>Default</Name>
          <Id>0</Id>
        </Item>
        <Item>
          <Name>Work</Name>
          <Id>1</Id>
        </Item>
        <Item>
          <Name>LowProductivity</Name>
          <Id>2</Id>
        </Item>
        <Item>
          <Name>Cheer</Name>
          <Id>3</Id>
        </Item>
        <Item>
          <Name>Boosted</Name>
          <Id>4</Id>
        </Item>
        <Item>
          <Name>Riot</Name>
          <Id>5</Id>
        </Item>
        <Item>
          <Name>RiotSpecial01</Name>
          <Id>6</Id>
        </Item>
        <Item>
          <Name>RiotSpecial02</Name>
          <Id>7</Id>
        </Item>
        <Item>
          <Name>RiotSpecial03</Name>
          <Id>8</Id>
        </Item>
      </Items>
    </DataSet>
```

- You may have guessed by now: The two relevant Object Sequences are `Default` and `Work`. The Game autoplays them. `Default` by, well, default, and `Work` if an Objects Factory Property has a productivity greater than 0. 
- Which Object Sequences a file supports is set in `ValidSequenceIDs` in the Fc Files FeedbackConfig 

## Mapping Object Sequences to Actor Sequences 

An Actor decides for himself which Object Sequences he supports. This is done using `FeedbackLoops` in the `Actors`/`Feedback Definitions`  Settings. each Key, aka `k` forms a pair with the following Value, aka `v`.  k is an `Id` in the Dataset `FeedbackSequenceType` above, v points to the Index of the Sequence in the Actors `SequenceDefinitions`. 

> k and v are index based. The first k relates to the first v, the second k to the second v and so on. It's totally valid to first write all k's, then all v's, as long as they are in order. 

Take a look at these `FeedbackLoops`

```XML
<FeedbackLoops>
  <k>0</k>
  <v>0</v>
  <k>1</k>
  <v>0</v>
</FeedbackLoops>
```

- Here, k=0, meaning `Default`, plays v=0, meaning the first Sequence of the Actor. k=1, so `Work`, plays the same first sequence. 
- You only need to add the Keys this actor should support, not all the file has. If an Actor only applies when `Work` is active, you just set: 

```XML
<FeedbackLoops>
  <k>1</k>
  <v>0</v>
</FeedbackLoops>
```


# Elements 

## DummyRoot 

The main `DummyGroup` for the entire object. Every `Dummy` that the Object can use is contained in here. 

## Dummy 

- Id: Unique Id of that Dummy
- Name: Unique Name of that Dummy
- Make sure that Dummies inside a group are always enumerated in ascending order, without any gaps in the enumeration. 
  - That is because the Game can refer to entire DummyGroups, using all their Dummies
  - So `Dummy_0`, `Dummy1`, `Dummy2` and so on. 
  - Don't do something like `Dummy_0`, `Dummy_1`, `Dummy_3`. If you have a gap like this, all dummies after the gap, in this case `Dummy_3`, won't be recognized by the game, and their orientation and position are lost. The objects will still spawn as there is a dummy present, but they spawn at the Object Center. 
- RotationY is in Radians
- Orientation is a Quaternion
- HeightAdaptationMode is 1 (Adapts Terrain Height) or 0 (Doesn't adapt)

### Special Dummies

- A DummyGroup named `FireDummy` with Dummies `FireDummy_0`, `FireDummy_1` and so on is used for applying Flames when an Object is burning. This is also used to add Riot and Festival banners, as well as Illness Smog. 
- A DummyGroup named `feedback_door` with Dummies `feedback_door_0`, `feedback_door_1` and so on is used for telling Dynamic Feedback (different type of feedback) where to the doors are on this building. 
> Dynamic Feedback does pathfinding between different buildings and travels from one building to another. For that, they need to know where the doors are. 

## Actor aka Feedback Definition 
- An Actor sets the Objects that use this Actors behavior using `/AssetVariationList/GuidVariationList`. This contains CDATA of tuples of a GUID that links to an `Inhabitant` Templated Asset and a Flag (0 or -1). 

```XML
<GuidVariationList>CDATA[101878 -1 101879 -1 101880 -1 101872 -1 101873 -1 101874 -1 100903 -1 100904 -1 100905 -1]</GuidVariationList>`
```
- FeedbackLoops are explained above 
- MainObject: Only one Actor can be the Main Object. This MainObject can control the CFG itself by setting CFG Sequences for DummyId 0
- SequenceDefinitions holds all Behaviors that this Actor can have. 

Actors also have a few more settings 

- ApplyScaleToMovementSpeed multiplies walking speed of an Actor with it's visual scale. So, if an actor is set to half it's scale, it will also only be half as fast. 
- ActorCount tells how many Instances of this Actor will spawn
- MaxActorCount tells the maximum number of Instaces this Actor will spawn 
- MultiplyActorByDummyCount will spawn an Instance for each Dummy in the linked DummyGroup.

### SequenceDefinitions  

- Sequence Definitions consist of three Loops. Intro, Running and Outro. 
- Intro (Loop0) is played on Actor Spawn 
- Running (Loop1) is played as long as this Actor Sequence is active 
- Outro (Loop2) is played after the last Running Loop has finished (Which is important. Feedback vanishes over time, when they finished playing on of their Running loops, not instantly.)
- Intro and Outro are optional. If missing, they are disregarded, and only Running is played.
- State is carried over. If Intro sets the Scale of an Actor, it will persist that state even while Running and Outro play. The state only resets when an Actor despawns.

### Loop

- A Loop has a DefaultState. This sets the State of a Dummy before the first Loop is running. 
- An ElementContainer contains a List of `Sequence Actions` that are played in order of appearance.
