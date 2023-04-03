# start-flutter
一个 flutter 跨平台脚手架（PC + Mobile），使用原生以及 C++ 混合开发

## flutter 简介
- https://github.com/flutter
- BSD-3-Clause license
- Dart（Skia）
- Google 开源的应用开发框架，支持移动、Web、桌面和嵌入式平台

## Dart 简介
- https://github.com/dart-lang/sdk
- BSD-3-Clause license
- Dart Native：包括一个带有 JIT（即时）编译的 Dart VM 和一个用于生成机器代码的 AOT（提前）编译器
- Dart Web：包括开发时编译器 (dartdevc) 和生产时编译器 (dart2js)
- 保持简洁：继承了许多与 C、Java、JavaScript 及其他语言相同的语句和表达式语法
- 支持：强类型、泛型、异常（throw try-catch）、异步（future async-await）

## 开发环境
- https://flutter.cn/docs/get-started/install
- 下载 flutter 
```bash
git clone https://github.com/flutter/flutter.git -b stable
flutter channel master # 可以切换 master/dev/beta/stable
flutter upgrade # 更新
```
- 配置环境变量 
```bash
export PATH="$PWD/flutter/bin:$PATH"
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```
- VS Code 安装 Flutter 插件运行 `flutter docker`

## 项目配置
- 可以使用 VS Code 插件运行 `flutter create`
- 创建 `launch.json` 并 `F5` 启动



# my_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
