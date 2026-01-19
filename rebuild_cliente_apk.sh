#!/bin/bash

# Script para regenerar SOLO el APK del Cliente con los cambios de recuperación de viaje
# Autor: Blincar Team
# Fecha: 2026-01-08

echo "🔄 Regenerando APK de Cliente con fix de recuperación de viaje..."
echo ""

# Crear directorio si no existe
mkdir -p apks_demo

echo "🧹 Limpiando build anterior..."
rm -rf build/app/outputs/flutter-apk/

echo ""
echo "📱 Generando APK de CLIENTE..."
flutter build apk --release -t lib/main.dart

if [ $? -eq 0 ]; then
    cp build/app/outputs/flutter-apk/app-release.apk apks_demo/blincar-cliente.apk
    echo ""
    echo "✅ APK Cliente regenerado: apks_demo/blincar-cliente.apk"
    echo ""
    echo "📊 Tamaño:"
    ls -lh apks_demo/blincar-cliente.apk | awk '{print "   " $9 ": " $5}'
    echo ""
    echo "🔧 Cambios incluidos:"
    echo "   ✅ Guarda tripId cuando se crea un viaje"
    echo "   ✅ Recupera viaje activo al abrir la app"
    echo "   ✅ Previene salida accidental con botón back"
    echo "   ✅ Limpia tripId cuando el viaje se completa"
    echo ""
    echo "📱 Para instalar:"
    echo "   adb install -r apks_demo/blincar-cliente.apk"
    echo ""
    echo "✨ ¡Listo! Ahora el viaje no se pierde si sales de la app"
else
    echo "❌ Error generando APK Cliente"
    exit 1
fi
