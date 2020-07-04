<p align="center">
  <br>
  <img src="Nocturnal/Assets.xcassets/AppIcon.appiconset/Icon-App-256x256@1x.png" alt="icon" height="145">
  <h3 align="center">Nocturnal</h3>
  <p align="center">
    Have more control over your screen at night
  </p>
</p>

### About

Nocturnal is a menu bar app for macOS that allows you to go the extra mile in controlling your display settings to reduce strain on your eyes. It includes darker than dark dimming, Night Shift fine tuning, multi-monitor support, and the ability to turn off TouchBar on Macbook Pro.

<p align="center">
<img src="Docs/Images/Nocturnal-Screenshot.png" alt="icon" height="300">
</p>

### System Requirements

Nocturnal is only supported on macOS Catalina 10.15 or later, and requires one of the computers listed [here](https://support.apple.com/en-us/HT207513#requirements).

### Installation

Download the latest version of Nocturnal from the [GitHub releases page](https://github.com/joshjon/nocturnal/releases).

**Releases are not currently signed with an Apple developer key. To open an unsigned app follow these steps.**

1. Control-click the app icon, then choose Open from the shortcut menu.
2. A dialog box will appear, then click Open.

For more information refer to the offical [Apple support article](https://support.apple.com/en-au/guide/mac-help/mh40616/mac).


### Build and Run

Build Nocturnal's dependencies using carthage and open the project in Xcode.

```bash
carthage bootstrap --platform Mac
open Nocturnal.xcodeproj
```