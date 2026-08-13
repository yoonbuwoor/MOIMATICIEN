@echo off
setlocal

where flutter >nul 2>nul
if errorlevel 1 (
  echo ERREUR : Flutter est introuvable dans le PATH.
  pause
  exit /b 1
)

echo [1/6] Preparation de la plateforme Android...
call flutter create --platforms=android --org com.novateur221 --project-name moi_geomaticien .
if errorlevel 1 goto :error

py -3 tool\configure_android.py 2>nul
if errorlevel 1 python tool\configure_android.py
if errorlevel 1 goto :error

echo [2/6] Installation des dependances...
call flutter pub get
if errorlevel 1 goto :error

echo [3/6] Analyse du code...
call flutter analyze --no-fatal-infos --no-fatal-warnings
if errorlevel 1 goto :error

echo [4/6] Tests...
call flutter test
if errorlevel 1 goto :error

echo [5/6] Compilation APK...
call flutter build apk --release
if errorlevel 1 goto :error

echo [6/6] Compilation AAB...
call flutter build appbundle --release
if errorlevel 1 goto :error

for %%F in (build\app\outputs\flutter-apk\app-release.apk build\app\outputs\bundle\release\app-release.aab) do (
  if %%~zF GTR 98566144 (
    echo ERREUR : %%F depasse 94 Mo.
    goto :error
  )
)

echo.
echo TERMINE :
echo APK : build\app\outputs\flutter-apk\app-release.apk
echo AAB : build\app\outputs\bundle\release\app-release.aab
pause
exit /b 0

:error
echo.
echo ECHEC : consultez les messages affiches ci-dessus.
pause
exit /b 1
