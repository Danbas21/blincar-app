#!/bin/bash

# Script SIMPLE para generar los APK de las 3 apps de Blincar
# Sin flavors - mismo applicationId, diferentes entry points
# Autor: Blincar Team
# Fecha: 2026-01-08

echo "🚀 Generando APKs de Blincar (versión simple)..."
echo ""
echo "⚠️  IMPORTANTE: Los 3 APKs tendrán el mismo applicationId"
echo "   Solo puedes instalar UNO a la vez en el mismo dispositivo."
echo "   Para la demo, usa 3 dispositivos/emuladores diferentes."
echo ""

# Crear directorio para APKs finales
mkdir -p apks_demo

echo "📱 1/3 Generando APK de CLIENTE..."
echo "   Entry point: lib/main.dart"
flutter build apk --release -t lib/main.dart
if [ $? -eq 0 ]; then
    cp build/app/outputs/flutter-apk/app-release.apk apks_demo/blincar-cliente.apk
    echo "   ✅ APK Cliente generado: apks_demo/blincar-cliente.apk"
else
    echo "   ❌ Error generando APK Cliente"
    exit 1
fi

echo ""
echo "🖥️  2/3 Generando APK de MONITOR..."
echo "   Entry point: lib/main_monitor.dart"
flutter build apk --release -t lib/main_monitor.dart
if [ $? -eq 0 ]; then
    cp build/app/outputs/flutter-apk/app-release.apk apks_demo/blincar-monitor.apk
    echo "   ✅ APK Monitor generado: apks_demo/blincar-monitor.apk"
else
    echo "   ❌ Error generando APK Monitor"
    exit 1
fi

echo ""
echo "🚗 3/3 Generando APK de DRIVER..."
echo "   Entry point: lib/main_driver.dart"
flutter build apk --release -t lib/main_driver.dart
if [ $? -eq 0 ]; then
    cp build/app/outputs/flutter-apk/app-release.apk apks_demo/blincar-driver.apk
    echo "   ✅ APK Driver generado: apks_demo/blincar-driver.apk"
else
    echo "   ❌ Error generando APK Driver"
    exit 1
fi

echo ""
echo "🎉 ¡Todos los APKs generados exitosamente!"
echo ""
echo "📦 Ubicación de los APKs:"
echo "   - Cliente: apks_demo/blincar-cliente.apk"
echo "   - Monitor: apks_demo/blincar-monitor.apk"
echo "   - Driver:  apks_demo/blincar-driver.apk"
echo ""
echo "📊 Tamaños:"
ls -lh apks_demo/*.apk | awk '{print "   - " $9 ": " $5}'
echo ""
echo "📱 Instrucciones de instalación:"
echo "   1. Instala cada APK en un dispositivo/emulador diferente"
echo "   2. O instala uno, pruébalo, desinstálalo, instala otro"
echo ""
echo "   Dispositivo 1: adb -s DEVICE1 install apks_demo/blincar-cliente.apk"
echo "   Dispositivo 2: adb -s DEVICE2 install apks_demo/blincar-monitor.apk"
echo "   Dispositivo 3: adb -s DEVICE3 install apks_demo/blincar-driver.apk"
echo ""
echo "✨ ¡Listo para la demo!"
