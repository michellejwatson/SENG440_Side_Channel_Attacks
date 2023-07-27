assemble_neon:
	arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -O3 -S /tmp/main.c

compile_neon:
	arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -o RSA_Routine_Neon.exe /tmp/main.c

neon:
	cp ./main.c /tmp/main.c && make assemble_neon && make compile_neon

assemble_exe:
	arm-linux-gcc -static -S /tmp/main.c && arm-linux-gcc -static -S /tmp/RSA_functions.c

compile_exe:
	arm-linux-gcc -static -o RSA_Routine.exe /tmp/main.c /tmp/RSA_functions.c

exe: 
	cp ./main.c /tmp/main.c && cp ./RSA_functions.c /tmp/RSA_functions.c && make assemble_exe && make compile_exe
