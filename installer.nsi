; ══════════════════════════════════════════════════════════════════════════
;  Kapda & Shoes Billing — Windows Installer (NSIS)
;  GitHub Actions ise automatically compile karega build-exe.yml workflow se.
; ══════════════════════════════════════════════════════════════════════════

!include "MUI2.nsh"

; ── Basic Info ───────────────────────────────────────────────────────────────
Name "Kapda & Shoes Billing Software"
OutFile "KapdaShoesBillingSetup.exe"

; Per-user folder mein install hota hai (LocalAppData) — isliye:
;   1) Admin rights ki zaroorat NAHI padti (UAC prompt nahi aayega)
;   2) Software apni database file (bhugtanease.db) yahan bina kisi
;      permission issue ke likh payega — Program Files mein likhne
;      ke liye admin chahiye hota hai, jo shop PCs pe dikkat karta hai.
InstallDir "$LOCALAPPDATA\KapdaShoesBilling"
InstallDirRegKey HKCU "Software\KapdaShoesBilling" "InstallDir"
RequestExecutionLevel user

; ── Icon (installer + uninstaller dono pe) ────────────────────────────────────
!define MUI_ICON   "icon.ico"
!define MUI_UNICON "icon.ico"

; ── Pages ──────────────────────────────────────────────────────────────────
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "$INSTDIR\KapdaShoesBilling.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Kapda & Shoes Billing abhi chalao"
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

; ── Install Section ────────────────────────────────────────────────────────
Section "Install"
    SetOutPath "$INSTDIR"
    File "dist\KapdaShoesBilling.exe"
    File "icon.ico"

    WriteRegStr HKCU "Software\KapdaShoesBilling" "InstallDir" "$INSTDIR"

    ; Start Menu shortcut
    CreateDirectory "$SMPROGRAMS\Kapda Shoes Billing"
    CreateShortcut "$SMPROGRAMS\Kapda Shoes Billing\Kapda Shoes Billing.lnk" \
                   "$INSTDIR\KapdaShoesBilling.exe" "" "$INSTDIR\icon.ico"
    CreateShortcut "$SMPROGRAMS\Kapda Shoes Billing\Uninstall.lnk" \
                   "$INSTDIR\Uninstall.exe"

    ; Desktop shortcut
    CreateShortcut "$DESKTOP\Kapda Shoes Billing.lnk" \
                   "$INSTDIR\KapdaShoesBilling.exe" "" "$INSTDIR\icon.ico"

    ; Uninstaller
    WriteUninstaller "$INSTDIR\Uninstall.exe"

    ; Windows "Add/Remove Programs" mein entry
    WriteRegStr   HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\KapdaShoesBilling" \
                  "DisplayName" "Kapda & Shoes Billing Software"
    WriteRegStr   HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\KapdaShoesBilling" \
                  "UninstallString" "$INSTDIR\Uninstall.exe"
    WriteRegStr   HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\KapdaShoesBilling" \
                  "DisplayIcon" "$INSTDIR\icon.ico"
    WriteRegStr   HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\KapdaShoesBilling" \
                  "Publisher" "Ashrisha Ecommerce Solution Pvt Ltd"
SectionEnd

; ── Uninstall Section ──────────────────────────────────────────────────────
; ⚠️ Database (bhugtanease.db) YAHAN DELETE NAHI HOTI — customer ka business
; data safe rehta hai. Sirf program files remove hote hain.
Section "Uninstall"
    Delete "$INSTDIR\KapdaShoesBilling.exe"
    Delete "$INSTDIR\icon.ico"
    Delete "$INSTDIR\Uninstall.exe"
    RMDir  "$INSTDIR"          ; sirf tab delete hoga jab folder khaali ho (db.db bachi rahegi to nahi hatega)

    Delete "$SMPROGRAMS\Kapda Shoes Billing\Kapda Shoes Billing.lnk"
    Delete "$SMPROGRAMS\Kapda Shoes Billing\Uninstall.lnk"
    RMDir  "$SMPROGRAMS\Kapda Shoes Billing"
    Delete "$DESKTOP\Kapda Shoes Billing.lnk"

    DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\KapdaShoesBilling"
    DeleteRegKey HKCU "Software\KapdaShoesBilling"
SectionEnd
