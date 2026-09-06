@echo off
setlocal

title DBob Player - Build Local

echo ==========================================
echo DBob Player - Build Local
echo ==========================================
echo.

where flutter >nul 2>nul
if errorlevel 1 (
  echo ERRO: Flutter nao encontrado no PATH.
  echo Instale o Flutter SDK e execute novamente.
  pause
  exit /b 1
)

if not exist android (
  echo Gerando estrutura Android oficial...
  flutter create --project-name dbob_player --org br.com.dbob --platforms=android .
)

echo.
echo Instalando dependencias...
flutter pub get
if errorlevel 1 goto erro

echo.
echo Analisando projeto...
flutter analyze --no-fatal-infos
if errorlevel 1 goto erro

echo.
echo Rodando testes...
flutter test
if errorlevel 1 goto erro

echo.
echo Gerando APK release...
flutter build apk --release
if errorlevel 1 goto erro

if not exist OUTPUT mkdir OUTPUT
copy /Y build\app\outputs\flutter-apk\app-release.apk OUTPUT\DBob_Player_v0.2.0_release.apk >nul

echo.
echo ==========================================
echo APK GERADO COM SUCESSO
echo ==========================================
echo OUTPUT\DBob_Player_v0.2.0_release.apk
echo.
pause
exit /b 0

:erro
echo.
echo ERRO: Build interrompida.
pause
exit /b 1
