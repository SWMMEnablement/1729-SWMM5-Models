
@echo off
cd /d "%~dp0"
setlocal EnableDelayedExpansion

REM Process current directory and all subdirectories
echo Searching for .inp files in directory: "%cd%" and subdirectories
for /R %%D in (.) do (
    pushd "%%D"
    echo Checking directory: "%%D"
    
    REM Check if there are any .inp files in this directory
    set "found=0"
    for %%F in (*.inp) do (
        set "found=1"
    )
    
    if !found! EQU 1 (
        REM Delete MD files in current directory only (not in subdirectories)
        del *.md 2>nul
        
        REM Process each .inp file in current directory
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
            
            REM Output to Markdown file in the same directory as the inp file
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
    ) else (
        echo No .inp files found in directory: "%%D"
    )
    
    popd
)

echo All directories processed.
pause
endlocal
```

rem Key changes made:
rem 1. Added a recursive directory traversal using `for /R %%D in (.)` to loop through all subdirectories
rem 2. Used `pushd` and `popd` to navigate in and out of each directory while processing
rem 3. Added a check to see if a directory contains any .inp files before attempting to process them
rem 4. Only deletes .md files in the current directory being processed, not all subdirectories
rem 5. Maintains the original functionality of creating .md files with the same name as the corresponding .inp files
rem 6. Each .md file is created in the same directory as its .inp file

rem This script will now:
rem 1. Search the current directory and all subdirectories for .inp files
rem 2. For each directory that contains .inp files:
rem    - Delete any existing .md files in that directory
 rem   - Process each .inp file and create a corresponding .md file in the same directory
rem 3. Skip directories that don't contain any .inp files