assemble_neon:
	/opt/arm/4.3.2/bin/arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -O3 -S /tmp/RSA_functions.c -o RSA_functions.s && /opt/arm/4.3.2/bin/arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -O3 -S /tmp/main.c -o main.s

compile_neon:
	/opt/arm/4.3.2/bin/arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -O3 -c RSA_functions.s -o RSA_functions.o && /opt/arm/4.3.2/bin/arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -O3 -c main.s -o main.o

exe_neon:
	/opt/arm/4.3.2/bin/arm-linux-gcc -mfloat-abi=softfp -mfpu=neon RSA_functions.s main.s -o RSA_Routine.exe

neon:
	cp ./main.c /tmp/main.c && cp ./RSA_functions.c /tmp/RSA_functions.c && cp ./RSA_functions.h /tmp/RSA_functions.h && make assemble_neon && make exe_neon
