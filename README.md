# DART JOBS
[![Build & Deploy](https://github.com/PlugFox/dart-jobs/actions/workflows/build-and-deploy.yml/badge.svg?branch=master)](https://github.com/PlugFox/dart-jobs/actions/workflows/build-and-deploy.yml)
[![Effective Dart](https://img.shields.io/badge/Style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![License: Proprietary](https://img.shields.io/badge/License-proprietary-red.svg)](https://en.wikipedia.org/wiki/Proprietary_software)
[![Localizely](https://img.shields.io/badge/Localizely-projects-ab47bc.svg)](https://app.localizely.com/projects/)
[![Firebase](https://img.shields.io/badge/Firebase-overview-blue.svg)](https://console.firebase.google.com/u/0/project/dart-job/overview)
[![PWA](https://img.shields.io/badge/Application-Progressive_Web_App-brightgreen.svg)](https://dart-jobs.plugfox.dev)
---



### Генерация `keystore.jks`

Windows
```bash
keytool -genkey -v -keystore ~/android/keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 50000 -alias release
```

Mac
```bash
keytool -genkey -v -keystore ~/android/keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 50000 -alias release
```


### Получить информацию из `keystore.jks`

Debug
```bash
keytool -list -v -keystore ~/.android/debug.keystore.jks -alias androiddebugkey -storepass android -keypass android 
```

Release
```bash
keytool -list -v -keystore ./android/keystore.jks -alias release
```


### Сборка приложения под андроид

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter build apk --release --no-pub --shrink --target-platform android-arm,android-arm64,android-x64
adb install build\app\outputs\flutter-apk\app-release.apk
```


### Сборка приложения под веб

HTML renderer:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter build web --no-pub --release --no-source-maps --tree-shake-icons --pwa-strategy offline-first --web-renderer html
```

CanvasKit renderer:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter build web --no-pub --release --no-source-maps --tree-shake-icons --pwa-strategy offline-first --web-renderer canvaskit --dart-define=FLUTTER_WEB_USE_SKIA=true
```


### Публикация в firebase

Serve
```bash
firebase login
cd build/web
firebase serve --project "f-o-x-y"
```

Develop preview
```bash
firebase login
cd build/web
firebase hosting:channel:deploy CHANNEL_NAME --project "f-o-x-y"
```

Production
```bash
firebase login
cd build/web
firebase deploy --only hosting --project "f-o-x-y" -m "<Описание ручного релиза>"
```


### Сбор аналитики с помощью adb и top

`adb shell top -m 50 | grep dev.plugfox.dart-jobs`  
  
  