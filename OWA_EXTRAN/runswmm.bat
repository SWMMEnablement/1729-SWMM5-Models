@echo off
for /r %%f in (*.inp) do (
    "C:\Program Files (x86)\EPA SWMM 5.2.4\runswmm.exe" "%%f" "%%~dpf%%~nf.rpt" "%%~dpf%%~nf.out"
)
pause