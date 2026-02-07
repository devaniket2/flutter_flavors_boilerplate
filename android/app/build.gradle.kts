plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.lonestar.flutter_boilerplate.flutter_flavors_boilerplate"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // app package
        applicationId = "com.lonestar.flutter_boilerplate.flutter_flavors_boilerplate"
        // sdk config
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // adding flavors 
    flavorDimensions += "env"

    productFlavors {
        // qa
        create("qa") {
            dimension = "env"
            applicationIdSuffix = ".qa"
        }
        // prod
        create("prod") {
            dimension = "env"
        }
    }
}

flutter {
    source = "../.."
}
