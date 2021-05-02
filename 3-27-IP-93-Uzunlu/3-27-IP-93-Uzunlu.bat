set %masm%=C:\masm32\bin

if not exist %1 (
  echo "No such file."
  exit /b 1
)

echo "Compiling..."
%masm%ml.exe -c -Zi -Fl -nologo %1.asm
echo "Linking..."
%masm%link.exe /MAP /SUBSYSTEM:CONSOLE %1.obj
