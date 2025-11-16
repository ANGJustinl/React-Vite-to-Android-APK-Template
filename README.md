# React-Vite-to-Android-APK-Template

# 📱 Convert Your React Vite App into an Android App | [中文Readme](README-zh.md)

Welcome! 🚀 This guide will walk you through converting your **React Vite web app** into a fully functional Android app using **Capacitor** and **Android SDK**. Whether you're a beginner or a pro, this guide has you covered! Let's turn your website into an app. 🎉

---

## 🚀 One-Click Build Script (Recommended)

You can use the `build.sh` script in this repository to automate all steps:

> **Note: Before running the script for the first time, please complete the following preparations:**
>
> 1. Install Capacitor dependencies:
>    ```bash
>    pnpm install @capacitor/core @capacitor/cli
>    ```
> 2. Build your frontend project:
>    ```bash
>    pnpm build
>    ```
> 3. Initialize Capacitor:
>    ```bash
>    npx cap init
>    ```
>    Fill in your app name and unique App ID as prompted.

1. Make the script executable:
```bash
chmod +x build.sh
```

2. Run the script:
```bash
./build.sh
```

The script will automatically:
- Update version number and app name
- Delete old `android/` directory and re-add Android platform
- Build and copy frontend resources
- Automatically insert domestic maven mirrors
- Configure gradle domestic mirrors
- Build Debug APK

You can modify these variables at the top of the script:
- `NEW_VERSION`: Set the app version number
- `APP_NAME`: Set the app name
- `ICON_DIR`: Set custom icon directory (optional)

---

### 📖 Script Usage Guide

**Step 1:** Open `build.sh` in your editor.  
**Step 2:** Edit the following variables at the top of the script as needed:
- `NEW_VERSION` — set your app version (e.g. `"1.0.0"`)
- `APP_NAME` — set your app name (e.g. `"MyApp"`)
- `ICON_DIR` — set your custom icon directory (optional)

**Step 3:** Save the file.

**Step 4:** In your terminal, run:
```bash
chmod +x build.sh
./build.sh
```

**Step 5:** After the script finishes, your APK will be generated at:
```
android/app/build/outputs/apk/debug/app-debug.apk
```

You can now install this APK on your Android device.

---

## 🛠️ Prerequisites
Before starting, make sure you have the following installed:
- **Node.js** and **pnpm** (recommended) or **npm**
- A **React Vite project** ready to go
- **Android SDK** installed on your system
- A connected Android device or emulator

---

## 📋 Step-by-Step Guide

### 1️⃣ **Install Capacitor in Your React Vite Project**
Open your terminal in the project folder and run:
```bash
pnpm install @capacitor/core @capacitor/cli
```
This installs Capacitor's core, CLI tools, and Android platform support.

### 2️⃣ **Build Your Project for Production**
Generate the production-ready files:
```bash
pnpm build
```
This creates a `dist` folder containing your web app files.

### 3️⃣ **Initialize Capacitor**
Add Capacitor to your project:
```bash
npx cap init
```
It will ask for:
- **App Name**: Give your app a name (e.g., "MyApp").
- **App ID**: Use a unique ID (e.g., `com.example.myapp`).

### 4️⃣ **Add the Android Platform**
Add Android as the platform:
```bash
npx cap add android
```
You should now see an `android` folder in your project directory.

### 5️⃣ **Copy Your Build Files to Android**
Copy your `dist` folder to the Android project:
```bash
npx cap copy
```

### 6️⃣ **Configure Domestic Mirrors (Optional but Recommended)**
To improve build speed, it's recommended to configure domestic mirrors:

1. Edit `android/build.gradle`, add to repositories block:
```gradle
maven { url 'https://mirrors.cloud.tencent.com/nexus/repository/maven-public/' }
```

2. Edit `android/gradle/wrapper/gradle-wrapper.properties`, modify distributionUrl:
```properties
distributionUrl=https\://mirrors.cloud.tencent.com/gradle/gradle-8.11.1-all.zip
```

---

## ⚙️ Building the APK with Command Line (Manual Process)

If you prefer to build manually or need more control over the process:

### 7️⃣ **Build the APK using Gradle**
1. Navigate to the android directory:
```bash
cd android
```

2. Build the debug APK:
```bash
./gradlew assembleDebug
```

3. For a release APK (requires signing configuration):
```bash
./gradlew assembleRelease
```

### 8️⃣ **Find and Install the APK**
1. The APK will be located at:
   - Debug: `android/app/build/outputs/apk/debug/app-debug.apk`
   - Release: `android/app/build/outputs/apk/release/app-release.apk`

2. Transfer the generated APK to your phone via USB or cloud storage.

3. Install the APK by opening it on your phone (you may need to enable "Install from unknown sources" in your phone settings).

---

## 📱 Using the App on Your Phone
1. After installation, go to your phone's **App Drawer** (list of all apps).
2. Search for your app by the name you provided in Step 3.
3. Open it and enjoy your app on mobile! 🎉

---

## 🐛 Common Errors and Fixes

### ❌ **Error: Gradle build fails**
**Fix**: Ensure Android SDK is properly installed and configured in your environment variables.

### ❌ **App not visible after installation**
**Fix**: Ensure the `AndroidManifest.xml` file has the correct intent filters:
```xml
<intent-filter>
    <action android:name="android.intent.action.MAIN" />
    <category android:name="android.intent.category.LAUNCHER" />
</intent-filter>
```

### ❌ **Build issues with dependencies**
**Fix**: Make sure you've copied the `dist` folder correctly and run `npx cap sync` after any changes.

### ❌ **Slow dependency download/failure**
**Fix**: Ensure you've configured domestic maven mirrors as shown in Step 6.

### ❌ **Signing related errors**
**Fix**: Debug builds don't require signing. Release builds need signing configuration in `build.gradle`.

---

## 🎉 Final Thoughts
Congratulations! 🎊 You've successfully converted your React Vite app into an Android app. This guide ensures you can build, install, and run your app without any hiccups.

---

## 🙏 Special Thanks

This document is based on [React-Vite-to-Android-APK-Guide](https://github.com/prathmesh-sargar/-React-Vite-to-Android-APK-Guide) and has been modified for users without gui and android studio. Special thanks to the original author for providing the excellent basic tutorial.

---

## 📚 Reference Links

- [Capacitor Official Documentation](https://capacitorjs.com/docs)
- [Vite Official Documentation](https://vitejs.dev/)
- [Gradle Mirror Configuration](https://developer.aliyun.com/mvn/guide)

---