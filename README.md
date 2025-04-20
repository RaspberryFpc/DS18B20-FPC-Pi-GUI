# DS18B20-FPC-Pi-GUI

Ein Free-Pascal-Projekt (Typhon) zur Anzeige von Temperaturen mehrerer DS18B20-Sensoren auf einem Raspberry Pi mit grafischer Benutzeroberfläche (GUI).

## 🌞 Eigenschaften

- Liest bis zu **8 DS18B20-Sensoren** über GPIO (1-Wire)
- Darstellung der Temperaturen in einer GUI (kein Konsolenprogramm)
- Automatische Aktualisierung der Werte im Sekundentakt
- **Linearisierung** der Sensorwerte zur Reduktion der typischen Nichtlinearität
- Anzeige der Sensor-IDs im Grid

## ⚖️ Technische Details

- Programmiert mit **Free Pascal** unter **Typhon**
- wenn sie Lazarus verwenden dann muss bei einigen Dateien der Suffix geändert werden 
- Entwickelt für **Raspberry Pi** unter **Linux** (nutzt `/sys/bus/w1/devices/...`)
- Keine zusätzlichen Bibliotheken erforderlich (reines FPC-Projekt)
- Sensorwerte werden ca. alle *(Anzahl Sensoren * 1 Sekunde)* aktualisiert (12-bit Auflösung)
- GUI startet automatisch

## 📈 Linearisierung

Die vom Hersteller angegebene Genauigkeit des DS18B20 liegt typischerweise bei **±0,5 °C**. Durch die Verwendung einer polynomialen Korrekturformel, basierend auf den Herstellerdaten, konnte die Abweichung auf **±0,03 °C** reduziert werden.

> Hinweis: Ein **konstanter Offset** kann sensorextern weiterhin erforderlich sein (z. B. zur individuellen Kalibrierung).

## 📷 Screenshots

### Linearisierung in Calc
![Screenshot](https://github.com/RaspberryPiFpcHub/DS18B20-FPC-Pi-GUI/main/DS18B20_temperatur correction.png)

### Beispielanwendung
![Screenshot GUI](screenshots/gui-anzeige.png)

## 🔧 Installation

1. Aktiviere 1-Wire unter `/boot/config.txt`:
   ```
   dtoverlay=w1-gpio
   ```
2. Reboote den Pi.
3. Kompiliere das Projekt mit **Typhon**.
4. Starte die Anwendung (GUI startet automatisch).

Alternativ kannst du auch die grafische Benutzeroberfläche von raspi-config verwenden, um den 1-Wire-Bus zu aktivieren.
Gehe zu den erweiterten Optionen: Wähle die Option Interfacing Options.
Aktiviere den 1-Wire-Bus: Wähle 1-Wire und setze ihn auf Enabled.
Starte den Raspberry Pi neu: Nachdem du den 1-Wire-Bus aktiviert hast, starte den Raspberry Pi neu, um die Änderungen zu übernehmen: 

**Lazarus Kompatibilität:**  
   Bei Verwendung von Lazarus muss der Suffix bei Dateien unter Umständen geändert werden.  
   Insbesondere in der Datei `form1.pas` sollten die Resourcen von `.frm` nach `.lfm` geändert werden.  
   Zudem muss auch die Ressourcendatei selbst (z.B. `form1.frm`) umbenannt werden, sodass sie den gleichen Namen wie die `.pas`-Datei trägt (z.B. `form1.lfm`).

## 📂 Dateien

- `ds18b20.pas`: Low-Level-Kommunikation mit dem Sensor + Linearisierung
- `Form1.pas: GUI-Anwendung
- `screenshots/`: Ordner mit Beispielbildern

## ✨ Lizenz

Dieses Projekt steht unter der MIT-Lizenz. Freie Nutzung, Änderung und Weitergabe erlaubt.

---

> Erstellt von [RaspberryPiFpcHub](https://github.com/RaspberryPiFpcHub)

