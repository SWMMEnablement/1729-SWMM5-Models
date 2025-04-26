@echo off
cd /d "%~dp0"
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
            if not "!line!"=="" (
                if "!section!"=="TITLE" (
                    if defined title_text (
                        set "title_text=!title_text! !line!"
                    ) else (
                        set "title_text=!line!"
                    )
                ) else if defined section (
                    set /A count!section!+=1
                )
            )
        )
    )

    REM Output to Markdown file
    set "outFile=%%~dpnF.md"
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
