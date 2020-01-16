<p align="center">
  <br>
  <img src="Nocturnal/Assets.xcassets/AppIcon.appiconset/Icon-App-256x256@1x.png" alt="icon" height="145">
  <h3 align="center">Nocturnal</h3>
  <p align="center">
    Have more control over your screen at night
  </p>
</p>

### About

Nocturnal is a menu bar app for macOS that allows you to go the extra mile in controlling your display settings to reduce strain on your eyes. It includes darker than dark dimming, Night Shift fine tuning, and the ability to disable for custom time periods.

<p align="center">
<img src="Docs/Images/Nocturnal-Screenshot.png" alt="icon" height="300">
</p>

### System requirements

Nocturnal is currently only supported on macOS Catalina 10.15 or later and requires one of the computers listed [here](https://support.apple.com/en-us/HT207513#requirements).

### Installation

Download the latest version of Nocturnal from the [GitHub releases page](https://github.com/joshjon/nocturnal/releases).

### Troubleshooting

* 'Nocturnal can't be opened because Apple cannot check it for malicious software'

  Solution: right-click Nocturnal.app and press 'Open', a pop-up will appear, and then click 'open' again

### Built with

- [Xcode 11.3](https://developer.apple.com/xcode/)
- [Swift 5](https://developer.apple.com/swift/)
- [Carthage](https://github.com/Carthage/Carthage) (dependency manager)
- [LaunchAtLogin ](https://github.com/sindresorhus/LaunchAtLogin) (framework)
- [CoreBrightness](https://github.com/w0lfschild/macOS_headers/tree/master/macOS/PrivateFrameworks/CoreBrightness/515) (private framework)

### Building and running

Nocturnal uses Carthage. Before building in Xcode run:

    $ carthage bootstrap --platform Mac

Once Carthage has finished Building Nocturnal's dependencies open the Xcode project:

    $ open Nocturnal.xcodeproj

After Xcode finishes loading the workspace press ⌘R to run Nocturnal.

### License

Distributed under the MIT License. See LICENSE for more information.

---

### Author

Joshua Jon<br>
GitHub: https://github.com/joshjon
