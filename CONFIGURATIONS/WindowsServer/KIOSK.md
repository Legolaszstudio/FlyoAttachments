# Group Policy Object: KIOSK

Az exportált GPO settings html [itt](./KIOSK.htm) található.

## General Details
* **Domain**: Flyo.directory
* **Owner**: FLYO\Domain Admins
* **Created**: 2026. 03. 06. 20:58:22
* **Modified**: 2026. 03. 30. 18:01:56
* **GPO Status**: Enabled

### Links
* **ShowRoom**: Flyo.directory/FlyoComputers/Branch/ShowRoom (Enabled, Not Enforced)
* **ShowRoom**: Flyo.directory/FlyoUsers/Branch/ShowRoom (Enabled, Not Enforced)

### Security Filtering
This GPO applies only to the following:
* FLYO\showroom_kiosk_users
* FLYO\showroom_kiosks

---

## Computer Configuration (Enabled)

### Administrative Templates

| Policy Path | Policy Name | Setting | Additional Details |
| :--- | :--- | :--- | :--- |
| **Microsoft Edge** | Allow download restrictions | Enabled | Download restrictions: Block all downloads |
| **Microsoft Edge** | Control where developer tools can be used | Enabled | Control where developer tools can be used: Don't allow using the developer tools |
| **Microsoft Edge/Experimentation** | Configure users ability to override feature flags | Enabled | Configure users ability to override feature flags: Prevent users from overriding feature flags |
| **Microsoft Edge/Printing** | Enable printing | Disabled | N/A |
| **System/Device Installation/...** | Prevent installation of removable devices | Enabled | N/A |
| **System/Group Policy** | Configure user Group Policy loopback processing mode | Enabled | Mode: Replace |
| **System/Removable Storage Access** | All Removable Storage classes: Deny all access | Enabled | N/A |
| **Windows Components/AutoPlay Policies** | Turn off Autoplay | Enabled | Turn off Autoplay on: All drives |

---

## User Configuration (Enabled)

### Administrative Templates

| Policy Path | Policy Name | Setting | Additional Details |
| :--- | :--- | :--- | :--- |
| **Start Menu and Taskbar** | Remove Run menu from Start Menu | Enabled | N/A |
| **System** | Custom User Interface | Enabled | Interface file name: `"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --kiosk "https://flyo.com" --no-first-run --user-data-dir="C:\EdgeKioskProfile"` |
| **System** | Prevent access to registry editing tools | Enabled | Disable regedit from running silently? Yes |
| **System** | Prevent access to the command prompt | Enabled | Disable the command prompt script processing also? Yes |
| **System/Ctrl+Alt+Del Options** | Remove Change Password | Enabled | N/A |
| **System/Ctrl+Alt+Del Options** | Remove Lock Computer | Enabled | N/A |
| **System/Ctrl+Alt+Del Options** | Remove Logoff | Enabled | N/A |
| **System/Ctrl+Alt+Del Options** | Remove Task Manager | Enabled | N/A |
| **Windows Components/File Explorer** | Turn off Windows Key hotkeys | Enabled | N/A |

---

### Preferences - Windows Settings (Registry)

All registry preferences below are set to the **Update** action under the **HKEY_CURRENT_USER** hive. Disabling ease of use features to prevent users from using them to bypass kiosk restrictions.

| Order | Key Path | Value Name | Value Type | Value Data |
| :--- | :--- | :--- | :--- | :--- |
| **1** | `Control Panel\Accessibility\StickyKeys` | `Flags` | REG_SZ | 506 |
| **2** | `Control Panel\Accessibility\HighContrast` | `Flags` | REG_SZ | 122 |
| **3** | `Control Panel\Accessibility\MouseKeys` | `Flags` | REG_SZ | 58 |
| **4** | `Control Panel\Accessibility\ToggleKeys` | `Flags` | REG_SZ | 58 |