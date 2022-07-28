# Particle Files (.rdp)

Particle animations stored in `.rdp` need some post processing after extracting them to be easier to modify.

## Get Editable RDP XML Files

Do `fctohex` with FileDBReader using the [RDP interpreter file](https://github.com/anno-mods/FileDBReader/blob/master/FileFormats/rdp.xml).

```sh
./FileDBReader.exe fctohex -f sparks_01.rdp -i ./FileFormats/rdp.xml
```

Output with CDATA as is:

```xml
  <ParticleCount>5</ParticleCount>
  ...
  <P_Starts>CDATA[140 123 105 53 35]</P_Starts>
  <P_Ends>CDATA[52 34 12 103 86]</P_Ends>
  <P_Materials>CDATA[0 0 0 0 0]</P_Materials>
  <TotalTickCount>259</TotalTickCount>
  <T_Positions>CDATA[-28936 23257 -1875 -28936 23257 -1875 ...]</T_Positions>
  <T_Rotations>CDATA[0 182 0 0 182 0 ...]</T_Rotations>
  <T_Scales>CDATA[255 255 255 255 255 255 ...]</T_Scales>
  <T_Colors>CDATA[255 255 255 0 255 255 255 19 ...]</T_Colors>
```

Read the [RDP interpreter file](https://github.com/anno-mods/FileDBReader/blob/master/FileFormats/rdp.xml) to understand how those `P_` and `T_` values are converted in useful numbers.

## Simplified RDP XML Files

The CDATA sections are quite annoying to work with.
[Anno Modding Tools for VSCode](https://marketplace.visualstudio.com/items?itemName=JakobHarder.anno-modding-tools) has also a right-click command to convert RDP files into a simplified XML and back with some structure changes:

```xml
  <Particles>
    <Particle>
      <Material>0</Material>
      <StartFrame>140</StartFrame>
      <Ticks>
        <Tick>
          <PositionXYZ>-0.883084 0.709769 -0.057222</PositionXYZ>
          <RotationXYZ>0.0 255.9 0.0</RotationXYZ>
          <ScaleXYZ>1.0000 1.0000 1.0000</ScaleXYZ>
          <ColorARGB>0 255 255 255</ColorARGB>
        </Tick>
        <Tick>
          <PositionXYZ>-0.883084 0.709769 -0.057222</PositionXYZ>
          <RotationXYZ>0.0 255.9 0.0</RotationXYZ>
          <ScaleXYZ>1.0000 1.0000 1.0000</ScaleXYZ>
          <ColorARGB>19 255 255 255</ColorARGB>
        </Tick>
        ...
```

- `Material`: `P_Materials` entry.
- `StartFrame`: `P_Starts` entry. `P_Ends` entry is calculated by the number of ticks when converting back.
- `PositionXYZ`: -1.0 to 1.0. Multiplied with &lt;Extents&gt; in the game.
- `RotationXZY`: 0 to 359.9 degrees.
- `ScaleXYZ`: 0.0 to 1.0. Multiplied with &lt;MaxScale&gt; in the game.
- `ColorARGB`: 0-255 per channel.
