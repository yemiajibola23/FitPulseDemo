# Frequently Asked Questions

Here are some of the most common questions about using `FitPulseDemo` and the `SmartSpectraSwiftSDK`.

---

### 1. **Does the SDK work offline?**

No. The `SmartSpectraSwiftSDK` requires an internet connection for activation and telemetry. Once initialized, it may perform limited processing offline, but core functionality (like heart rate inference) may be affected.


### 2. **How do I add a real-time chart?**

You can integrate a real-time BPM line chart using a SwiftUI library like `Charts` or `SwiftUICharts`.

Here’s a basic example using `SwiftUICharts`:

```swift
LineChartView(data: viewModel.history, title: "Heart Rate", legend: "BPM")
```

### 3. **How do I reduce CPU usage on older iPhones?**
Use **frame throttling**. Only analyze 1 of every 3 frames.

```swift
if frameCount % 3 == 0 {
    processFrame()
}
frameCount += 1
```
This reduces overhead while perserving heart rate accuracy.


### 4. **Why isn't BPM updating?**

Make sure:
- Camera permission is granted.
- `viewModel.startMonitoring()` is called
- You're using a real device (not a simulator)
- Your face is centered in the front of the camera