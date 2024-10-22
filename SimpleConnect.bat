@echo off
setlocal enabledelayedexpansion
title SimpleConnect

:menu
cls
echo SimpleConnect - Detailed Process Monitor
echo ============================================
echo.
echo 1. Filter by process name
echo 2. Show all processes
echo 3. Filter by process ID
echo 4. Exit
echo.
set /p choice="Select an option (1-4): "

if "%choice%"=="1" (
    set /p processName="Enter the process name to filter (e.g., notepad.exe) or leave blank for all processes: "
    goto loop
) else if "%choice%"=="2" (
    goto showAllProcesses
) else if "%choice%"=="3" (
    set /p processID="Enter the process ID to filter (e.g., 1234): "
    goto filterByID
) else if "%choice%"=="4" (
    exit
) else (
    echo Invalid option, please try again.
    timeout /t 1 >nul
    goto menu
)

:loop
cls
echo SimpleConnect - Detailed Process Monitor
echo ============================================
echo.

if "%processName%"=="" (
    echo Showing all processes:
    echo ------------------------------
    wmic process get Caption, ProcessId, CommandLine, ExecutablePath, WorkingSetSize, ReadOperationCount, WriteOperationCount, ThreadCount, CreationDate, Priority, TerminationDate, HandleCount, PageFileUsage /format:list
) else (
    echo Showing processes matching: %processName%
    echo ------------------------------
    wmic process where "Caption='%processName%'" get Caption, ProcessId, CommandLine, ExecutablePath, WorkingSetSize, ReadOperationCount, WriteOperationCount, ThreadCount, CreationDate, Priority, TerminationDate, HandleCount, PageFileUsage /format:list
)

echo.
timeout /t 1 >nul
goto loop

:showAllProcesses
cls
echo SimpleConnect - Showing All Processes
echo ============================================
echo.
wmic process get Caption, ProcessId, CommandLine, ExecutablePath, WorkingSetSize, ReadOperationCount, WriteOperationCount, ThreadCount, CreationDate, Priority, TerminationDate, HandleCount, PageFileUsage /format:list
echo.
timeout /t 10 >nul
goto showAllProcesses

:filterByID
cls
echo SimpleConnect - Filtering by Process ID
echo ============================================
echo.

if "%processID%"=="" (
    echo No Process ID entered.
) else (
    echo Showing details for Process ID: %processID%
    echo ------------------------------
    wmic process where "ProcessId='%processID%'" get Caption, ProcessId, CommandLine, ExecutablePath, WorkingSetSize, ReadOperationCount, WriteOperationCount, ThreadCount, CreationDate, Priority, TerminationDate, HandleCount, PageFileUsage /format:list
)

echo.
timeout /t 1 >nul
goto filterByID
