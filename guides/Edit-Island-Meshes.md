# Compact guide to edit island meshes

From **Taludas** written here: https://discord.com/channels/578443209940926465/578443576552325143/1204023503658164326

## How to unpack/edit/repack island mesh files (.tmc):

**Prerequisits:**
- FileDBReader and RDAConsole are installed in a folder, that is checked by windows path variable (google for tutorials)
- Copy of the island files including _gamedata folder in a dedicated work folder.

**Setup:**
- copy "tmc.xml" from the FileDBReader Interpreter Folder to the _gamedata/islandname Folder (eg. `_gamedata/moderate_c_01_colony01`).
- copy the following tmc_converter.bat file into the /meshes folder (eg. `_gamedata/moderate_c_01_colony01/meshes`):
  <details>
  <summary>(CLICK) tmc_converter.bat CODE</summary>  
  
  Save this code as tmc_converter.bat file.  
  ```batch file
  @ECHO off

  FOR /R %%i IN (*.tmc) DO (
      START /W /B FileDBReader decompress -f "%%i" -i "../tmc.xml" -y
  )

  FOR /R %%i IN (*.xml) DO (
      ECHO ^<ModOps^> > "%%i_patch.xml" 
      ECHO ^<ModOp Type^=^"replace^" Path=^"^/^/GroundObjects^/None^/FileName^[text^(^) ^= ^'data^\graphics^\props^\terrain^_props^\vegetation^\grass^\flowers^_moderate^_01^.prp^'^]^"^> >> "%%i_patch.xml" 
      ECHO ^<FileName^>data^\graphics^\props^\terrain_props^\vegetation^\grass^\flowers^_jungle^_01^.prp^<^/FileName^> >> "%%i_patch.xml"    
      ECHO ^<^/ModOp^> >> "%%i_patch.xml"
      ECHO ^<ModOp Type^=^"replace^" Path=^"^/^/GroundObjects^/None^/FileName^[text^(^) ^= ^'data^\graphics^\props^\terrain^_props^\vegetation^\grass^\flowers^_moderate^_02^.prp^'^]^"^> >> "%%i_patch.xml" 
      ECHO ^<FileName^>data^\graphics^\props^\terrain_props^\vegetation^\grass^\flowers^_jungle^_02^.prp^<^/FileName^> >> "%%i_patch.xml"     
      ECHO ^<^/ModOp^> >> "%%i_patch.xml"
      ECHO ^<ModOp Type^=^"replace^" Path=^"^/^/GroundObjects^/None^/FileName^[text^(^) ^= ^'data^\graphics^\props^\terrain^_props^\vegetation^\grass^\flowers^_moderate^_03^.prp^'^]^"^> >> "%%i_patch.xml" 
      ECHO ^<FileName^>data^\graphics^\props^\terrain_props^\vegetation^\grass^\flowers^_jungle^_03^.prp^<^/FileName^> >> "%%i_patch.xml"     
      ECHO ^<^/ModOp^> >> "%%i_patch.xml"
      ECHO ^<ModOp Type^=^"replace^" Path=^"^/^/GroundObjects^/None^/FileName^[text^(^) ^= ^'data^\graphics^\props^\terrain^_props^\vegetation^\grass^\flowers^_moderate^_04^.prp^'^]^"^> >> "%%i_patch.xml" 
      ECHO ^<FileName^>data^\graphics^\props^\terrain_props^\vegetation^\grass^\flowers^_jungle^_04^.prp^<^/FileName^> >> "%%i_patch.xml"     
      ECHO ^<^/ModOp^> >> "%%i_patch.xml"
      ECHO ^<ModOp Type^=^"replace^" Path=^"^/^/GroundObjects^/None^/FileName^[text^(^) ^= ^'data^\graphics^\props^\terrain^_props^\vegetation^\grass^\flowers^_moderate^_05^.prp^'^]^"^> >> "%%i_patch.xml" 
      ECHO ^<FileName^>data^\graphics^\props^\terrain_props^\vegetation^\grass^\flowers^_jungle^_01^.prp^<^/FileName^> >> "%%i_patch.xml"   
      ECHO ^<^/ModOp^> >> "%%i_patch.xml"     
      ECHO ^<^/ModOps^> >> "%%i_patch.xml"
  )  


  [text() = 'hello']
  ```
  </details>
**Note:** Edit the code in the lower half before running the .bat file if you want to set up some patching. Uses regular ModOp expressions.
I've set this up to replace the flower props of one region with those of the other region. 
- run the .bat file. You will now find inside the individual folder "0,1,..." the original .tmc file, the original interprated .xml file, if you set it up the _patch.xml file.
- if you want, do manual edits to the _patch.xml file (lots of work duh...)  

