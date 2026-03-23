# patient_project

Una aplicación Flutter para gestión de pacientes.

## Requisitos previos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) >= 3.11.0
- Dart >= 3.11.0
- Android Studio / Xcode (para emuladores)

## Instalación

1. Clona el repositorio:
   ```bash
   git clone <url-del-repositorio>
   cd patient_project
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Genera los archivos de código (freezed, json_serializable):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

## Ejecutar la app

### En un emulador o dispositivo físico

```bash
flutter run
```

### En una plataforma específica

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome

# macOS
flutter run -d macos
```

### Ver dispositivos disponibles

```bash
flutter devices
```

## Build de producción

```bash
# Android (APK)
flutter build apk

# Android (App Bundle)
flutter build appbundle

# iOS
flutter build ios

# Web
flutter build web
```

## Estructura del proyecto

El proyecto sigue Clean Architecture con BLoC como gestor de estado.

- `lib/` — Código fuente principal
- `assets/mock/` — Datos de prueba en formato JSON
