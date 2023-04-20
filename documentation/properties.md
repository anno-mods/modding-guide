# Property Documentation

## Random Properties

### `Values/Building`

Don't forget to set `SecondPartyRelevant` to 0 if AI should not use this building.

### `Item/Building`

Building GUID

### `NeedProvideNeedUpgrade`

When SubstituteNeed is consumed and fulfilled, ProvidedNeed product will also be fulfilled.

Content: `<Item><ProvidedNeed /><SubstituteNeed /></Item>`

### `DefaultLockedState`

`0` - unlocked and visible.
`1` - needs `FeatureUnlock` to unhide and unlock.

### `BuildingBlockPool`

Define which variation is used when building next to `InfluencedByNeighbors`.

Note: Multiple entries of the same variation with different rotations won't work.
Vanilla assets.xml also defines them, so they were supposed to work at some point.

[See guide on GitHub](https://github.com/anno-mods/modding-guide/blob/main/guides/variations.md)

## Property Topic 1

## Property Topic 2
