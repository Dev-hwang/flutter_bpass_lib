# flutter_bpass_lib

B PASS 모바일 앱과 연동되어 사용자 인증을 수행할 수 있도록 도와주는 플러그인 입니다.

## Getting Started

To use this plugin, add `flutter_bpass_lib` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). For example:

```yaml
dependencies:
  flutter_bpass_lib:
    git:
      url: https://github.com/Dev-hwang/flutter_bpass_lib.git
      ref: master
```

### :baby_chick: Android

1. 프로젝트의 android 폴더를 열고 아래와 같이 bpass-sdk 폴더를 생성하세요.

![folder_struct](https://user-images.githubusercontent.com/47127353/150471560-c4730c0d-6eae-418f-bc83-33c345f733c0.png)

2. bpass-dsk 폴더에 다운로드한 aar 파일을 넣고 `build.gradle` 파일을 작성하세요.

```
configurations.maybeCreate("default")
artifacts.add("default", file('BPassSDK-Android-0.6.1.aar'))
```

3. `settings.gradle` 파일을 열어서 위에서 추가한 폴더를 include 해주세요.

```
include ':app', ':bpass-sdk'
```

4. `AndroidManifest.xml` 파일을 열고 필요 권한 및 메타 데이터를 설정해주세요.

```xml
<manifest>
    <!-- 필요 권한 -->
    <uses-permission android:name="android.permission.INTERNET" />

    <application>
        <!-- 발급받은 service id 설정 -->
        <meta-data android:name="BPASS_SERVICE_ID" android:value="..." />

        <!-- 발급받은 secret key 설정 -->
        <meta-data android:name="BPASS_SECRET" android:value="..." />

        <!-- 인증 서버 도메인 설정 (개발: bauth.mykeepin.com, 운영: auth.blockchainbusan.kr) -->
        <meta-data
            android:name="BPASS_AUTH_SERVER_DOMAIN"
            android:value="auth.blockchainbusan.kr" />
    </application>
</manifest>
```

### :baby_chick: iOS

1. Xcode에서 BusanKeepinSDK.framework를 추가해 주세요.

![step_1](https://user-images.githubusercontent.com/47127353/178185879-443b6634-f5c8-4e3b-a739-3d79c68c0489.png)

2. Runner의 General 탭에서 BusanKeepinSDK.framework를 추가해 주세요.

![step_2](https://user-images.githubusercontent.com/47127353/178185937-fd11ef4a-be44-4dd9-9338-1884acf3fd9c.png)

3. Runner의 `Info.plist` 파일을 열고 Service ID, Secret Key, URL scheme를 설정해 주세요.

![step_3](https://user-images.githubusercontent.com/47127353/178186524-5f42aa96-9b18-4e32-b06d-c6324413676b.png)

4. SP 등록 시에 부여받은 URL scheme를 설정해 주세요.

![step_4](https://user-images.githubusercontent.com/47127353/178186523-3e88e1d9-0aac-4904-9d58-33c7af4288f4.png)

5. 인증 서버와 통신하기 위해 아래 키를 추가해 주세요.

```text
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    <key>NSAllowsArbitraryLoadsInWebContent</key>
    <true/>
</dict>
```

6. Runner의 `AppDelegate.swift` 파일을 열고 아래 함수를 추가해 주세요.

```swift
override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
  if url.scheme == "4에서 설정한 URL Schemes" {
    BusanKeepinSDK.delegateURL(url: url)
  }

  return true
}
```
