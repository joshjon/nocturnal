Details about this file’s format at <http://keepachangelog.com/>. The change log is parsed automatically when minting releases through Fastlane, see `Fastlane/Fastfile`.

## [Unreleased]

## [2.4.0] - 2019-06-11

- Use properly typedef’d enumerations to improve Swift syntax [Tony Arnold]
- Fix return from a NSToolTip method that expects a non-null return value [Tony Arnold]
- Brazilian Portuguese localization [vitu]
- `kVK_ANSI_KeypadMinus` fixes [Vyacheslav Dubovitsky]
- Swedish localization [Pavel Kozárek]
- Provide intrinsicContenSize to improve compatibility with autolayout [Fletcher T. Penney]
- Allow app extension API only for the framework target [zoul]
- Make it possible to turn off shortcut validation [zoul]
- Use more specific types for -keyCode and -modifierFlags [zoul]
- Use NSEvent constants instead of hard-coded numbers [zoul]

## [2.3.6] - 2016-10-30
- Improve compatibility with the 10.12 SDK [thanks to Clemens Schulz]

## [2.3.5] - 2016-9-7
- Improve Italian localization [zoul]

## [2.3.4] - 2016-8-12
- Simplified and traditional Chinese localization [MichaelRow]
- Add Korean, Dutch, Polish, Russian & update Spanish localizations [Radek Pietruszewski]
- Improved German localization [Florian Schliep]
- Add a Makefile to improve command-line building [sfsam]

## [2.3.3] - 2016-1-9
- Improved Japanese localization [oreshinya]
- Improved Frech localization [magiclantern]
- Fixed CocoaPods localization with `use_frameworks!` [nivanchikov]

## [2.3.2] - 2015-10-12
- Fixed localization when building through CocoaPods [Allan Beaufour]

## [2.3.1] - 2015-9-10
- Trying to work around a strange build error in CocoaPods.

## [2.3.0] - 2015-9-10
- Basic localization support for Czech, German, Spanish, Italian, French, and Japanese. Native speaking testers welcome!

## [2.2.0] - 2015-8-18
- Basic accessibility support [starkos]
- Added an option to hide the shortcut delete button [oreshinya]
- Advertised support for Carthage [Tom Brown]
- Bugfix for shortcuts not working after set twice [Roman Sokolov]
- Ignore a solo Tab key when recording shortcuts [Roman Sokolov]

## [2.1.2] - 2015-1-28
- Better key equivalent handling for non-ASCII layouts. [Dmitry Obukhov]

## [2.1.1] - 2015-1-16
- Another headerdoc fix for CocoaDocs, hopefully the last one.

## [2.1.0] - 2015-1-16
- Added support for older OS X versions down to 10.6 included.
- Headerdoc markup that plays better with CocoaDocs.

## [2.0.1] - 2015-1-9
- Trivial Podspec fix.

## [2.0.0] - 2015-1-9
- First version with a changes file :)
- Major, backwards incompatible refactoring to simplify long-term maintenance.
- Added a simple spec describing the recording behaviour.
- Adds compatibility mode with Shortcut Recorder.
