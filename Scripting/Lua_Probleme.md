----
(Serp)
# Lua Probleme und MP und Lösungsansätze erklärt (brainstorming):  

Möglichkeit ***lua auszuführen***:  
- erstmaliges starten geht nur über xml (danach können sie sich auch gegenseitig aufrufen)
- ActionExecuteScript startet das lua Skript für alle lokalen Spieler (sowohl alle Humans, als auch alle Coop-Peers), egal wer diese Action ausgeführt hat.
- Commands die über Keybinds ausgelöst werden, werden nur für den lokalen Spieler ausgeführt, der die Taste gedrückt hat.  

&nbsp;  

***Wer ist wer?***  
Es gibt keine direkten lua Funktionen um rauszufinden ob man selbst der Host ist, ob man ein Coop Team hat, welcher Peer man ist oder welcher Peer überhaupt noch aktiv im Spiel ist (nachdem er einmal aktiv war, aber jetzt evlt. nicht mehr)  
&nbsp;Für Konsole wurden wohl ein paar weitere Funktionen zugefügt? jedenfalls gibts in xml "MPLobbyConsoleScene" Sachen wie LocalPlayerIsCoopTeamLead, aber das ist sicherlich alles außerhalb von lua oder auch textsource...

&nbsp;  

***Sync:***  
In Multiplayer verhalten sich nicht alle lua befehle gleich:  
- Automatisch ***gesynce Befehle***: Macht kein Desync, aber hat den Haken, dass die Aktion für jeden lokalen Spieler einmal ausgeführt wird, auch für Coop Peers.  
&nbsp;Beispiel: mit ActionExecuteScript wird ein Skript mit Gutschrift von 100 Münzen ausgeführt: In einem Spiel mit 2 CoopSpieler für Human0 werden Human0 dann 200 Münzen gutgeschrieben. Dh. entweder teilt man den Betrag durch die Anzahl der Coop-Spieler (Anzahl bekommt man über genau diesem Umstand raus), oder man darf den Befehl nur für einen der Peers ausführen, doch dazu muss man wissen, welcher Peer man selbst ist (was nicht so einfach ist).
- ***Nicht gesynced***: Diese Befehle lösen Desync aus, AUßER jeder lokale Spieler führt sie im exakt selben Tick aus, mit demselben Ergebnis. Hier ist es von Vorteil, dass ActionExecuteScript ein Skript für alle lokalen Spieler ausführt. Aber das mit dem exakt selben Tick und vorallem mit demselben Ergebnis, ist oft leider schwieriger als man denkt, zb auch weil viele Befehle nur auf den lokalen Spieler wirken, nicht auf einen Beliebigen.  
Welche Befehle gesynced sind und welche nicht, lässt sich an sich nur durch ausprobieren rausfinden, konnte da kein Muster erkennen.

&nbsp;  

Nicht alle Daten sind ***von überall zugänglich***:  
- userdata (also das was man zb bei session.getSelectedFactory() returned bekommt), ist nur für einen lokalen Spieler zugänglich, wenn er in derselben Session wie dieses Objekt ist. Es lässt sich auch nicht zwischenspeichern, da es lediglich ein Zeiger-Objekt ist.
- Für GameObjects (zb das was man bei ts.Selection.Object erhält) haben wir einen Weg gefunden, auf Objekte in anderen Sessions zuzugreifen:  
&nbsp;ts.GetGameObject(OID), dies funktioniert für die meisten Dinge, ABER nicht alles. Am besten immer ausführlich den Anwendungsfall testen, obs klappt oder nicht!  
&nbsp;&nbsp;Zusätzlich gibt es damit im MP Probleme, wenn man Werte ändert, zb. den Namen eines Objekts ändert. Dies wird nur korrekt gesynced, wenn die anderen Spieler in derselben Session sind!  
&nbsp;Alternative die zuverlässiger ist: "MetaObjects SessionGameObject", doch dies ist nicht in lua direkt zugänglich, siehe nächsten Punkt.  

&nbsp;  

Nicht alle ***textsourcelist*** Funktionen sind ***in lua zugänglich***, vorallem Funktionen die Listen returnen wie "ItemContainer Sockets" usw. oder auch das wichtige "MetaObjects SessionGameObject":  
&nbsp;Lösung: hiermit "game.TextSourceManager.setDebugTextSource(ts_embed_string)" führen wir textsource-code aus, bekommen aber leider nichts returned. Workaround ist, dem ts_embed_string zuzufügen, dass er das ergebnis in ein Nameable Hilfsobjekt schreiben soll, was wir dann in lua auslesen können.

&nbsp;  

***Verzögerung*** bis Aktionen Wirkung im Spiel haben, bzw. wieder ausgelesen werden können:  
Wenn man via skript eine ressource gutschreibt und direkt danach abfragt, wieviel der spieler von der reesource hat, bekommt man noch nicht das neue ergebnis. Stattdessen muss man zb mit coroutine.yield() erstmal abwarten, bis das Spiel den Befehl bearbeitet hat. Ein yield wartet einen GameTick welcher wohl 100 ingame milisekunden lang ist.  
&nbsp;Problem ist nun, dass je nach Hardware und Spielfortschritt, das Spiel unterschiedlich schnell beim Aktualisieren der neuen Infos ist. So reicht bei einem neuen Spiel oft ein einziger yield aus, um das neue ergebnis abzufragen. Bei riesigen Spielständen benötigt es dann aber mehr.  

