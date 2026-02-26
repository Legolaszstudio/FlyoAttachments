# ==========================================
# KONFIGURÁCIÓ: A TELEPÍTENDŐ PROGRAMOK LISTÁJA
# ==========================================

# Itt sorold fel a programokat. A sorrend FONTOS! (Fentről lefelé halad)
$AppsToInstall = @(
    @{
        Name = "Brave"
        Path = "\\HQ-WIN-MASTER\Telepitok\BraveBrowserStandaloneSetup.exe"
        Args = "/silent /install"
        Check = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
    },
    @{
        Name = "TotalCommander"
        Path = "\\HQ-WIN-MASTER\Telepitok\tcmd1156x64.exe"
        Args = "/iAHMGDU"
        Check = "c:\Program Files\TotCMD"
    },
    @{
        Name = "SublimeText"
        Path = "\\HQ-WIN-MASTER\Telepitok\sublime_text_build_4200_x64_setup.exe"
        Args = "/VERYSILENT /NORESTART"
        Check = "C:\Program Files\Sublime Text\sublime_text.exe"
    }
)

$LogPath = "C:\Windows\Temp\multi_install_log.txt"

# ==========================================
# A SCRIPT LOGIKA
# ==========================================

Function Write-Log {
    Param ([string]$Message)
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogPath -Value "$TimeStamp - $Message"
}

Write-Log "--- Tömeges telepítés indítása ---"

# Végigmegyünk a listán (Ciklus)
foreach ($App in $AppsToInstall) {
    
    Write-Log "Feldolgozás: $($App.Name)..."

    # 1. Ellenőrzés: Fent van már?
    if (Test-Path $App.Check) {
        Write-Log "  -> Már telepítve van. Ugrás a következőre."
        continue # Kihagyja ezt, megy a következőre
    }

    # 2. Ellenőrzés: Elérhető a telepítő?
    if (-not (Test-Path $App.Path)) {
        Write-Log "  -> HIBA: A telepítő nem található itt: $($App.Path)"
        continue
    }

    # 3. Telepítés
    Write-Log "  -> Telepítés indítása..."
    try {
        $Process = Start-Process -FilePath $App.Path -ArgumentList $App.Args -Wait -PassThru -NoNewWindow
        
        if ($Process.ExitCode -eq 0) {
            Write-Log "  -> SIKER. (Exit Code: 0)"
        } elseif ($Process.ExitCode -eq 3010) {
             Write-Log "  -> SIKER (Újraindítás szükséges). (Exit Code: 3010)"
        } else {
            Write-Log "  -> HIBAGYANÚS kimenet: $($Process.ExitCode)"
        }
    }
    catch {
        Write-Log "  -> KRITIKUS HIBA a folyamat indításakor: $_"
    }
}

Write-Log "--- Minden feladat befejezve ---"