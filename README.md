# year_in_pixels

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Testing on Android Devices

To test this project on an Android device, follow these steps:

1. **Enable Developer Mode on Your Android Device**:
   - Go to `Settings` > `About phone`.
   - Tap on `Build number` multiple times until you see a message that says "You are now a developer!"

2. **Enable Wireless Debugging**:
   - Go to `Settings` > `System` > `Developer options`.
   - Scroll down and enable `Wireless debugging`.

3. **Pair Device with ADB**:
   - In `Developer options`, tap on `Wireless debugging`.
   - Select `Pair device with pairing code`.
   - A pairing code along with an IP address and port will be displayed.
   - Open your terminal/command prompt on your computer.
   - Run the following command, replacing `<ip>` and `<port>` with the values shown on your device:
     ```bash
     adb pair <ip>:<port>
     ```
   - Enter the pairing code displayed on your device when prompted.

4. **Connect to the Device from VSCode**:
   - In VSCode, press `Ctrl+Shift+P` to open the command palette.
   - Search for and select `ADB: Connect to device IP`.
   - Enter the IP address and port displayed on the `Wireless debugging` screen.

5. **Run the Project**:
   - With the device connected, run the project using your preferred method.
   - The app should now be deployed and running on your Android device.

**Note**: Ensure that the ADB client is installed on your computer. You can download it from the Android Studio [official website](https://developer.android.com/studio).

