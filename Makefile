assemble_neon:
	arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -O3 -S /tmp/main.c

exe_neon:
	arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -o RSA_Routine_Neon.exe /tmp/main.c

neon:
	cp ./main.c /tmp/main.c && make assemble_neon && make exe_neon

assemble_exe:
	arm-linux-gcc -static -S /tmp/main.c 

exe: 
	cp ./main.c /tmp/main.c && make assemble_exe && arm-linux-gcc -static -o RSA_Routine.exe /tmp/main.c 