**Repack:**
- copy the following tmc_compressor.bat file to each folder "0,1..." (eg. `_gamedata/moderate_c_01_colony01/meshes/0` and so on):
  <details>
  <summary>(CLICK) tmc_compressor.bat CODE</summary>  
  
  Save this code as tmc_compressor.bat file.  
  ```batch file
  @ECHO off
  
  START /W /B xmltest 0x0.xml 0x0.xml_patch.xml
  MOVE /Y patched.xml 0x0_patched.xml
  START /W /B Filedbreader compress -f 0x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x0_patched.tmc 0x0.tmc

  START /W /B xmltest 0x1.xml 0x1.xml_patch.xml
  MOVE /Y patched.xml 0x1_patched.xml
  START /W /B Filedbreader compress -f 0x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x1_patched.tmc 0x1.tmc

  START /W /B xmltest 0x2.xml 0x2.xml_patch.xml
  MOVE /Y patched.xml 0x2_patched.xml
  START /W /B Filedbreader compress -f 0x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x2_patched.tmc 0x2.tmc

  START /W /B xmltest 0x3.xml 0x3.xml_patch.xml
  MOVE /Y patched.xml 0x3_patched.xml
  START /W /B Filedbreader compress -f 0x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x3_patched.tmc 0x3.tmc

  START /W /B xmltest 0x4.xml 0x4.xml_patch.xml
  MOVE /Y patched.xml 0x4_patched.xml
  START /W /B Filedbreader compress -f 0x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x4_patched.tmc 0x4.tmc

  START /W /B xmltest 0x5.xml 0x5.xml_patch.xml
  MOVE /Y patched.xml 0x5_patched.xml
  START /W /B Filedbreader compress -f 0x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x5_patched.tmc 0x5.tmc

  START /W /B xmltest 0x6.xml 0x6.xml_patch.xml
  MOVE /Y patched.xml 0x6_patched.xml
  START /W /B Filedbreader compress -f 0x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x6_patched.tmc 0x6.tmc

  START /W /B xmltest 0x7.xml 0x7.xml_patch.xml
  MOVE /Y patched.xml 0x7_patched.xml
  START /W /B Filedbreader compress -f 0x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x7_patched.tmc 0x7.tmc

  START /W /B xmltest 0x8.xml 0x8.xml_patch.xml
  MOVE /Y patched.xml 0x8_patched.xml
  START /W /B Filedbreader compress -f 0x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x8_patched.tmc 0x8.tmc

  START /W /B xmltest 0x9.xml 0x9.xml_patch.xml
  MOVE /Y patched.xml 0x9_patched.xml
  START /W /B Filedbreader compress -f 0x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x9_patched.tmc 0x9.tmc

  START /W /B xmltest 0x10.xml 0x10.xml_patch.xml
  MOVE /Y patched.xml 0x10_patched.xml
  START /W /B Filedbreader compress -f 0x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x10_patched.tmc 0x10.tmc

  START /W /B xmltest 0x11.xml 0x11.xml_patch.xml
  MOVE /Y patched.xml 0x11_patched.xml
  START /W /B Filedbreader compress -f 0x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x11_patched.tmc 0x11.tmc

  START /W /B xmltest 0x12.xml 0x12.xml_patch.xml
  MOVE /Y patched.xml 0x12_patched.xml
  START /W /B Filedbreader compress -f 0x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x12_patched.tmc 0x12.tmc

  START /W /B xmltest 0x13.xml 0x13.xml_patch.xml
  MOVE /Y patched.xml 0x13_patched.xml
  START /W /B Filedbreader compress -f 0x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x13_patched.tmc 0x13.tmc

  START /W /B xmltest 0x14.xml 0x14.xml_patch.xml
  MOVE /Y patched.xml 0x14_patched.xml
  START /W /B Filedbreader compress -f 0x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x14_patched.tmc 0x14.tmc

  START /W /B xmltest 0x15.xml 0x15.xml_patch.xml
  MOVE /Y patched.xml 0x15_patched.xml
  START /W /B Filedbreader compress -f 0x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x15_patched.tmc 0x15.tmc

  START /W /B xmltest 0x16.xml 0x16.xml_patch.xml
  MOVE /Y patched.xml 0x16_patched.xml
  START /W /B Filedbreader compress -f 0x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x16_patched.tmc 0x16.tmc

  START /W /B xmltest 0x17.xml 0x17.xml_patch.xml
  MOVE /Y patched.xml 0x17_patched.xml
  START /W /B Filedbreader compress -f 0x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x17_patched.tmc 0x17.tmc

  START /W /B xmltest 0x18.xml 0x18.xml_patch.xml
  MOVE /Y patched.xml 0x18_patched.xml
  START /W /B Filedbreader compress -f 0x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x18_patched.tmc 0x18.tmc

  START /W /B xmltest 0x19.xml 0x19.xml_patch.xml
  MOVE /Y patched.xml 0x19_patched.xml
  START /W /B Filedbreader compress -f 0x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x19_patched.tmc 0x19.tmc

  START /W /B xmltest 0x20.xml 0x20.xml_patch.xml
  MOVE /Y patched.xml 0x20_patched.xml
  START /W /B Filedbreader compress -f 0x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x20_patched.tmc 0x20.tmc

  START /W /B xmltest 0x21.xml 0x21.xml_patch.xml
  MOVE /Y patched.xml 0x21_patched.xml
  START /W /B Filedbreader compress -f 0x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x21_patched.tmc 0x21.tmc

  START /W /B xmltest 0x22.xml 0x22.xml_patch.xml
  MOVE /Y patched.xml 0x22_patched.xml
  START /W /B Filedbreader compress -f 0x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x22_patched.tmc 0x22.tmc

  START /W /B xmltest 0x23.xml 0x23.xml_patch.xml
  MOVE /Y patched.xml 0x23_patched.xml
  START /W /B Filedbreader compress -f 0x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 0x23_patched.tmc 0x23.tmc



  START /W /B xmltest 1x0.xml 1x0.xml_patch.xml
  MOVE /Y patched.xml 1x0_patched.xml
  START /W /B Filedbreader compress -f 1x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x0_patched.tmc 1x0.tmc

  START /W /B xmltest 1x1.xml 1x1.xml_patch.xml
  MOVE /Y patched.xml 1x1_patched.xml
  START /W /B Filedbreader compress -f 1x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x1_patched.tmc 1x1.tmc

  START /W /B xmltest 1x2.xml 1x2.xml_patch.xml
  MOVE /Y patched.xml 1x2_patched.xml
  START /W /B Filedbreader compress -f 1x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x2_patched.tmc 1x2.tmc

  START /W /B xmltest 1x3.xml 1x3.xml_patch.xml
  MOVE /Y patched.xml 1x3_patched.xml
  START /W /B Filedbreader compress -f 1x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x3_patched.tmc 1x3.tmc

  START /W /B xmltest 1x4.xml 1x4.xml_patch.xml
  MOVE /Y patched.xml 1x4_patched.xml
  START /W /B Filedbreader compress -f 1x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x4_patched.tmc 1x4.tmc

  START /W /B xmltest 1x5.xml 1x5.xml_patch.xml
  MOVE /Y patched.xml 1x5_patched.xml
  START /W /B Filedbreader compress -f 1x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x5_patched.tmc 1x5.tmc

  START /W /B xmltest 1x6.xml 1x6.xml_patch.xml
  MOVE /Y patched.xml 1x6_patched.xml
  START /W /B Filedbreader compress -f 1x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x6_patched.tmc 1x6.tmc

  START /W /B xmltest 1x7.xml 1x7.xml_patch.xml
  MOVE /Y patched.xml 1x7_patched.xml
  START /W /B Filedbreader compress -f 1x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x7_patched.tmc 1x7.tmc

  START /W /B xmltest 1x8.xml 1x8.xml_patch.xml
  MOVE /Y patched.xml 1x8_patched.xml
  START /W /B Filedbreader compress -f 1x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x8_patched.tmc 1x8.tmc

  START /W /B xmltest 1x9.xml 1x9.xml_patch.xml
  MOVE /Y patched.xml 1x9_patched.xml
  START /W /B Filedbreader compress -f 1x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x9_patched.tmc 1x9.tmc

  START /W /B xmltest 1x10.xml 1x10.xml_patch.xml
  MOVE /Y patched.xml 1x10_patched.xml
  START /W /B Filedbreader compress -f 1x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x10_patched.tmc 1x10.tmc

  START /W /B xmltest 1x11.xml 1x11.xml_patch.xml
  MOVE /Y patched.xml 1x11_patched.xml
  START /W /B Filedbreader compress -f 1x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x11_patched.tmc 1x11.tmc

  START /W /B xmltest 1x12.xml 1x12.xml_patch.xml
  MOVE /Y patched.xml 1x12_patched.xml
  START /W /B Filedbreader compress -f 1x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x12_patched.tmc 1x12.tmc

  START /W /B xmltest 1x13.xml 1x13.xml_patch.xml
  MOVE /Y patched.xml 1x13_patched.xml
  START /W /B Filedbreader compress -f 1x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x13_patched.tmc 1x13.tmc

  START /W /B xmltest 1x14.xml 1x14.xml_patch.xml
  MOVE /Y patched.xml 1x14_patched.xml
  START /W /B Filedbreader compress -f 1x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x14_patched.tmc 1x14.tmc

  START /W /B xmltest 1x15.xml 1x15.xml_patch.xml
  MOVE /Y patched.xml 1x15_patched.xml
  START /W /B Filedbreader compress -f 1x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x15_patched.tmc 1x15.tmc

  START /W /B xmltest 1x16.xml 1x16.xml_patch.xml
  MOVE /Y patched.xml 1x16_patched.xml
  START /W /B Filedbreader compress -f 1x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x16_patched.tmc 1x16.tmc

  START /W /B xmltest 1x17.xml 1x17.xml_patch.xml
  MOVE /Y patched.xml 1x17_patched.xml
  START /W /B Filedbreader compress -f 1x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x17_patched.tmc 1x17.tmc

  START /W /B xmltest 1x18.xml 1x18.xml_patch.xml
  MOVE /Y patched.xml 1x18_patched.xml
  START /W /B Filedbreader compress -f 1x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x18_patched.tmc 1x18.tmc

  START /W /B xmltest 1x19.xml 1x19.xml_patch.xml
  MOVE /Y patched.xml 1x19_patched.xml
  START /W /B Filedbreader compress -f 1x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x19_patched.tmc 1x19.tmc

  START /W /B xmltest 1x20.xml 1x20.xml_patch.xml
  MOVE /Y patched.xml 1x20_patched.xml
  START /W /B Filedbreader compress -f 1x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x20_patched.tmc 1x20.tmc

  START /W /B xmltest 1x21.xml 1x21.xml_patch.xml
  MOVE /Y patched.xml 1x21_patched.xml
  START /W /B Filedbreader compress -f 1x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x21_patched.tmc 1x21.tmc

  START /W /B xmltest 1x22.xml 1x22.xml_patch.xml
  MOVE /Y patched.xml 1x22_patched.xml
  START /W /B Filedbreader compress -f 1x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x22_patched.tmc 1x22.tmc

  START /W /B xmltest 1x23.xml 1x23.xml_patch.xml
  MOVE /Y patched.xml 1x23_patched.xml
  START /W /B Filedbreader compress -f 1x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 1x23_patched.tmc 1x23.tmc



  START /W /B xmltest 2x0.xml 2x0.xml_patch.xml
  MOVE /Y patched.xml 2x0_patched.xml
  START /W /B Filedbreader compress -f 2x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x0_patched.tmc 2x0.tmc

  START /W /B xmltest 2x1.xml 2x1.xml_patch.xml
  MOVE /Y patched.xml 2x1_patched.xml
  START /W /B Filedbreader compress -f 2x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x1_patched.tmc 2x1.tmc

  START /W /B xmltest 2x2.xml 2x2.xml_patch.xml
  MOVE /Y patched.xml 2x2_patched.xml
  START /W /B Filedbreader compress -f 2x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x2_patched.tmc 2x2.tmc

  START /W /B xmltest 2x3.xml 2x3.xml_patch.xml
  MOVE /Y patched.xml 2x3_patched.xml
  START /W /B Filedbreader compress -f 2x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x3_patched.tmc 2x3.tmc

  START /W /B xmltest 2x4.xml 2x4.xml_patch.xml
  MOVE /Y patched.xml 2x4_patched.xml
  START /W /B Filedbreader compress -f 2x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x4_patched.tmc 2x4.tmc

  START /W /B xmltest 2x5.xml 2x5.xml_patch.xml
  MOVE /Y patched.xml 2x5_patched.xml
  START /W /B Filedbreader compress -f 2x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x5_patched.tmc 2x5.tmc

  START /W /B xmltest 2x6.xml 2x6.xml_patch.xml
  MOVE /Y patched.xml 2x6_patched.xml
  START /W /B Filedbreader compress -f 2x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x6_patched.tmc 2x6.tmc

  START /W /B xmltest 2x7.xml 2x7.xml_patch.xml
  MOVE /Y patched.xml 2x7_patched.xml
  START /W /B Filedbreader compress -f 2x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x7_patched.tmc 2x7.tmc

  START /W /B xmltest 2x8.xml 2x8.xml_patch.xml
  MOVE /Y patched.xml 2x8_patched.xml
  START /W /B Filedbreader compress -f 2x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x8_patched.tmc 2x8.tmc

  START /W /B xmltest 2x9.xml 2x9.xml_patch.xml
  MOVE /Y patched.xml 2x9_patched.xml
  START /W /B Filedbreader compress -f 2x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x9_patched.tmc 2x9.tmc

  START /W /B xmltest 2x10.xml 2x10.xml_patch.xml
  MOVE /Y patched.xml 2x10_patched.xml
  START /W /B Filedbreader compress -f 2x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x10_patched.tmc 2x10.tmc

  START /W /B xmltest 2x11.xml 2x11.xml_patch.xml
  MOVE /Y patched.xml 2x11_patched.xml
  START /W /B Filedbreader compress -f 2x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x11_patched.tmc 2x11.tmc

  START /W /B xmltest 2x12.xml 2x12.xml_patch.xml
  MOVE /Y patched.xml 2x12_patched.xml
  START /W /B Filedbreader compress -f 2x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x12_patched.tmc 2x12.tmc

  START /W /B xmltest 2x13.xml 2x13.xml_patch.xml
  MOVE /Y patched.xml 2x13_patched.xml
  START /W /B Filedbreader compress -f 2x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x13_patched.tmc 2x13.tmc

  START /W /B xmltest 2x14.xml 2x14.xml_patch.xml
  MOVE /Y patched.xml 2x14_patched.xml
  START /W /B Filedbreader compress -f 2x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x14_patched.tmc 2x14.tmc

  START /W /B xmltest 2x15.xml 2x15.xml_patch.xml
  MOVE /Y patched.xml 2x15_patched.xml
  START /W /B Filedbreader compress -f 2x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x15_patched.tmc 2x15.tmc

  START /W /B xmltest 2x16.xml 2x16.xml_patch.xml
  MOVE /Y patched.xml 2x16_patched.xml
  START /W /B Filedbreader compress -f 2x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x16_patched.tmc 2x16.tmc

  START /W /B xmltest 2x17.xml 2x17.xml_patch.xml
  MOVE /Y patched.xml 2x17_patched.xml
  START /W /B Filedbreader compress -f 2x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x17_patched.tmc 2x17.tmc

  START /W /B xmltest 2x18.xml 2x18.xml_patch.xml
  MOVE /Y patched.xml 2x18_patched.xml
  START /W /B Filedbreader compress -f 2x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x18_patched.tmc 2x18.tmc

  START /W /B xmltest 2x19.xml 2x19.xml_patch.xml
  MOVE /Y patched.xml 2x19_patched.xml
  START /W /B Filedbreader compress -f 2x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x19_patched.tmc 2x19.tmc

  START /W /B xmltest 2x20.xml 2x20.xml_patch.xml
  MOVE /Y patched.xml 2x20_patched.xml
  START /W /B Filedbreader compress -f 2x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x20_patched.tmc 2x20.tmc

  START /W /B xmltest 2x21.xml 2x21.xml_patch.xml
  MOVE /Y patched.xml 2x21_patched.xml
  START /W /B Filedbreader compress -f 2x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x21_patched.tmc 2x21.tmc

  START /W /B xmltest 2x22.xml 2x22.xml_patch.xml
  MOVE /Y patched.xml 2x22_patched.xml
  START /W /B Filedbreader compress -f 2x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x22_patched.tmc 2x22.tmc

  START /W /B xmltest 2x23.xml 2x23.xml_patch.xml
  MOVE /Y patched.xml 2x23_patched.xml
  START /W /B Filedbreader compress -f 2x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 2x23_patched.tmc 2x23.tmc




  START /W /B xmltest 3x0.xml 3x0.xml_patch.xml
  MOVE /Y patched.xml 3x0_patched.xml
  START /W /B Filedbreader compress -f 3x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x0_patched.tmc 3x0.tmc

  START /W /B xmltest 3x1.xml 3x1.xml_patch.xml
  MOVE /Y patched.xml 3x1_patched.xml
  START /W /B Filedbreader compress -f 3x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x1_patched.tmc 3x1.tmc

  START /W /B xmltest 3x2.xml 3x2.xml_patch.xml
  MOVE /Y patched.xml 3x2_patched.xml
  START /W /B Filedbreader compress -f 3x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x2_patched.tmc 3x2.tmc

  START /W /B xmltest 3x3.xml 3x3.xml_patch.xml
  MOVE /Y patched.xml 3x3_patched.xml
  START /W /B Filedbreader compress -f 3x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x3_patched.tmc 3x3.tmc

  START /W /B xmltest 3x4.xml 3x4.xml_patch.xml
  MOVE /Y patched.xml 3x4_patched.xml
  START /W /B Filedbreader compress -f 3x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x4_patched.tmc 3x4.tmc

  START /W /B xmltest 3x5.xml 3x5.xml_patch.xml
  MOVE /Y patched.xml 3x5_patched.xml
  START /W /B Filedbreader compress -f 3x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x5_patched.tmc 3x5.tmc

  START /W /B xmltest 3x6.xml 3x6.xml_patch.xml
  MOVE /Y patched.xml 3x6_patched.xml
  START /W /B Filedbreader compress -f 3x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x6_patched.tmc 3x6.tmc

  START /W /B xmltest 3x7.xml 3x7.xml_patch.xml
  MOVE /Y patched.xml 3x7_patched.xml
  START /W /B Filedbreader compress -f 3x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x7_patched.tmc 3x7.tmc

  START /W /B xmltest 3x8.xml 3x8.xml_patch.xml
  MOVE /Y patched.xml 3x8_patched.xml
  START /W /B Filedbreader compress -f 3x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x8_patched.tmc 3x8.tmc

  START /W /B xmltest 3x9.xml 3x9.xml_patch.xml
  MOVE /Y patched.xml 3x9_patched.xml
  START /W /B Filedbreader compress -f 3x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x9_patched.tmc 3x9.tmc

  START /W /B xmltest 3x10.xml 3x10.xml_patch.xml
  MOVE /Y patched.xml 3x10_patched.xml
  START /W /B Filedbreader compress -f 3x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x10_patched.tmc 3x10.tmc

  START /W /B xmltest 3x11.xml 3x11.xml_patch.xml
  MOVE /Y patched.xml 3x11_patched.xml
  START /W /B Filedbreader compress -f 3x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x11_patched.tmc 3x11.tmc

  START /W /B xmltest 3x12.xml 3x12.xml_patch.xml
  MOVE /Y patched.xml 3x12_patched.xml
  START /W /B Filedbreader compress -f 3x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x12_patched.tmc 3x12.tmc

  START /W /B xmltest 3x13.xml 3x13.xml_patch.xml
  MOVE /Y patched.xml 3x13_patched.xml
  START /W /B Filedbreader compress -f 3x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x13_patched.tmc 3x13.tmc

  START /W /B xmltest 3x14.xml 3x14.xml_patch.xml
  MOVE /Y patched.xml 3x14_patched.xml
  START /W /B Filedbreader compress -f 3x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x14_patched.tmc 3x14.tmc

  START /W /B xmltest 3x15.xml 3x15.xml_patch.xml
  MOVE /Y patched.xml 3x15_patched.xml
  START /W /B Filedbreader compress -f 3x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x15_patched.tmc 3x15.tmc

  START /W /B xmltest 3x16.xml 3x16.xml_patch.xml
  MOVE /Y patched.xml 3x16_patched.xml
  START /W /B Filedbreader compress -f 3x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x16_patched.tmc 3x16.tmc

  START /W /B xmltest 3x17.xml 3x17.xml_patch.xml
  MOVE /Y patched.xml 3x17_patched.xml
  START /W /B Filedbreader compress -f 3x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x17_patched.tmc 3x17.tmc

  START /W /B xmltest 3x18.xml 3x18.xml_patch.xml
  MOVE /Y patched.xml 3x18_patched.xml
  START /W /B Filedbreader compress -f 3x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x18_patched.tmc 3x18.tmc

  START /W /B xmltest 3x19.xml 3x19.xml_patch.xml
  MOVE /Y patched.xml 3x19_patched.xml
  START /W /B Filedbreader compress -f 3x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x19_patched.tmc 3x19.tmc

  START /W /B xmltest 3x20.xml 3x20.xml_patch.xml
  MOVE /Y patched.xml 3x20_patched.xml
  START /W /B Filedbreader compress -f 3x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x20_patched.tmc 3x20.tmc

  START /W /B xmltest 3x21.xml 3x21.xml_patch.xml
  MOVE /Y patched.xml 3x21_patched.xml
  START /W /B Filedbreader compress -f 3x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x21_patched.tmc 3x21.tmc

  START /W /B xmltest 3x22.xml 3x22.xml_patch.xml
  MOVE /Y patched.xml 3x22_patched.xml
  START /W /B Filedbreader compress -f 3x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x22_patched.tmc 3x22.tmc

  START /W /B xmltest 3x23.xml 3x23.xml_patch.xml
  MOVE /Y patched.xml 3x23_patched.xml
  START /W /B Filedbreader compress -f 3x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 3x23_patched.tmc 3x23.tmc



  START /W /B xmltest 4x0.xml 4x0.xml_patch.xml
  MOVE /Y patched.xml 4x0_patched.xml
  START /W /B Filedbreader compress -f 4x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x0_patched.tmc 4x0.tmc

  START /W /B xmltest 4x1.xml 4x1.xml_patch.xml
  MOVE /Y patched.xml 4x1_patched.xml
  START /W /B Filedbreader compress -f 4x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x1_patched.tmc 4x1.tmc

  START /W /B xmltest 4x2.xml 4x2.xml_patch.xml
  MOVE /Y patched.xml 4x2_patched.xml
  START /W /B Filedbreader compress -f 4x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x2_patched.tmc 4x2.tmc

  START /W /B xmltest 4x3.xml 4x3.xml_patch.xml
  MOVE /Y patched.xml 4x3_patched.xml
  START /W /B Filedbreader compress -f 4x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x3_patched.tmc 4x3.tmc

  START /W /B xmltest 4x4.xml 4x4.xml_patch.xml
  MOVE /Y patched.xml 4x4_patched.xml
  START /W /B Filedbreader compress -f 4x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x4_patched.tmc 4x4.tmc

  START /W /B xmltest 4x5.xml 4x5.xml_patch.xml
  MOVE /Y patched.xml 4x5_patched.xml
  START /W /B Filedbreader compress -f 4x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x5_patched.tmc 4x5.tmc

  START /W /B xmltest 4x6.xml 4x6.xml_patch.xml
  MOVE /Y patched.xml 4x6_patched.xml
  START /W /B Filedbreader compress -f 4x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x6_patched.tmc 4x6.tmc

  START /W /B xmltest 4x7.xml 4x7.xml_patch.xml
  MOVE /Y patched.xml 4x7_patched.xml
  START /W /B Filedbreader compress -f 4x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x7_patched.tmc 4x7.tmc

  START /W /B xmltest 4x8.xml 4x8.xml_patch.xml
  MOVE /Y patched.xml 4x8_patched.xml
  START /W /B Filedbreader compress -f 4x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x8_patched.tmc 4x8.tmc

  START /W /B xmltest 4x9.xml 4x9.xml_patch.xml
  MOVE /Y patched.xml 4x9_patched.xml
  START /W /B Filedbreader compress -f 4x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x9_patched.tmc 4x9.tmc

  START /W /B xmltest 4x10.xml 4x10.xml_patch.xml
  MOVE /Y patched.xml 4x10_patched.xml
  START /W /B Filedbreader compress -f 4x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x10_patched.tmc 4x10.tmc

  START /W /B xmltest 4x11.xml 4x11.xml_patch.xml
  MOVE /Y patched.xml 4x11_patched.xml
  START /W /B Filedbreader compress -f 4x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x11_patched.tmc 4x11.tmc

  START /W /B xmltest 4x12.xml 4x12.xml_patch.xml
  MOVE /Y patched.xml 4x12_patched.xml
  START /W /B Filedbreader compress -f 4x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x12_patched.tmc 4x12.tmc

  START /W /B xmltest 4x13.xml 4x13.xml_patch.xml
  MOVE /Y patched.xml 4x13_patched.xml
  START /W /B Filedbreader compress -f 4x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x13_patched.tmc 4x13.tmc

  START /W /B xmltest 4x14.xml 4x14.xml_patch.xml
  MOVE /Y patched.xml 4x14_patched.xml
  START /W /B Filedbreader compress -f 4x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x14_patched.tmc 4x14.tmc

  START /W /B xmltest 4x15.xml 4x15.xml_patch.xml
  MOVE /Y patched.xml 4x15_patched.xml
  START /W /B Filedbreader compress -f 4x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x15_patched.tmc 4x15.tmc

  START /W /B xmltest 4x16.xml 4x16.xml_patch.xml
  MOVE /Y patched.xml 4x16_patched.xml
  START /W /B Filedbreader compress -f 4x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x16_patched.tmc 4x16.tmc

  START /W /B xmltest 4x17.xml 4x17.xml_patch.xml
  MOVE /Y patched.xml 4x17_patched.xml
  START /W /B Filedbreader compress -f 4x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x17_patched.tmc 4x17.tmc

  START /W /B xmltest 4x18.xml 4x18.xml_patch.xml
  MOVE /Y patched.xml 4x18_patched.xml
  START /W /B Filedbreader compress -f 4x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x18_patched.tmc 4x18.tmc

  START /W /B xmltest 4x19.xml 4x19.xml_patch.xml
  MOVE /Y patched.xml 4x19_patched.xml
  START /W /B Filedbreader compress -f 4x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x19_patched.tmc 4x19.tmc

  START /W /B xmltest 4x20.xml 4x20.xml_patch.xml
  MOVE /Y patched.xml 4x20_patched.xml
  START /W /B Filedbreader compress -f 4x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x20_patched.tmc 4x20.tmc

  START /W /B xmltest 4x21.xml 4x21.xml_patch.xml
  MOVE /Y patched.xml 4x21_patched.xml
  START /W /B Filedbreader compress -f 4x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x21_patched.tmc 4x21.tmc

  START /W /B xmltest 4x22.xml 4x22.xml_patch.xml
  MOVE /Y patched.xml 4x22_patched.xml
  START /W /B Filedbreader compress -f 4x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x22_patched.tmc 4x22.tmc

  START /W /B xmltest 4x23.xml 4x23.xml_patch.xml
  MOVE /Y patched.xml 4x23_patched.xml
  START /W /B Filedbreader compress -f 4x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 4x23_patched.tmc 4x23.tmc



  START /W /B xmltest 5x0.xml 5x0.xml_patch.xml
  MOVE /Y patched.xml 5x0_patched.xml
  START /W /B Filedbreader compress -f 5x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x0_patched.tmc 5x0.tmc

  START /W /B xmltest 5x1.xml 5x1.xml_patch.xml
  MOVE /Y patched.xml 5x1_patched.xml
  START /W /B Filedbreader compress -f 5x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x1_patched.tmc 5x1.tmc

  START /W /B xmltest 5x2.xml 5x2.xml_patch.xml
  MOVE /Y patched.xml 5x2_patched.xml
  START /W /B Filedbreader compress -f 5x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x2_patched.tmc 5x2.tmc

  START /W /B xmltest 5x3.xml 5x3.xml_patch.xml
  MOVE /Y patched.xml 5x3_patched.xml
  START /W /B Filedbreader compress -f 5x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x3_patched.tmc 5x3.tmc

  START /W /B xmltest 5x4.xml 5x4.xml_patch.xml
  MOVE /Y patched.xml 5x4_patched.xml
  START /W /B Filedbreader compress -f 5x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x4_patched.tmc 5x4.tmc

  START /W /B xmltest 5x5.xml 5x5.xml_patch.xml
  MOVE /Y patched.xml 5x5_patched.xml
  START /W /B Filedbreader compress -f 5x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x5_patched.tmc 5x5.tmc

  START /W /B xmltest 5x6.xml 5x6.xml_patch.xml
  MOVE /Y patched.xml 5x6_patched.xml
  START /W /B Filedbreader compress -f 5x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x6_patched.tmc 5x6.tmc

  START /W /B xmltest 5x7.xml 5x7.xml_patch.xml
  MOVE /Y patched.xml 5x7_patched.xml
  START /W /B Filedbreader compress -f 5x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x7_patched.tmc 5x7.tmc

  START /W /B xmltest 5x8.xml 5x8.xml_patch.xml
  MOVE /Y patched.xml 5x8_patched.xml
  START /W /B Filedbreader compress -f 5x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x8_patched.tmc 5x8.tmc

  START /W /B xmltest 5x9.xml 5x9.xml_patch.xml
  MOVE /Y patched.xml 5x9_patched.xml
  START /W /B Filedbreader compress -f 5x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x9_patched.tmc 5x9.tmc

  START /W /B xmltest 5x10.xml 5x10.xml_patch.xml
  MOVE /Y patched.xml 5x10_patched.xml
  START /W /B Filedbreader compress -f 5x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x10_patched.tmc 5x10.tmc

  START /W /B xmltest 5x11.xml 5x11.xml_patch.xml
  MOVE /Y patched.xml 5x11_patched.xml
  START /W /B Filedbreader compress -f 5x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x11_patched.tmc 5x11.tmc

  START /W /B xmltest 5x12.xml 5x12.xml_patch.xml
  MOVE /Y patched.xml 5x12_patched.xml
  START /W /B Filedbreader compress -f 5x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x12_patched.tmc 5x12.tmc

  START /W /B xmltest 5x13.xml 5x13.xml_patch.xml
  MOVE /Y patched.xml 5x13_patched.xml
  START /W /B Filedbreader compress -f 5x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x13_patched.tmc 5x13.tmc

  START /W /B xmltest 5x14.xml 5x14.xml_patch.xml
  MOVE /Y patched.xml 5x14_patched.xml
  START /W /B Filedbreader compress -f 5x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x14_patched.tmc 5x14.tmc

  START /W /B xmltest 5x15.xml 5x15.xml_patch.xml
  MOVE /Y patched.xml 5x15_patched.xml
  START /W /B Filedbreader compress -f 5x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x15_patched.tmc 5x15.tmc

  START /W /B xmltest 5x16.xml 5x16.xml_patch.xml
  MOVE /Y patched.xml 5x16_patched.xml
  START /W /B Filedbreader compress -f 5x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x16_patched.tmc 5x16.tmc

  START /W /B xmltest 5x17.xml 5x17.xml_patch.xml
  MOVE /Y patched.xml 5x17_patched.xml
  START /W /B Filedbreader compress -f 5x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x17_patched.tmc 5x17.tmc

  START /W /B xmltest 5x18.xml 5x18.xml_patch.xml
  MOVE /Y patched.xml 5x18_patched.xml
  START /W /B Filedbreader compress -f 5x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x18_patched.tmc 5x18.tmc

  START /W /B xmltest 5x19.xml 5x19.xml_patch.xml
  MOVE /Y patched.xml 5x19_patched.xml
  START /W /B Filedbreader compress -f 5x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x19_patched.tmc 5x19.tmc

  START /W /B xmltest 5x20.xml 5x20.xml_patch.xml
  MOVE /Y patched.xml 5x20_patched.xml
  START /W /B Filedbreader compress -f 5x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x20_patched.tmc 5x20.tmc

  START /W /B xmltest 5x21.xml 5x21.xml_patch.xml
  MOVE /Y patched.xml 5x21_patched.xml
  START /W /B Filedbreader compress -f 5x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x21_patched.tmc 5x21.tmc

  START /W /B xmltest 5x22.xml 5x22.xml_patch.xml
  MOVE /Y patched.xml 5x22_patched.xml
  START /W /B Filedbreader compress -f 5x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x22_patched.tmc 5x22.tmc

  START /W /B xmltest 5x23.xml 5x23.xml_patch.xml
  MOVE /Y patched.xml 5x23_patched.xml
  START /W /B Filedbreader compress -f 5x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 5x23_patched.tmc 5x23.tmc



  START /W /B xmltest 6x0.xml 6x0.xml_patch.xml
  MOVE /Y patched.xml 6x0_patched.xml
  START /W /B Filedbreader compress -f 6x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x0_patched.tmc 6x0.tmc

  START /W /B xmltest 6x1.xml 6x1.xml_patch.xml
  MOVE /Y patched.xml 6x1_patched.xml
  START /W /B Filedbreader compress -f 6x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x1_patched.tmc 6x1.tmc

  START /W /B xmltest 6x2.xml 6x2.xml_patch.xml
  MOVE /Y patched.xml 6x2_patched.xml
  START /W /B Filedbreader compress -f 6x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x2_patched.tmc 6x2.tmc

  START /W /B xmltest 6x3.xml 6x3.xml_patch.xml
  MOVE /Y patched.xml 6x3_patched.xml
  START /W /B Filedbreader compress -f 6x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x3_patched.tmc 6x3.tmc

  START /W /B xmltest 6x4.xml 6x4.xml_patch.xml
  MOVE /Y patched.xml 6x4_patched.xml
  START /W /B Filedbreader compress -f 6x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x4_patched.tmc 6x4.tmc

  START /W /B xmltest 6x5.xml 6x5.xml_patch.xml
  MOVE /Y patched.xml 6x5_patched.xml
  START /W /B Filedbreader compress -f 6x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x5_patched.tmc 6x5.tmc

  START /W /B xmltest 6x6.xml 6x6.xml_patch.xml
  MOVE /Y patched.xml 6x6_patched.xml
  START /W /B Filedbreader compress -f 6x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x6_patched.tmc 6x6.tmc

  START /W /B xmltest 6x7.xml 6x7.xml_patch.xml
  MOVE /Y patched.xml 6x7_patched.xml
  START /W /B Filedbreader compress -f 6x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x7_patched.tmc 6x7.tmc

  START /W /B xmltest 6x8.xml 6x8.xml_patch.xml
  MOVE /Y patched.xml 6x8_patched.xml
  START /W /B Filedbreader compress -f 6x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x8_patched.tmc 6x8.tmc

  START /W /B xmltest 6x9.xml 6x9.xml_patch.xml
  MOVE /Y patched.xml 6x9_patched.xml
  START /W /B Filedbreader compress -f 6x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x9_patched.tmc 6x9.tmc

  START /W /B xmltest 6x10.xml 6x10.xml_patch.xml
  MOVE /Y patched.xml 6x10_patched.xml
  START /W /B Filedbreader compress -f 6x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x10_patched.tmc 6x10.tmc

  START /W /B xmltest 6x11.xml 6x11.xml_patch.xml
  MOVE /Y patched.xml 6x11_patched.xml
  START /W /B Filedbreader compress -f 6x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x11_patched.tmc 6x11.tmc

  START /W /B xmltest 6x12.xml 6x12.xml_patch.xml
  MOVE /Y patched.xml 6x12_patched.xml
  START /W /B Filedbreader compress -f 6x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x12_patched.tmc 6x12.tmc

  START /W /B xmltest 6x13.xml 6x13.xml_patch.xml
  MOVE /Y patched.xml 6x13_patched.xml
  START /W /B Filedbreader compress -f 6x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x13_patched.tmc 6x13.tmc

  START /W /B xmltest 6x14.xml 6x14.xml_patch.xml
  MOVE /Y patched.xml 6x14_patched.xml
  START /W /B Filedbreader compress -f 6x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x14_patched.tmc 6x14.tmc

  START /W /B xmltest 6x15.xml 6x15.xml_patch.xml
  MOVE /Y patched.xml 6x15_patched.xml
  START /W /B Filedbreader compress -f 6x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x15_patched.tmc 6x15.tmc

  START /W /B xmltest 6x16.xml 6x16.xml_patch.xml
  MOVE /Y patched.xml 6x16_patched.xml
  START /W /B Filedbreader compress -f 6x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x16_patched.tmc 6x16.tmc

  START /W /B xmltest 6x17.xml 6x17.xml_patch.xml
  MOVE /Y patched.xml 6x17_patched.xml
  START /W /B Filedbreader compress -f 6x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x17_patched.tmc 6x17.tmc

  START /W /B xmltest 6x18.xml 6x18.xml_patch.xml
  MOVE /Y patched.xml 6x18_patched.xml
  START /W /B Filedbreader compress -f 6x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x18_patched.tmc 6x18.tmc

  START /W /B xmltest 6x19.xml 6x19.xml_patch.xml
  MOVE /Y patched.xml 6x19_patched.xml
  START /W /B Filedbreader compress -f 6x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x19_patched.tmc 6x19.tmc

  START /W /B xmltest 6x20.xml 6x20.xml_patch.xml
  MOVE /Y patched.xml 6x20_patched.xml
  START /W /B Filedbreader compress -f 6x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x20_patched.tmc 6x20.tmc

  START /W /B xmltest 6x21.xml 6x21.xml_patch.xml
  MOVE /Y patched.xml 6x21_patched.xml
  START /W /B Filedbreader compress -f 6x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x21_patched.tmc 6x21.tmc

  START /W /B xmltest 6x22.xml 6x22.xml_patch.xml
  MOVE /Y patched.xml 6x22_patched.xml
  START /W /B Filedbreader compress -f 6x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x22_patched.tmc 6x22.tmc

  START /W /B xmltest 6x23.xml 6x23.xml_patch.xml
  MOVE /Y patched.xml 6x23_patched.xml
  START /W /B Filedbreader compress -f 6x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 6x23_patched.tmc 6x23.tmc




  START /W /B xmltest 7x0.xml 7x0.xml_patch.xml
  MOVE /Y patched.xml 7x0_patched.xml
  START /W /B Filedbreader compress -f 7x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x0_patched.tmc 7x0.tmc

  START /W /B xmltest 7x1.xml 7x1.xml_patch.xml
  MOVE /Y patched.xml 7x1_patched.xml
  START /W /B Filedbreader compress -f 7x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x1_patched.tmc 7x1.tmc

  START /W /B xmltest 7x2.xml 7x2.xml_patch.xml
  MOVE /Y patched.xml 7x2_patched.xml
  START /W /B Filedbreader compress -f 7x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x2_patched.tmc 7x2.tmc

  START /W /B xmltest 7x3.xml 7x3.xml_patch.xml
  MOVE /Y patched.xml 7x3_patched.xml
  START /W /B Filedbreader compress -f 7x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x3_patched.tmc 7x3.tmc

  START /W /B xmltest 7x4.xml 7x4.xml_patch.xml
  MOVE /Y patched.xml 7x4_patched.xml
  START /W /B Filedbreader compress -f 7x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x4_patched.tmc 7x4.tmc

  START /W /B xmltest 7x5.xml 7x5.xml_patch.xml
  MOVE /Y patched.xml 7x5_patched.xml
  START /W /B Filedbreader compress -f 7x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x5_patched.tmc 7x5.tmc

  START /W /B xmltest 7x6.xml 7x6.xml_patch.xml
  MOVE /Y patched.xml 7x6_patched.xml
  START /W /B Filedbreader compress -f 7x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x6_patched.tmc 7x6.tmc

  START /W /B xmltest 7x7.xml 7x7.xml_patch.xml
  MOVE /Y patched.xml 7x7_patched.xml
  START /W /B Filedbreader compress -f 7x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x7_patched.tmc 7x7.tmc

  START /W /B xmltest 7x8.xml 7x8.xml_patch.xml
  MOVE /Y patched.xml 7x8_patched.xml
  START /W /B Filedbreader compress -f 7x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x8_patched.tmc 7x8.tmc

  START /W /B xmltest 7x9.xml 7x9.xml_patch.xml
  MOVE /Y patched.xml 7x9_patched.xml
  START /W /B Filedbreader compress -f 7x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x9_patched.tmc 7x9.tmc

  START /W /B xmltest 7x10.xml 7x10.xml_patch.xml
  MOVE /Y patched.xml 7x10_patched.xml
  START /W /B Filedbreader compress -f 7x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x10_patched.tmc 7x10.tmc

  START /W /B xmltest 7x11.xml 7x11.xml_patch.xml
  MOVE /Y patched.xml 7x11_patched.xml
  START /W /B Filedbreader compress -f 7x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x11_patched.tmc 7x11.tmc

  START /W /B xmltest 7x12.xml 7x12.xml_patch.xml
  MOVE /Y patched.xml 7x12_patched.xml
  START /W /B Filedbreader compress -f 7x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x12_patched.tmc 7x12.tmc

  START /W /B xmltest 7x13.xml 7x13.xml_patch.xml
  MOVE /Y patched.xml 7x13_patched.xml
  START /W /B Filedbreader compress -f 7x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x13_patched.tmc 7x13.tmc

  START /W /B xmltest 7x14.xml 7x14.xml_patch.xml
  MOVE /Y patched.xml 7x14_patched.xml
  START /W /B Filedbreader compress -f 7x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x14_patched.tmc 7x14.tmc

  START /W /B xmltest 7x15.xml 7x15.xml_patch.xml
  MOVE /Y patched.xml 7x15_patched.xml
  START /W /B Filedbreader compress -f 7x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x15_patched.tmc 7x15.tmc

  START /W /B xmltest 7x16.xml 7x16.xml_patch.xml
  MOVE /Y patched.xml 7x16_patched.xml
  START /W /B Filedbreader compress -f 7x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x16_patched.tmc 7x16.tmc

  START /W /B xmltest 7x17.xml 7x17.xml_patch.xml
  MOVE /Y patched.xml 7x17_patched.xml
  START /W /B Filedbreader compress -f 7x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x17_patched.tmc 7x17.tmc

  START /W /B xmltest 7x18.xml 7x18.xml_patch.xml
  MOVE /Y patched.xml 7x18_patched.xml
  START /W /B Filedbreader compress -f 7x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x18_patched.tmc 7x18.tmc

  START /W /B xmltest 7x19.xml 7x19.xml_patch.xml
  MOVE /Y patched.xml 7x19_patched.xml
  START /W /B Filedbreader compress -f 7x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x19_patched.tmc 7x19.tmc

  START /W /B xmltest 7x20.xml 7x20.xml_patch.xml
  MOVE /Y patched.xml 7x20_patched.xml
  START /W /B Filedbreader compress -f 7x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x20_patched.tmc 7x20.tmc

  START /W /B xmltest 7x21.xml 7x21.xml_patch.xml
  MOVE /Y patched.xml 7x21_patched.xml
  START /W /B Filedbreader compress -f 7x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x21_patched.tmc 7x21.tmc

  START /W /B xmltest 7x22.xml 7x22.xml_patch.xml
  MOVE /Y patched.xml 7x22_patched.xml
  START /W /B Filedbreader compress -f 7x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x22_patched.tmc 7x22.tmc

  START /W /B xmltest 7x23.xml 7x23.xml_patch.xml
  MOVE /Y patched.xml 7x23_patched.xml
  START /W /B Filedbreader compress -f 7x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 7x23_patched.tmc 7x23.tmc




  START /W /B xmltest 8x0.xml 8x0.xml_patch.xml
  MOVE /Y patched.xml 8x0_patched.xml
  START /W /B Filedbreader compress -f 8x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x0_patched.tmc 8x0.tmc

  START /W /B xmltest 8x1.xml 8x1.xml_patch.xml
  MOVE /Y patched.xml 8x1_patched.xml
  START /W /B Filedbreader compress -f 8x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x1_patched.tmc 8x8.tmc

  START /W /B xmltest 8x2.xml 8x2.xml_patch.xml
  MOVE /Y patched.xml 8x2_patched.xml
  START /W /B Filedbreader compress -f 8x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x2_patched.tmc 8x2.tmc

  START /W /B xmltest 8x3.xml 8x3.xml_patch.xml
  MOVE /Y patched.xml 8x3_patched.xml
  START /W /B Filedbreader compress -f 8x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x3_patched.tmc 8x3.tmc

  START /W /B xmltest 8x4.xml 8x4.xml_patch.xml
  MOVE /Y patched.xml 8x4_patched.xml
  START /W /B Filedbreader compress -f 8x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x4_patched.tmc 8x4.tmc

  START /W /B xmltest 8x5.xml 8x5.xml_patch.xml
  MOVE /Y patched.xml 8x5_patched.xml
  START /W /B Filedbreader compress -f 8x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x5_patched.tmc 8x5.tmc

  START /W /B xmltest 8x6.xml 8x6.xml_patch.xml
  MOVE /Y patched.xml 8x6_patched.xml
  START /W /B Filedbreader compress -f 8x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x6_patched.tmc 8x6.tmc

  START /W /B xmltest 8x7.xml 8x7.xml_patch.xml
  MOVE /Y patched.xml 8x7_patched.xml
  START /W /B Filedbreader compress -f 8x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x7_patched.tmc 8x7.tmc

  START /W /B xmltest 8x8.xml 8x8.xml_patch.xml
  MOVE /Y patched.xml 8x8_patched.xml
  START /W /B Filedbreader compress -f 8x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x8_patched.tmc 8x8.tmc

  START /W /B xmltest 8x9.xml 8x9.xml_patch.xml
  MOVE /Y patched.xml 8x9_patched.xml
  START /W /B Filedbreader compress -f 8x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x9_patched.tmc 8x9.tmc

  START /W /B xmltest 8x10.xml 8x10.xml_patch.xml
  MOVE /Y patched.xml 8x10_patched.xml
  START /W /B Filedbreader compress -f 8x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x10_patched.tmc 8x10.tmc

  START /W /B xmltest 8x11.xml 8x11.xml_patch.xml
  MOVE /Y patched.xml 8x11_patched.xml
  START /W /B Filedbreader compress -f 8x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x11_patched.tmc 8x11.tmc

  START /W /B xmltest 8x12.xml 8x12.xml_patch.xml
  MOVE /Y patched.xml 8x12_patched.xml
  START /W /B Filedbreader compress -f 8x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x12_patched.tmc 8x12.tmc

  START /W /B xmltest 8x13.xml 8x13.xml_patch.xml
  MOVE /Y patched.xml 8x13_patched.xml
  START /W /B Filedbreader compress -f 8x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x13_patched.tmc 8x13.tmc

  START /W /B xmltest 8x14.xml 8x14.xml_patch.xml
  MOVE /Y patched.xml 8x14_patched.xml
  START /W /B Filedbreader compress -f 8x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x14_patched.tmc 8x14.tmc

  START /W /B xmltest 8x15.xml 8x15.xml_patch.xml
  MOVE /Y patched.xml 8x15_patched.xml
  START /W /B Filedbreader compress -f 8x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x15_patched.tmc 8x15.tmc

  START /W /B xmltest 8x16.xml 8x16.xml_patch.xml
  MOVE /Y patched.xml 8x16_patched.xml
  START /W /B Filedbreader compress -f 8x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x16_patched.tmc 8x16.tmc

  START /W /B xmltest 8x17.xml 8x17.xml_patch.xml
  MOVE /Y patched.xml 8x17_patched.xml
  START /W /B Filedbreader compress -f 8x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x17_patched.tmc 8x17.tmc

  START /W /B xmltest 8x18.xml 8x18.xml_patch.xml
  MOVE /Y patched.xml 8x18_patched.xml
  START /W /B Filedbreader compress -f 8x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x18_patched.tmc 8x18.tmc

  START /W /B xmltest 8x19.xml 8x19.xml_patch.xml
  MOVE /Y patched.xml 8x19_patched.xml
  START /W /B Filedbreader compress -f 8x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x19_patched.tmc 8x19.tmc

  START /W /B xmltest 8x20.xml 8x20.xml_patch.xml
  MOVE /Y patched.xml 8x20_patched.xml
  START /W /B Filedbreader compress -f 8x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x20_patched.tmc 8x20.tmc

  START /W /B xmltest 8x21.xml 8x21.xml_patch.xml
  MOVE /Y patched.xml 8x21_patched.xml
  START /W /B Filedbreader compress -f 8x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x21_patched.tmc 8x21.tmc

  START /W /B xmltest 8x22.xml 8x22.xml_patch.xml
  MOVE /Y patched.xml 8x22_patched.xml
  START /W /B Filedbreader compress -f 8x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x22_patched.tmc 8x22.tmc

  START /W /B xmltest 8x23.xml 8x23.xml_patch.xml
  MOVE /Y patched.xml 8x23_patched.xml
  START /W /B Filedbreader compress -f 8x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 8x23_patched.tmc 8x23.tmc



  START /W /B xmltest 9x0.xml 9x0.xml_patch.xml
  MOVE /Y patched.xml 9x0_patched.xml
  START /W /B Filedbreader compress -f 9x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x0_patched.tmc 9x0.tmc

  START /W /B xmltest 9x1.xml 9x1.xml_patch.xml
  MOVE /Y patched.xml 9x1_patched.xml
  START /W /B Filedbreader compress -f 9x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x1_patched.tmc 9x1.tmc

  START /W /B xmltest 9x2.xml 9x2.xml_patch.xml
  MOVE /Y patched.xml 9x2_patched.xml
  START /W /B Filedbreader compress -f 9x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x2_patched.tmc 9x2.tmc

  START /W /B xmltest 9x3.xml 9x3.xml_patch.xml
  MOVE /Y patched.xml 9x3_patched.xml
  START /W /B Filedbreader compress -f 9x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x3_patched.tmc 9x3.tmc

  START /W /B xmltest 9x4.xml 9x4.xml_patch.xml
  MOVE /Y patched.xml 9x4_patched.xml
  START /W /B Filedbreader compress -f 9x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x4_patched.tmc 9x4.tmc

  START /W /B xmltest 9x5.xml 9x5.xml_patch.xml
  MOVE /Y patched.xml 9x5_patched.xml
  START /W /B Filedbreader compress -f 9x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x5_patched.tmc 9x5.tmc

  START /W /B xmltest 9x6.xml 9x6.xml_patch.xml
  MOVE /Y patched.xml 9x6_patched.xml
  START /W /B Filedbreader compress -f 9x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x6_patched.tmc 9x6.tmc

  START /W /B xmltest 9x7.xml 9x7.xml_patch.xml
  MOVE /Y patched.xml 9x7_patched.xml
  START /W /B Filedbreader compress -f 9x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x7_patched.tmc 9x7.tmc

  START /W /B xmltest 9x8.xml 9x8.xml_patch.xml
  MOVE /Y patched.xml 9x8_patched.xml
  START /W /B Filedbreader compress -f 9x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x8_patched.tmc 9x8.tmc

  START /W /B xmltest 9x9.xml 9x9.xml_patch.xml
  MOVE /Y patched.xml 9x9_patched.xml
  START /W /B Filedbreader compress -f 9x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x9_patched.tmc 9x9.tmc

  START /W /B xmltest 9x10.xml 9x10.xml_patch.xml
  MOVE /Y patched.xml 9x10_patched.xml
  START /W /B Filedbreader compress -f 9x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x10_patched.tmc 9x10.tmc

  START /W /B xmltest 9x11.xml 9x11.xml_patch.xml
  MOVE /Y patched.xml 9x11_patched.xml
  START /W /B Filedbreader compress -f 9x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x11_patched.tmc 9x11.tmc

  START /W /B xmltest 9x12.xml 9x12.xml_patch.xml
  MOVE /Y patched.xml 9x12_patched.xml
  START /W /B Filedbreader compress -f 9x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x12_patched.tmc 9x12.tmc

  START /W /B xmltest 9x13.xml 9x13.xml_patch.xml
  MOVE /Y patched.xml 9x13_patched.xml
  START /W /B Filedbreader compress -f 9x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x13_patched.tmc 9x13.tmc

  START /W /B xmltest 9x14.xml 9x14.xml_patch.xml
  MOVE /Y patched.xml 9x14_patched.xml
  START /W /B Filedbreader compress -f 9x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x14_patched.tmc 9x14.tmc

  START /W /B xmltest 9x15.xml 9x15.xml_patch.xml
  MOVE /Y patched.xml 9x15_patched.xml
  START /W /B Filedbreader compress -f 9x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x15_patched.tmc 9x15.tmc

  START /W /B xmltest 9x16.xml 9x16.xml_patch.xml
  MOVE /Y patched.xml 9x16_patched.xml
  START /W /B Filedbreader compress -f 9x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x16_patched.tmc 9x16.tmc

  START /W /B xmltest 9x17.xml 9x17.xml_patch.xml
  MOVE /Y patched.xml 9x17_patched.xml
  START /W /B Filedbreader compress -f 9x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x17_patched.tmc 9x17.tmc

  START /W /B xmltest 9x18.xml 9x18.xml_patch.xml
  MOVE /Y patched.xml 9x18_patched.xml
  START /W /B Filedbreader compress -f 9x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x18_patched.tmc 9x18.tmc

  START /W /B xmltest 9x19.xml 9x19.xml_patch.xml
  MOVE /Y patched.xml 9x19_patched.xml
  START /W /B Filedbreader compress -f 9x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x19_patched.tmc 9x19.tmc

  START /W /B xmltest 9x20.xml 9x20.xml_patch.xml
  MOVE /Y patched.xml 9x20_patched.xml
  START /W /B Filedbreader compress -f 9x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x20_patched.tmc 9x20.tmc

  START /W /B xmltest 9x21.xml 9x21.xml_patch.xml
  MOVE /Y patched.xml 9x21_patched.xml
  START /W /B Filedbreader compress -f 9x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x21_patched.tmc 9x21.tmc

  START /W /B xmltest 9x22.xml 9x22.xml_patch.xml
  MOVE /Y patched.xml 9x22_patched.xml
  START /W /B Filedbreader compress -f 9x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x22_patched.tmc 9x22.tmc

  START /W /B xmltest 9x23.xml 9x23.xml_patch.xml
  MOVE /Y patched.xml 9x23_patched.xml
  START /W /B Filedbreader compress -f 9x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 9x23_patched.tmc 9x23.tmc




  START /W /B xmltest 10x0.xml 10x0.xml_patch.xml
  MOVE /Y patched.xml 10x0_patched.xml
  START /W /B Filedbreader compress -f 10x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x0_patched.tmc 10x0.tmc

  START /W /B xmltest 10x1.xml 10x1.xml_patch.xml
  MOVE /Y patched.xml 10x1_patched.xml
  START /W /B Filedbreader compress -f 10x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x1_patched.tmc 10x1.tmc

  START /W /B xmltest 10x2.xml 10x2.xml_patch.xml
  MOVE /Y patched.xml 10x2_patched.xml
  START /W /B Filedbreader compress -f 10x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x2_patched.tmc 10x2.tmc

  START /W /B xmltest 10x3.xml 10x3.xml_patch.xml
  MOVE /Y patched.xml 10x3_patched.xml
  START /W /B Filedbreader compress -f 10x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x3_patched.tmc 10x3.tmc

  START /W /B xmltest 10x4.xml 10x4.xml_patch.xml
  MOVE /Y patched.xml 10x4_patched.xml
  START /W /B Filedbreader compress -f 10x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x4_patched.tmc 10x4.tmc

  START /W /B xmltest 10x5.xml 10x5.xml_patch.xml
  MOVE /Y patched.xml 10x5_patched.xml
  START /W /B Filedbreader compress -f 10x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x5_patched.tmc 10x5.tmc

  START /W /B xmltest 10x6.xml 10x6.xml_patch.xml
  MOVE /Y patched.xml 10x6_patched.xml
  START /W /B Filedbreader compress -f 10x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x6_patched.tmc 10x6.tmc

  START /W /B xmltest 10x7.xml 10x7.xml_patch.xml
  MOVE /Y patched.xml 10x7_patched.xml
  START /W /B Filedbreader compress -f 10x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x7_patched.tmc 10x7.tmc

  START /W /B xmltest 10x8.xml 10x8.xml_patch.xml
  MOVE /Y patched.xml 10x8_patched.xml
  START /W /B Filedbreader compress -f 10x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x8_patched.tmc 10x8.tmc

  START /W /B xmltest 10x9.xml 10x9.xml_patch.xml
  MOVE /Y patched.xml 10x9_patched.xml
  START /W /B Filedbreader compress -f 10x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x9_patched.tmc 10x9.tmc

  START /W /B xmltest 10x10.xml 10x10.xml_patch.xml
  MOVE /Y patched.xml 10x10_patched.xml
  START /W /B Filedbreader compress -f 10x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x10_patched.tmc 10x10.tmc

  START /W /B xmltest 10x11.xml 10x11.xml_patch.xml
  MOVE /Y patched.xml 10x11_patched.xml
  START /W /B Filedbreader compress -f 10x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x11_patched.tmc 10x11.tmc

  START /W /B xmltest 10x12.xml 10x12.xml_patch.xml
  MOVE /Y patched.xml 10x12_patched.xml
  START /W /B Filedbreader compress -f 10x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x12_patched.tmc 10x12.tmc

  START /W /B xmltest 10x13.xml 10x13.xml_patch.xml
  MOVE /Y patched.xml 10x13_patched.xml
  START /W /B Filedbreader compress -f 10x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x13_patched.tmc 10x13.tmc

  START /W /B xmltest 10x14.xml 10x14.xml_patch.xml
  MOVE /Y patched.xml 10x14_patched.xml
  START /W /B Filedbreader compress -f 10x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x14_patched.tmc 10x14.tmc

  START /W /B xmltest 10x15.xml 10x15.xml_patch.xml
  MOVE /Y patched.xml 10x15_patched.xml
  START /W /B Filedbreader compress -f 10x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x15_patched.tmc 10x15.tmc

  START /W /B xmltest 10x16.xml 10x16.xml_patch.xml
  MOVE /Y patched.xml 10x16_patched.xml
  START /W /B Filedbreader compress -f 10x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x16_patched.tmc 10x16.tmc

  START /W /B xmltest 10x17.xml 10x17.xml_patch.xml
  MOVE /Y patched.xml 10x17_patched.xml
  START /W /B Filedbreader compress -f 10x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x17_patched.tmc 10x17.tmc

  START /W /B xmltest 10x18.xml 10x18.xml_patch.xml
  MOVE /Y patched.xml 10x18_patched.xml
  START /W /B Filedbreader compress -f 10x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x18_patched.tmc 10x18.tmc

  START /W /B xmltest 10x19.xml 10x19.xml_patch.xml
  MOVE /Y patched.xml 10x19_patched.xml
  START /W /B Filedbreader compress -f 10x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x19_patched.tmc 10x19.tmc

  START /W /B xmltest 10x20.xml 10x20.xml_patch.xml
  MOVE /Y patched.xml 10x20_patched.xml
  START /W /B Filedbreader compress -f 10x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x20_patched.tmc 10x20.tmc

  START /W /B xmltest 10x21.xml 10x21.xml_patch.xml
  MOVE /Y patched.xml 10x21_patched.xml
  START /W /B Filedbreader compress -f 10x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x21_patched.tmc 10x21.tmc

  START /W /B xmltest 10x22.xml 10x22.xml_patch.xml
  MOVE /Y patched.xml 10x22_patched.xml
  START /W /B Filedbreader compress -f 10x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x22_patched.tmc 10x22.tmc

  START /W /B xmltest 10x23.xml 10x23.xml_patch.xml
  MOVE /Y patched.xml 10x23_patched.xml
  START /W /B Filedbreader compress -f 10x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 10x23_patched.tmc 10x23.tmc




  START /W /B xmltest 11x0.xml 11x0.xml_patch.xml
  MOVE /Y patched.xml 11x0_patched.xml
  START /W /B Filedbreader compress -f 11x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x0_patched.tmc 11x0.tmc

  START /W /B xmltest 11x1.xml 11x1.xml_patch.xml
  MOVE /Y patched.xml 11x1_patched.xml
  START /W /B Filedbreader compress -f 11x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x1_patched.tmc 11x1.tmc

  START /W /B xmltest 11x2.xml 11x2.xml_patch.xml
  MOVE /Y patched.xml 11x2_patched.xml
  START /W /B Filedbreader compress -f 11x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x2_patched.tmc 11x2.tmc

  START /W /B xmltest 11x3.xml 11x3.xml_patch.xml
  MOVE /Y patched.xml 11x3_patched.xml
  START /W /B Filedbreader compress -f 11x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x3_patched.tmc 11x3.tmc

  START /W /B xmltest 11x4.xml 11x4.xml_patch.xml
  MOVE /Y patched.xml 11x4_patched.xml
  START /W /B Filedbreader compress -f 11x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x4_patched.tmc 11x4.tmc

  START /W /B xmltest 11x5.xml 11x5.xml_patch.xml
  MOVE /Y patched.xml 11x5_patched.xml
  START /W /B Filedbreader compress -f 11x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x5_patched.tmc 11x5.tmc

  START /W /B xmltest 11x6.xml 11x6.xml_patch.xml
  MOVE /Y patched.xml 11x6_patched.xml
  START /W /B Filedbreader compress -f 11x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x6_patched.tmc 11x6.tmc

  START /W /B xmltest 11x7.xml 11x7.xml_patch.xml
  MOVE /Y patched.xml 11x7_patched.xml
  START /W /B Filedbreader compress -f 11x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x7_patched.tmc 11x7.tmc

  START /W /B xmltest 11x8.xml 11x8.xml_patch.xml
  MOVE /Y patched.xml 11x8_patched.xml
  START /W /B Filedbreader compress -f 11x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x8_patched.tmc 11x8.tmc

  START /W /B xmltest 11x9.xml 11x9.xml_patch.xml
  MOVE /Y patched.xml 11x9_patched.xml
  START /W /B Filedbreader compress -f 11x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x9_patched.tmc 11x9.tmc

  START /W /B xmltest 11x10.xml 11x10.xml_patch.xml
  MOVE /Y patched.xml 11x10_patched.xml
  START /W /B Filedbreader compress -f 11x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x10_patched.tmc 11x10.tmc

  START /W /B xmltest 11x11.xml 11x11.xml_patch.xml
  MOVE /Y patched.xml 11x11_patched.xml
  START /W /B Filedbreader compress -f 11x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x11_patched.tmc 11x11.tmc

  START /W /B xmltest 11x12.xml 11x12.xml_patch.xml
  MOVE /Y patched.xml 11x12_patched.xml
  START /W /B Filedbreader compress -f 11x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x12_patched.tmc 11x12.tmc

  START /W /B xmltest 11x13.xml 11x13.xml_patch.xml
  MOVE /Y patched.xml 11x13_patched.xml
  START /W /B Filedbreader compress -f 11x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x13_patched.tmc 11x13.tmc

  START /W /B xmltest 11x14.xml 11x14.xml_patch.xml
  MOVE /Y patched.xml 11x14_patched.xml
  START /W /B Filedbreader compress -f 11x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x14_patched.tmc 11x14.tmc

  START /W /B xmltest 11x15.xml 11x15.xml_patch.xml
  MOVE /Y patched.xml 11x15_patched.xml
  START /W /B Filedbreader compress -f 11x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x15_patched.tmc 11x15.tmc

  START /W /B xmltest 11x16.xml 11x16.xml_patch.xml
  MOVE /Y patched.xml 11x16_patched.xml
  START /W /B Filedbreader compress -f 11x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x16_patched.tmc 11x16.tmc

  START /W /B xmltest 11x17.xml 11x17.xml_patch.xml
  MOVE /Y patched.xml 11x17_patched.xml
  START /W /B Filedbreader compress -f 11x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x17_patched.tmc 11x17.tmc

  START /W /B xmltest 11x18.xml 11x18.xml_patch.xml
  MOVE /Y patched.xml 11x18_patched.xml
  START /W /B Filedbreader compress -f 11x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x18_patched.tmc 11x18.tmc

  START /W /B xmltest 11x19.xml 11x19.xml_patch.xml
  MOVE /Y patched.xml 11x19_patched.xml
  START /W /B Filedbreader compress -f 11x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x19_patched.tmc 11x19.tmc

  START /W /B xmltest 11x20.xml 11x20.xml_patch.xml
  MOVE /Y patched.xml 11x20_patched.xml
  START /W /B Filedbreader compress -f 11x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x20_patched.tmc 11x20.tmc

  START /W /B xmltest 11x21.xml 11x21.xml_patch.xml
  MOVE /Y patched.xml 11x21_patched.xml
  START /W /B Filedbreader compress -f 11x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x21_patched.tmc 11x21.tmc

  START /W /B xmltest 11x22.xml 11x22.xml_patch.xml
  MOVE /Y patched.xml 11x22_patched.xml
  START /W /B Filedbreader compress -f 11x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x22_patched.tmc 11x22.tmc

  START /W /B xmltest 11x23.xml 11x23.xml_patch.xml
  MOVE /Y patched.xml 11x23_patched.xml
  START /W /B Filedbreader compress -f 11x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 11x23_patched.tmc 11x23.tmc



  START /W /B xmltest 12x0.xml 12x0.xml_patch.xml
  MOVE /Y patched.xml 12x0_patched.xml
  START /W /B Filedbreader compress -f 12x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x0_patched.tmc 12x0.tmc

  START /W /B xmltest 12x1.xml 12x1.xml_patch.xml
  MOVE /Y patched.xml 12x1_patched.xml
  START /W /B Filedbreader compress -f 12x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x1_patched.tmc 12x1.tmc

  START /W /B xmltest 12x2.xml 12x2.xml_patch.xml
  MOVE /Y patched.xml 12x2_patched.xml
  START /W /B Filedbreader compress -f 12x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x2_patched.tmc 12x2.tmc

  START /W /B xmltest 12x3.xml 12x3.xml_patch.xml
  MOVE /Y patched.xml 12x3_patched.xml
  START /W /B Filedbreader compress -f 12x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x3_patched.tmc 12x3.tmc

  START /W /B xmltest 12x4.xml 12x4.xml_patch.xml
  MOVE /Y patched.xml 12x4_patched.xml
  START /W /B Filedbreader compress -f 12x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x4_patched.tmc 12x4.tmc

  START /W /B xmltest 12x5.xml 12x5.xml_patch.xml
  MOVE /Y patched.xml 12x5_patched.xml
  START /W /B Filedbreader compress -f 12x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x5_patched.tmc 12x5.tmc

  START /W /B xmltest 12x6.xml 12x6.xml_patch.xml
  MOVE /Y patched.xml 12x6_patched.xml
  START /W /B Filedbreader compress -f 12x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x6_patched.tmc 12x6.tmc

  START /W /B xmltest 12x7.xml 12x7.xml_patch.xml
  MOVE /Y patched.xml 12x7_patched.xml
  START /W /B Filedbreader compress -f 12x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x7_patched.tmc 12x7.tmc

  START /W /B xmltest 12x8.xml 12x8.xml_patch.xml
  MOVE /Y patched.xml 12x8_patched.xml
  START /W /B Filedbreader compress -f 12x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x8_patched.tmc 12x8.tmc

  START /W /B xmltest 12x9.xml 12x9.xml_patch.xml
  MOVE /Y patched.xml 12x9_patched.xml
  START /W /B Filedbreader compress -f 12x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x9_patched.tmc 12x9.tmc

  START /W /B xmltest 12x10.xml 12x10.xml_patch.xml
  MOVE /Y patched.xml 12x10_patched.xml
  START /W /B Filedbreader compress -f 12x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x10_patched.tmc 12x10.tmc

  START /W /B xmltest 12x11.xml 12x11.xml_patch.xml
  MOVE /Y patched.xml 12x11_patched.xml
  START /W /B Filedbreader compress -f 12x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x11_patched.tmc 12x11.tmc

  START /W /B xmltest 12x12.xml 12x12.xml_patch.xml
  MOVE /Y patched.xml 12x12_patched.xml
  START /W /B Filedbreader compress -f 12x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x12_patched.tmc 12x12.tmc

  START /W /B xmltest 12x13.xml 12x13.xml_patch.xml
  MOVE /Y patched.xml 12x13_patched.xml
  START /W /B Filedbreader compress -f 12x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x13_patched.tmc 12x13.tmc

  START /W /B xmltest 12x14.xml 12x14.xml_patch.xml
  MOVE /Y patched.xml 12x14_patched.xml
  START /W /B Filedbreader compress -f 12x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x14_patched.tmc 12x14.tmc

  START /W /B xmltest 12x15.xml 12x15.xml_patch.xml
  MOVE /Y patched.xml 12x15_patched.xml
  START /W /B Filedbreader compress -f 12x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x15_patched.tmc 12x15.tmc

  START /W /B xmltest 12x16.xml 12x16.xml_patch.xml
  MOVE /Y patched.xml 12x16_patched.xml
  START /W /B Filedbreader compress -f 12x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x16_patched.tmc 12x16.tmc

  START /W /B xmltest 12x17.xml 12x17.xml_patch.xml
  MOVE /Y patched.xml 12x17_patched.xml
  START /W /B Filedbreader compress -f 12x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x17_patched.tmc 12x17.tmc

  START /W /B xmltest 12x18.xml 12x18.xml_patch.xml
  MOVE /Y patched.xml 12x18_patched.xml
  START /W /B Filedbreader compress -f 12x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x18_patched.tmc 12x18.tmc

  START /W /B xmltest 12x19.xml 12x19.xml_patch.xml
  MOVE /Y patched.xml 12x19_patched.xml
  START /W /B Filedbreader compress -f 12x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x19_patched.tmc 12x19.tmc

  START /W /B xmltest 12x20.xml 12x20.xml_patch.xml
  MOVE /Y patched.xml 12x20_patched.xml
  START /W /B Filedbreader compress -f 12x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x20_patched.tmc 12x20.tmc

  START /W /B xmltest 12x21.xml 12x21.xml_patch.xml
  MOVE /Y patched.xml 12x21_patched.xml
  START /W /B Filedbreader compress -f 12x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x21_patched.tmc 12x21.tmc

  START /W /B xmltest 12x22.xml 12x22.xml_patch.xml
  MOVE /Y patched.xml 12x22_patched.xml
  START /W /B Filedbreader compress -f 12x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x22_patched.tmc 12x22.tmc

  START /W /B xmltest 12x23.xml 12x23.xml_patch.xml
  MOVE /Y patched.xml 12x23_patched.xml
  START /W /B Filedbreader compress -f 12x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 12x23_patched.tmc 12x23.tmc



  START /W /B xmltest 13x0.xml 13x0.xml_patch.xml
  MOVE /Y patched.xml 13x0_patched.xml
  START /W /B Filedbreader compress -f 13x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x0_patched.tmc 13x0.tmc

  START /W /B xmltest 13x1.xml 13x1.xml_patch.xml
  MOVE /Y patched.xml 13x1_patched.xml
  START /W /B Filedbreader compress -f 13x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x1_patched.tmc 13x1.tmc

  START /W /B xmltest 13x2.xml 13x2.xml_patch.xml
  MOVE /Y patched.xml 13x2_patched.xml
  START /W /B Filedbreader compress -f 13x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x2_patched.tmc 13x2.tmc

  START /W /B xmltest 13x3.xml 13x3.xml_patch.xml
  MOVE /Y patched.xml 13x3_patched.xml
  START /W /B Filedbreader compress -f 13x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x3_patched.tmc 13x3.tmc

  START /W /B xmltest 13x4.xml 13x4.xml_patch.xml
  MOVE /Y patched.xml 13x4_patched.xml
  START /W /B Filedbreader compress -f 13x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x4_patched.tmc 13x4.tmc

  START /W /B xmltest 13x5.xml 13x5.xml_patch.xml
  MOVE /Y patched.xml 13x5_patched.xml
  START /W /B Filedbreader compress -f 13x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x5_patched.tmc 13x5.tmc

  START /W /B xmltest 13x6.xml 13x6.xml_patch.xml
  MOVE /Y patched.xml 13x6_patched.xml
  START /W /B Filedbreader compress -f 13x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x6_patched.tmc 13x6.tmc

  START /W /B xmltest 13x7.xml 13x7.xml_patch.xml
  MOVE /Y patched.xml 13x7_patched.xml
  START /W /B Filedbreader compress -f 13x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x7_patched.tmc 13x7.tmc

  START /W /B xmltest 13x8.xml 13x8.xml_patch.xml
  MOVE /Y patched.xml 13x8_patched.xml
  START /W /B Filedbreader compress -f 13x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x8_patched.tmc 13x8.tmc

  START /W /B xmltest 13x9.xml 13x9.xml_patch.xml
  MOVE /Y patched.xml 13x9_patched.xml
  START /W /B Filedbreader compress -f 13x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x9_patched.tmc 13x9.tmc

  START /W /B xmltest 13x10.xml 13x10.xml_patch.xml
  MOVE /Y patched.xml 13x10_patched.xml
  START /W /B Filedbreader compress -f 13x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x10_patched.tmc 13x10.tmc

  START /W /B xmltest 13x11.xml 13x11.xml_patch.xml
  MOVE /Y patched.xml 13x11_patched.xml
  START /W /B Filedbreader compress -f 13x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x11_patched.tmc 13x11.tmc

  START /W /B xmltest 13x12.xml 13x12.xml_patch.xml
  MOVE /Y patched.xml 13x12_patched.xml
  START /W /B Filedbreader compress -f 13x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x12_patched.tmc 13x12.tmc

  START /W /B xmltest 13x13.xml 13x13.xml_patch.xml
  MOVE /Y patched.xml 13x13_patched.xml
  START /W /B Filedbreader compress -f 13x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x13_patched.tmc 13x13.tmc

  START /W /B xmltest 13x14.xml 13x14.xml_patch.xml
  MOVE /Y patched.xml 13x14_patched.xml
  START /W /B Filedbreader compress -f 13x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x14_patched.tmc 13x14.tmc

  START /W /B xmltest 13x15.xml 13x15.xml_patch.xml
  MOVE /Y patched.xml 13x15_patched.xml
  START /W /B Filedbreader compress -f 13x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x15_patched.tmc 13x15.tmc

  START /W /B xmltest 13x16.xml 13x16.xml_patch.xml
  MOVE /Y patched.xml 13x16_patched.xml
  START /W /B Filedbreader compress -f 13x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x16_patched.tmc 13x16.tmc

  START /W /B xmltest 13x17.xml 13x17.xml_patch.xml
  MOVE /Y patched.xml 13x17_patched.xml
  START /W /B Filedbreader compress -f 13x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x17_patched.tmc 13x17.tmc

  START /W /B xmltest 13x18.xml 13x18.xml_patch.xml
  MOVE /Y patched.xml 13x18_patched.xml
  START /W /B Filedbreader compress -f 13x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x18_patched.tmc 13x18.tmc

  START /W /B xmltest 13x19.xml 13x19.xml_patch.xml
  MOVE /Y patched.xml 13x19_patched.xml
  START /W /B Filedbreader compress -f 13x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x19_patched.tmc 13x19.tmc

  START /W /B xmltest 13x20.xml 13x20.xml_patch.xml
  MOVE /Y patched.xml 13x20_patched.xml
  START /W /B Filedbreader compress -f 13x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x20_patched.tmc 13x20.tmc

  START /W /B xmltest 13x21.xml 13x21.xml_patch.xml
  MOVE /Y patched.xml 13x21_patched.xml
  START /W /B Filedbreader compress -f 13x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x21_patched.tmc 13x21.tmc

  START /W /B xmltest 13x22.xml 13x22.xml_patch.xml
  MOVE /Y patched.xml 13x22_patched.xml
  START /W /B Filedbreader compress -f 13x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x22_patched.tmc 13x22.tmc

  START /W /B xmltest 13x23.xml 13x23.xml_patch.xml
  MOVE /Y patched.xml 13x23_patched.xml
  START /W /B Filedbreader compress -f 13x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 13x23_patched.tmc 13x23.tmc



  START /W /B xmltest 14x0.xml 14x0.xml_patch.xml
  MOVE /Y patched.xml 14x0_patched.xml
  START /W /B Filedbreader compress -f 14x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x0_patched.tmc 14x0.tmc

  START /W /B xmltest 14x1.xml 14x1.xml_patch.xml
  MOVE /Y patched.xml 14x1_patched.xml
  START /W /B Filedbreader compress -f 14x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x1_patched.tmc 14x1.tmc

  START /W /B xmltest 14x2.xml 14x2.xml_patch.xml
  MOVE /Y patched.xml 14x2_patched.xml
  START /W /B Filedbreader compress -f 14x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x2_patched.tmc 14x2.tmc

  START /W /B xmltest 14x3.xml 14x3.xml_patch.xml
  MOVE /Y patched.xml 14x3_patched.xml
  START /W /B Filedbreader compress -f 14x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x3_patched.tmc 14x3.tmc

  START /W /B xmltest 14x4.xml 14x4.xml_patch.xml
  MOVE /Y patched.xml 14x4_patched.xml
  START /W /B Filedbreader compress -f 14x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x4_patched.tmc 14x4.tmc

  START /W /B xmltest 14x5.xml 14x5.xml_patch.xml
  MOVE /Y patched.xml 14x5_patched.xml
  START /W /B Filedbreader compress -f 14x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x5_patched.tmc 14x5.tmc

  START /W /B xmltest 14x6.xml 14x6.xml_patch.xml
  MOVE /Y patched.xml 14x6_patched.xml
  START /W /B Filedbreader compress -f 14x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x6_patched.tmc 14x6.tmc

  START /W /B xmltest 14x7.xml 14x7.xml_patch.xml
  MOVE /Y patched.xml 14x7_patched.xml
  START /W /B Filedbreader compress -f 14x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x7_patched.tmc 14x7.tmc

  START /W /B xmltest 14x8.xml 14x8.xml_patch.xml
  MOVE /Y patched.xml 14x8_patched.xml
  START /W /B Filedbreader compress -f 14x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x8_patched.tmc 14x8.tmc

  START /W /B xmltest 14x9.xml 14x9.xml_patch.xml
  MOVE /Y patched.xml 14x9_patched.xml
  START /W /B Filedbreader compress -f 14x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x9_patched.tmc 14x9.tmc

  START /W /B xmltest 14x10.xml 14x10.xml_patch.xml
  MOVE /Y patched.xml 14x10_patched.xml
  START /W /B Filedbreader compress -f 14x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x10_patched.tmc 14x10.tmc

  START /W /B xmltest 14x11.xml 14x11.xml_patch.xml
  MOVE /Y patched.xml 14x11_patched.xml
  START /W /B Filedbreader compress -f 14x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x11_patched.tmc 14x11.tmc

  START /W /B xmltest 14x12.xml 14x12.xml_patch.xml
  MOVE /Y patched.xml 14x12_patched.xml
  START /W /B Filedbreader compress -f 14x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x12_patched.tmc 14x12.tmc

  START /W /B xmltest 14x13.xml 14x13.xml_patch.xml
  MOVE /Y patched.xml 14x13_patched.xml
  START /W /B Filedbreader compress -f 14x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x13_patched.tmc 14x13.tmc

  START /W /B xmltest 14x14.xml 14x14.xml_patch.xml
  MOVE /Y patched.xml 14x14_patched.xml
  START /W /B Filedbreader compress -f 14x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x14_patched.tmc 14x14.tmc

  START /W /B xmltest 14x15.xml 14x15.xml_patch.xml
  MOVE /Y patched.xml 14x15_patched.xml
  START /W /B Filedbreader compress -f 14x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x15_patched.tmc 14x15.tmc

  START /W /B xmltest 14x16.xml 14x16.xml_patch.xml
  MOVE /Y patched.xml 14x16_patched.xml
  START /W /B Filedbreader compress -f 14x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x16_patched.tmc 14x16.tmc

  START /W /B xmltest 14x17.xml 14x17.xml_patch.xml
  MOVE /Y patched.xml 14x17_patched.xml
  START /W /B Filedbreader compress -f 14x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x17_patched.tmc 14x17.tmc

  START /W /B xmltest 14x18.xml 14x18.xml_patch.xml
  MOVE /Y patched.xml 14x18_patched.xml
  START /W /B Filedbreader compress -f 14x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x18_patched.tmc 14x18.tmc

  START /W /B xmltest 14x19.xml 14x19.xml_patch.xml
  MOVE /Y patched.xml 14x19_patched.xml
  START /W /B Filedbreader compress -f 14x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x19_patched.tmc 14x19.tmc

  START /W /B xmltest 14x20.xml 14x20.xml_patch.xml
  MOVE /Y patched.xml 14x20_patched.xml
  START /W /B Filedbreader compress -f 14x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x20_patched.tmc 14x20.tmc

  START /W /B xmltest 14x21.xml 14x21.xml_patch.xml
  MOVE /Y patched.xml 14x21_patched.xml
  START /W /B Filedbreader compress -f 14x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x21_patched.tmc 14x21.tmc

  START /W /B xmltest 14x22.xml 14x22.xml_patch.xml
  MOVE /Y patched.xml 14x22_patched.xml
  START /W /B Filedbreader compress -f 14x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x22_patched.tmc 14x22.tmc

  START /W /B xmltest 14x23.xml 14x23.xml_patch.xml
  MOVE /Y patched.xml 14x23_patched.xml
  START /W /B Filedbreader compress -f 14x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 14x23_patched.tmc 14x23.tmc



  START /W /B xmltest 15x0.xml 15x0.xml_patch.xml
  MOVE /Y patched.xml 15x0_patched.xml
  START /W /B Filedbreader compress -f 15x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x0_patched.tmc 15x0.tmc

  START /W /B xmltest 15x1.xml 15x1.xml_patch.xml
  MOVE /Y patched.xml 15x1_patched.xml
  START /W /B Filedbreader compress -f 15x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x1_patched.tmc 15x1.tmc

  START /W /B xmltest 15x2.xml 15x2.xml_patch.xml
  MOVE /Y patched.xml 15x2_patched.xml
  START /W /B Filedbreader compress -f 15x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x2_patched.tmc 15x2.tmc

  START /W /B xmltest 15x3.xml 15x3.xml_patch.xml
  MOVE /Y patched.xml 15x3_patched.xml
  START /W /B Filedbreader compress -f 15x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x3_patched.tmc 15x3.tmc

  START /W /B xmltest 15x4.xml 15x4.xml_patch.xml
  MOVE /Y patched.xml 15x4_patched.xml
  START /W /B Filedbreader compress -f 15x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x4_patched.tmc 15x4.tmc

  START /W /B xmltest 15x5.xml 15x5.xml_patch.xml
  MOVE /Y patched.xml 15x5_patched.xml
  START /W /B Filedbreader compress -f 15x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x5_patched.tmc 15x5.tmc

  START /W /B xmltest 15x6.xml 15x6.xml_patch.xml
  MOVE /Y patched.xml 15x6_patched.xml
  START /W /B Filedbreader compress -f 15x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x6_patched.tmc 15x6.tmc

  START /W /B xmltest 15x7.xml 15x7.xml_patch.xml
  MOVE /Y patched.xml 15x7_patched.xml
  START /W /B Filedbreader compress -f 15x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x7_patched.tmc 15x7.tmc

  START /W /B xmltest 15x8.xml 15x8.xml_patch.xml
  MOVE /Y patched.xml 15x8_patched.xml
  START /W /B Filedbreader compress -f 15x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x8_patched.tmc 15x8.tmc

  START /W /B xmltest 15x9.xml 15x9.xml_patch.xml
  MOVE /Y patched.xml 15x9_patched.xml
  START /W /B Filedbreader compress -f 15x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x9_patched.tmc 15x9.tmc

  START /W /B xmltest 15x10.xml 15x10.xml_patch.xml
  MOVE /Y patched.xml 15x10_patched.xml
  START /W /B Filedbreader compress -f 15x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x10_patched.tmc 15x10.tmc

  START /W /B xmltest 15x11.xml 15x11.xml_patch.xml
  MOVE /Y patched.xml 15x11_patched.xml
  START /W /B Filedbreader compress -f 15x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x11_patched.tmc 15x11.tmc

  START /W /B xmltest 15x12.xml 15x12.xml_patch.xml
  MOVE /Y patched.xml 15x12_patched.xml
  START /W /B Filedbreader compress -f 15x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x12_patched.tmc 15x12.tmc

  START /W /B xmltest 15x13.xml 15x13.xml_patch.xml
  MOVE /Y patched.xml 15x13_patched.xml
  START /W /B Filedbreader compress -f 15x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x13_patched.tmc 15x13.tmc

  START /W /B xmltest 15x14.xml 15x14.xml_patch.xml
  MOVE /Y patched.xml 15x14_patched.xml
  START /W /B Filedbreader compress -f 15x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x14_patched.tmc 15x14.tmc

  START /W /B xmltest 15x15.xml 15x15.xml_patch.xml
  MOVE /Y patched.xml 15x15_patched.xml
  START /W /B Filedbreader compress -f 15x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x15_patched.tmc 15x15.tmc

  START /W /B xmltest 15x16.xml 15x16.xml_patch.xml
  MOVE /Y patched.xml 15x16_patched.xml
  START /W /B Filedbreader compress -f 15x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x16_patched.tmc 15x16.tmc

  START /W /B xmltest 15x17.xml 15x17.xml_patch.xml
  MOVE /Y patched.xml 15x17_patched.xml
  START /W /B Filedbreader compress -f 15x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x17_patched.tmc 15x17.tmc

  START /W /B xmltest 15x18.xml 15x18.xml_patch.xml
  MOVE /Y patched.xml 15x18_patched.xml
  START /W /B Filedbreader compress -f 15x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x18_patched.tmc 15x18.tmc

  START /W /B xmltest 15x19.xml 15x19.xml_patch.xml
  MOVE /Y patched.xml 15x19_patched.xml
  START /W /B Filedbreader compress -f 15x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x19_patched.tmc 15x19.tmc

  START /W /B xmltest 15x20.xml 15x20.xml_patch.xml
  MOVE /Y patched.xml 15x20_patched.xml
  START /W /B Filedbreader compress -f 15x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x20_patched.tmc 15x20.tmc

  START /W /B xmltest 15x21.xml 15x21.xml_patch.xml
  MOVE /Y patched.xml 15x21_patched.xml
  START /W /B Filedbreader compress -f 15x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x21_patched.tmc 15x21.tmc

  START /W /B xmltest 15x22.xml 15x22.xml_patch.xml
  MOVE /Y patched.xml 15x22_patched.xml
  START /W /B Filedbreader compress -f 15x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x22_patched.tmc 15x22.tmc

  START /W /B xmltest 15x23.xml 15x23.xml_patch.xml
  MOVE /Y patched.xml 15x23_patched.xml
  START /W /B Filedbreader compress -f 15x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 15x23_patched.tmc 15x23.tmc



  START /W /B xmltest 16x0.xml 16x0.xml_patch.xml
  MOVE /Y patched.xml 16x0_patched.xml
  START /W /B Filedbreader compress -f 16x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x0_patched.tmc 16x0.tmc

  START /W /B xmltest 16x1.xml 16x1.xml_patch.xml
  MOVE /Y patched.xml 16x1_patched.xml
  START /W /B Filedbreader compress -f 16x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x1_patched.tmc 16x1.tmc

  START /W /B xmltest 16x2.xml 16x2.xml_patch.xml
  MOVE /Y patched.xml 16x2_patched.xml
  START /W /B Filedbreader compress -f 16x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x2_patched.tmc 16x2.tmc

  START /W /B xmltest 16x3.xml 16x3.xml_patch.xml
  MOVE /Y patched.xml 16x3_patched.xml
  START /W /B Filedbreader compress -f 16x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x3_patched.tmc 16x3.tmc

  START /W /B xmltest 16x4.xml 16x4.xml_patch.xml
  MOVE /Y patched.xml 16x4_patched.xml
  START /W /B Filedbreader compress -f 16x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x4_patched.tmc 16x4.tmc

  START /W /B xmltest 16x5.xml 16x5.xml_patch.xml
  MOVE /Y patched.xml 16x5_patched.xml
  START /W /B Filedbreader compress -f 16x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x5_patched.tmc 16x5.tmc

  START /W /B xmltest 16x6.xml 16x6.xml_patch.xml
  MOVE /Y patched.xml 16x6_patched.xml
  START /W /B Filedbreader compress -f 16x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x6_patched.tmc 16x6.tmc

  START /W /B xmltest 16x7.xml 16x7.xml_patch.xml
  MOVE /Y patched.xml 16x7_patched.xml
  START /W /B Filedbreader compress -f 16x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x7_patched.tmc 16x7.tmc

  START /W /B xmltest 16x8.xml 16x8.xml_patch.xml
  MOVE /Y patched.xml 16x8_patched.xml
  START /W /B Filedbreader compress -f 16x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x8_patched.tmc 16x8.tmc

  START /W /B xmltest 16x9.xml 16x9.xml_patch.xml
  MOVE /Y patched.xml 16x9_patched.xml
  START /W /B Filedbreader compress -f 16x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x9_patched.tmc 16x9.tmc

  START /W /B xmltest 16x10.xml 16x10.xml_patch.xml
  MOVE /Y patched.xml 16x10_patched.xml
  START /W /B Filedbreader compress -f 16x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x10_patched.tmc 16x10.tmc

  START /W /B xmltest 16x11.xml 16x11.xml_patch.xml
  MOVE /Y patched.xml 16x11_patched.xml
  START /W /B Filedbreader compress -f 16x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x11_patched.tmc 16x11.tmc

  START /W /B xmltest 16x12.xml 16x12.xml_patch.xml
  MOVE /Y patched.xml 16x12_patched.xml
  START /W /B Filedbreader compress -f 16x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x12_patched.tmc 16x12.tmc

  START /W /B xmltest 16x13.xml 16x13.xml_patch.xml
  MOVE /Y patched.xml 16x13_patched.xml
  START /W /B Filedbreader compress -f 16x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x13_patched.tmc 16x13.tmc

  START /W /B xmltest 16x14.xml 16x14.xml_patch.xml
  MOVE /Y patched.xml 16x14_patched.xml
  START /W /B Filedbreader compress -f 16x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x14_patched.tmc 16x14.tmc

  START /W /B xmltest 16x15.xml 16x15.xml_patch.xml
  MOVE /Y patched.xml 16x15_patched.xml
  START /W /B Filedbreader compress -f 16x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x15_patched.tmc 16x15.tmc

  START /W /B xmltest 16x16.xml 16x16.xml_patch.xml
  MOVE /Y patched.xml 16x16_patched.xml
  START /W /B Filedbreader compress -f 16x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x16_patched.tmc 16x16.tmc

  START /W /B xmltest 16x17.xml 16x17.xml_patch.xml
  MOVE /Y patched.xml 16x17_patched.xml
  START /W /B Filedbreader compress -f 16x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x17_patched.tmc 16x17.tmc

  START /W /B xmltest 16x18.xml 16x18.xml_patch.xml
  MOVE /Y patched.xml 16x18_patched.xml
  START /W /B Filedbreader compress -f 16x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x18_patched.tmc 16x18.tmc

  START /W /B xmltest 16x19.xml 16x19.xml_patch.xml
  MOVE /Y patched.xml 16x19_patched.xml
  START /W /B Filedbreader compress -f 16x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x19_patched.tmc 16x19.tmc

  START /W /B xmltest 16x20.xml 16x20.xml_patch.xml
  MOVE /Y patched.xml 16x20_patched.xml
  START /W /B Filedbreader compress -f 16x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x20_patched.tmc 16x20.tmc

  START /W /B xmltest 16x21.xml 16x21.xml_patch.xml
  MOVE /Y patched.xml 16x21_patched.xml
  START /W /B Filedbreader compress -f 16x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x21_patched.tmc 16x21.tmc

  START /W /B xmltest 16x22.xml 16x22.xml_patch.xml
  MOVE /Y patched.xml 16x22_patched.xml
  START /W /B Filedbreader compress -f 16x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x22_patched.tmc 16x22.tmc

  START /W /B xmltest 16x23.xml 16x23.xml_patch.xml
  MOVE /Y patched.xml 16x23_patched.xml
  START /W /B Filedbreader compress -f 16x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 16x23_patched.tmc 16x23.tmc



  START /W /B xmltest 17x0.xml 17x0.xml_patch.xml
  MOVE /Y patched.xml 17x0_patched.xml
  START /W /B Filedbreader compress -f 17x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x0_patched.tmc 17x0.tmc

  START /W /B xmltest 17x1.xml 17x1.xml_patch.xml
  MOVE /Y patched.xml 17x1_patched.xml
  START /W /B Filedbreader compress -f 17x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x1_patched.tmc 17x1.tmc

  START /W /B xmltest 17x2.xml 17x2.xml_patch.xml
  MOVE /Y patched.xml 17x2_patched.xml
  START /W /B Filedbreader compress -f 17x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x2_patched.tmc 17x2.tmc

  START /W /B xmltest 17x3.xml 17x3.xml_patch.xml
  MOVE /Y patched.xml 17x3_patched.xml
  START /W /B Filedbreader compress -f 17x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x3_patched.tmc 17x3.tmc

  START /W /B xmltest 17x4.xml 17x4.xml_patch.xml
  MOVE /Y patched.xml 17x4_patched.xml
  START /W /B Filedbreader compress -f 17x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x4_patched.tmc 17x4.tmc

  START /W /B xmltest 17x5.xml 17x5.xml_patch.xml
  MOVE /Y patched.xml 17x5_patched.xml
  START /W /B Filedbreader compress -f 17x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x5_patched.tmc 17x5.tmc

  START /W /B xmltest 17x6.xml 17x6.xml_patch.xml
  MOVE /Y patched.xml 17x6_patched.xml
  START /W /B Filedbreader compress -f 17x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x6_patched.tmc 17x6.tmc

  START /W /B xmltest 17x7.xml 17x7.xml_patch.xml
  MOVE /Y patched.xml 17x7_patched.xml
  START /W /B Filedbreader compress -f 17x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x7_patched.tmc 17x7.tmc

  START /W /B xmltest 17x8.xml 17x8.xml_patch.xml
  MOVE /Y patched.xml 17x8_patched.xml
  START /W /B Filedbreader compress -f 17x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x8_patched.tmc 17x8.tmc

  START /W /B xmltest 17x9.xml 17x9.xml_patch.xml
  MOVE /Y patched.xml 17x9_patched.xml
  START /W /B Filedbreader compress -f 17x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x9_patched.tmc 17x9.tmc

  START /W /B xmltest 17x10.xml 17x10.xml_patch.xml
  MOVE /Y patched.xml 17x10_patched.xml
  START /W /B Filedbreader compress -f 17x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x10_patched.tmc 17x10.tmc

  START /W /B xmltest 17x11.xml 17x11.xml_patch.xml
  MOVE /Y patched.xml 17x11_patched.xml
  START /W /B Filedbreader compress -f 17x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x11_patched.tmc 17x11.tmc

  START /W /B xmltest 17x12.xml 17x12.xml_patch.xml
  MOVE /Y patched.xml 17x12_patched.xml
  START /W /B Filedbreader compress -f 17x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x12_patched.tmc 17x12.tmc

  START /W /B xmltest 17x13.xml 17x13.xml_patch.xml
  MOVE /Y patched.xml 17x13_patched.xml
  START /W /B Filedbreader compress -f 17x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x13_patched.tmc 17x13.tmc

  START /W /B xmltest 17x14.xml 17x14.xml_patch.xml
  MOVE /Y patched.xml 17x14_patched.xml
  START /W /B Filedbreader compress -f 17x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x14_patched.tmc 17x14.tmc

  START /W /B xmltest 17x15.xml 17x15.xml_patch.xml
  MOVE /Y patched.xml 17x15_patched.xml
  START /W /B Filedbreader compress -f 17x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x15_patched.tmc 17x15.tmc

  START /W /B xmltest 17x16.xml 17x16.xml_patch.xml
  MOVE /Y patched.xml 17x16_patched.xml
  START /W /B Filedbreader compress -f 17x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x16_patched.tmc 17x16.tmc

  START /W /B xmltest 17x17.xml 17x17.xml_patch.xml
  MOVE /Y patched.xml 17x17_patched.xml
  START /W /B Filedbreader compress -f 17x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x17_patched.tmc 17x17.tmc

  START /W /B xmltest 17x18.xml 17x18.xml_patch.xml
  MOVE /Y patched.xml 17x18_patched.xml
  START /W /B Filedbreader compress -f 17x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x18_patched.tmc 17x18.tmc

  START /W /B xmltest 17x19.xml 17x19.xml_patch.xml
  MOVE /Y patched.xml 17x19_patched.xml
  START /W /B Filedbreader compress -f 17x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x19_patched.tmc 17x19.tmc

  START /W /B xmltest 17x20.xml 17x20.xml_patch.xml
  MOVE /Y patched.xml 17x20_patched.xml
  START /W /B Filedbreader compress -f 17x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x20_patched.tmc 17x20.tmc

  START /W /B xmltest 17x21.xml 17x21.xml_patch.xml
  MOVE /Y patched.xml 17x21_patched.xml
  START /W /B Filedbreader compress -f 17x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x21_patched.tmc 17x21.tmc

  START /W /B xmltest 17x22.xml 17x22.xml_patch.xml
  MOVE /Y patched.xml 17x22_patched.xml
  START /W /B Filedbreader compress -f 17x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x22_patched.tmc 17x22.tmc

  START /W /B xmltest 17x23.xml 17x23.xml_patch.xml
  MOVE /Y patched.xml 17x23_patched.xml
  START /W /B Filedbreader compress -f 17x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 17x23_patched.tmc 17x23.tmc




  START /W /B xmltest 18x0.xml 18x0.xml_patch.xml
  MOVE /Y patched.xml 18x0_patched.xml
  START /W /B Filedbreader compress -f 18x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x0_patched.tmc 18x0.tmc

  START /W /B xmltest 18x1.xml 18x1.xml_patch.xml
  MOVE /Y patched.xml 18x1_patched.xml
  START /W /B Filedbreader compress -f 18x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x1_patched.tmc 18x1.tmc

  START /W /B xmltest 18x2.xml 18x2.xml_patch.xml
  MOVE /Y patched.xml 18x2_patched.xml
  START /W /B Filedbreader compress -f 18x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x2_patched.tmc 18x2.tmc

  START /W /B xmltest 18x3.xml 18x3.xml_patch.xml
  MOVE /Y patched.xml 18x3_patched.xml
  START /W /B Filedbreader compress -f 18x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x3_patched.tmc 18x3.tmc

  START /W /B xmltest 18x4.xml 18x4.xml_patch.xml
  MOVE /Y patched.xml 18x4_patched.xml
  START /W /B Filedbreader compress -f 18x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x4_patched.tmc 18x4.tmc

  START /W /B xmltest 18x5.xml 18x5.xml_patch.xml
  MOVE /Y patched.xml 18x5_patched.xml
  START /W /B Filedbreader compress -f 18x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x5_patched.tmc 18x5.tmc

  START /W /B xmltest 18x6.xml 18x6.xml_patch.xml
  MOVE /Y patched.xml 18x6_patched.xml
  START /W /B Filedbreader compress -f 18x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x6_patched.tmc 18x6.tmc

  START /W /B xmltest 18x7.xml 18x7.xml_patch.xml
  MOVE /Y patched.xml 18x7_patched.xml
  START /W /B Filedbreader compress -f 18x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x7_patched.tmc 18x7.tmc

  START /W /B xmltest 18x8.xml 18x8.xml_patch.xml
  MOVE /Y patched.xml 18x8_patched.xml
  START /W /B Filedbreader compress -f 18x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x8_patched.tmc 18x8.tmc

  START /W /B xmltest 18x9.xml 18x9.xml_patch.xml
  MOVE /Y patched.xml 18x9_patched.xml
  START /W /B Filedbreader compress -f 18x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x9_patched.tmc 18x9.tmc

  START /W /B xmltest 18x10.xml 18x10.xml_patch.xml
  MOVE /Y patched.xml 18x10_patched.xml
  START /W /B Filedbreader compress -f 18x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x10_patched.tmc 18x10.tmc

  START /W /B xmltest 18x11.xml 18x11.xml_patch.xml
  MOVE /Y patched.xml 18x11_patched.xml
  START /W /B Filedbreader compress -f 18x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x11_patched.tmc 18x11.tmc

  START /W /B xmltest 18x12.xml 18x12.xml_patch.xml
  MOVE /Y patched.xml 18x12_patched.xml
  START /W /B Filedbreader compress -f 18x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x12_patched.tmc 18x12.tmc

  START /W /B xmltest 18x13.xml 18x13.xml_patch.xml
  MOVE /Y patched.xml 18x13_patched.xml
  START /W /B Filedbreader compress -f 18x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x13_patched.tmc 18x13.tmc

  START /W /B xmltest 18x14.xml 18x14.xml_patch.xml
  MOVE /Y patched.xml 18x14_patched.xml
  START /W /B Filedbreader compress -f 18x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x14_patched.tmc 18x14.tmc

  START /W /B xmltest 18x15.xml 18x15.xml_patch.xml
  MOVE /Y patched.xml 18x15_patched.xml
  START /W /B Filedbreader compress -f 18x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x15_patched.tmc 18x15.tmc

  START /W /B xmltest 18x16.xml 18x16.xml_patch.xml
  MOVE /Y patched.xml 18x16_patched.xml
  START /W /B Filedbreader compress -f 18x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x16_patched.tmc 18x16.tmc

  START /W /B xmltest 18x17.xml 18x17.xml_patch.xml
  MOVE /Y patched.xml 18x17_patched.xml
  START /W /B Filedbreader compress -f 18x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x17_patched.tmc 18x17.tmc

  START /W /B xmltest 18x18.xml 18x18.xml_patch.xml
  MOVE /Y patched.xml 18x18_patched.xml
  START /W /B Filedbreader compress -f 18x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x18_patched.tmc 18x18.tmc

  START /W /B xmltest 18x19.xml 18x19.xml_patch.xml
  MOVE /Y patched.xml 18x19_patched.xml
  START /W /B Filedbreader compress -f 18x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x19_patched.tmc 18x19.tmc

  START /W /B xmltest 18x20.xml 18x20.xml_patch.xml
  MOVE /Y patched.xml 18x20_patched.xml
  START /W /B Filedbreader compress -f 18x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x20_patched.tmc 18x20.tmc

  START /W /B xmltest 18x21.xml 18x21.xml_patch.xml
  MOVE /Y patched.xml 18x21_patched.xml
  START /W /B Filedbreader compress -f 18x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x21_patched.tmc 18x21.tmc

  START /W /B xmltest 18x22.xml 18x22.xml_patch.xml
  MOVE /Y patched.xml 18x22_patched.xml
  START /W /B Filedbreader compress -f 18x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x22_patched.tmc 18x22.tmc

  START /W /B xmltest 18x23.xml 18x23.xml_patch.xml
  MOVE /Y patched.xml 18x23_patched.xml
  START /W /B Filedbreader compress -f 18x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 18x23_patched.tmc 18x23.tmc




  START /W /B xmltest 19x0.xml 19x0.xml_patch.xml
  MOVE /Y patched.xml 19x0_patched.xml
  START /W /B Filedbreader compress -f 19x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x0_patched.tmc 19x0.tmc

  START /W /B xmltest 19x1.xml 19x1.xml_patch.xml
  MOVE /Y patched.xml 19x1_patched.xml
  START /W /B Filedbreader compress -f 19x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x1_patched.tmc 19x1.tmc

  START /W /B xmltest 19x2.xml 19x2.xml_patch.xml
  MOVE /Y patched.xml 19x2_patched.xml
  START /W /B Filedbreader compress -f 19x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x2_patched.tmc 19x2.tmc

  START /W /B xmltest 19x3.xml 19x3.xml_patch.xml
  MOVE /Y patched.xml 19x3_patched.xml
  START /W /B Filedbreader compress -f 19x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x3_patched.tmc 19x3.tmc

  START /W /B xmltest 19x4.xml 19x4.xml_patch.xml
  MOVE /Y patched.xml 19x4_patched.xml
  START /W /B Filedbreader compress -f 19x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x4_patched.tmc 19x4.tmc

  START /W /B xmltest 19x5.xml 19x5.xml_patch.xml
  MOVE /Y patched.xml 19x5_patched.xml
  START /W /B Filedbreader compress -f 19x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x5_patched.tmc 19x5.tmc

  START /W /B xmltest 19x6.xml 19x6.xml_patch.xml
  MOVE /Y patched.xml 19x6_patched.xml
  START /W /B Filedbreader compress -f 19x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x6_patched.tmc 19x6.tmc

  START /W /B xmltest 19x7.xml 19x7.xml_patch.xml
  MOVE /Y patched.xml 19x7_patched.xml
  START /W /B Filedbreader compress -f 19x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x7_patched.tmc 19x7.tmc

  START /W /B xmltest 19x8.xml 19x8.xml_patch.xml
  MOVE /Y patched.xml 19x8_patched.xml
  START /W /B Filedbreader compress -f 19x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x8_patched.tmc 19x8.tmc

  START /W /B xmltest 19x9.xml 19x9.xml_patch.xml
  MOVE /Y patched.xml 19x9_patched.xml
  START /W /B Filedbreader compress -f 19x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x9_patched.tmc 19x9.tmc

  START /W /B xmltest 19x10.xml 19x10.xml_patch.xml
  MOVE /Y patched.xml 19x10_patched.xml
  START /W /B Filedbreader compress -f 19x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x10_patched.tmc 19x10.tmc

  START /W /B xmltest 19x11.xml 19x11.xml_patch.xml
  MOVE /Y patched.xml 19x11_patched.xml
  START /W /B Filedbreader compress -f 19x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x11_patched.tmc 19x11.tmc

  START /W /B xmltest 19x12.xml 19x12.xml_patch.xml
  MOVE /Y patched.xml 19x12_patched.xml
  START /W /B Filedbreader compress -f 19x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x12_patched.tmc 19x12.tmc

  START /W /B xmltest 19x13.xml 19x13.xml_patch.xml
  MOVE /Y patched.xml 19x13_patched.xml
  START /W /B Filedbreader compress -f 19x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x13_patched.tmc 19x13.tmc

  START /W /B xmltest 19x14.xml 19x14.xml_patch.xml
  MOVE /Y patched.xml 19x14_patched.xml
  START /W /B Filedbreader compress -f 19x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x14_patched.tmc 19x14.tmc

  START /W /B xmltest 19x15.xml 19x15.xml_patch.xml
  MOVE /Y patched.xml 19x15_patched.xml
  START /W /B Filedbreader compress -f 19x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x15_patched.tmc 19x15.tmc

  START /W /B xmltest 19x16.xml 19x16.xml_patch.xml
  MOVE /Y patched.xml 19x16_patched.xml
  START /W /B Filedbreader compress -f 19x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x16_patched.tmc 19x16.tmc

  START /W /B xmltest 19x17.xml 19x17.xml_patch.xml
  MOVE /Y patched.xml 19x17_patched.xml
  START /W /B Filedbreader compress -f 19x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x17_patched.tmc 19x17.tmc

  START /W /B xmltest 19x18.xml 19x18.xml_patch.xml
  MOVE /Y patched.xml 19x18_patched.xml
  START /W /B Filedbreader compress -f 19x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x18_patched.tmc 19x18.tmc

  START /W /B xmltest 19x19.xml 19x19.xml_patch.xml
  MOVE /Y patched.xml 19x19_patched.xml
  START /W /B Filedbreader compress -f 19x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x19_patched.tmc 19x19.tmc

  START /W /B xmltest 19x20.xml 19x20.xml_patch.xml
  MOVE /Y patched.xml 19x20_patched.xml
  START /W /B Filedbreader compress -f 19x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x20_patched.tmc 19x20.tmc

  START /W /B xmltest 19x21.xml 19x21.xml_patch.xml
  MOVE /Y patched.xml 19x21_patched.xml
  START /W /B Filedbreader compress -f 19x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x21_patched.tmc 19x21.tmc

  START /W /B xmltest 19x22.xml 19x22.xml_patch.xml
  MOVE /Y patched.xml 19x22_patched.xml
  START /W /B Filedbreader compress -f 19x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x22_patched.tmc 19x22.tmc

  START /W /B xmltest 19x23.xml 19x23.xml_patch.xml
  MOVE /Y patched.xml 19x23_patched.xml
  START /W /B Filedbreader compress -f 19x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x23_patched.tmc 19x23.tmc




  START /W /B xmltest 19x0.xml 19x0.xml_patch.xml
  MOVE /Y patched.xml 19x0_patched.xml
  START /W /B Filedbreader compress -f 19x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x0_patched.tmc 19x0.tmc

  START /W /B xmltest 19x1.xml 19x1.xml_patch.xml
  MOVE /Y patched.xml 19x1_patched.xml
  START /W /B Filedbreader compress -f 19x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x1_patched.tmc 19x1.tmc

  START /W /B xmltest 19x2.xml 19x2.xml_patch.xml
  MOVE /Y patched.xml 19x2_patched.xml
  START /W /B Filedbreader compress -f 19x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x2_patched.tmc 19x2.tmc

  START /W /B xmltest 19x3.xml 19x3.xml_patch.xml
  MOVE /Y patched.xml 19x3_patched.xml
  START /W /B Filedbreader compress -f 19x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x3_patched.tmc 19x3.tmc

  START /W /B xmltest 19x4.xml 19x4.xml_patch.xml
  MOVE /Y patched.xml 19x4_patched.xml
  START /W /B Filedbreader compress -f 19x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x4_patched.tmc 19x4.tmc

  START /W /B xmltest 19x5.xml 19x5.xml_patch.xml
  MOVE /Y patched.xml 19x5_patched.xml
  START /W /B Filedbreader compress -f 19x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x5_patched.tmc 19x5.tmc

  START /W /B xmltest 19x6.xml 19x6.xml_patch.xml
  MOVE /Y patched.xml 19x6_patched.xml
  START /W /B Filedbreader compress -f 19x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x6_patched.tmc 19x6.tmc

  START /W /B xmltest 19x7.xml 19x7.xml_patch.xml
  MOVE /Y patched.xml 19x7_patched.xml
  START /W /B Filedbreader compress -f 19x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x7_patched.tmc 19x7.tmc

  START /W /B xmltest 19x8.xml 19x8.xml_patch.xml
  MOVE /Y patched.xml 19x8_patched.xml
  START /W /B Filedbreader compress -f 19x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x8_patched.tmc 19x8.tmc

  START /W /B xmltest 19x9.xml 19x9.xml_patch.xml
  MOVE /Y patched.xml 19x9_patched.xml
  START /W /B Filedbreader compress -f 19x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x9_patched.tmc 19x9.tmc

  START /W /B xmltest 19x10.xml 19x10.xml_patch.xml
  MOVE /Y patched.xml 19x10_patched.xml
  START /W /B Filedbreader compress -f 19x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x10_patched.tmc 19x10.tmc

  START /W /B xmltest 19x11.xml 19x11.xml_patch.xml
  MOVE /Y patched.xml 19x11_patched.xml
  START /W /B Filedbreader compress -f 19x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x11_patched.tmc 19x11.tmc

  START /W /B xmltest 19x12.xml 19x12.xml_patch.xml
  MOVE /Y patched.xml 19x12_patched.xml
  START /W /B Filedbreader compress -f 19x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x12_patched.tmc 19x12.tmc

  START /W /B xmltest 19x13.xml 19x13.xml_patch.xml
  MOVE /Y patched.xml 19x13_patched.xml
  START /W /B Filedbreader compress -f 19x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x13_patched.tmc 19x13.tmc

  START /W /B xmltest 19x14.xml 19x14.xml_patch.xml
  MOVE /Y patched.xml 19x14_patched.xml
  START /W /B Filedbreader compress -f 19x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x14_patched.tmc 19x14.tmc

  START /W /B xmltest 19x15.xml 19x15.xml_patch.xml
  MOVE /Y patched.xml 19x15_patched.xml
  START /W /B Filedbreader compress -f 19x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x15_patched.tmc 19x15.tmc

  START /W /B xmltest 19x16.xml 19x16.xml_patch.xml
  MOVE /Y patched.xml 19x16_patched.xml
  START /W /B Filedbreader compress -f 19x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x16_patched.tmc 19x16.tmc

  START /W /B xmltest 19x17.xml 19x17.xml_patch.xml
  MOVE /Y patched.xml 19x17_patched.xml
  START /W /B Filedbreader compress -f 19x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x17_patched.tmc 19x17.tmc

  START /W /B xmltest 19x18.xml 19x18.xml_patch.xml
  MOVE /Y patched.xml 19x18_patched.xml
  START /W /B Filedbreader compress -f 19x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x18_patched.tmc 19x18.tmc

  START /W /B xmltest 19x19.xml 19x19.xml_patch.xml
  MOVE /Y patched.xml 19x19_patched.xml
  START /W /B Filedbreader compress -f 19x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x19_patched.tmc 19x19.tmc

  START /W /B xmltest 19x20.xml 19x20.xml_patch.xml
  MOVE /Y patched.xml 19x20_patched.xml
  START /W /B Filedbreader compress -f 19x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x20_patched.tmc 19x20.tmc

  START /W /B xmltest 19x21.xml 19x21.xml_patch.xml
  MOVE /Y patched.xml 19x21_patched.xml
  START /W /B Filedbreader compress -f 19x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x21_patched.tmc 19x21.tmc

  START /W /B xmltest 19x22.xml 19x22.xml_patch.xml
  MOVE /Y patched.xml 19x22_patched.xml
  START /W /B Filedbreader compress -f 19x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x22_patched.tmc 19x22.tmc

  START /W /B xmltest 19x23.xml 19x23.xml_patch.xml
  MOVE /Y patched.xml 19x23_patched.xml
  START /W /B Filedbreader compress -f 19x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 19x23_patched.tmc 19x23.tmc




  START /W /B xmltest 20x0.xml 20x0.xml_patch.xml
  MOVE /Y patched.xml 20x0_patched.xml
  START /W /B Filedbreader compress -f 20x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x0_patched.tmc 20x0.tmc

  START /W /B xmltest 20x1.xml 20x1.xml_patch.xml
  MOVE /Y patched.xml 20x1_patched.xml
  START /W /B Filedbreader compress -f 20x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x1_patched.tmc 20x1.tmc

  START /W /B xmltest 20x2.xml 20x2.xml_patch.xml
  MOVE /Y patched.xml 20x2_patched.xml
  START /W /B Filedbreader compress -f 20x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x2_patched.tmc 20x2.tmc

  START /W /B xmltest 20x3.xml 20x3.xml_patch.xml
  MOVE /Y patched.xml 20x3_patched.xml
  START /W /B Filedbreader compress -f 20x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x3_patched.tmc 20x3.tmc

  START /W /B xmltest 20x4.xml 20x4.xml_patch.xml
  MOVE /Y patched.xml 20x4_patched.xml
  START /W /B Filedbreader compress -f 20x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x4_patched.tmc 20x4.tmc

  START /W /B xmltest 20x5.xml 20x5.xml_patch.xml
  MOVE /Y patched.xml 20x5_patched.xml
  START /W /B Filedbreader compress -f 20x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x5_patched.tmc 20x5.tmc

  START /W /B xmltest 20x6.xml 20x6.xml_patch.xml
  MOVE /Y patched.xml 20x6_patched.xml
  START /W /B Filedbreader compress -f 20x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x6_patched.tmc 20x6.tmc

  START /W /B xmltest 20x7.xml 20x7.xml_patch.xml
  MOVE /Y patched.xml 20x7_patched.xml
  START /W /B Filedbreader compress -f 20x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x7_patched.tmc 20x7.tmc

  START /W /B xmltest 20x8.xml 20x8.xml_patch.xml
  MOVE /Y patched.xml 20x8_patched.xml
  START /W /B Filedbreader compress -f 20x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x8_patched.tmc 20x8.tmc

  START /W /B xmltest 20x9.xml 20x9.xml_patch.xml
  MOVE /Y patched.xml 20x9_patched.xml
  START /W /B Filedbreader compress -f 20x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x9_patched.tmc 20x9.tmc

  START /W /B xmltest 20x10.xml 20x10.xml_patch.xml
  MOVE /Y patched.xml 20x10_patched.xml
  START /W /B Filedbreader compress -f 20x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x10_patched.tmc 20x10.tmc

  START /W /B xmltest 20x11.xml 20x11.xml_patch.xml
  MOVE /Y patched.xml 20x11_patched.xml
  START /W /B Filedbreader compress -f 20x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x11_patched.tmc 20x11.tmc

  START /W /B xmltest 20x12.xml 20x12.xml_patch.xml
  MOVE /Y patched.xml 20x12_patched.xml
  START /W /B Filedbreader compress -f 20x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x12_patched.tmc 20x12.tmc

  START /W /B xmltest 20x13.xml 20x13.xml_patch.xml
  MOVE /Y patched.xml 20x13_patched.xml
  START /W /B Filedbreader compress -f 20x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x13_patched.tmc 20x13.tmc

  START /W /B xmltest 20x14.xml 20x14.xml_patch.xml
  MOVE /Y patched.xml 20x14_patched.xml
  START /W /B Filedbreader compress -f 20x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x14_patched.tmc 20x14.tmc

  START /W /B xmltest 20x15.xml 20x15.xml_patch.xml
  MOVE /Y patched.xml 20x15_patched.xml
  START /W /B Filedbreader compress -f 20x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x15_patched.tmc 20x15.tmc

  START /W /B xmltest 20x16.xml 20x16.xml_patch.xml
  MOVE /Y patched.xml 20x16_patched.xml
  START /W /B Filedbreader compress -f 20x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x16_patched.tmc 20x16.tmc

  START /W /B xmltest 20x17.xml 20x17.xml_patch.xml
  MOVE /Y patched.xml 20x17_patched.xml
  START /W /B Filedbreader compress -f 20x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x17_patched.tmc 20x17.tmc

  START /W /B xmltest 20x18.xml 20x18.xml_patch.xml
  MOVE /Y patched.xml 20x18_patched.xml
  START /W /B Filedbreader compress -f 20x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x18_patched.tmc 20x18.tmc

  START /W /B xmltest 20x19.xml 20x19.xml_patch.xml
  MOVE /Y patched.xml 20x19_patched.xml
  START /W /B Filedbreader compress -f 20x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x19_patched.tmc 20x19.tmc

  START /W /B xmltest 20x20.xml 20x20.xml_patch.xml
  MOVE /Y patched.xml 20x20_patched.xml
  START /W /B Filedbreader compress -f 20x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x20_patched.tmc 20x20.tmc

  START /W /B xmltest 20x21.xml 20x21.xml_patch.xml
  MOVE /Y patched.xml 20x21_patched.xml
  START /W /B Filedbreader compress -f 20x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x21_patched.tmc 20x21.tmc

  START /W /B xmltest 20x22.xml 20x22.xml_patch.xml
  MOVE /Y patched.xml 20x22_patched.xml
  START /W /B Filedbreader compress -f 20x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x22_patched.tmc 20x22.tmc

  START /W /B xmltest 20x23.xml 20x23.xml_patch.xml
  MOVE /Y patched.xml 20x23_patched.xml
  START /W /B Filedbreader compress -f 20x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 20x23_patched.tmc 20x23.tmc



  START /W /B xmltest 21x0.xml 21x0.xml_patch.xml
  MOVE /Y patched.xml 21x0_patched.xml
  START /W /B Filedbreader compress -f 21x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x0_patched.tmc 21x0.tmc

  START /W /B xmltest 21x1.xml 21x1.xml_patch.xml
  MOVE /Y patched.xml 21x1_patched.xml
  START /W /B Filedbreader compress -f 21x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x1_patched.tmc 21x1.tmc

  START /W /B xmltest 21x2.xml 21x2.xml_patch.xml
  MOVE /Y patched.xml 21x2_patched.xml
  START /W /B Filedbreader compress -f 21x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x2_patched.tmc 21x2.tmc

  START /W /B xmltest 21x3.xml 21x3.xml_patch.xml
  MOVE /Y patched.xml 21x3_patched.xml
  START /W /B Filedbreader compress -f 21x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x3_patched.tmc 21x3.tmc

  START /W /B xmltest 21x4.xml 21x4.xml_patch.xml
  MOVE /Y patched.xml 21x4_patched.xml
  START /W /B Filedbreader compress -f 21x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x4_patched.tmc 21x4.tmc

  START /W /B xmltest 21x5.xml 21x5.xml_patch.xml
  MOVE /Y patched.xml 21x5_patched.xml
  START /W /B Filedbreader compress -f 21x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x5_patched.tmc 21x5.tmc

  START /W /B xmltest 21x6.xml 21x6.xml_patch.xml
  MOVE /Y patched.xml 21x6_patched.xml
  START /W /B Filedbreader compress -f 21x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x6_patched.tmc 21x6.tmc

  START /W /B xmltest 21x7.xml 21x7.xml_patch.xml
  MOVE /Y patched.xml 21x7_patched.xml
  START /W /B Filedbreader compress -f 21x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x7_patched.tmc 21x7.tmc

  START /W /B xmltest 21x8.xml 21x8.xml_patch.xml
  MOVE /Y patched.xml 21x8_patched.xml
  START /W /B Filedbreader compress -f 21x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x8_patched.tmc 21x8.tmc

  START /W /B xmltest 21x9.xml 21x9.xml_patch.xml
  MOVE /Y patched.xml 21x9_patched.xml
  START /W /B Filedbreader compress -f 21x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x9_patched.tmc 21x9.tmc

  START /W /B xmltest 21x10.xml 21x10.xml_patch.xml
  MOVE /Y patched.xml 21x10_patched.xml
  START /W /B Filedbreader compress -f 21x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x10_patched.tmc 21x10.tmc

  START /W /B xmltest 21x11.xml 21x11.xml_patch.xml
  MOVE /Y patched.xml 21x11_patched.xml
  START /W /B Filedbreader compress -f 21x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x11_patched.tmc 21x11.tmc

  START /W /B xmltest 21x12.xml 21x12.xml_patch.xml
  MOVE /Y patched.xml 21x12_patched.xml
  START /W /B Filedbreader compress -f 21x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x12_patched.tmc 21x12.tmc

  START /W /B xmltest 21x13.xml 21x13.xml_patch.xml
  MOVE /Y patched.xml 21x13_patched.xml
  START /W /B Filedbreader compress -f 21x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x13_patched.tmc 21x13.tmc

  START /W /B xmltest 21x14.xml 21x14.xml_patch.xml
  MOVE /Y patched.xml 21x14_patched.xml
  START /W /B Filedbreader compress -f 21x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x14_patched.tmc 21x14.tmc

  START /W /B xmltest 21x15.xml 21x15.xml_patch.xml
  MOVE /Y patched.xml 21x15_patched.xml
  START /W /B Filedbreader compress -f 21x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x15_patched.tmc 21x15.tmc

  START /W /B xmltest 21x16.xml 21x16.xml_patch.xml
  MOVE /Y patched.xml 21x16_patched.xml
  START /W /B Filedbreader compress -f 21x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x16_patched.tmc 21x16.tmc

  START /W /B xmltest 21x17.xml 21x17.xml_patch.xml
  MOVE /Y patched.xml 21x17_patched.xml
  START /W /B Filedbreader compress -f 21x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x17_patched.tmc 21x17.tmc

  START /W /B xmltest 21x18.xml 21x18.xml_patch.xml
  MOVE /Y patched.xml 21x18_patched.xml
  START /W /B Filedbreader compress -f 21x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x18_patched.tmc 21x18.tmc

  START /W /B xmltest 21x19.xml 21x19.xml_patch.xml
  MOVE /Y patched.xml 21x19_patched.xml
  START /W /B Filedbreader compress -f 21x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x19_patched.tmc 21x19.tmc

  START /W /B xmltest 21x20.xml 21x20.xml_patch.xml
  MOVE /Y patched.xml 21x20_patched.xml
  START /W /B Filedbreader compress -f 21x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x20_patched.tmc 21x20.tmc

  START /W /B xmltest 21x21.xml 21x21.xml_patch.xml
  MOVE /Y patched.xml 21x21_patched.xml
  START /W /B Filedbreader compress -f 21x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x21_patched.tmc 21x21.tmc

  START /W /B xmltest 21x22.xml 21x22.xml_patch.xml
  MOVE /Y patched.xml 21x22_patched.xml
  START /W /B Filedbreader compress -f 21x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x22_patched.tmc 21x22.tmc

  START /W /B xmltest 21x23.xml 21x23.xml_patch.xml
  MOVE /Y patched.xml 21x23_patched.xml
  START /W /B Filedbreader compress -f 21x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 21x23_patched.tmc 21x23.tmc




  START /W /B xmltest 22x0.xml 22x0.xml_patch.xml
  MOVE /Y patched.xml 22x0_patched.xml
  START /W /B Filedbreader compress -f 22x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x0_patched.tmc 22x0.tmc

  START /W /B xmltest 22x1.xml 22x1.xml_patch.xml
  MOVE /Y patched.xml 22x1_patched.xml
  START /W /B Filedbreader compress -f 22x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x1_patched.tmc 22x1.tmc

  START /W /B xmltest 22x2.xml 22x2.xml_patch.xml
  MOVE /Y patched.xml 22x2_patched.xml
  START /W /B Filedbreader compress -f 22x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x2_patched.tmc 22x2.tmc

  START /W /B xmltest 22x3.xml 22x3.xml_patch.xml
  MOVE /Y patched.xml 22x3_patched.xml
  START /W /B Filedbreader compress -f 22x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x3_patched.tmc 22x3.tmc

  START /W /B xmltest 22x4.xml 22x4.xml_patch.xml
  MOVE /Y patched.xml 22x4_patched.xml
  START /W /B Filedbreader compress -f 22x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x4_patched.tmc 22x4.tmc

  START /W /B xmltest 22x5.xml 22x5.xml_patch.xml
  MOVE /Y patched.xml 22x5_patched.xml
  START /W /B Filedbreader compress -f 22x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x5_patched.tmc 22x5.tmc

  START /W /B xmltest 22x6.xml 22x6.xml_patch.xml
  MOVE /Y patched.xml 22x6_patched.xml
  START /W /B Filedbreader compress -f 22x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x6_patched.tmc 22x6.tmc

  START /W /B xmltest 22x7.xml 22x7.xml_patch.xml
  MOVE /Y patched.xml 22x7_patched.xml
  START /W /B Filedbreader compress -f 22x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x7_patched.tmc 22x7.tmc

  START /W /B xmltest 22x8.xml 22x8.xml_patch.xml
  MOVE /Y patched.xml 22x8_patched.xml
  START /W /B Filedbreader compress -f 22x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x8_patched.tmc 22x8.tmc

  START /W /B xmltest 22x9.xml 22x9.xml_patch.xml
  MOVE /Y patched.xml 22x9_patched.xml
  START /W /B Filedbreader compress -f 22x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x9_patched.tmc 22x9.tmc

  START /W /B xmltest 22x10.xml 22x10.xml_patch.xml
  MOVE /Y patched.xml 22x10_patched.xml
  START /W /B Filedbreader compress -f 22x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x10_patched.tmc 22x10.tmc

  START /W /B xmltest 22x11.xml 22x11.xml_patch.xml
  MOVE /Y patched.xml 22x11_patched.xml
  START /W /B Filedbreader compress -f 22x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x11_patched.tmc 22x11.tmc

  START /W /B xmltest 22x12.xml 22x12.xml_patch.xml
  MOVE /Y patched.xml 22x12_patched.xml
  START /W /B Filedbreader compress -f 22x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x12_patched.tmc 22x12.tmc

  START /W /B xmltest 22x13.xml 22x13.xml_patch.xml
  MOVE /Y patched.xml 22x13_patched.xml
  START /W /B Filedbreader compress -f 22x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x13_patched.tmc 22x13.tmc

  START /W /B xmltest 22x14.xml 22x14.xml_patch.xml
  MOVE /Y patched.xml 22x14_patched.xml
  START /W /B Filedbreader compress -f 22x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x14_patched.tmc 22x14.tmc

  START /W /B xmltest 22x15.xml 22x15.xml_patch.xml
  MOVE /Y patched.xml 22x15_patched.xml
  START /W /B Filedbreader compress -f 22x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x15_patched.tmc 22x15.tmc

  START /W /B xmltest 22x16.xml 22x16.xml_patch.xml
  MOVE /Y patched.xml 22x16_patched.xml
  START /W /B Filedbreader compress -f 22x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x16_patched.tmc 22x16.tmc

  START /W /B xmltest 22x17.xml 22x17.xml_patch.xml
  MOVE /Y patched.xml 22x17_patched.xml
  START /W /B Filedbreader compress -f 22x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x17_patched.tmc 22x17.tmc

  START /W /B xmltest 22x18.xml 22x18.xml_patch.xml
  MOVE /Y patched.xml 22x18_patched.xml
  START /W /B Filedbreader compress -f 22x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x18_patched.tmc 22x18.tmc

  START /W /B xmltest 22x19.xml 22x19.xml_patch.xml
  MOVE /Y patched.xml 22x19_patched.xml
  START /W /B Filedbreader compress -f 22x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x19_patched.tmc 22x19.tmc

  START /W /B xmltest 22x20.xml 22x20.xml_patch.xml
  MOVE /Y patched.xml 22x20_patched.xml
  START /W /B Filedbreader compress -f 22x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x20_patched.tmc 22x20.tmc

  START /W /B xmltest 22x21.xml 22x21.xml_patch.xml
  MOVE /Y patched.xml 22x21_patched.xml
  START /W /B Filedbreader compress -f 22x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x21_patched.tmc 22x21.tmc

  START /W /B xmltest 22x22.xml 22x22.xml_patch.xml
  MOVE /Y patched.xml 22x22_patched.xml
  START /W /B Filedbreader compress -f 22x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x22_patched.tmc 22x22.tmc

  START /W /B xmltest 22x23.xml 22x23.xml_patch.xml
  MOVE /Y patched.xml 22x23_patched.xml
  START /W /B Filedbreader compress -f 22x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 22x23_patched.tmc 22x23.tmc




  START /W /B xmltest 23x0.xml 23x0.xml_patch.xml
  MOVE /Y patched.xml 23x0_patched.xml
  START /W /B Filedbreader compress -f 23x0_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x0_patched.tmc 23x0.tmc

  START /W /B xmltest 23x1.xml 23x1.xml_patch.xml
  MOVE /Y patched.xml 23x1_patched.xml
  START /W /B Filedbreader compress -f 23x1_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x1_patched.tmc 23x1.tmc

  START /W /B xmltest 23x2.xml 23x2.xml_patch.xml
  MOVE /Y patched.xml 23x2_patched.xml
  START /W /B Filedbreader compress -f 23x2_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x2_patched.tmc 23x2.tmc

  START /W /B xmltest 23x3.xml 23x3.xml_patch.xml
  MOVE /Y patched.xml 23x3_patched.xml
  START /W /B Filedbreader compress -f 23x3_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x3_patched.tmc 23x3.tmc

  START /W /B xmltest 23x4.xml 23x4.xml_patch.xml
  MOVE /Y patched.xml 23x4_patched.xml
  START /W /B Filedbreader compress -f 23x4_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x4_patched.tmc 23x4.tmc

  START /W /B xmltest 23x5.xml 23x5.xml_patch.xml
  MOVE /Y patched.xml 23x5_patched.xml
  START /W /B Filedbreader compress -f 23x5_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x5_patched.tmc 23x5.tmc

  START /W /B xmltest 23x6.xml 23x6.xml_patch.xml
  MOVE /Y patched.xml 23x6_patched.xml
  START /W /B Filedbreader compress -f 23x6_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x6_patched.tmc 23x6.tmc

  START /W /B xmltest 23x7.xml 23x7.xml_patch.xml
  MOVE /Y patched.xml 23x7_patched.xml
  START /W /B Filedbreader compress -f 23x7_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x7_patched.tmc 23x7.tmc

  START /W /B xmltest 23x8.xml 23x8.xml_patch.xml
  MOVE /Y patched.xml 23x8_patched.xml
  START /W /B Filedbreader compress -f 23x8_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x8_patched.tmc 23x8.tmc

  START /W /B xmltest 23x9.xml 23x9.xml_patch.xml
  MOVE /Y patched.xml 23x9_patched.xml
  START /W /B Filedbreader compress -f 23x9_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x9_patched.tmc 23x9.tmc

  START /W /B xmltest 23x10.xml 23x10.xml_patch.xml
  MOVE /Y patched.xml 23x10_patched.xml
  START /W /B Filedbreader compress -f 23x10_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x10_patched.tmc 23x10.tmc

  START /W /B xmltest 23x11.xml 23x11.xml_patch.xml
  MOVE /Y patched.xml 23x11_patched.xml
  START /W /B Filedbreader compress -f 23x11_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x11_patched.tmc 23x11.tmc

  START /W /B xmltest 23x12.xml 23x12.xml_patch.xml
  MOVE /Y patched.xml 23x12_patched.xml
  START /W /B Filedbreader compress -f 23x12_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x12_patched.tmc 23x12.tmc

  START /W /B xmltest 23x13.xml 23x13.xml_patch.xml
  MOVE /Y patched.xml 23x13_patched.xml
  START /W /B Filedbreader compress -f 23x13_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x13_patched.tmc 23x13.tmc

  START /W /B xmltest 23x14.xml 23x14.xml_patch.xml
  MOVE /Y patched.xml 23x14_patched.xml
  START /W /B Filedbreader compress -f 23x14_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x14_patched.tmc 23x14.tmc

  START /W /B xmltest 23x15.xml 23x15.xml_patch.xml
  MOVE /Y patched.xml 23x15_patched.xml
  START /W /B Filedbreader compress -f 23x15_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x15_patched.tmc 23x15.tmc

  START /W /B xmltest 23x16.xml 23x16.xml_patch.xml
  MOVE /Y patched.xml 23x16_patched.xml
  START /W /B Filedbreader compress -f 23x16_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x16_patched.tmc 23x16.tmc

  START /W /B xmltest 23x17.xml 23x17.xml_patch.xml
  MOVE /Y patched.xml 23x17_patched.xml
  START /W /B Filedbreader compress -f 23x17_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x17_patched.tmc 23x17.tmc

  START /W /B xmltest 23x18.xml 23x18.xml_patch.xml
  MOVE /Y patched.xml 23x18_patched.xml
  START /W /B Filedbreader compress -f 23x18_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x18_patched.tmc 23x18.tmc

  START /W /B xmltest 23x19.xml 23x19.xml_patch.xml
  MOVE /Y patched.xml 23x19_patched.xml
  START /W /B Filedbreader compress -f 23x19_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x19_patched.tmc 23x19.tmc

  START /W /B xmltest 23x20.xml 23x20.xml_patch.xml
  MOVE /Y patched.xml 23x20_patched.xml
  START /W /B Filedbreader compress -f 23x20_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x20_patched.tmc 23x20.tmc

  START /W /B xmltest 23x21.xml 23x21.xml_patch.xml
  MOVE /Y patched.xml 23x21_patched.xml
  START /W /B Filedbreader compress -f 23x21_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x21_patched.tmc 23x21.tmc

  START /W /B xmltest 23x22.xml 23x22.xml_patch.xml
  MOVE /Y patched.xml 23x22_patched.xml
  START /W /B Filedbreader compress -f 23x22_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x22_patched.tmc 23x22.tmc

  START /W /B xmltest 23x23.xml 23x23.xml_patch.xml
  MOVE /Y patched.xml 23x23_patched.xml
  START /W /B Filedbreader compress -f 23x23_patched.xml -c 2 -i ../../tmc.xml -o .tmc -y
  MOVE /Y 23x23_patched.tmc 23x23.tmc
  ```
  </details>
- run the compressor .bat file. It will iterate through a lot of non existent files as well, but this was the only thing I could set up with my limited coding knowledge, so it might take some time, especially in the later folders with only a hand full of .tmc files inside.
 
- repeat last step for every folder you modified/want to modify.
- You will then also get a name_patched.xml intermediate file which is then recompressed into .tmc (will overwrite original .tmc files!!! -> edit code if you want to keep them!)

Hope this helps
