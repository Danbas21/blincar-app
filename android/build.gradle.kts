// android/build.gradle.kts

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // 🔥 ANDROID GRADLE PLUGIN 8.9.1
        classpath("com.android.tools.build:gradle:8.9.1")
        // 🔥 KOTLIN 2.1.0
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.1.0")
        // 🔥 GOOGLE SERVICES (Firebase)
        classpath("com.google.gms:google-services:4.4.2")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = file("../build")

subprojects {
    project.buildDir = file("${rootProject.buildDir}/${project.name}")
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}