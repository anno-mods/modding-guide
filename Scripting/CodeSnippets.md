# CodeSnippets

Some code snippets which might be usueful.

```lua
-- logging https://github.com/anno-mods/modding-guide/blob/main/Scripting/ExecutingScripts.md#logging
local function modlog(t)
  local file = io.open("logs/modlog.txt", "a")
  io.output(file)
  io.write(t,"\n")
  io.close(file)
end 
```

```lua
-- returns a table like:
-- {SessionGUID=SessionGUID, ParticipantID=ParticipantID, Objects=Objects}
--   with Objects[OID] = {GUID=GUID,userdata=userdata,GameObject=GameObject}
--  with objects from the executing player from the session he is currently in
 -- I don't know a way to get objects from other players, especially non human and from other sessions.
-- with GameObject you can do textsource commands of "CGameObject" (see textsourcelist.json), BUT after you did eg. "GameObject.GetGUID()", do a "GameObject = ts.Objects.GetObject(OID)" again, because GameObject gets corrupted each time.
-- with userdata you can do some undocumented commands like userdata:changeGUID(ToGUID) or :moveTo(), :setPosition(), :destruct() :kill() (found these commands here https://github.com/ChrisAnd1998/Anno1800PythonAPI/blob/main/DUMP/x64dbg_Strings.txt )
 -- you can also get selected userdata by "session.getSelectedFactory()", beware that in coop game the same player can have multiple objects selected, while you only get one depending on the executing PC...
-- For propertyID see https://github.com/anno-mods/modding-guide/blob/main/Scripting/ENUMs.md#propertyids
-- written by Serp
local function GetSessionObjectsFromHuman(propertyID)
  
  local function get_oid(userdata)
    local oid,Namestring
    Namestring = userdata:getName() -- returns eg. "GameObject, oid 8589934647", while getOID returns an local ObjectID, not usuable in ts.Objects.GetObject.
    if Namestring~=nil and type(Namestring)=="string" then
      oid = string.match(Namestring, "oid (.*)")
      if oid~=nil and type(oid)=="string" then
        oid = tonumber(oid)
      end
    end
    return oid
  end

  local userdatas,userdata,ParticipantID,GameObject,GUID
  local Objects = {}
  userdatas = session.getObjectGroupByProperty(propertyID)
  local SessionGUID = session.getSessionGUID()
  
  if userdatas~=nil and #userdatas>0 then
    userdata = nil
    for k,userdata in pairs(userdatas) do
      if userdata~=nil then
        GameObject,GUID = nil
        local OID = get_oid(userdata)
        -- it is important to do GameObject = ts.Objects.GetObject(OID) several times, because it is broken after we do eg. GameObject.GetGUID() !!
        GameObject = ts.Objects.GetObject(OID)
        GUID = GameObject.GetGUID()
        if ParticipantID==nil then -- will be the same for all objects, so no need to get it multiple times
          GameObject = ts.Objects.GetObject(OID)
          ParticipantID = GameObject.GetOwner() -- ParticipantID
        end
        GameObject = ts.Objects.GetObject(OID)
        Objects[OID] = {GUID=GUID,userdata=userdata,GameObject=GameObject}
      end
    end
  end
  return {SessionGUID=SessionGUID, ParticipantID=ParticipantID, Objects=Objects}
end
```
