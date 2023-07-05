@echo off
setlocal

set retries=100
set timeout=5


git.exe add --all
git.exe commit -m "-"

:retry
git.exe push --progress "origin" master

if %errorlevel% neq 0 (
    set /a retries-=1
    if %retries% gtr 0 (
        echo Push failed. Retrying in %timeout% seconds...
        timeout /t %timeout% >nul
        goto retry
    ) else (
        echo Maximum retries exceeded. Unable to push.
    )
) else (
    echo Push successful.
)

endlocal