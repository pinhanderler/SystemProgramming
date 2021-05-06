@echo off
set fileToFind=%1%
set pathToMl=C:\masm32\bin\ml
set pathToLink=C:\masm32\bin\link16
for /f "tokens=*" %%f in ('dir %fileToFind% /s /b') do set FILE = %%f
%pathToMl% /Bl %pathToLink% %FILE%
