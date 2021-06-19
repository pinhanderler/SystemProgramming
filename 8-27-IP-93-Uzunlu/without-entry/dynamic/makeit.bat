C:\masm32\bin\ml.exe /c /coff "mymdl.asm"
C:\masm32\bin\link /dll /export:funcNum1 /export:funcNum2 /export:funcNum3 /noentry mymdl.obj
C:\masm32\bin\ml.exe /c /coff "8-27-IP-93-Uzunlu.asm"
C:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS "8-27-IP-93-Uzunlu.obj"
