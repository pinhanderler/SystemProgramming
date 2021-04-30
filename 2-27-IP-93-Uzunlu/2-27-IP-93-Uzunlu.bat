@echo off
set masmPath=C:\masm32\bin
for /f "delims=" %%F in ('dir /b /s "C:\%1" 2^>nul') do set var=%%F
%masmPath%\ml /Bl %masmPath\%link16.exe %var%
