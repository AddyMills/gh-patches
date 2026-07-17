@echo off
if exist "%~dp0DATA\patch.pak.xen" del "%~dp0DATA\patch.pak.xen"
honeycomb pak compile "%~dp0src" -g ghsh -c x360 -o "%~dp0DATA"
ren "%~dp0DATA\src.pak.xen" "patch.pak.xen"