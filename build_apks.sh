#!/bin/bash

# Script para generar los APK de las 3 apps de Blincar
# Autor: Blincar Team
# Fecha: 2026-01-08

echo "🚀 Generando APKs de Blincar..."
echo ""

# Limpiar builds anteriores
echo "🧹 Limpiando builds anteriores..."
flutter clean
flutter pub get

# Crear directorio para APKs finales
mkdir -p apks_final

echo ""
echo "📱 Generando APK de CLIENTE..."
flutter build apk --release --flavor cliente -t lib/main.dart
cp build/app/outputs/flutter-apk/app-cliente-release.apk apks_final/blincar-cliente.apk
echo "✅ APK Cliente generado: apks_final/blincar-cliente.apk"

echo ""
echo "🖥️  Generando APK de MONITOR..."
flutter build apk --release --flavor monitor -t lib/main_monitor.dart
cp build/app/outputs/flutter-apk/app-monitor-release.apk apks_final/blincar-monitor.apk
echo "✅ APK Monitor generado: apks_final/blincar-monitor.apk"

echo ""
echo "🚗 Generando APK de DRIVER..."
flutter build apk --release --flavor driver -t lib/main_driver.dart
cp build/app/outputs/flutter-apk/app-driver-release.apk apks_final/blincar-driver.apk
echo "✅ APK Driver generado: apks_final/blincar-driver.apk"

echo ""
echo "🎉 ¡Todos los APKs generados exitosamente!"
echo ""
echo "📦 Ubicación de los APKs:"
echo "   - Cliente: apks_final/blincar-cliente.apk"
echo "   - Monitor: apks_final/blincar-monitor.apk"
echo "   - Driver:  apks_final/blincar-driver.apk"
echo ""
echo "📊 Tamaños:"
ls -lh apks_final/*.apk | awk '{print "   - " $9 ": " $5}'
echo ""
echo "✨ ¡Listo para instalar en dispositivos!"
