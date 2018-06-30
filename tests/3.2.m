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
addi r14, r0, 2100  % Set the stack pointer
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
addi r1, r0, 10	% Storing 10
sb 12(r14), r1
addi r1, r0, 0	% Storing 0
sb 13(r14), r1
addi r1, r0, 0	% Storing 0
sb 14(r14), r1
addi r1, r0, 0	% Storing 0
sb 15(r14), r1
lw r1, 12(r14)	% x=10 - loading 0 of 4
lw r2, 8(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r0, 20	% Storing 20
sb 20(r14), r1
addi r1, r0, 0	% Storing 0
sb 21(r14), r1
addi r1, r0, 0	% Storing 0
sb 22(r14), r1
addi r1, r0, 0	% Storing 0
sb 23(r14), r1
lw r1, 20(r14)	% y=20 - loading 0 of 4
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
lw r2, 8(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 16(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
clt r1, r2, r3	% Evaluate (x < y)
sw 24(r14), r1
lw r1, 24(r14)	% Loading the value of (x < y)
bz r1, else_8_5	% If (x < y).
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
lw r2, 16(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 8(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
cgt r1, r2, r3	% Evaluate (y > x)
sw 28(r14), r1
lw r1, 28(r14)	% Loading the value of (y > x)
bz r1, else_9_9	% If (y > x).
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
addi r1, r0, 10	% Storing 10
sb 12(r14), r1
addi r1, r0, 0	% Storing 0
sb 13(r14), r1
addi r1, r0, 0	% Storing 0
sb 14(r14), r1
addi r1, r0, 0	% Storing 0
sb 15(r14), r1
lw r1, 12(r14)	% x=10 - loading 0 of 4
lw r2, 8(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r0, 10	% Storing 10
sb 12(r14), r1
addi r1, r0, 0	% Storing 0
sb 13(r14), r1
addi r1, r0, 0	% Storing 0
sb 14(r14), r1
addi r1, r0, 0	% Storing 0
sb 15(r14), r1
lw r1, 12(r14)	% y=10 - loading 0 of 4
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
lw r2, 16(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 8(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
cge r1, r2, r3	% Evaluate (y >= x)
sw 32(r14), r1
lw r1, 32(r14)	% Loading the value of (y >= x)
bz r1, else_13_13	% If (y >= x).
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
lw r2, 8(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 16(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
cge r1, r2, r3	% Evaluate (x >= y)
sw 36(r14), r1
lw r1, 36(r14)	% Loading the value of (x >= y)
bz r1, else_14_17	% If (x >= y).
addi r1, r0, 57	% Storing 57
sb 40(r14), r1
addi r1, r0, 48	% Storing 48
sb 41(r14), r1
addi r1, r0, 0	% Storing 0
sb 42(r14), r1
addi r1, r0, 0	% Storing 0
sb 43(r14), r1
lw r1, 40(r14)	% Store the put value of 12345 - loading 0 of 4
sw 68(r14), r1	% Store the put value of 12345 - storing 0 of 4
addi r14, r14, 64
jl r15, puti_func
subi r14, r14, 64
j endif_14_17	% Go to the end of the else block.
else_14_17    nop	% Start the else block
addi r1, r0, 1	% Storing 1
sb 44(r14), r1
addi r1, r0, 0	% Storing 0
sb 45(r14), r1
addi r1, r0, 0	% Storing 0
sb 46(r14), r1
addi r1, r0, 0	% Storing 0
sb 47(r14), r1
lw r2, 44(r14)	% Calculating (-1)
muli r2, r2, -1
sw 48(r14), r2
lw r1, 48(r14)	% Store the put value of (-1) - loading 0 of 4
sw 68(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 64
jl r15, puti_func
subi r14, r14, 64
endif_14_17    nop	% End the else block
j endif_13_13	% Go to the end of the else block.
else_13_13    nop	% Start the else block
addi r1, r0, 1	% Storing 1
sb 44(r14), r1
addi r1, r0, 0	% Storing 0
sb 45(r14), r1
addi r1, r0, 0	% Storing 0
sb 46(r14), r1
addi r1, r0, 0	% Storing 0
sb 47(r14), r1
lw r2, 44(r14)	% Calculating (-1)
muli r2, r2, -1
sw 48(r14), r2
lw r1, 48(r14)	% Store the put value of (-1) - loading 0 of 4
sw 68(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 64
jl r15, puti_func
subi r14, r14, 64
endif_13_13    nop	% End the else block
j endif_9_9	% Go to the end of the else block.
else_9_9    nop	% Start the else block
addi r1, r0, 1	% Storing 1
sb 44(r14), r1
addi r1, r0, 0	% Storing 0
sb 45(r14), r1
addi r1, r0, 0	% Storing 0
sb 46(r14), r1
addi r1, r0, 0	% Storing 0
sb 47(r14), r1
lw r2, 44(r14)	% Calculating (-1)
muli r2, r2, -1
sw 48(r14), r2
lw r1, 48(r14)	% Store the put value of (-1) - loading 0 of 4
sw 68(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 64
jl r15, puti_func
subi r14, r14, 64
endif_9_9    nop	% End the else block
j endif_8_5	% Go to the end of the else block.
else_8_5    nop	% Start the else block
addi r1, r0, 1	% Storing 1
sb 44(r14), r1
addi r1, r0, 0	% Storing 0
sb 45(r14), r1
addi r1, r0, 0	% Storing 0
sb 46(r14), r1
addi r1, r0, 0	% Storing 0
sb 47(r14), r1
lw r2, 44(r14)	% Calculating (-1)
muli r2, r2, -1
sw 48(r14), r2
lw r1, 48(r14)	% Store the put value of (-1) - loading 0 of 4
sw 68(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 64
jl r15, puti_func
subi r14, r14, 64
endif_8_5    nop	% End the else block
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
addi r1, r0, 10	% Storing 10
sb 12(r14), r1
addi r1, r0, 0	% Storing 0
sb 13(r14), r1
addi r1, r0, 0	% Storing 0
sb 14(r14), r1
addi r1, r0, 0	% Storing 0
sb 15(r14), r1
lw r1, 12(r14)	% x=10 - loading 0 of 4
lw r2, 8(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r0, 20	% Storing 20
sb 20(r14), r1
addi r1, r0, 0	% Storing 0
sb 21(r14), r1
addi r1, r0, 0	% Storing 0
sb 22(r14), r1
addi r1, r0, 0	% Storing 0
sb 23(r14), r1
lw r1, 20(r14)	% y=20 - loading 0 of 4
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
lw r2, 8(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 16(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
cgt r1, r2, r3	% Evaluate (x > y)
sw 52(r14), r1
lw r1, 52(r14)	% Loading the value of (x > y)
bz r1, else_32_5	% If (x > y).
addi r1, r0, 1	% Storing 1
sb 44(r14), r1
addi r1, r0, 0	% Storing 0
sb 45(r14), r1
addi r1, r0, 0	% Storing 0
sb 46(r14), r1
addi r1, r0, 0	% Storing 0
sb 47(r14), r1
lw r2, 44(r14)	% Calculating (-1)
muli r2, r2, -1
sw 48(r14), r2
lw r1, 48(r14)	% Store the put value of (-1) - loading 0 of 4
sw 68(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 64
jl r15, puti_func
subi r14, r14, 64
j endif_32_5	% Go to the end of the else block.
else_32_5    nop	% Start the else block
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
lw r2, 16(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 8(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
clt r1, r2, r3	% Evaluate (y < x)
sw 56(r14), r1
lw r1, 56(r14)	% Loading the value of (y < x)
bz r1, else_35_9	% If (y < x).
addi r1, r0, 1	% Storing 1
sb 44(r14), r1
addi r1, r0, 0	% Storing 0
sb 45(r14), r1
addi r1, r0, 0	% Storing 0
sb 46(r14), r1
addi r1, r0, 0	% Storing 0
sb 47(r14), r1
lw r2, 44(r14)	% Calculating (-1)
muli r2, r2, -1
sw 48(r14), r2
lw r1, 48(r14)	% Store the put value of (-1) - loading 0 of 4
sw 68(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 64
jl r15, puti_func
subi r14, r14, 64
j endif_35_9	% Go to the end of the else block.
else_35_9    nop	% Start the else block
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
lw r2, 8(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 16(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
cge r1, r2, r3	% Evaluate (x >= y)
sw 36(r14), r1
lw r1, 36(r14)	% Loading the value of (x >= y)
bz r1, else_38_13	% If (x >= y).
addi r1, r0, 1	% Storing 1
sb 44(r14), r1
addi r1, r0, 0	% Storing 0
sb 45(r14), r1
addi r1, r0, 0	% Storing 0
sb 46(r14), r1
addi r1, r0, 0	% Storing 0
sb 47(r14), r1
lw r2, 44(r14)	% Calculating (-1)
muli r2, r2, -1
sw 48(r14), r2
lw r1, 48(r14)	% Store the put value of (-1) - loading 0 of 4
sw 68(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 64
jl r15, puti_func
subi r14, r14, 64
j endif_38_13	% Go to the end of the else block.
else_38_13    nop	% Start the else block
addi r1, r0, 4	% Start to calculate the offset for y
sw 16(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 8(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 8(r14)
add r1, r1, r2
sw 8(r14), r1
lw r2, 16(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 8(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
cle r1, r2, r3	% Evaluate (y <= x)
sw 60(r14), r1
lw r1, 60(r14)	% Loading the value of (y <= x)
bz r1, else_41_17	% If (y <= x).
addi r1, r0, 1	% Storing 1
sb 44(r14), r1
addi r1, r0, 0	% Storing 0
sb 45(r14), r1
addi r1, r0, 0	% Storing 0
sb 46(r14), r1
addi r1, r0, 0	% Storing 0
sb 47(r14), r1
lw r2, 44(r14)	% Calculating (-1)
muli r2, r2, -1
sw 48(r14), r2
lw r1, 48(r14)	% Store the put value of (-1) - loading 0 of 4
sw 68(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 64
jl r15, puti_func
subi r14, r14, 64
j endif_41_17	% Go to the end of the else block.
else_41_17    nop	% Start the else block
addi r1, r0, 57	% Storing 57
sb 40(r14), r1
addi r1, r0, 48	% Storing 48
sb 41(r14), r1
addi r1, r0, 0	% Storing 0
sb 42(r14), r1
addi r1, r0, 0	% Storing 0
sb 43(r14), r1
lw r1, 40(r14)	% Store the put value of 12345 - loading 0 of 4
sw 68(r14), r1	% Store the put value of 12345 - storing 0 of 4
addi r14, r14, 64
jl r15, puti_func
subi r14, r14, 64
endif_41_17    nop	% End the else block
endif_38_13    nop	% End the else block
endif_35_9    nop	% End the else block
endif_32_5    nop	% End the else block
hlt
