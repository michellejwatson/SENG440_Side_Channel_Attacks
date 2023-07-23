assemble_neon:
	arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -O3 -S /tmp/main.c

exe_neon:
	arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -o RSA_Routine_Neon.exe /tmp/main.c

neon:
	cp ./main.c /tmp/main.c && make assemble_neon && make exe_neon

exe: 
	cp ./main.c /tmp/main.c && arm-linux-gcc -static -o RSA_Routine.exe /tmp/main.c 
