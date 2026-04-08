@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

if exist "%~dp0ship\DATA\PAK\qb.pak.xen" del "%~dp0ship\DATA\PAK\qb.pak.xen"
if exist "%~dp0ship\DATA\PAK\qb.pab.xen" del "%~dp0ship\DATA\PAK\qb.pab.xen"
honeycomb pak compile "%~dp0src\base\qb" -g gh3 -c pc -s -o "%~dp0ship\DATA\PAK"

if exist "%~dp0ship\DATA\PAK\qb_f.pak.xen" del "%~dp0ship\DATA\PAK\qb_f.pak.xen"
if exist "%~dp0ship\DATA\PAK\qb_f.pab.xen" del "%~dp0ship\DATA\PAK\qb_f.pab.xen"
honeycomb pak compile "%~dp0src\base\qb_f" -g gh3 -c pc -s -o "%~dp0ship\DATA\PAK"

if exist "%~dp0ship\DATA\PAK\qb_g.pak.xen" del "%~dp0ship\DATA\PAK\qb_g.pak.xen"
if exist "%~dp0ship\DATA\PAK\qb_g.pab.xen" del "%~dp0ship\DATA\PAK\qb_g.pab.xen"
honeycomb pak compile "%~dp0src\base\qb_g" -g gh3 -c pc -s -o "%~dp0ship\DATA\PAK"

if exist "%~dp0ship\DATA\PAK\qb_i.pak.xen" del "%~dp0ship\DATA\PAK\qb_i.pak.xen"
if exist "%~dp0ship\DATA\PAK\qb_i.pab.xen" del "%~dp0ship\DATA\PAK\qb_i.pab.xen"
honeycomb pak compile "%~dp0src\base\qb_i" -g gh3 -c pc -s -o "%~dp0ship\DATA\PAK"

:: shows an "unsupported" message
if exist "%~dp0ship\DATA\PAK\qb_k.pak.xen" del "%~dp0ship\DATA\PAK\qb_k.pak.xen"
if exist "%~dp0ship\DATA\PAK\qb_k.pab.xen" del "%~dp0ship\DATA\PAK\qb_k.pab.xen"
honeycomb pak compile "%~dp0src\base\qb_k" -g gh3 -c pc -s -o "%~dp0ship\DATA\PAK"

if exist "%~dp0ship\DATA\PAK\qb_s.pak.xen" del "%~dp0ship\DATA\PAK\qb_s.pak.xen"
if exist "%~dp0ship\DATA\PAK\qb_s.pab.xen" del "%~dp0ship\DATA\PAK\qb_s.pab.xen"
honeycomb pak compile "%~dp0src\base\qb_s" -g gh3 -c pc -s -o "%~dp0ship\DATA\PAK"

if exist "%~dp0ship\DATA\customs.pak.xen" del "%~dp0ship\DATA\customs.pak.xen"
honeycomb pak compile "%~dp0src\base\customs" -g gh3 -c pc -o "%~dp0ship\DATA"