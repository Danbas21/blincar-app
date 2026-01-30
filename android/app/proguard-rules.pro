# ============================================
# BLINCAR APP - PROGUARD RULES
# ============================================
# Configuración de ofuscación y optimización para release

# ============================================
# FLUTTER CORE
# ============================================
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# ============================================
# FIREBASE
# ============================================
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses

# Firebase Auth
-keep class com.google.firebase.auth.** { *; }
-keep class com.google.android.gms.auth.** { *; }

# Firebase Database
-keep class com.google.firebase.database.** { *; }

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }

# ============================================
# STRIPE
# ============================================
-keep class com.stripe.android.** { *; }
-keep class com.reactnativestripesdk.** { *; }
-keep class com.flutter.stripe.** { *; }
-dontwarn com.stripe.android.pushProvisioning.**

# ============================================
# GOOGLE PLAY SERVICES
# ============================================
-keep class com.google.android.gms.common.** { *; }
-keep class com.google.android.gms.location.** { *; }
-keep class com.google.android.gms.maps.** { *; }

# Google Play Core (deferred components)
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# ============================================
# SECURITY - OFUSCACIÓN ADICIONAL
# ============================================

# Ofuscar nombres de clases de la app
-repackageclasses 'b'
-allowaccessmodification

# Optimizaciones agresivas
-optimizationpasses 5
-dontusemixedcaseclassnames
-verbose

# Remover logs en release (SEGURIDAD)
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# Remover System.out en release
-assumenosideeffects class java.io.PrintStream {
    public void println(...);
    public void print(...);
}

# ============================================
# MANTENER ELEMENTOS CRÍTICOS
# ============================================

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Keep Parcelables
-keepclassmembers class * implements android.os.Parcelable {
    static ** CREATOR;
}

# Keep Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep custom exceptions
-keep public class * extends java.lang.Exception

# ============================================
# ANNOTATIONS
# ============================================
-keepattributes RuntimeVisibleAnnotations
-keepattributes RuntimeInvisibleAnnotations
-keepattributes RuntimeVisibleParameterAnnotations
-keepattributes RuntimeInvisibleParameterAnnotations

# Keep JsonSerializable annotations
-keep class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# ============================================
# CRYPTO / SEGURIDAD
# ============================================
-keep class javax.crypto.** { *; }
-keep class java.security.** { *; }
-keep class org.bouncycastle.** { *; }
-dontwarn org.bouncycastle.**

# ============================================
# HTTP / NETWORKING
# ============================================
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

# ============================================
# WARNINGS SUPRIMIDOS
# ============================================
-dontwarn java.lang.invoke.**
-dontwarn javax.annotation.**
-dontwarn kotlin.**
-dontwarn kotlinx.**
