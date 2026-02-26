# VM Optimizer GPO

Az exportált GPO settings html [itt](./VM%20Performance%20Tuning.htm) található.

# GPO Report: VM Performance Tuning
**Data Collected:** 2026. 02. 26. 10:35:46
**Domain:** Flyo.directory

---

## 1. Computer Configuration (System Level)

### Security Settings & System Services
* **Shutdown: Allow system to be shut down without having to log on:** Enabled.
* **Windows Search:** Startup Mode set to Disabled.

### Administrative Templates

#### Power Management
* **Select an active power plan:** Enabled (Setting: High Performance).
* **Select the Power button action (plugged in):** Enabled (Setting: Shut down).
* **Allow standby states (S1-S3) (on battery/plugged in):** Disabled.
* **System hibernate timeout (on battery/plugged in):** Enabled (0 seconds).
* **System sleep timeout (on battery/plugged in):** Enabled (0 seconds).
* **Unattended sleep timeout (on battery/plugged in):** Enabled (0 seconds).
* **Turn off hybrid sleep (plugged in):** Enabled.

#### Windows Components
* **Microsoft Defender Antivirus:** Turn off Microsoft Defender Antivirus is Enabled.
* **Real-time Protection:** Turn off real-time protection is Enabled.
* **Windows AI:** Allow Recall to be enabled is Disabled.
* **Widgets:** Allow widgets is Disabled; Disable Widgets Board is Enabled.
* **Cloud Content:** Do not show Windows tips is Enabled; Turn off cloud optimized content is Enabled.
* **Windows Update:** Configure Automatic Updates is Disabled.

#### Windows Time Service
* **Configure Windows NTP Client:** Enabled (NtpServer: hu.pool.ntp.org,0x8).

### Registry Preferences (Machine)
| Key Path | Value Name | Value Data |
| :--- | :--- | :--- |
| `SYSTEM\CurrentControlSet\Control\FileSystem` | `NtfsDisableLastAccessUpdate` | `0x1 (1)` |
| `SYSTEM\CurrentControlSet\Control\Session Manager\Power` | `HiberbootEnabled` | `0x0 (0)` |

---

## 2. User Configuration (UI & Performance)

### Registry Preferences (User)
The following settings are configured to reduce visual overhead for virtual environments:

| Value Name | Hive | Value Data | Effect |
| :--- | :--- | :--- | :--- |
| `VisualFXSetting` | HKEY_CURRENT_USER | `0x3 (3)` | Custom Visual Effects |
| `MinAnimate` | HKEY_CURRENT_USER | `0` | Disables window animations |
| `TaskbarAnimations` | HKEY_CURRENT_USER | `0x0 (0)` | Disables taskbar animations |
| `DragFullWindows` | HKEY_CURRENT_USER | `0` | Disables dragging full window |
| `PointerShadow` | HKEY_CURRENT_USER | `0x0 (0)` | Disables pointer shadows |
| `CompositionPolicy` | HKEY_CURRENT_USER | `0x0 (0)` | Disables Desktop Composition |
| `SmoothScroll` | HKEY_CURRENT_USER | `0x0 (0)` | Disables smooth scrolling |
| `IconsOnly` | HKEY_CURRENT_USER | `0x1 (1)` | Shows icons instead of thumbnails |
| `ListviewAlphaSelect` | HKEY_CURRENT_USER | `0x0 (0)` | Disables translucent selection |
| `FontSmoothing` | HKEY_CURRENT_USER | `2` | Standard font smoothing |