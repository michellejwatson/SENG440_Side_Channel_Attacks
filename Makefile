compile_neon:
	/opt/arm/4.3.2/bin/arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -O3 -S /tmp/RSA_Routine.c

exe_neon:
	/opt/arm/4.3.2/bin/arm-linux-gcc -mfloat-abi=softfp -mfpu=neon RSA_Routine.s -o RSA_Routine.exe

neon:
	cp ./RSA_Routine.c /tmp/RSA_Routine.c && make compile_neon && make exe_neon
