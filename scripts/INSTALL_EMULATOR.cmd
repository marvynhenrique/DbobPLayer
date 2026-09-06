@echo off
setlocal

title DBob Player - Instalar no Emulador

echo ==========================================
echo DBob Player - Instalar APK
echo ==========================================
echo.

where adb >nul 2>nul
if errorlevel 1 (
  echo ERRO: ADB nao encontrado.
  pause
  exit /b 1
)

adb devices

if exist OUTPUT\DBob_Player_v0.2.0_release.apk (
  adb install -r OUTPUT\DBob_Player_v0.2.0_release.apk
) else (
  echo APK nao encontrado em OUTPUT.
  echo Execute scripts\BUILD_DBOB_PLAYER.cmd primeiro.
)

pause
