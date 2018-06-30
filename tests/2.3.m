putf_func	sw 0(r14), r15	% store the return address	% Link the puts library
			lw r1, 4(r14)	% load the real value
			sw 16(r14), r1	% Store the real value
			addi r14, r14, 12
			jl r15, nnlpi_func
			subi r14, r14, 12
			addi r1, r0, 101
			putc r1
			lw r1, 8(r14)
			sw 16(r14), r1
			addi r14, r14, 12
			jl r15, puti_func
			subi r14, r14, 12
			lw r15, 0(r14)
			jr r15
nnlpi_func	sw 0(r14), r15 % store the return address.
			lw r1, 4(r14) % load the value into a register
			cgei r2, r1, 0 % Check if it's good.
			bnz r2, nnlpi_cont
			muli r1, r1, -1 % Convert to positive.
			addi r2, r0, 45 % Print the minus sign
			putc r2
nnlpi_cont	addi r3, r0, 10 % initialize the iteration counter
			addi r4, r14, 44 % Set the base iteration pointer
nnlpi_calc	modi r2, r1, 10 % get the mod value
			sw 0(r4), r2	% and store it
			divi r1, r1, 10 % divide by 10.
			subi r3, r3, 1  % remove one from the iteration counter
			subi r4, r4, 4  % Shift the pointer down one word.
			bnz r1, nnlpi_calc % Perform another iteration if r1 is not 0
nnlpi_put	addi r4, r4, 4 	% Increase the pointer by one word.
			addi r3, r3, 1	% Increase the iteration by one.
			lw r1, 0(r4)	% load the value
			addi r1, r1, 48	% Make it ascii
			putc r1			% Print it
			subi r1, r3, 10 % Check if we're at 10
			bnz r1, nnlpi_put
			lw r15, 0(r14) 	% Load the return address.
			jr r15
puti_func	sw 0(r14), r15 % store the return address.
			lw r1, 4(r14) % load the value into a register
			cgei r2, r1, 0 % Check if it's good.
			bnz r2, puti_cont
			muli r1, r1, -1 % Convert to positive.
			addi r2, r0, 45 % Print the minus sign
			putc r2
puti_cont	addi r3, r0, 10 % initialize the iteration counter
			addi r4, r14, 44 % Set the base iteration pointer
puti_calc	modi r2, r1, 10 % get the mod value
			sw 0(r4), r2	% and store it
			divi r1, r1, 10 % divide by 10.
			subi r3, r3, 1  % remove one from the iteration counter
			subi r4, r4, 4  % Shift the pointer down one word.
			bnz r1, puti_calc % Perform another iteration if r1 is not 0
puti_put	addi r4, r4, 4 	% Increase the pointer by one word.
			addi r3, r3, 1	% Increase the iteration by one.
			lw r1, 0(r4)	% load the value
			addi r1, r1, 48	% Make it ascii
			putc r1			% Print it
			subi r1, r3, 10 % Check if we're at 10
			bnz r1, puti_put
			addi r1, r0, 13	% Return carriage
			putc r1
			addi r1, r0, 10 % New line
			putc r1
			lw r15, 0(r14) 	% Load the return address.
			jr r15
geti_func	addi r1, r0, 0	% Reset the register.
			addi r6, r0, 1	% Register to hold the sign.
			getc r3			% Get input from the user.
			ceqi r2, r3, 45 % Check if negative.
			bz r2, geti_proin % It's not a negative sign. Continue to proceess it.'
			addi r6, r0, -1	% Make the factor -1.
geti_input	getc r3			% Get input from the user.
geti_proin	ceqi r2, r3, 10	% Check if we should terminate.
			bnz r2, geti_save
			subi r3, r3, 48	% Convert it to decimal.
			muli r1, r1, 10 % Shift the stored value to make room for the new value.
			add r1, r1, r3 % Add the digit.
			j geti_input
geti_save	mul r1, r1, r6	% Make sure the sign is correct.
			sw 0(r5), r1	% Store the result in the designated place.
			jr r15
