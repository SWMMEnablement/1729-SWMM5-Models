cd /d "%~dp0"
@echo off
REM Loop over all SWMM5 .inp files in the current directory
echo Searching for .inp files in directory: "%cd%"
for %%F in (*.inp) do (
    echo --------------------------------------
    echo Processing file: %%~nxF

    REM Initialize variables
    set "section="
    set "title_text="
    set "nodesList="
    set "linksList="
    set /A countNodes=0
    set /A countLinks=0

    REM Read the file line by line
    for /F "usebackq delims=" %%A in ("%%F") do (
        set "line=%%A"

        REM Debug - show current line
        REM echo [DEBUG] Reading line: !line!

        REM Check for section headers
        if "!line:~0,1!"=="[" (
            rem echo [DEBUG] Found section header: !line!

            if "!line!"=="[TITLE]" (
                set "section=TITLE"
                set "title_text="
                rem echo [DEBUG] Entering TITLE section
            ) else if "!line!"=="[JUNCTIONS]" (
                set "section=JUNCTIONS"
                set /A countNodes=0
                set "nodesList="
                rem echo [DEBUG] Entering JUNCTIONS section
            ) else if "!line!"=="[CONDUITS]" (
                set "section=CONDUITS"
                set /A countLinks=0
                set "linksList="
                rem echo [DEBUG] Entering CONDUITS section
            ) else (
                REM Exit sections we don't care about
                set "section="
                rem echo [DEBUG] Exiting known sections
            )
        ) else (
            if "!section!"=="TITLE" (
                if not "!line!"=="" (
                    if defined title_text (
                        set "title_text=!title_text! !line!"
                    ) else (
                        set "title_text=!line!"
                    )
                    rem echo [DEBUG] Title text updated: !title_text!
                )
            ) else if "!section!"=="JUNCTIONS" (
                if not "!line!"=="" (
                    for /F "tokens=1" %%B in ("!line!") do (
                        set /A countNodes+=1
                        set "nodesList=!nodesList! %%B"
                        rem echo [DEBUG] Node found: %%B
                    )
                )
            ) else if "!section!"=="CONDUITS" (
                if not "!line!"=="" (
                    for /F "tokens=1" %%C in ("!line!") do (
                        set /A countLinks+=1
                        set "linksList=!linksList! %%C"
                        rem echo [DEBUG] Link found: %%C
                    )
                )
            )
        )
    )

    REM Output to Markdown file
    set "outFile=%%~dpnF.md"
    echo [DEBUG] Writing summary to "!outFile!"
    > "!outFile!" echo # %%~nxF
    >> "!outFile!" echo **Title:** !title_text!
    >> "!outFile!" echo **Number of Nodes:** !countNodes!
    >> "!outFile!" echo **Number of Links:** !countLinks!
    >> "!outFile!" echo.
    >> "!outFile!" echo ## List of Node IDs
    for %%N in (!nodesList!) do >> "!outFile!" echo - %%N
    >> "!outFile!" echo.
    >> "!outFile!" echo ## List of Link IDs
    for %%L in (!linksList!) do >> "!outFile!" echo - %%L

    echo [DEBUG] Finished processing %%~nxF
    echo --------------------------------------
)

ENDLOCAL

pause