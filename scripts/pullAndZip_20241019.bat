@echo off
FOR /f "tokens=1-8 delims=:./ " %%G in ("%date%%time%") DO (
::set datetime=%%G%%H%%I_%%J_%%K
set datetime=%%I-%%H-%%J)

echo %datetime%

::set /p datetime=What Filename should the 7z file be?
echo %date%
set day=%date:~7,2%
set daynm=%date:~0,3%
set month=%date:~4,2%
set year=%date:~10,4%

echo Starting Data pull From local databases %datetime% ...
echo today is %daynm%
pause

echo %year%-%month%-%day%
echo %day%-%month%-%year%

echo Create STATA datasets 
pause 

:: runs the do files to export each of the separate dataset from SQL

"C:\Program Files\Stata17\StataBE-64" -e do "C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MINDR\data\scripts\run_generatescripts.do"
pause

::"C:\Program Files\StatTransfer11-64\st.exe" "C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MINDR\data\scripts\Convert_to_SAS_no_opts.stcmd"

"C:\Program Files\7-Zip\7z.exe" a -t7z -pM1ND3R! "C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MINDR\data\datasets\"%year%-%month%-%day%.7z @"C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MINDR\data\scripts\7zlistfiles.txt"

echo made it in if 1
pause
:End


echo Data sets has successfully been archived ...

::pause
