@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

if exist "%~dp0ship\DATA\patch.pak.xen" del "%~dp0ship\DATA\patch.pak.xen"
honeycomb pak compile "%~dp0src\patch" -g gh3 -c pc -o "%~dp0ship\DATA"