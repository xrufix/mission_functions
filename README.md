# xrufix' Mission Functions
Standard mission functions for Arma 3.

## English

### Includes the following components:
* **Addons**: Set some mod specific standards.
* **AI**: Improve AI detection and sharing of players.
* **doSuppress**: Let's AI Units suppress target positions or players inside an area.
* **Misc**: Various functions that should be present in every Mission.

### How to use:
1. Copy the folder `xru` into your mission folder root.
2. Include `xru\CfgFunctions.hpp` in your `description.ext`'s CfgFunctions-class.
2. Include `xru\params.hpp` in your `description.ext`'s params-class.

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
* **Addons**: Einige modspezifische Standardeinstellungen.
* **AI**: Verbessert Erkennung von Spielern und Teilen von Informationen durch KI.
* **doSuppress**: Lässt KI ein Gebiet oder Spieler innerhalb eines Gebiets unterdrücken.
* **Misc**: Verschiedene Funktionen, die in einer Mission nützlich sind.

### Anleitung:
1. Kopiere den Ordner `xru` in dein Missionsverzeichnis.
2. Inkludiere die Datei `xru\CfgFunctions.hpp` in die CfgFunctions-Klasse deiner `description.ext`.
2. Inkludiere die Datei `xru\params.hpp` in die params-Klasse deiner `description.ext`.

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
