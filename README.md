# Issue
1. jump to flutter page from webview then the webview white all the time.
2. jump to flutter page from webview then the Slider to webview white splash.


# When
Only repoduce on ios, especially when first open app or after clean cache.

# Reproduce video

https://github.com/ahyangnb/blinking_webview_demo/blob/main/RPReplay_Final1745393942.MP4


# Env
Flutter 3.29.3

```
flutter doctor -v
[✓] Flutter (Channel stable, 3.29.3, on macOS 14.6 23G5061b darwin-x64, locale en-CN) [859ms]
    • Flutter version 3.29.3 on channel stable at /Users/q1/fvm/versions/3.29.3
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision ea121f8859 (12 days ago), 2025-04-11 19:10:07 +0000
    • Engine revision cf56914b32
    • Dart version 3.7.2
    • DevTools version 2.42.3
    • Pub download mirror https://pub-web.flutter-io.cn
    • Flutter download mirror https://storage.flutter-io.cn

[✓] Android toolchain - develop for Android devices (Android SDK version 35.0.0) [7.3s]
    • Android SDK at /Users/q1/android-sdk-macosx
    • Platform android-35, build-tools 35.0.0
    • Java binary at: /Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin/java
      This JDK is specified in your Flutter configuration.
      To change the current JDK, run: `flutter config --jdk-dir="path/to/jdk"`.
    • Java version Java(TM) SE Runtime Environment (build 17.0.10+11-LTS-240)
    • All Android licenses accepted.

[!] Xcode - develop for iOS and macOS (Xcode 16.2) [3.4s]
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 16C5032a
    ! CocoaPods 1.15.2 out of date (1.16.2 is recommended).
        CocoaPods is a package manager for iOS or macOS platform code.
        Without CocoaPods, plugins will not work on iOS or macOS.
        For more info, see https://flutter.dev/to/platform-plugins
      To update CocoaPods, see https://guides.cocoapods.org/using/getting-started.html#updating-cocoapods

[✓] Chrome - develop for the web [44ms]
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2024.2) [42ms]
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 21.0.4+-12422083-b607.1)

[✓] VS Code (version 1.99.0) [38ms]
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.108.0

[✓] Connected device (5 available) [9.6s]
    • Redmi 8A (mobile)                  • 14cf44340706              • android-arm    • Android 10 (API 29)
    • qqqqqqq1iPhone (wireless) (mobile) • 00008030-000171CE1168802E • ios            • iOS 18.2 22C152
    • 挽风 (wireless) (mobile)             • 00008130-0001751801F2001C • ios            • iOS 17.5.1 21F90
    • macOS (desktop)                    • macos                     • darwin-x64     • macOS 14.6 23G5061b
      darwin-x64
    • Chrome (web)                       • chrome                    • web-javascript • Google Chrome
      135.0.7049.96

[✓] Network resources [837ms]
    • All expected network resources are available.

! Doctor found issues in 1 category.
 ```