@ECHO off

:Start
:: Check if the input file has been specified and whether it even exists or not
IF [%1] == [] (
	:: Create an html window with a javascript alert
	MSHTA javascript:alert^("Input an ahk file to convert"^);close^(^); /time 3
	:: Using EXIT /B will stop execution of a batch file
	:: or subroutine and return control to the command processor
	:: or to the calling batch file or code immediately.
	EXIT /B
)
IF NOT EXIST %1 (
	SET ESCAPED_PATH=%1
	MSHTA javascript:alert^("File does not exist!\nPath: %ESCAPED_PATH%"^);close^(^); /time 3
	EXIT /B
)

:: Use the passed in input file now that it has been verified to exist
SET IN_FILE=%1
:: Remove all quotes from the input file name
SET OUT_FILE=%IN_FILE:"=%
:: Remove the last 4 characters, ".ahk" and add ".exe" as the name of the output exe file
SET OUT_FILE="%OUT_FILE:~0,-4%.exe"

:: The path to the AHK exe compiler and binary file
SET AHK_PATH=C:\Program Files\AutoHotkey\Compiler
SET AHK_EXE="%AHK_PATH%\Ahk2Exe.exe"
SET AHK_BIN="%AHK_PATH%\AutoHotkeySC.bin"
:: If an icon isn't passed in with the ahk file being converted,
:: attempt to use "icon.ico" in the same directory that the script is being ran
IF [%2] == [] (
	SET ICON_FILE="icon.ico"
) ELSE (
	SET ICON_FILE=%2
)

:: Compile the ahk script to an exe
%AHK_EXE% /in %IN_FILE% /out %OUT_FILE% /icon %ICON_FILE% /bin %AHK_BIN% /mpress 1