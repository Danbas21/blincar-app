// android/app/build.gradle.kts

import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // 🔥 GOOGLE SERVICES (Firebase)
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

// 🔐 Cargar key.properties para firma de release
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.blincar.app"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        // 🔥 DESUGARING HABILITADO (Requerido por flutter_local_notifications)
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    // 🔐 Configuracion de firma
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    defaultConfig {
        applicationId = "com.blincar.app"
        minSdk = 24
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // 🔥 MULTIDEX HABILITADO
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // 🔥 CORE LIBRARY DESUGARING (Requerido)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // 🔥 MULTIDEX
    implementation("androidx.multidex:multidex:2.0.1")

    // 💳 MATERIAL COMPONENTS (Requerido por Stripe)
    implementation("com.google.android.material:material:1.12.0")
    implementation("com.google.android.gms:play-services-wallet:19.3.0")
    // Firebase BOM (Bill of Materials) - Gestiona versiones automáticamente
    implementation(platform("com.google.firebase:firebase-bom:33.7.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-database")
    implementation("com.google.firebase:firebase-storage")
    implementation("com.google.firebase:firebase-messaging")
}