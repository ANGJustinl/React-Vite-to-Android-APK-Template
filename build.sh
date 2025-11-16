#!/bin/bash

# Set the version number here (update for each new release)
NEW_VERSION="0.0.1"
# Convert version number to numeric format (e.g., 0.1.4 becomes 014)
VERSION_CODE=$(echo $NEW_VERSION | sed 's/\.//g')

# Set the app name here
APP_NAME="Health Management Platform"

# Set the app icon directory here (if you want to use custom icons)
# The icon directory should contain: mipmap-hdpi, mipmap-mdpi, mipmap-xhdpi, mipmap-xxhdpi, mipmap-xxxhdpi
# Each directory should contain: ic_launcher.png, ic_launcher_round.png, ic_launcher_foreground.png
ICON_DIR="app-icons"  # Leave empty to skip icon copying

echo "Updating version to: $NEW_VERSION"
echo "App name: $APP_NAME"

# 1. Update version in package.json
echo "Updating version in package.json..."
sed -i "s/\"version\": \"[^\"]*\"/\"version\": \"$NEW_VERSION\"/" package.json

# 2. Remove old android folder
echo "Removing old android folder..."
rm -rf android

# 3. Add Android platform
echo "Adding Android platform..."
npx cap add android

# 4. Build and copy frontend resources
echo "Building and copying frontend resources..."
pnpm build
npx cap copy

# 5. Insert maven repository at line 24 in build.gradle
BUILD_GRADLE="android/build.gradle"
MAVEN_LINE="        maven { url 'https://mirrors.cloud.tencent.com/nexus/repository/maven-public/' }"
sed -i "24i\\$MAVEN_LINE" "$BUILD_GRADLE"

# 6. Update distributionUrl in gradle-wrapper.properties
WRAPPER_PROPERTIES="android/gradle/wrapper/gradle-wrapper.properties"
sed -i "s|^distributionUrl=.*|distributionUrl=https\\://mirrors.cloud.tencent.com/gradle/gradle-8.11.1-all.zip|" "$WRAPPER_PROPERTIES"

# 7. Update Android app version to match specified version
echo "Updating Android app version..."
APP_BUILD_GRADLE="android/app/build.gradle"
# Replace versionCode
sed -i "s/versionCode [0-9]*/versionCode $VERSION_CODE/" "$APP_BUILD_GRADLE"
# Replace versionName
sed -i "s/versionName \"[^\"]*\"/versionName \"$NEW_VERSION\"/" "$APP_BUILD_GRADLE"

# 8. Update app name
echo "Updating app name..."
STRINGS_XML="android/app/src/main/res/values/strings.xml"
# Replace app name
sed -i "s/<string name=\"app_name\">[^<]*<\/string>/<string name=\"app_name\">$APP_NAME<\/string>/" "$STRINGS_XML"
sed -i "s/<string name=\"title_activity_main\">[^<]*<\/string>/<string name=\"title_activity_main\">$APP_NAME<\/string>/" "$STRINGS_XML"

# 9. Copy app icons (if icon directory is set)
if [ -n "$ICON_DIR" ] && [ -d "$ICON_DIR" ]; then
    echo "Copying app icons..."
    # Copy main icons
    for dir in mipmap-hdpi mipmap-mdpi mipmap-xhdpi mipmap-xxhdpi mipmap-xxxhdpi; do
        if [ -d "$ICON_DIR/$dir" ]; then
            echo "Copying icons for $dir..."
            cp "$ICON_DIR/$dir/ic_launcher.png" "android/app/src/main/res/$dir/" 2>/dev/null || true
            cp "$ICON_DIR/$dir/ic_launcher_round.png" "android/app/src/main/res/$dir/" 2>/dev/null || true
            cp "$ICON_DIR/$dir/ic_launcher_foreground.png" "android/app/src/main/res/$dir/" 2>/dev/null || true
        fi
    done
else
    echo "Skipping icon copy (icon directory not set or does not exist)"
fi

# 10. Build APK in android directory
echo "Building APK..."
cd android
./gradlew assembleDebug

echo "Build complete!"
echo "Version: $NEW_VERSION"
echo "App name: $APP_NAME"