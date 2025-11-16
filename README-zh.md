# React-Vite-to-Android-APK-Template

# 📱 将你的 React Vite 应用快速转换为 Android APK

欢迎！🚀 本指南将带你一步步将 **React Vite 网页应用** 转换为可安装的 Android 应用（APK），无需 Android Studio 图形界面，只需命令行即可完成全部流程。

---

## 🛠️ 环境准备

请确保已安装：
- **Node.js** 和 **pnpm**（推荐）或 **npm**
- 一个已准备好的 **React Vite 项目**
- 已安装 **Android SDK**
- 已连接的 Android 设备或模拟器

---

## 🚀 一键打包脚本（推荐）

你可以使用仓库中的 `build.sh` 一键脚本自动完成所有步骤：

> **注意：首次使用脚本前，请先完成以下准备工作：**
>
> 1. 安装 Capacitor 依赖：
>    ```bash
>    pnpm install @capacitor/core @capacitor/cli
>    ```
> 2. 构建前端项目：
>    ```bash
>    pnpm build
>    ```
> 3. 初始化 Capacitor：
>    ```bash
>    npx cap init
>    ```
>    按提示填写应用名称和唯一 App ID。

1. 赋予脚本执行权限：
```bash
chmod +x build.sh
```

2. 运行脚本：
```bash
./build.sh
```

脚本会自动完成：
- 更新版本号和应用名称
- 删除旧的 `android/` 目录并重新添加 Android 平台
- 构建并复制前端资源
- 自动插入国内 maven 镜像
- 配置 gradle 国内镜像
- 构建 Debug APK

你可以在脚本顶部修改这些变量：
- `NEW_VERSION`：设置应用版本号
- `APP_NAME`：设置应用名称
- `ICON_DIR`：自定义图标目录（可选）

---

### 📖 脚本使用教程

**步骤 1：** 用编辑器打开 `build.sh`  
**步骤 2：** 根据需要修改顶部变量：
- `NEW_VERSION` — 设置版本号（如 `"1.0.0"`）
- `APP_NAME` — 设置应用名称（如 `"MyAPP"`）
- `ICON_DIR` — 设置自定义图标目录（可选）

**步骤 3：** 保存文件

**步骤 4：** 在终端运行：
```bash
chmod +x build.sh
./build.sh
```

**步骤 5：** 脚本执行完毕后，APK 文件会生成在：
```
android/app/build/outputs/apk/debug/app-debug.apk
```

你可以将 APK 安装到 Android 设备上。

---

## 📋 手动打包流程

如需手动操作或更细致控制：

1. 安装 Capacitor 依赖：
```bash
pnpm install @capacitor/core @capacitor/cli
```

2. 构建前端项目：
```bash
pnpm build
```

3. 初始化 Capacitor：
```bash
npx cap init
```
根据提示填写应用名称和唯一 App ID。

4. 添加 Android 平台：
```bash
npx cap add android
```

5. 复制构建文件到 Android 项目：
```bash
npx cap copy
```

6. 配置国内镜像（推荐）：
- 编辑 `android/build.gradle`，在 repositories 块添加：
```gradle
maven { url 'https://mirrors.cloud.tencent.com/nexus/repository/maven-public/' }
```
- 编辑 `android/gradle/wrapper/gradle-wrapper.properties`，修改 distributionUrl：
```properties
distributionUrl=https\://mirrors.cloud.tencent.com/gradle/gradle-8.11.1-all.zip
```

7. 构建 APK：
```bash
cd android
./gradlew assembleDebug
```

8. APK 文件位置：
- Debug: `android/app/build/outputs/apk/debug/app-debug.apk`
- Release: `android/app/build/outputs/apk/release/app-release.apk`

---

## 📱 手机安装与使用

1. 将 APK 文件传到手机
2. 打开 APK 文件安装（如遇安全提示请允许“未知来源”安装）
3. 在应用列表找到你的应用并打开

---

## 🐛 常见问题与解决方法

- **Gradle 构建失败**  
  检查 Android SDK 是否正确安装并配置环境变量

- **安装后找不到应用**  
  检查 `AndroidManifest.xml` 是否包含正确的 intent-filter

- **依赖下载慢或失败**  
  按上述方法配置国内 maven 镜像

- **签名相关错误**  
  Debug 构建无需签名，Release 构建需在 `build.gradle` 配置签名

---

## 🎉 结语

恭喜你！🎊 现在你已经可以将 React Vite 应用快速打包为 Android APK 并安装到手机上。

---

## 🙏 致谢

本教程参考自 [React-Vite-to-Android-APK-Guide](https://github.com/prathmesh-sargar/-React-Vite-to-Android-APK-Guide)，并针对无 GUI 和 Android Studio 用户做了优化，感谢原作者的优秀教程。

---

## 📚 参考链接

- [Capacitor 官方文档](https://capacitorjs.com/docs)
- [Vite 官方文档](https://vitejs.dev/)
- [Gradle 镜像配置](https://developer.aliyun.com/mvn/guide)

---