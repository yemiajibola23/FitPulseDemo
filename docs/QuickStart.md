# ⚡ Quick Start Guide – FitPulseDemo

This guide walks you through setting up and running the `FitPulseDemo` project using the `SmartSpectraSwiftSDK`.

---

## Requirements

- Xcode 15+
- iOS 16.0+ deployment target
- Physical iPhone (camera access required)
- Internet connection (for SDK activation)

---

## 1. Clone and Open the Project
Copy this code and execute in Terminal:

```bash
git clone https://github.com/yemiajibola23/FitPulseDemo.git
cd FitPulseDemo
open FitPulseDemo.xcodeproj
```

## 2. Request a SmartSpectra API Key
Visit [SmartSpectra Developer Portal](https://physiology.presagetech.com) and request an API key for SDK activation.

Once obtained, add the key to your app's configuration by injecting it into the Info.plist:

```xml
<key>PresageAPIKey</key>
<string>YOUR_API_KEY_HERE</string>
```

## 3. Check for required privacy settings
In `Info.plist`, make sure the following key is included:
```xml
<key>NSCameraUsageDescription</key>
<string>This app uses the camera to measure your heart rate.</string>
```

## 4. Build & run
Ensure a physical device is selected (not the simulator). Then:

- Hit ⌘ + R to build and run.
- Tap Start to begin heart rate monitoring.
- Tap Stop to end the session.

___

## ⚠️ Common Gotchas
| Issue                                    | Solution                                                                                                 |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| **App crashes on launch**                | Make sure camera permission is granted                                                                   |
| **Camera doesn't activate**              | Try restarting the app or checking iOS Settings                                                          |
| **SDK not found**                        | Confirm that `SmartSpectraSwiftSDK` is properly added in **Frameworks, Libraries, and Embedded Content** |
| **Build error: Missing package product** | Clean build folder (`⇧⌘K`), delete derived data, and restart Xcode                                       |
