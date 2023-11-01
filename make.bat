cd .\tests\
for %%x in (*.lz4) do del "%%x" 
for %%x in (*.bin) do ..\tools\lz4ultra.exe -r "%%x" "%%~nx.bin.lz4"

cd ..
cmd /c "BeebAsm.exe -v -i lz4_test.s.asm -do lz4_test.ssd -opt 3"