&nbsp;  

***Inaktive Spieler***: Spieler die im Multiplayer Spiel mal dabei waren, aber es jetzt nicht mehr sind, belegen weiterhin ihren Peer Slot!  
&nbsp;Auch returned GetActiveSessionGUIDOfPeerInt weiterhin die zuletzt aktive Session für diese inaktiven Peers.  
&nbsp;Bei GetCoopPeersAtMarker (auch nicht direkt in lua verfügbar) tauchen sie nicht auf, doch auch der lokale Spieler taucht da nicht auf, sodass dies alleine nicht reicht um sicher festzustellen, wer inaktiv und wer man selbst ist.  
&nbsp;Aktueller workaround: eine neue Session laden und alle Spieler da hinein zwingen. Inaktive Spieler wechseln ihre Session bei so einem Zwang dennoch nicht.  
&nbsp;&nbsp;Zusammen mit GetCoopPeersAtMarker (alle Spieler in ein UI, zb Statistikmenü zwingen) weiß man dann endlich wer inaktiv ist und wer man selbst ist.  
&nbsp;Eine andere Methode habe ich noch nicht finden können, obwohl ich sehr sehr viele Stunden damit verbracht habe.  

&nbsp;  

INFO zum ***Nameable Property*** in lua:  
1) Bei SetName("string") wird lokal für den ausführenden Spieler sofort dieser String als Name hinterlegt und kann
 auch sofort imselben Tick wieder mit GetName() zurückerhalten werden.
 Das ist besonders hilfreich, wenn wir dadrin zb. bei setDebugTextSource lokal andere Informationen drin speichern müssen
&nbsp;dh. selbst wenn die Skripte quasi zeitgleich für jeden lokalen Spieler ausgeführt werden, bekommen sie mit GetName imselben Tick nur das zurück, was sie selbst reingeschrieben haben.
2) ts.GetGameObject(HelperOID).Nameable.SetName(infostring) für fremde sessions funktioniert im Singleplayer unabhängig von der Session.
 Aber wenn der ausführende Spieler in einer anderen Session als das Objekt ist, dann klappt es nur für ihn selbst! für andere Spieler im MP bleibt der alte Namen bestehen.
 Lösung: setDebugTextSource für die Namensänderung nehmen
3) WICHTIG: wenn es darum geht Informationen über SetName mit anderen Spielern zu teilen, wie in meinen ShareLuaInfo Funktionen,
 dann muss man wissen, dass erst ~3-10 gameticks NACH SetName() dieser Name auch für andere Spieler über GetName bekommbar ist (zeit schwankt stark von PC Leistung und Spielfortschritt!)
  und da es lokal sofort hinterlegt ist, kann man dann auch nicht einfach ein while true coroutine.yield() machen und warten, weil das lokal gesetzte ja sofort da ist
  und einfach 10 yields zu machen dauert und ist nicht 100% sicher.
   (das ist dann ein problem, wenn alle Spieler exakt gleich lange warten müssen, damit desyncende-Commands gleichzeitig ausgeführt werden)
  Selbst im Singleplayer gibt es dieses "synchronisieren" nach SetName, wodurch das passiert: SetName(1), yield, SetName(2) Name==2 , yield, Name==1 yield,yield Name==2
Das bedeudet, dass ShareLuaInfo mindestens 2-4 Sekunden pro Verwendung geblockt sein wird, um sicher zu gehen, dass Name ziwschen allen korrekt gesynced wurde.
 womit es nicht für die allgemeine Verwendung von Jedem genutzt werden kann, zumindest nicht mit derselben HelperOID.

&nbsp;  

***Beispiel***   
Im Multiplayer stellen diese Faktoren nun ernste Probleme da, besonders die Kombination aus:
 Nicht gesynceter Befehl, der nur mit userdata geht und abhängig von einer Verzögerung ist (kommt häufiger vor als man denkt.. Praktisches Beispiel: Wechsel den Besitzer von einem Schiff (beliebiger neuer owner) in lua):
  Hier muss der Befehl für alle lokalen Spieler exakt imselben Tick mit demselben Ergebnis ausgeführt werden, damit es keinen Desync gibt.
   Durch userdata haben wir das Problem, dass dazu alle Peer in derselben Session sein müssen. Die einzige bisher bekannte Lösung ist also, dass wir sie durch einen lua Befehl alle in dieselbe Session zwingen.
    Doch der Sessionwechsel dauert eine zeit lang, eventuell bei jedem Peer einen Tick anders (bin nicht sicher obs die untersch. Dauer je nach Hardware auch in diesem Fall gibt, ist aber möglich). Dh. wir brauchen eine Methode, wie jeder lokale Spieler sicher gehen kann, dass jeder andere Spieler erfolgreich in der Session ist. In diesem Fall gibt es dazu glücklicherweise eine Funktion, bei vielen anderen Dingen gibt es keine Möglichkeit Infos über andere Peers zu erlangen!
   Nur wenn man weiß, welche Peers inaktiv sind, kann man darauf warten, dass alle aktiven Peers die Session erfolgreich gewechselt haben.  

&nbsp;  

----
