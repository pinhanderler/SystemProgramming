if not exist %1.asm (
  echo "No such file."
  exit /b 1
)

echo "Compiling..."
C:\masm32\bin\ml.exe -c -Zi -Fl -nologo %1.asm
echo "Linking..."
C:\masm32\bin\link.exe /MAP /SUBSYSTEM:CONSOLE %1.obj
