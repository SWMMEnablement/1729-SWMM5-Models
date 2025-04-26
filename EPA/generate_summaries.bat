I notice there's an issue with your batch script. The main problem is that you're using `current_section` in your conditional checks, but you actually defined the variable as `section`. That's why your counters aren't incrementing properly.

Let me fix the entire script for you:

```batch
@echo off
cd /d "%~dp0"
del *.md
SETLOCAL EnableDelayedExpansion

REM Loop over all SWMM5 .inp files in the current directory
echo Searching for .inp files in directory: "%cd%"
for %%F in (*.inp) do (
    echo --------------------------------------
    echo Processing file: %%~nxF

    REM Initialize variables
    set "section="
    set "title_text="
    set /A countNodes=0
    set /A countLinks=0
    set /A countPumps=0
    set /A countWeirs=0
    set /A countOrifices=0
    set /A countOutfalls=0
    set /A countStorages=0
    set /A countOutlets=0
    set /A countSubcatchments=0
    set /A countRaingages=0

    REM Read the file line by line
    for /F "usebackq delims=" %%A in ("%%F") do (
        set "line=%%A"

        REM Check for section headers
        if "!line:~0,1!"=="[" (
            if "!line!"=="[TITLE]" (
                set "section=TITLE"
                set "title_text="
            ) else if "!line!"=="[JUNCTIONS]" (
                set "section=JUNCTIONS"
                set /A countNodes=0
            ) else if "!line!"=="[CONDUITS]" (
                set "section=CONDUITS"
                set /A countLinks=0
            ) else if "!line!"=="[PUMPS]" (
                set "section=PUMPS"
                set /A countPumps=0
            ) else if "!line!"=="[WEIRS]" (
                set "section=WEIRS"
                set /A countWeirs=0
            ) else if "!line!"=="[ORIFICES]" (
                set "section=ORIFICES"
                set /A countOrifices=0
            ) else if "!line!"=="[OUTFALLS]" (
                set "section=OUTFALLS"
                set /A countOutfalls=0
            ) else if "!line!"=="[STORAGE]" (
                set "section=STORAGE"
                set /A countStorages=0
            ) else if "!line!"=="[OUTLETS]" (
                set "section=OUTLETS"
                set /A countOutlets=0
            ) else if "!line!"=="[SUBCATCHMENTS]" (
                set "section=SUBCATCHMENTS"
                set /A countSubcatchments=0
            ) else if "!line!"=="[RAINGAGES]" (
                set "section=RAINGAGES"
                set /A countRaingages=0
            ) else (
                set "section="
            )
        ) else (
            REM Explicitly check the section and increment the correct counter
            if "!section!"=="JUNCTIONS" (
                set /A countNodes+=1
            ) else if "!section!"=="CONDUITS" (
                set /A countLinks+=1
            ) else if "!section!"=="PUMPS" (
                set /A countPumps+=1
            ) else if "!section!"=="WEIRS" (
                set /A countWeirs+=1
            ) else if "!section!"=="ORIFICES" (
                set /A countOrifices+=1
            ) else if "!section!"=="OUTFALLS" (
                set /A countOutfalls+=1
            ) else if "!section!"=="STORAGE" (
                set /A countStorages+=1
            ) else if "!section!"=="OUTLETS" (
                set /A countOutlets+=1
            ) else if "!section!"=="SUBCATCHMENTS" (
                set /A countSubcatchments+=1
            ) else if "!section!"=="RAINGAGES" (
                set /A countRaingages+=1
            ) else if "!section!"=="TITLE" (
                if not "!line!"=="[TITLE]" (
                    set "title_text=!line!"
                )
            )
        )
    )
 
    REM Output to Markdown file
    set "outFile=%%~nF.md"
    echo Writing summary to "!outFile!"
    > "!outFile!" echo # %%~nxF
    >> "!outFile!" echo **Title:** !title_text!
    >> "!outFile!" echo **Number of Nodes:** !countNodes!
    >> "!outFile!" echo **Number of Links:** !countLinks!
    >> "!outFile!" echo **Number of Pumps:** !countPumps!
    >> "!outFile!" echo **Number of Weirs:** !countWeirs!
    >> "!outFile!" echo **Number of Orifices:** !countOrifices!
    >> "!outFile!" echo **Number of Outfalls:** !countOutfalls!
    >> "!outFile!" echo **Number of Storages:** !countStorages!
    >> "!outFile!" echo **Number of Outlets:** !countOutlets!
    >> "!outFile!" echo **Number of Subcatchments:** !countSubcatchments!
    >> "!outFile!" echo **Number of Raingages:** !countRaingages!

    echo Finished processing %%~nxF
    echo --------------------------------------
)

ENDLOCAL

pause
