# Natura Design System for iOS

[![Build Status](https://travis-ci.org/natura-cosmeticos/natds-ios.svg)](https://travis-ci.org/natura-cosmeticos/natds-ios)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/NatDS.svg)](https://img.shields.io/cocoapods/v/NatDS.svg)


## What for
Library with iOS components defined by [Natura Group Design System Team](https://zeroheight.com/25ddaa7f8/p/07a27e).


## Tech Stack
- __Swift 5__
- Supports iOS __9__ to __13__
- CocoaPods
- Fastlane
- Bitrise (CI)
- Travis (CI)
- Git-LFS (https://git-lfs.github.com/)
- Swiftlint

## Dependecies
- [Xcode 11.3](https://download.developer.apple.com/Developer_Tools/Xcode_11.3/Xcode_11.3.xip)
- Homebrew
- Ruby 2.6.5
- Bundler
- [Git-LFS](https://git-lfs.github.com/)

---
## Before open the project ##
  Intalling dependencies:

1. Install project dependencies:  
   ```
   make setup
   ```
3. ## Natura employees only:  
   OBS: Before execute this line, call System Team to request requiried credentials.

   ```
   make install_certificates
   ```  

4. Done! Open project on Xcode using _.xcworkspace_

---

### Using CocoaPods

Add the following line to your Podfile:
```ruby
  pod 'NatDS'
```

## Sample
We have provided a sample project in the repository. To use it download the repo, run pod install to download the required libraries and open NatDS.xcworkspace. You'll see two schemes: NatDS and NatDS-SampleApp - select the NatDS-Sample and then build & run! Source files for these are in the NatDS-SamppleApp/Sources directory in project navigator.

## How to contribute
You can contribute submitting [pull requests](https://github.com/natura-cosmeticos/natds-ios/pulls).

### Automated Tests
- We are using screenshot tests with [iOSSnapshotTestCase](https://github.com/uber/ios-snapshot-test-case) to validate our built components state, color and behavior.