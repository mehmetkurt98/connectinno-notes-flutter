@echo off
echo ========================================
echo Connectinno Backend Başlatılıyor...
echo ========================================

REM Backend klasörüne git
cd /d "C:\Users\Mehmet\AndroidStudioProjects\connectinno_backend"

REM Backend'i başlat
echo Backend sunucusu başlatılıyor...
echo URL: http://localhost:8000
echo.
python main.py

pause
