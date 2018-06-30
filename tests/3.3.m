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
entry
addi r14, r0, 1600  % Set the stack pointer
addi r1, r0, 0	% Storing 0
sb 8(r14), r1
addi r1, r0, 0	% Storing 0
sb 9(r14), r1
addi r1, r0, 0	% Storing 0
sb 10(r14), r1
addi r1, r0, 0	% Storing 0
sb 11(r14), r1
lw r1, 8(r14)	% int x = 0 - loading 0 of 4
sw 0(r14), r1	% int x = 0 - storing 0 of 4
j forcond_2_5
for_2_5    nop	% Start the for loop
addi r1, r0, 0	% Start to calculate the offset for x
sw 12(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 12(r14)
add r1, r1, r2
sw 12(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 12(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 12(r14)
add r1, r1, r2
sw 12(r14), r1
addi r1, r0, 1	% Storing 1
sb 16(r14), r1
addi r1, r0, 0	% Storing 0
sb 17(r14), r1
addi r1, r0, 0	% Storing 0
sb 18(r14), r1
addi r1, r0, 0	% Storing 0
sb 19(r14), r1
lw r2, 12(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 16(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (x + 1)
sw 20(r14), r1
lw r1, 20(r14)	% x=(x + 1) - loading 0 of 4
lw r2, 12(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_2_5   nop
addi r1, r0, 0	% Start to calculate the offset for x
sw 12(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 12(r14)
add r1, r1, r2
sw 12(r14), r1
addi r1, r0, 10	% Storing 10
sb 24(r14), r1
addi r1, r0, 0	% Storing 0
sb 25(r14), r1
addi r1, r0, 0	% Storing 0
sb 26(r14), r1
addi r1, r0, 0	% Storing 0
sb 27(r14), r1
lw r2, 12(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 24(r14)	% Loading the value of 10
clt r1, r2, r3	% Evaluate (x < 10)
sw 28(r14), r1
lw r1, 28(r14)	% Loading the value of (x < 10)
bz r1, endfor_2_5
addi r1, r0, 0	% Storing 0
sb 8(r14), r1
addi r1, r0, 0	% Storing 0
sb 9(r14), r1
addi r1, r0, 0	% Storing 0
sb 10(r14), r1
addi r1, r0, 0	% Storing 0
sb 11(r14), r1
lw r1, 8(r14)	% int y = 0 - loading 0 of 4
sw 4(r14), r1	% int y = 0 - storing 0 of 4
j forcond_3_9
for_3_9    nop	% Start the for loop
addi r1, r0, 4	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r0, 1	% Storing 1
sb 16(r14), r1
addi r1, r0, 0	% Storing 0
sb 17(r14), r1
addi r1, r0, 0	% Storing 0
sb 18(r14), r1
addi r1, r0, 0	% Storing 0
sb 19(r14), r1
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 16(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (y + 1)
sw 36(r14), r1
lw r1, 36(r14)	% y=(y + 1) - loading 0 of 4
lw r2, 32(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_3_9   nop
addi r1, r0, 4	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r0, 10	% Storing 10
sb 24(r14), r1
addi r1, r0, 0	% Storing 0
sb 25(r14), r1
addi r1, r0, 0	% Storing 0
sb 26(r14), r1
addi r1, r0, 0	% Storing 0
sb 27(r14), r1
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 24(r14)	% Loading the value of 10
clt r1, r2, r3	% Evaluate (y < 10)
sw 40(r14), r1
lw r1, 40(r14)	% Loading the value of (y < 10)
bz r1, endfor_3_9
addi r1, r0, 0	% Start to calculate the offset for x
sw 12(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 12(r14)
add r1, r1, r2
sw 12(r14), r1
addi r1, r0, 10	% Storing 10
sb 24(r14), r1
addi r1, r0, 0	% Storing 0
sb 25(r14), r1
addi r1, r0, 0	% Storing 0
sb 26(r14), r1
addi r1, r0, 0	% Storing 0
sb 27(r14), r1
lw r2, 12(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 24(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (x * 10)
sw 44(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
lw r2, 44(r14)	% Loading the value of (x * 10)
lw r3, 32(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
add r1, r2, r3	% Calculating ((x * 10) + y)
sw 48(r14), r1
lw r1, 48(r14)	% Store the put value of ((x * 10) + y) - loading 0 of 4
sw 72(r14), r1	% Store the put value of ((x * 10) + y) - storing 0 of 4
addi r14, r14, 68
jl r15, puti_func
subi r14, r14, 68
j for_3_9
endfor_3_9    nop
j for_2_5
endfor_2_5    nop
addi r1, r0, 0	% Storing 0
sb 8(r14), r1
addi r1, r0, 0	% Storing 0
sb 9(r14), r1
addi r1, r0, 0	% Storing 0
sb 10(r14), r1
addi r1, r0, 0	% Storing 0
sb 11(r14), r1
lw r1, 8(r14)	% int x = 0 - loading 0 of 4
sw 0(r14), r1	% int x = 0 - storing 0 of 4
j forcond_7_5
for_7_5    nop	% Start the for loop
addi r1, r0, 0	% Start to calculate the offset for x
sw 12(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 12(r14)
add r1, r1, r2
sw 12(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 12(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 12(r14)
add r1, r1, r2
sw 12(r14), r1
addi r1, r0, 1	% Storing 1
sb 16(r14), r1
addi r1, r0, 0	% Storing 0
sb 17(r14), r1
addi r1, r0, 0	% Storing 0
sb 18(r14), r1
addi r1, r0, 0	% Storing 0
sb 19(r14), r1
lw r2, 12(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 16(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (x + 1)
sw 20(r14), r1
lw r1, 20(r14)	% x=(x + 1) - loading 0 of 4
lw r2, 12(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_7_5   nop
addi r1, r0, 0	% Start to calculate the offset for x
sw 12(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 12(r14)
add r1, r1, r2
sw 12(r14), r1
addi r1, r0, 50	% Storing 50
sb 52(r14), r1
addi r1, r0, 0	% Storing 0
sb 53(r14), r1
addi r1, r0, 0	% Storing 0
sb 54(r14), r1
addi r1, r0, 0	% Storing 0
sb 55(r14), r1
lw r2, 12(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 52(r14)	% Loading the value of 50
clt r1, r2, r3	% Evaluate (x < 50)
sw 56(r14), r1
lw r1, 56(r14)	% Loading the value of (x < 50)
bz r1, endfor_7_5
addi r1, r0, 0	% Start to calculate the offset for x
sw 12(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 12(r14)
add r1, r1, r2
sw 12(r14), r1
lw r1, 12(r14)	% Store the put value of x - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 72(r14), r1	% Store the put value of x - storing 0 of 4
addi r14, r14, 68
jl r15, puti_func
subi r14, r14, 68
j for_7_5
endfor_7_5    nop
addi r1, r0, 50	% Storing 50
sb 52(r14), r1
addi r1, r0, 0	% Storing 0
sb 53(r14), r1
addi r1, r0, 0	% Storing 0
sb 54(r14), r1
addi r1, r0, 0	% Storing 0
sb 55(r14), r1
lw r1, 52(r14)	% int y = 50 - loading 0 of 4
sw 4(r14), r1	% int y = 50 - storing 0 of 4
j forcond_10_5
for_10_5    nop	% Start the for loop
addi r1, r0, 4	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r0, 1	% Storing 1
sb 16(r14), r1
addi r1, r0, 0	% Storing 0
sb 17(r14), r1
addi r1, r0, 0	% Storing 0
sb 18(r14), r1
addi r1, r0, 0	% Storing 0
sb 19(r14), r1
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 16(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (y + 1)
sw 36(r14), r1
lw r1, 36(r14)	% y=(y + 1) - loading 0 of 4
lw r2, 32(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_10_5   nop
addi r1, r0, 4	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r0, 100	% Storing 100
sb 60(r14), r1
addi r1, r0, 0	% Storing 0
sb 61(r14), r1
addi r1, r0, 0	% Storing 0
sb 62(r14), r1
addi r1, r0, 0	% Storing 0
sb 63(r14), r1
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 60(r14)	% Loading the value of 100
clt r1, r2, r3	% Evaluate (y < 100)
sw 64(r14), r1
lw r1, 64(r14)	% Loading the value of (y < 100)
bz r1, endfor_10_5
addi r1, r0, 4	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
lw r1, 32(r14)	% Store the put value of y - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 72(r14), r1	% Store the put value of y - storing 0 of 4
addi r14, r14, 68
jl r15, puti_func
subi r14, r14, 68
j for_10_5
endfor_10_5    nop
hlt
