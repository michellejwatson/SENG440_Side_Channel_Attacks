compile_neon:
	/opt/arm/4.3.2/bin/arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -O3 -S /tmp/RSA_functions.c /tmp/main.c

exe_neon:
	/opt/arm/4.3.2/bin/arm-linux-gcc -mfloat-abi=softfp -mfpu=neon /tmp/RSA_functions.o /tmp/main.o -o RSA_Routine.exe

neon:
	cp ./main.c /tmp/main.c && cp ./RSA_functions.c /tmp/RSA_functions.c && 
	cp ./RSA_functions.h /tmp/RSA_functions.h && make compile_neon && make exe_neon
