@echo off
setlocal

title DBob Player - Bootstrap Android

echo Gerando estrutura Android oficial do Flutter...
flutter create --project-name dbob_player --org br.com.dbob --platforms=android .

echo.
echo Concluido.
pause
