@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

if exist "%~dp0ship\DATA\patch.pak.xen" del "%~dp0ship\DATA\patch.pak.xen"
honeycomb pak compile "%~dp0src\patch" -g gh3 -c pc -o "%~dp0ship\DATA"

if exist "%~dp0ship\DATA\patch_text.pak.xen" del "%~dp0ship\DATA\patch_text.pak.xen"
honeycomb pak compile "%~dp0src\patch_text" -g gh3 -c pc -o "%~dp0ship\DATA"

if exist "%~dp0ship\DATA\patch_text_f.pak.xen" del "%~dp0ship\DATA\patch_text_f.pak.xen"
honeycomb pak compile "%~dp0src\patch_text_f" -g gh3 -c pc -o "%~dp0ship\DATA"

if exist "%~dp0ship\DATA\patch_text_g.pak.xen" del "%~dp0ship\DATA\patch_text_g.pak.xen"
honeycomb pak compile "%~dp0src\patch_text_g" -g gh3 -c pc -o "%~dp0ship\DATA"

if exist "%~dp0ship\DATA\patch_text_i.pak.xen" del "%~dp0ship\DATA\patch_text_i.pak.xen"
honeycomb pak compile "%~dp0src\patch_text_i" -g gh3 -c pc -o "%~dp0ship\DATA"

if exist "%~dp0ship\DATA\patch_text_s.pak.xen" del "%~dp0ship\DATA\patch_text_s.pak.xen"
honeycomb pak compile "%~dp0src\patch_text_s" -g gh3 -c pc -o "%~dp0ship\DATA"