function_Foo sw 0(r14), r15	% Store the return address.
addi r1, r0, 8	% Start to calculate the offset for val1
sw 76(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val1
lw r2, 76(r14)
add r1, r1, r2
sw 76(r14), r1
addi r1, r0, 8	% Start to calculate the offset for val1
sw 76(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val1
lw r2, 76(r14)
add r1, r1, r2
sw 76(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 76(r14)	% Loading the value of val1
lw r2, 0(r2)	% Pointer detected. Dereferencing val1
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val1 * 10)
sw 84(r14), r1
lw r1, 84(r14)	% val1=(val1 * 10) - loading 0 of 4
lw r2, 76(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 12	% Start to calculate the offset for val2
sw 88(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val2
lw r2, 88(r14)
add r1, r1, r2
sw 88(r14), r1
addi r1, r0, 12	% Start to calculate the offset for val2
sw 88(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val2
lw r2, 88(r14)
add r1, r1, r2
sw 88(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 88(r14)	% Loading the value of val2
lw r2, 0(r2)	% Pointer detected. Dereferencing val2
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val2 * 10)
sw 92(r14), r1
lw r1, 92(r14)	% val2=(val2 * 10) - loading 0 of 4
lw r2, 88(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 16	% Start to calculate the offset for val3
sw 96(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val3
lw r2, 96(r14)
add r1, r1, r2
sw 96(r14), r1
addi r1, r0, 16	% Start to calculate the offset for val3
sw 96(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val3
lw r2, 96(r14)
add r1, r1, r2
sw 96(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 96(r14)	% Loading the value of val3
lw r2, 0(r2)	% Pointer detected. Dereferencing val3
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val3 * 10)
sw 100(r14), r1
lw r1, 100(r14)	% val3=(val3 * 10) - loading 0 of 4
lw r2, 96(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 20	% Start to calculate the offset for val4
sw 104(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val4
lw r2, 104(r14)
add r1, r1, r2
sw 104(r14), r1
addi r1, r0, 20	% Start to calculate the offset for val4
sw 104(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val4
lw r2, 104(r14)
add r1, r1, r2
sw 104(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 104(r14)	% Loading the value of val4
lw r2, 0(r2)	% Pointer detected. Dereferencing val4
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val4 * 10)
sw 108(r14), r1
lw r1, 108(r14)	% val4=(val4 * 10) - loading 0 of 4
lw r2, 104(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 24	% Start to calculate the offset for val5
sw 112(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val5
lw r2, 112(r14)
add r1, r1, r2
sw 112(r14), r1
addi r1, r0, 24	% Start to calculate the offset for val5
sw 112(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val5
lw r2, 112(r14)
add r1, r1, r2
sw 112(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 112(r14)	% Loading the value of val5
lw r2, 0(r2)	% Pointer detected. Dereferencing val5
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val5 * 10)
sw 116(r14), r1
lw r1, 116(r14)	% val5=(val5 * 10) - loading 0 of 4
lw r2, 112(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 28	% Start to calculate the offset for val6
sw 120(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val6
lw r2, 120(r14)
add r1, r1, r2
sw 120(r14), r1
addi r1, r0, 28	% Start to calculate the offset for val6
sw 120(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val6
lw r2, 120(r14)
add r1, r1, r2
sw 120(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 120(r14)	% Loading the value of val6
lw r2, 0(r2)	% Pointer detected. Dereferencing val6
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val6 * 10)
sw 124(r14), r1
lw r1, 124(r14)	% val6=(val6 * 10) - loading 0 of 4
lw r2, 120(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 32	% Start to calculate the offset for val7
sw 128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val7
lw r2, 128(r14)
add r1, r1, r2
sw 128(r14), r1
addi r1, r0, 32	% Start to calculate the offset for val7
sw 128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val7
lw r2, 128(r14)
add r1, r1, r2
sw 128(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 128(r14)	% Loading the value of val7
lw r2, 0(r2)	% Pointer detected. Dereferencing val7
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val7 * 10)
sw 132(r14), r1
lw r1, 132(r14)	% val7=(val7 * 10) - loading 0 of 4
lw r2, 128(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 36	% Start to calculate the offset for val8
sw 136(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val8
lw r2, 136(r14)
add r1, r1, r2
sw 136(r14), r1
addi r1, r0, 36	% Start to calculate the offset for val8
sw 136(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val8
lw r2, 136(r14)
add r1, r1, r2
sw 136(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 136(r14)	% Loading the value of val8
lw r2, 0(r2)	% Pointer detected. Dereferencing val8
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val8 * 10)
sw 140(r14), r1
lw r1, 140(r14)	% val8=(val8 * 10) - loading 0 of 4
lw r2, 136(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 40	% Start to calculate the offset for val9
sw 144(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val9
lw r2, 144(r14)
add r1, r1, r2
sw 144(r14), r1
addi r1, r0, 40	% Start to calculate the offset for val9
sw 144(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val9
lw r2, 144(r14)
add r1, r1, r2
sw 144(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 144(r14)	% Loading the value of val9
lw r2, 0(r2)	% Pointer detected. Dereferencing val9
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val9 * 10)
sw 148(r14), r1
lw r1, 148(r14)	% val9=(val9 * 10) - loading 0 of 4
lw r2, 144(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 44	% Start to calculate the offset for val10
sw 152(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val10
lw r2, 152(r14)
add r1, r1, r2
sw 152(r14), r1
addi r1, r0, 44	% Start to calculate the offset for val10
sw 152(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val10
lw r2, 152(r14)
add r1, r1, r2
sw 152(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 152(r14)	% Loading the value of val10
lw r2, 0(r2)	% Pointer detected. Dereferencing val10
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val10 * 10)
sw 156(r14), r1
lw r1, 156(r14)	% val10=(val10 * 10) - loading 0 of 4
lw r2, 152(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 48	% Start to calculate the offset for val11
sw 160(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val11
lw r2, 160(r14)
add r1, r1, r2
sw 160(r14), r1
addi r1, r0, 48	% Start to calculate the offset for val11
sw 160(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val11
lw r2, 160(r14)
add r1, r1, r2
sw 160(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 160(r14)	% Loading the value of val11
lw r2, 0(r2)	% Pointer detected. Dereferencing val11
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val11 * 10)
sw 164(r14), r1
lw r1, 164(r14)	% val11=(val11 * 10) - loading 0 of 4
lw r2, 160(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 52	% Start to calculate the offset for val12
sw 168(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val12
lw r2, 168(r14)
add r1, r1, r2
sw 168(r14), r1
addi r1, r0, 52	% Start to calculate the offset for val12
sw 168(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val12
lw r2, 168(r14)
add r1, r1, r2
sw 168(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 168(r14)	% Loading the value of val12
lw r2, 0(r2)	% Pointer detected. Dereferencing val12
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val12 * 10)
sw 172(r14), r1
lw r1, 172(r14)	% val12=(val12 * 10) - loading 0 of 4
lw r2, 168(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 56	% Start to calculate the offset for val13
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val13
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 56	% Start to calculate the offset for val13
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val13
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 176(r14)	% Loading the value of val13
lw r2, 0(r2)	% Pointer detected. Dereferencing val13
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val13 * 10)
sw 180(r14), r1
lw r1, 180(r14)	% val13=(val13 * 10) - loading 0 of 4
lw r2, 176(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 60	% Start to calculate the offset for val14
sw 184(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val14
lw r2, 184(r14)
add r1, r1, r2
sw 184(r14), r1
addi r1, r0, 60	% Start to calculate the offset for val14
sw 184(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val14
lw r2, 184(r14)
add r1, r1, r2
sw 184(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 184(r14)	% Loading the value of val14
lw r2, 0(r2)	% Pointer detected. Dereferencing val14
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val14 * 10)
sw 188(r14), r1
lw r1, 188(r14)	% val14=(val14 * 10) - loading 0 of 4
lw r2, 184(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 64	% Start to calculate the offset for val15
sw 192(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val15
lw r2, 192(r14)
add r1, r1, r2
sw 192(r14), r1
addi r1, r0, 64	% Start to calculate the offset for val15
sw 192(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val15
lw r2, 192(r14)
add r1, r1, r2
sw 192(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 192(r14)	% Loading the value of val15
lw r2, 0(r2)	% Pointer detected. Dereferencing val15
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val15 * 10)
sw 196(r14), r1
lw r1, 196(r14)	% val15=(val15 * 10) - loading 0 of 4
lw r2, 192(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 68	% Start to calculate the offset for val16
sw 200(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val16
lw r2, 200(r14)
add r1, r1, r2
sw 200(r14), r1
addi r1, r0, 68	% Start to calculate the offset for val16
sw 200(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val16
lw r2, 200(r14)
add r1, r1, r2
sw 200(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 200(r14)	% Loading the value of val16
lw r2, 0(r2)	% Pointer detected. Dereferencing val16
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val16 * 10)
sw 204(r14), r1
lw r1, 204(r14)	% val16=(val16 * 10) - loading 0 of 4
lw r2, 200(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 72	% Start to calculate the offset for val17
sw 208(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val17
lw r2, 208(r14)
add r1, r1, r2
sw 208(r14), r1
addi r1, r0, 72	% Start to calculate the offset for val17
sw 208(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val17
lw r2, 208(r14)
add r1, r1, r2
sw 208(r14), r1
addi r1, r0, 10	% Storing 10
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 208(r14)	% Loading the value of val17
lw r2, 0(r2)	% Pointer detected. Dereferencing val17
lw r3, 80(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (val17 * 10)
sw 212(r14), r1
lw r1, 212(r14)	% val17=(val17 * 10) - loading 0 of 4
lw r2, 208(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 8	% Start to calculate the offset for val1
sw 76(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val1
lw r2, 76(r14)
add r1, r1, r2
sw 76(r14), r1
lw r1, 76(r14)	% Store the put value of val1 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val1 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 12	% Start to calculate the offset for val2
sw 88(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val2
lw r2, 88(r14)
add r1, r1, r2
sw 88(r14), r1
lw r1, 88(r14)	% Store the put value of val2 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val2 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 16	% Start to calculate the offset for val3
sw 96(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val3
lw r2, 96(r14)
add r1, r1, r2
sw 96(r14), r1
lw r1, 96(r14)	% Store the put value of val3 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val3 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 20	% Start to calculate the offset for val4
sw 104(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val4
lw r2, 104(r14)
add r1, r1, r2
sw 104(r14), r1
lw r1, 104(r14)	% Store the put value of val4 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val4 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 24	% Start to calculate the offset for val5
sw 112(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val5
lw r2, 112(r14)
add r1, r1, r2
sw 112(r14), r1
lw r1, 112(r14)	% Store the put value of val5 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val5 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 28	% Start to calculate the offset for val6
sw 120(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val6
lw r2, 120(r14)
add r1, r1, r2
sw 120(r14), r1
lw r1, 120(r14)	% Store the put value of val6 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val6 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 32	% Start to calculate the offset for val7
sw 128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val7
lw r2, 128(r14)
add r1, r1, r2
sw 128(r14), r1
lw r1, 128(r14)	% Store the put value of val7 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val7 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 36	% Start to calculate the offset for val8
sw 136(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val8
lw r2, 136(r14)
add r1, r1, r2
sw 136(r14), r1
lw r1, 136(r14)	% Store the put value of val8 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val8 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 40	% Start to calculate the offset for val9
sw 144(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val9
lw r2, 144(r14)
add r1, r1, r2
sw 144(r14), r1
lw r1, 144(r14)	% Store the put value of val9 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val9 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 44	% Start to calculate the offset for val10
sw 152(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val10
lw r2, 152(r14)
add r1, r1, r2
sw 152(r14), r1
lw r1, 152(r14)	% Store the put value of val10 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val10 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 48	% Start to calculate the offset for val11
sw 160(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val11
lw r2, 160(r14)
add r1, r1, r2
sw 160(r14), r1
lw r1, 160(r14)	% Store the put value of val11 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val11 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 52	% Start to calculate the offset for val12
sw 168(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val12
lw r2, 168(r14)
add r1, r1, r2
sw 168(r14), r1
lw r1, 168(r14)	% Store the put value of val12 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val12 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 56	% Start to calculate the offset for val13
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val13
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
lw r1, 176(r14)	% Store the put value of val13 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val13 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 60	% Start to calculate the offset for val14
sw 184(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val14
lw r2, 184(r14)
add r1, r1, r2
sw 184(r14), r1
lw r1, 184(r14)	% Store the put value of val14 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val14 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 64	% Start to calculate the offset for val15
sw 192(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val15
lw r2, 192(r14)
add r1, r1, r2
sw 192(r14), r1
lw r1, 192(r14)	% Store the put value of val15 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val15 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 68	% Start to calculate the offset for val16
sw 200(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val16
lw r2, 200(r14)
add r1, r1, r2
sw 200(r14), r1
lw r1, 200(r14)	% Store the put value of val16 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val16 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 72	% Start to calculate the offset for val17
sw 208(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val17
lw r2, 208(r14)
add r1, r1, r2
sw 208(r14), r1
lw r1, 208(r14)	% Store the put value of val17 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val17 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
lw r15, 0(r14)	% Load the return address, and return.
jr r15
entry
addi r14, r0, 5736  % Set the stack pointer
addi r1, r0, 4	% Start to calculate the offset for val1
sw 72(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val1
lw r2, 72(r14)
add r1, r1, r2
sw 72(r14), r1
addi r1, r0, 1	% Storing 1
sb 76(r14), r1
addi r1, r0, 0	% Storing 0
sb 77(r14), r1
addi r1, r0, 0	% Storing 0
sb 78(r14), r1
addi r1, r0, 0	% Storing 0
sb 79(r14), r1
lw r1, 76(r14)	% val1=1 - loading 0 of 4
lw r2, 72(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 8	% Start to calculate the offset for val2
sw 80(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val2
lw r2, 80(r14)
add r1, r1, r2
sw 80(r14), r1
addi r1, r0, 2	% Storing 2
sb 84(r14), r1
addi r1, r0, 0	% Storing 0
sb 85(r14), r1
addi r1, r0, 0	% Storing 0
sb 86(r14), r1
addi r1, r0, 0	% Storing 0
sb 87(r14), r1
lw r1, 84(r14)	% val2=2 - loading 0 of 4
lw r2, 80(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 12	% Start to calculate the offset for val3
sw 88(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val3
lw r2, 88(r14)
add r1, r1, r2
sw 88(r14), r1
addi r1, r0, 3	% Storing 3
sb 92(r14), r1
addi r1, r0, 0	% Storing 0
sb 93(r14), r1
addi r1, r0, 0	% Storing 0
sb 94(r14), r1
addi r1, r0, 0	% Storing 0
sb 95(r14), r1
lw r1, 92(r14)	% val3=3 - loading 0 of 4
lw r2, 88(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 16	% Start to calculate the offset for val4
sw 96(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val4
lw r2, 96(r14)
add r1, r1, r2
sw 96(r14), r1
addi r1, r0, 4	% Storing 4
sb 100(r14), r1
addi r1, r0, 0	% Storing 0
sb 101(r14), r1
addi r1, r0, 0	% Storing 0
sb 102(r14), r1
addi r1, r0, 0	% Storing 0
sb 103(r14), r1
lw r1, 100(r14)	% val4=4 - loading 0 of 4
lw r2, 96(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 20	% Start to calculate the offset for val5
sw 104(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val5
lw r2, 104(r14)
add r1, r1, r2
sw 104(r14), r1
addi r1, r0, 5	% Storing 5
sb 108(r14), r1
addi r1, r0, 0	% Storing 0
sb 109(r14), r1
addi r1, r0, 0	% Storing 0
sb 110(r14), r1
addi r1, r0, 0	% Storing 0
sb 111(r14), r1
lw r1, 108(r14)	% val5=5 - loading 0 of 4
lw r2, 104(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 24	% Start to calculate the offset for val6
sw 112(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val6
lw r2, 112(r14)
add r1, r1, r2
sw 112(r14), r1
addi r1, r0, 6	% Storing 6
sb 116(r14), r1
addi r1, r0, 0	% Storing 0
sb 117(r14), r1
addi r1, r0, 0	% Storing 0
sb 118(r14), r1
addi r1, r0, 0	% Storing 0
sb 119(r14), r1
lw r1, 116(r14)	% val6=6 - loading 0 of 4
lw r2, 112(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 28	% Start to calculate the offset for val7
sw 120(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val7
lw r2, 120(r14)
add r1, r1, r2
sw 120(r14), r1
addi r1, r0, 7	% Storing 7
sb 124(r14), r1
addi r1, r0, 0	% Storing 0
sb 125(r14), r1
addi r1, r0, 0	% Storing 0
sb 126(r14), r1
addi r1, r0, 0	% Storing 0
sb 127(r14), r1
lw r1, 124(r14)	% val7=7 - loading 0 of 4
lw r2, 120(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 32	% Start to calculate the offset for val8
sw 128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val8
lw r2, 128(r14)
add r1, r1, r2
sw 128(r14), r1
addi r1, r0, 8	% Storing 8
sb 132(r14), r1
addi r1, r0, 0	% Storing 0
sb 133(r14), r1
addi r1, r0, 0	% Storing 0
sb 134(r14), r1
addi r1, r0, 0	% Storing 0
sb 135(r14), r1
lw r1, 132(r14)	% val8=8 - loading 0 of 4
lw r2, 128(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 36	% Start to calculate the offset for val9
sw 136(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val9
lw r2, 136(r14)
add r1, r1, r2
sw 136(r14), r1
addi r1, r0, 9	% Storing 9
sb 140(r14), r1
addi r1, r0, 0	% Storing 0
sb 141(r14), r1
addi r1, r0, 0	% Storing 0
sb 142(r14), r1
addi r1, r0, 0	% Storing 0
sb 143(r14), r1
lw r1, 140(r14)	% val9=9 - loading 0 of 4
lw r2, 136(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 40	% Start to calculate the offset for val10
sw 144(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val10
lw r2, 144(r14)
add r1, r1, r2
sw 144(r14), r1
addi r1, r0, 10	% Storing 10
sb 148(r14), r1
addi r1, r0, 0	% Storing 0
sb 149(r14), r1
addi r1, r0, 0	% Storing 0
sb 150(r14), r1
addi r1, r0, 0	% Storing 0
sb 151(r14), r1
lw r1, 148(r14)	% val10=10 - loading 0 of 4
lw r2, 144(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 44	% Start to calculate the offset for val11
sw 152(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val11
lw r2, 152(r14)
add r1, r1, r2
sw 152(r14), r1
addi r1, r0, 11	% Storing 11
sb 156(r14), r1
addi r1, r0, 0	% Storing 0
sb 157(r14), r1
addi r1, r0, 0	% Storing 0
sb 158(r14), r1
addi r1, r0, 0	% Storing 0
sb 159(r14), r1
lw r1, 156(r14)	% val11=11 - loading 0 of 4
lw r2, 152(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 48	% Start to calculate the offset for val12
sw 160(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val12
lw r2, 160(r14)
add r1, r1, r2
sw 160(r14), r1
addi r1, r0, 12	% Storing 12
sb 164(r14), r1
addi r1, r0, 0	% Storing 0
sb 165(r14), r1
addi r1, r0, 0	% Storing 0
sb 166(r14), r1
addi r1, r0, 0	% Storing 0
sb 167(r14), r1
lw r1, 164(r14)	% val12=12 - loading 0 of 4
lw r2, 160(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 52	% Start to calculate the offset for val13
sw 168(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val13
lw r2, 168(r14)
add r1, r1, r2
sw 168(r14), r1
addi r1, r0, 13	% Storing 13
sb 172(r14), r1
addi r1, r0, 0	% Storing 0
sb 173(r14), r1
addi r1, r0, 0	% Storing 0
sb 174(r14), r1
addi r1, r0, 0	% Storing 0
sb 175(r14), r1
lw r1, 172(r14)	% val13=13 - loading 0 of 4
lw r2, 168(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 56	% Start to calculate the offset for val14
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val14
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 14	% Storing 14
sb 180(r14), r1
addi r1, r0, 0	% Storing 0
sb 181(r14), r1
addi r1, r0, 0	% Storing 0
sb 182(r14), r1
addi r1, r0, 0	% Storing 0
sb 183(r14), r1
lw r1, 180(r14)	% val14=14 - loading 0 of 4
lw r2, 176(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 60	% Start to calculate the offset for val15
sw 184(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val15
lw r2, 184(r14)
add r1, r1, r2
sw 184(r14), r1
addi r1, r0, 15	% Storing 15
sb 188(r14), r1
addi r1, r0, 0	% Storing 0
sb 189(r14), r1
addi r1, r0, 0	% Storing 0
sb 190(r14), r1
addi r1, r0, 0	% Storing 0
sb 191(r14), r1
lw r1, 188(r14)	% val15=15 - loading 0 of 4
lw r2, 184(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 64	% Start to calculate the offset for val16
sw 192(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val16
lw r2, 192(r14)
add r1, r1, r2
sw 192(r14), r1
addi r1, r0, 16	% Storing 16
sb 196(r14), r1
addi r1, r0, 0	% Storing 0
sb 197(r14), r1
addi r1, r0, 0	% Storing 0
sb 198(r14), r1
addi r1, r0, 0	% Storing 0
sb 199(r14), r1
lw r1, 196(r14)	% val16=16 - loading 0 of 4
lw r2, 192(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 68	% Start to calculate the offset for val17
sw 200(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val17
lw r2, 200(r14)
add r1, r1, r2
sw 200(r14), r1
addi r1, r0, 17	% Storing 17
sb 204(r14), r1
addi r1, r0, 0	% Storing 0
sb 205(r14), r1
addi r1, r0, 0	% Storing 0
sb 206(r14), r1
addi r1, r0, 0	% Storing 0
sb 207(r14), r1
lw r1, 204(r14)	% val17=17 - loading 0 of 4
lw r2, 200(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Start to calculate the offset for result
sw 208(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for result
lw r2, 208(r14)
add r1, r1, r2
sw 208(r14), r1
addi r1, r0, 4	% Start to calculate the offset for val1
sw 72(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val1
lw r2, 72(r14)
add r1, r1, r2
sw 72(r14), r1
addi r1, r0, 8	% Start to calculate the offset for val2
sw 80(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val2
lw r2, 80(r14)
add r1, r1, r2
sw 80(r14), r1
addi r1, r0, 12	% Start to calculate the offset for val3
sw 88(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val3
lw r2, 88(r14)
add r1, r1, r2
sw 88(r14), r1
addi r1, r0, 16	% Start to calculate the offset for val4
sw 96(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val4
lw r2, 96(r14)
add r1, r1, r2
sw 96(r14), r1
addi r1, r0, 20	% Start to calculate the offset for val5
sw 104(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val5
lw r2, 104(r14)
add r1, r1, r2
sw 104(r14), r1
addi r1, r0, 24	% Start to calculate the offset for val6
sw 112(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val6
lw r2, 112(r14)
add r1, r1, r2
sw 112(r14), r1
addi r1, r0, 28	% Start to calculate the offset for val7
sw 120(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val7
lw r2, 120(r14)
add r1, r1, r2
sw 120(r14), r1
addi r1, r0, 32	% Start to calculate the offset for val8
sw 128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val8
lw r2, 128(r14)
add r1, r1, r2
sw 128(r14), r1
addi r1, r0, 36	% Start to calculate the offset for val9
sw 136(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val9
lw r2, 136(r14)
add r1, r1, r2
sw 136(r14), r1
addi r1, r0, 40	% Start to calculate the offset for val10
sw 144(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val10
lw r2, 144(r14)
add r1, r1, r2
sw 144(r14), r1
addi r1, r0, 44	% Start to calculate the offset for val11
sw 152(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val11
lw r2, 152(r14)
add r1, r1, r2
sw 152(r14), r1
addi r1, r0, 48	% Start to calculate the offset for val12
sw 160(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val12
lw r2, 160(r14)
add r1, r1, r2
sw 160(r14), r1
addi r1, r0, 52	% Start to calculate the offset for val13
sw 168(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val13
lw r2, 168(r14)
add r1, r1, r2
sw 168(r14), r1
addi r1, r0, 56	% Start to calculate the offset for val14
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val14
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 60	% Start to calculate the offset for val15
sw 184(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val15
lw r2, 184(r14)
add r1, r1, r2
sw 184(r14), r1
addi r1, r0, 64	% Start to calculate the offset for val16
sw 192(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val16
lw r2, 192(r14)
add r1, r1, r2
sw 192(r14), r1
addi r1, r0, 68	% Start to calculate the offset for val17
sw 200(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val17
lw r2, 200(r14)
add r1, r1, r2
sw 200(r14), r1
addi r7, r14, 0	% This is to calculate the data offset for any potential member functions.
lw r1, 72(r14)	% Passing parameter val1 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 224(r14), r1	% Passing parameter val1 - storing 0 of 4
lw r1, 80(r14)	% Passing parameter val2 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 228(r14), r1	% Passing parameter val2 - storing 0 of 4
lw r1, 88(r14)	% Passing parameter val3 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 232(r14), r1	% Passing parameter val3 - storing 0 of 4
lw r1, 96(r14)	% Passing parameter val4 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 236(r14), r1	% Passing parameter val4 - storing 0 of 4
lw r1, 104(r14)	% Passing parameter val5 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 240(r14), r1	% Passing parameter val5 - storing 0 of 4
lw r1, 112(r14)	% Passing parameter val6 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 244(r14), r1	% Passing parameter val6 - storing 0 of 4
lw r1, 120(r14)	% Passing parameter val7 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 248(r14), r1	% Passing parameter val7 - storing 0 of 4
lw r1, 128(r14)	% Passing parameter val8 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 252(r14), r1	% Passing parameter val8 - storing 0 of 4
lw r1, 136(r14)	% Passing parameter val9 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 256(r14), r1	% Passing parameter val9 - storing 0 of 4
lw r1, 144(r14)	% Passing parameter val10 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 260(r14), r1	% Passing parameter val10 - storing 0 of 4
lw r1, 152(r14)	% Passing parameter val11 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 264(r14), r1	% Passing parameter val11 - storing 0 of 4
lw r1, 160(r14)	% Passing parameter val12 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 268(r14), r1	% Passing parameter val12 - storing 0 of 4
lw r1, 168(r14)	% Passing parameter val13 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 272(r14), r1	% Passing parameter val13 - storing 0 of 4
lw r1, 176(r14)	% Passing parameter val14 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 276(r14), r1	% Passing parameter val14 - storing 0 of 4
lw r1, 184(r14)	% Passing parameter val15 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 280(r14), r1	% Passing parameter val15 - storing 0 of 4
lw r1, 192(r14)	% Passing parameter val16 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 284(r14), r1	% Passing parameter val16 - storing 0 of 4
lw r1, 200(r14)	% Passing parameter val17 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 288(r14), r1	% Passing parameter val17 - storing 0 of 4
addi r14, r14, 216
jl r15, function_Foo	% Call the function Foo
subi r14, r14, 216
lw r1, 220(r14)	% Retrieve the returnvalue - loading 0 of 4
sw 212(r14), r1	% Retrieve the returnvalue - storing 0 of 4
addi r7, r14, 0	% This is to calculate the data offset for any potential member functions.
addi r1, r14, 0	% Calculating the REAL offset for Foo(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17)
addi r1, r14, 212	% Get the function call's pointer
lw r2, 212(r14)
sw 212(r14), r2
lw r1, 212(r14)	% result=Foo(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17) - loading 0 of 4
lw r2, 208(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 4	% Start to calculate the offset for val1
sw 72(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val1
lw r2, 72(r14)
add r1, r1, r2
sw 72(r14), r1
lw r1, 72(r14)	% Store the put value of val1 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val1 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 8	% Start to calculate the offset for val2
sw 80(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val2
lw r2, 80(r14)
add r1, r1, r2
sw 80(r14), r1
lw r1, 80(r14)	% Store the put value of val2 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val2 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 12	% Start to calculate the offset for val3
sw 88(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val3
lw r2, 88(r14)
add r1, r1, r2
sw 88(r14), r1
lw r1, 88(r14)	% Store the put value of val3 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val3 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 16	% Start to calculate the offset for val4
sw 96(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val4
lw r2, 96(r14)
add r1, r1, r2
sw 96(r14), r1
lw r1, 96(r14)	% Store the put value of val4 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val4 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 20	% Start to calculate the offset for val5
sw 104(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val5
lw r2, 104(r14)
add r1, r1, r2
sw 104(r14), r1
lw r1, 104(r14)	% Store the put value of val5 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val5 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 24	% Start to calculate the offset for val6
sw 112(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val6
lw r2, 112(r14)
add r1, r1, r2
sw 112(r14), r1
lw r1, 112(r14)	% Store the put value of val6 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val6 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 28	% Start to calculate the offset for val7
sw 120(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val7
lw r2, 120(r14)
add r1, r1, r2
sw 120(r14), r1
lw r1, 120(r14)	% Store the put value of val7 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val7 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 32	% Start to calculate the offset for val8
sw 128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val8
lw r2, 128(r14)
add r1, r1, r2
sw 128(r14), r1
lw r1, 128(r14)	% Store the put value of val8 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val8 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 36	% Start to calculate the offset for val9
sw 136(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val9
lw r2, 136(r14)
add r1, r1, r2
sw 136(r14), r1
lw r1, 136(r14)	% Store the put value of val9 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val9 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 40	% Start to calculate the offset for val10
sw 144(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val10
lw r2, 144(r14)
add r1, r1, r2
sw 144(r14), r1
lw r1, 144(r14)	% Store the put value of val10 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val10 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 44	% Start to calculate the offset for val11
sw 152(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val11
lw r2, 152(r14)
add r1, r1, r2
sw 152(r14), r1
lw r1, 152(r14)	% Store the put value of val11 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val11 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 48	% Start to calculate the offset for val12
sw 160(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val12
lw r2, 160(r14)
add r1, r1, r2
sw 160(r14), r1
lw r1, 160(r14)	% Store the put value of val12 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val12 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 52	% Start to calculate the offset for val13
sw 168(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val13
lw r2, 168(r14)
add r1, r1, r2
sw 168(r14), r1
lw r1, 168(r14)	% Store the put value of val13 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val13 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 56	% Start to calculate the offset for val14
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val14
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
lw r1, 176(r14)	% Store the put value of val14 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val14 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 60	% Start to calculate the offset for val15
sw 184(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val15
lw r2, 184(r14)
add r1, r1, r2
sw 184(r14), r1
lw r1, 184(r14)	% Store the put value of val15 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val15 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 64	% Start to calculate the offset for val16
sw 192(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val16
lw r2, 192(r14)
add r1, r1, r2
sw 192(r14), r1
lw r1, 192(r14)	% Store the put value of val16 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val16 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
addi r1, r0, 68	% Start to calculate the offset for val17
sw 200(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for val17
lw r2, 200(r14)
add r1, r1, r2
sw 200(r14), r1
lw r1, 200(r14)	% Store the put value of val17 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 220(r14), r1	% Store the put value of val17 - storing 0 of 4
addi r14, r14, 216
jl r15, puti_func
subi r14, r14, 216
hlt
