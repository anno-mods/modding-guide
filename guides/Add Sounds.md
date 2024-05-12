# WIP: Add Sounds

work in progress, currently only german and mostly personal notes and for sure not complete  

Eigene Sounds zuzufügen ist leider ziemlich kompliziert und geht nur über das Programm Wwise.

wwise installieren:
AudiokineticLauncher exe starten und Wwise_v2019.2.15_Build7667 installieren, erfordert kostenlosen Account erstellen.

man kann nur .wav dateien nutzen.
Dazu zb. "Audacity" Programm nutzen. https://www.youtube.com/watch?v=HVOjueiEBzc
Dazu die mp3 Dateien einfach alles in das Programm reinziehen.
Dann oben links auf "Datei/Exportieren/Mehrere exportieren" Dort dann den Zielornder einfügen wohin das convertierte soll.
Als Dateiformat sollte WAV 16bit passen. Rest passt so, dann Exportieren klicken.
 dann fragt er für jede Datei nochmal ob ich was ändern will, scheint keinen "für alle" button zu geben, also zigmal draufklicken


youtube tutorial:
https://www.youtube.com/watch?v=jIPWDSSsG2I  (from "Violet Chaolan" Anno Modding Discord)
um mehrere Audio einträgen ein Event zu geben, einfach alle markieren, rechtsklick und dort jedem ein einzelnes Play Event geben lassen.
Um Zb. Positioning oder andere Settings für alle zu machen, kann man die setting auch im SFX Mixxer machen, diese werden dann defaultmäßig 
verwendet, sofern im audio/event selbst nichts anderes definiert ist (auch conversion zu kleinerer size im mixxer machen).
Für Sprachlautstärke anstatt SFX (effekte) nimmt man als GameParameter Namen "Menu_Volume_VO".
Ich glaube wie der Mixxer heißt ist egal, aber vorsichtshalber "Voice Mixxer" nennen?
Braucht auch "Menu_Volume_Master" als Gemaparameter! sonst ändert sich sound nicht zusammen mit der "GesmatLautstärke"


Positioning:
Achtung, nicht jede Art von Sounds bzw. jede Art von Verwendung in Anno unterstützt das! Schüsse usw vermutlich schon,
 aber Selection/Move Commands offenbar nicht, jedenfalls hör ich nichts mehr, sobald ich Positioning zufüge. Ist hierbei aber auch nicht schlimm.
 wobeis evlt auch daran liegt, dass das AudioAsset das hier braucht: "MaxAttenuation"  "ActivationRangeOffset"?

mit voices und übersetzung arbeiten:
https://www.youtube.com/watch?v=Sq-Rg5QkQTY
kurz:
beim Importieren zuerst Import Mode: Create New Object. Import as: Sound Voice, die englischen Voice sounds importieren.
für englisch muss die Sprache "en_us" heißen!
Dann bei Project/Language eine neue Sprache mit Add zufügen (einfach "de_de" eintippen) und so alles bestätigen. (mit Make Up Gain kann man wohl in einer sprache alle sounds lauter/leiser machen)
Dann erneut Importieren und nun also Import Mode Localize Languages nutzen und de_de auswählen und importieren 
..
bnk MUSS in dann rein in data\sound\generatedsoundbanks\windows dann ein en_us und ein de_de Ordner rein, wo dann die bnk dateien direkt reinkommen!
 Und die Soundbank Datei nach ihrer ID benennen, dann findet das spiel die soundbanks (in wwise kann man sie nicht direkt so bennenen,erlaubt keine zahl zu beginn)
und zurzeit scheints dann nur zu funktionieren, wenn die bnk Datei im Anno Installationsordner ist Anno 1800\data\sound\generatedsoundbanks\windows
 (Ab dem Mai 2024 Anno Update werden Sounds wohl auch über Mods gehen, ohne sie im Installationsorder zu haben)

um die ".wem" Dateien noch zu erhalten (nicht sicher ob nötig? ne nicht noetig)
muss man bei audio der datei dann "Stream" haken setzen und "no latency".
Man kann die einstellungen für alle sounds aufeinmal machen, indem man sie für den SFX Mixxer macht, also auch Positioning


komisch ist noch, dass die event-ID für die sounds immer dieselbe ist, auch in neuen projekten mit anderer soundbank id? evlt wird die anhand des dateinamen des sounds generiert oderso?


Wenn man Portrait Lipsync haben will, dann muss man wohl:
Start, Stop and End markers in wwise 
that's how lipsync works
in case you would want a custom voiceline
relates to the sequences of the portraits 
start: talk
stop: idle_talk
end: back to idle


man nutzt dann die soundbank Id die in der xml Datei steht als WwiseID im <Template>SoundBank</Template> und fügt die soundbank GUID zu
  <ModOp Type="add" GUID="9899002" Path="/Values/RequiredSoundBanks/SoundBanks">
hinzu.
Dann ein <Template>Audio</Template> mit WwiseID von dem Event Id aus der soundbank.
Dieses AudioAsset kann dann wie in vanilla verwendet werden, zb innerhalb AudioText.

 
