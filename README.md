# Hello, world!

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Set Up
- Install [Flutter](https://flutter.dev/docs/get-started/install/windows)
- `Flutter` and `Dart` plugins for **Intellij** and **Andriod Studio**:
  1. Configure > Plugins > Search for `Flutter` and `Dart` and click `Install`
  2. Once completed, restart the IDE
- Install [Git for Windows](https://git-scm.com/download/win)
  1. Download the executable file (.exe) from the above link
  2. Once completed, double-click to run
- Launch **Git for Windows** at any directory you wish and run: 
```linux
git clone https://github.com/alice-0-kim/flutter-app.git
```
- Launch **Andriod Studio** and open cloned directory:
  1. Select Open an existing Andriod Studio project
  2. Select cloned repository to open
  3. Tools > AVD Manager > Create Virtual Device... to create a new virtual device
  4. Click `No device` dropdown to select the newly created virtual device
  ![](20190528093110.png)
  5. Run `main.dart` or press `Shift` + `F10`

## Authentication
- Google
- Troubleshooting
  - People API has not been used in project XXXXXXXXXXXX before or it is disabled
    - Follow the instruction to enable the API
  - PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null)
    - [Related StackOverFlow discussion](https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google)
  - PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 12500: , null)
    - [Related GitHub Issues page](https://github.com/flutter/flutter/issues/25909#issuecomment-497378619)

## Helpful Tutorials
- [How to build an app from scratch](https://medium.com/aviabird/flutter-tutorial-how-to-build-an-app-from-scratch-b88d4e0e10d7)
- [Just enough Dart for Flutter](https://medium.com/thetechnocafe/just-enough-dart-for-flutter-e907b80f4ff4)
