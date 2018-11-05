# xrufix' Mission Functions
Standard mission functions for Arma 3.

## English

### Includes the following components:
* **Addons**: Enable / disable mods features' from multiplayer lobby.
* **AI**: Give AI units custom loadouts using BaerMitUmlaut's Poppy.
* **APS**: Active Protection System for tanks and other vehicles.
* **Misc**: Various functions that should be present in every Mission.
* **Suppress**: Simulated suppression effects on players, both visual and physical.

### How to use:
1. Copy the folder `xru` into your mission folder root.
2. Include `xru\CfgFunctions.hpp` in your `description.ext`'s CfgFunctions-class.
2. Include `xru\params.hpp` in your `description.ext`'s params-class.
3. Include `xru\RscTitles.hpp` in your `description.ext`'s RscTitles-class.

If you want to use only part of the package, comment out the includes inside the above mentioned files and delte the respecting folders. Only deleting the folders will make your game crash!

If you do not know how to use description.ext, [click this link](https://community.bistudio.com/wiki/Description.ext).

### Example `description.ext`-includes:
```
author = "yourName";
onLoadName = "your missions name";
onLoadMission = "your missions description";
overviewText = "your missions description";

class CfgFunctions {
    #include "xru\CfgFunctions.hpp"
};

class params {
    #include "xru\params.hpp"
};
```

## Deutsch

### Enthaltene Komponenten:
* **Addons**: Features bestimmter Mods in der Multiplayerlobby deaktivieren oder aktivieren.
* **AI**: KI-Loadouts und Schwierigkeit anpassen (erfordert BaerMitUmlaut's Poppy).
* **APS**: Aktive Schutzmaßnahmen für Panzer und Fahrzeuge.
* **Misc**: Verschiedene Funktionen, die in einer Mission nützlich sind.
* **Suppress**: Simuliert Unterdrückungseffekte bei Spielern, sowohl visuell als auch physisch.

### How to use:
1. Kopiere den Ordner `xru` in dein Missionsverzeichnis.
2. Inkludiere die Datei `xru\CfgFunctions.hpp` in die CfgFunctions-Klasse deiner `description.ext`.
2. Inkludiere die Datei `xru\params.hpp` in die params-Klasse deiner `description.ext`.
3. Inkludiere die Datei `xru\RscTitles.hpp` in die RscTitles-Klasse deiner `description.ext`.

Wenn du nur manche Teile des Paketes nutzen willst, kommentiere die Includes innerhalb der oben genannten Dateien aus und lösche die entsprechenden Ordner. Die Ordner nur zu löschen wird das Spiel abstürzen lassen!

Wenn du nicht weißt, wie die `description.ext` funktioniert, [folge diesem Link](https://community.bistudio.com/wiki/Description.ext).

### Beispiel für die Includes in der `description.ext`:
```
author = "Dein Name";
onLoadName = "Dein Missionsname";
onLoadMission = "Deine Missionsbeschreibung";
overviewText = "Deine Missionsbeschreibung";

class CfgFunctions {
    #include "xru\CfgFunctions.hpp"
};

class params {
    #include "xru\params.hpp"
};
```
