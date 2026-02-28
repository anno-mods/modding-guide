@ECHO off

call :set_islandname "%cd%"

ECHO unpacking island

::A7M unpacking
START /W RdaConsole ^extract -f %island_name%.a7m -o %island_name% -y

CD /D %island_name%

START /W FileDBReader decompress -f gamedata.data -i Island_Gamedata_V2.xml -y 
MOVE /Y gamedata.xml gamedata_original.xml

START /W FileDBReader decompress -f rd3d.data -i Island_RD3D.xml -y 
MOVE /Y rd3d.xml rd3d_original.xml

IF NOT exist gamedata_patch.xml (
    ECHO ^<ModOps^> > gamedata_patch.xml 
    ECHO. >> gamedata_patch.xml
    ECHO ^<^/ModOps^> >> gamedata_patch.xml 
)

IF NOT exist rd3d_patch.xml (
    ECHO ^<ModOps^> > rd3d_patch.xml 
    ECHO. >> rd3d_patch.xml
    ECHO ^<^/ModOps^> >> rd3d_patch.xml 
)

CD .. 

::A7MINFO unpacking
START /W FileDBReader decompress -f %island_name%.a7minfo -y -i ../a7minfo.xml
MOVE /Y %island_name%.xml %island_name%_original.xml

IF NOT exist %island_name%_patch.xml (
    ECHO ^<ModOps^> > %island_name%_patch.xml
    ECHO. >> %island_name%_patch.xml
    ECHO ^<^/ModOps^> >> %island_name%_patch.xml
)

:set_islandname
set island_name=%~n1
goto :eof