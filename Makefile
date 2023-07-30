assemble_neon:
	arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -O3 -S /tmp/main.c /tmp/RSA_functions.c

compile_neon:
	arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -o RSA_Routine_Neon.exe /tmp/main.c /tmp/RSA_functions.c /tmp/tests.c

neon:
	make copy_files && make assemble_neon && make compile_neon

copy_files:
	cp ./main.c /tmp/main.c && cp ./RSA_functions.h /tmp/RSA_functions.h && cp ./RSA_functions.c /tmp/RSA_functions.c && cp ./tests.c /tmp/tests.c && cp ./tests.h /tmp/tests.h

assemble_exe:
	arm-linux-gcc -static -S /tmp/main.c && arm-linux-gcc -static -S /tmp/RSA_functions.c

compile_exe:
	arm-linux-gcc -static -o RSA_Routine.exe /tmp/main.c /tmp/RSA_functions.c /tmp/tests.c

exe: 
	make copy_files && make assemble_exe && make compile_exe

