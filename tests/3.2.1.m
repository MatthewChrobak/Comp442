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
addi r14, r0, 3324  % Set the stack pointer
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r0, 0	% Storing 0
sb 24(r14), r1
addi r1, r0, 225	% Storing 225
sb 25(r14), r1
addi r1, r0, 245	% Storing 245
sb 26(r14), r1
addi r1, r0, 5	% Storing 5
sb 27(r14), r1
addi r1, r0, 249	% Storing 249
sb 28(r14), r1
addi r1, r0, 255	% Storing 255
sb 29(r14), r1
addi r1, r0, 255	% Storing 255
sb 30(r14), r1
addi r1, r0, 255	% Storing 255
sb 31(r14), r1
lw r1, 24(r14)	% x=10.0 - loading 0 of 8
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 28(r14)	% x=10.0 - loading 4 of 8
lw r2, 16(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r0, 0	% Storing 0
sb 40(r14), r1
addi r1, r0, 194	% Storing 194
sb 41(r14), r1
addi r1, r0, 235	% Storing 235
sb 42(r14), r1
addi r1, r0, 11	% Storing 11
sb 43(r14), r1
addi r1, r0, 249	% Storing 249
sb 44(r14), r1
addi r1, r0, 255	% Storing 255
sb 45(r14), r1
addi r1, r0, 255	% Storing 255
sb 46(r14), r1
addi r1, r0, 255	% Storing 255
sb 47(r14), r1
lw r1, 40(r14)	% y=20.0 - loading 0 of 8
lw r2, 32(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 44(r14)	% y=20.0 - loading 4 of 8
lw r2, 32(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
lw r2, 16(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 20(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
lw r4, 32(r14)	% Loading the value of y
lw r4, 0(r4)	% Pointer detected. Dereferencing y
lw r5, 36(r14)	% Loading the value of y
lw r5, 0(r5)	% Pointer detected. Dereferencing y
pas111_8    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal
bz r1, pas211_8    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas111_8
pas211_8   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas311_8    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas211_8
pas311_8     add r3, r0, r4    % Put everything into r2 and r3 registers
lw r2, 16(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 32(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
clt r1, r2, r3	% Evaluate (x < y)
sw 48(r14), r1
lw r1, 48(r14)	% Loading the value of (x < y)
bz r1, else_8_5	% If (x < y).
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 36(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
lw r4, 16(r14)	% Loading the value of x
lw r4, 0(r4)	% Pointer detected. Dereferencing x
lw r5, 20(r14)	% Loading the value of x
lw r5, 0(r5)	% Pointer detected. Dereferencing x
pas115_9    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal
bz r1, pas215_9    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas115_9
pas215_9   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas315_9    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas215_9
pas315_9     add r3, r0, r4    % Put everything into r2 and r3 registers
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 16(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
cgt r1, r2, r3	% Evaluate (y > x)
sw 56(r14), r1
lw r1, 56(r14)	% Loading the value of (y > x)
bz r1, else_9_9	% If (y > x).
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r0, 0	% Storing 0
sb 24(r14), r1
addi r1, r0, 225	% Storing 225
sb 25(r14), r1
addi r1, r0, 245	% Storing 245
sb 26(r14), r1
addi r1, r0, 5	% Storing 5
sb 27(r14), r1
addi r1, r0, 249	% Storing 249
sb 28(r14), r1
addi r1, r0, 255	% Storing 255
sb 29(r14), r1
addi r1, r0, 255	% Storing 255
sb 30(r14), r1
addi r1, r0, 255	% Storing 255
sb 31(r14), r1
lw r1, 24(r14)	% x=10.0 - loading 0 of 8
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 28(r14)	% x=10.0 - loading 4 of 8
lw r2, 16(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r0, 0	% Storing 0
sb 24(r14), r1
addi r1, r0, 225	% Storing 225
sb 25(r14), r1
addi r1, r0, 245	% Storing 245
sb 26(r14), r1
addi r1, r0, 5	% Storing 5
sb 27(r14), r1
addi r1, r0, 249	% Storing 249
sb 28(r14), r1
addi r1, r0, 255	% Storing 255
sb 29(r14), r1
addi r1, r0, 255	% Storing 255
sb 30(r14), r1
addi r1, r0, 255	% Storing 255
sb 31(r14), r1
lw r1, 24(r14)	% y=10.0 - loading 0 of 8
lw r2, 32(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 28(r14)	% y=10.0 - loading 4 of 8
lw r2, 32(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 36(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
lw r4, 16(r14)	% Loading the value of x
lw r4, 0(r4)	% Pointer detected. Dereferencing x
lw r5, 20(r14)	% Loading the value of x
lw r5, 0(r5)	% Pointer detected. Dereferencing x
pas119_13    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal
bz r1, pas219_13    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas119_13
pas219_13   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas319_13    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas219_13
pas319_13     add r3, r0, r4    % Put everything into r2 and r3 registers
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 16(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
cge r1, r2, r3	% Evaluate (y >= x)
sw 64(r14), r1
lw r1, 64(r14)	% Loading the value of (y >= x)
bz r1, else_13_13	% If (y >= x).
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
lw r2, 16(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 20(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
lw r4, 32(r14)	% Loading the value of y
lw r4, 0(r4)	% Pointer detected. Dereferencing y
lw r5, 36(r14)	% Loading the value of y
lw r5, 0(r5)	% Pointer detected. Dereferencing y
pas123_14    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal
bz r1, pas223_14    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas123_14
pas223_14   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas323_14    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas223_14
pas323_14     add r3, r0, r4    % Put everything into r2 and r3 registers
lw r2, 16(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 32(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
cge r1, r2, r3	% Evaluate (x >= y)
sw 72(r14), r1
lw r1, 72(r14)	% Loading the value of (x >= y)
bz r1, else_14_17	% If (x >= y).
addi r1, r0, 57	% Storing 57
sb 80(r14), r1
addi r1, r0, 48	% Storing 48
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r1, 80(r14)	% Store the put value of 12345 - loading 0 of 4
sw 120(r14), r1	% Store the put value of 12345 - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
j endif_14_17	% Go to the end of the else block.
else_14_17    nop	% Start the else block
addi r1, r0, 1	% Storing 1
sb 84(r14), r1
addi r1, r0, 0	% Storing 0
sb 85(r14), r1
addi r1, r0, 0	% Storing 0
sb 86(r14), r1
addi r1, r0, 0	% Storing 0
sb 87(r14), r1
lw r2, 84(r14)	% Calculating (-1)
muli r2, r2, -1
sw 88(r14), r2
lw r1, 88(r14)	% Store the put value of (-1) - loading 0 of 4
sw 120(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
endif_14_17    nop	% End the else block
j endif_13_13	% Go to the end of the else block.
else_13_13    nop	% Start the else block
addi r1, r0, 1	% Storing 1
sb 84(r14), r1
addi r1, r0, 0	% Storing 0
sb 85(r14), r1
addi r1, r0, 0	% Storing 0
sb 86(r14), r1
addi r1, r0, 0	% Storing 0
sb 87(r14), r1
lw r2, 84(r14)	% Calculating (-1)
muli r2, r2, -1
sw 88(r14), r2
lw r1, 88(r14)	% Store the put value of (-1) - loading 0 of 4
sw 120(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
endif_13_13    nop	% End the else block
j endif_9_9	% Go to the end of the else block.
else_9_9    nop	% Start the else block
addi r1, r0, 1	% Storing 1
sb 84(r14), r1
addi r1, r0, 0	% Storing 0
sb 85(r14), r1
addi r1, r0, 0	% Storing 0
sb 86(r14), r1
addi r1, r0, 0	% Storing 0
sb 87(r14), r1
lw r2, 84(r14)	% Calculating (-1)
muli r2, r2, -1
sw 88(r14), r2
lw r1, 88(r14)	% Store the put value of (-1) - loading 0 of 4
sw 120(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
endif_9_9    nop	% End the else block
j endif_8_5	% Go to the end of the else block.
else_8_5    nop	% Start the else block
addi r1, r0, 1	% Storing 1
sb 84(r14), r1
addi r1, r0, 0	% Storing 0
sb 85(r14), r1
addi r1, r0, 0	% Storing 0
sb 86(r14), r1
addi r1, r0, 0	% Storing 0
sb 87(r14), r1
lw r2, 84(r14)	% Calculating (-1)
muli r2, r2, -1
sw 88(r14), r2
lw r1, 88(r14)	% Store the put value of (-1) - loading 0 of 4
sw 120(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
endif_8_5    nop	% End the else block
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r0, 0	% Storing 0
sb 24(r14), r1
addi r1, r0, 225	% Storing 225
sb 25(r14), r1
addi r1, r0, 245	% Storing 245
sb 26(r14), r1
addi r1, r0, 5	% Storing 5
sb 27(r14), r1
addi r1, r0, 249	% Storing 249
sb 28(r14), r1
addi r1, r0, 255	% Storing 255
sb 29(r14), r1
addi r1, r0, 255	% Storing 255
sb 30(r14), r1
addi r1, r0, 255	% Storing 255
sb 31(r14), r1
lw r1, 24(r14)	% x=10.0 - loading 0 of 8
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 28(r14)	% x=10.0 - loading 4 of 8
lw r2, 16(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r0, 0	% Storing 0
sb 40(r14), r1
addi r1, r0, 194	% Storing 194
sb 41(r14), r1
addi r1, r0, 235	% Storing 235
sb 42(r14), r1
addi r1, r0, 11	% Storing 11
sb 43(r14), r1
addi r1, r0, 249	% Storing 249
sb 44(r14), r1
addi r1, r0, 255	% Storing 255
sb 45(r14), r1
addi r1, r0, 255	% Storing 255
sb 46(r14), r1
addi r1, r0, 255	% Storing 255
sb 47(r14), r1
lw r1, 40(r14)	% y=20.0 - loading 0 of 8
lw r2, 32(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 44(r14)	% y=20.0 - loading 4 of 8
lw r2, 32(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
lw r2, 16(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 20(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
lw r4, 32(r14)	% Loading the value of y
lw r4, 0(r4)	% Pointer detected. Dereferencing y
lw r5, 36(r14)	% Loading the value of y
lw r5, 0(r5)	% Pointer detected. Dereferencing y
pas111_32    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal
bz r1, pas211_32    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas111_32
pas211_32   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas311_32    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas211_32
pas311_32     add r3, r0, r4    % Put everything into r2 and r3 registers
lw r2, 16(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 32(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
cgt r1, r2, r3	% Evaluate (x > y)
sw 92(r14), r1
lw r1, 92(r14)	% Loading the value of (x > y)
bz r1, else_32_5	% If (x > y).
addi r1, r0, 1	% Storing 1
sb 84(r14), r1
addi r1, r0, 0	% Storing 0
sb 85(r14), r1
addi r1, r0, 0	% Storing 0
sb 86(r14), r1
addi r1, r0, 0	% Storing 0
sb 87(r14), r1
lw r2, 84(r14)	% Calculating (-1)
muli r2, r2, -1
sw 88(r14), r2
lw r1, 88(r14)	% Store the put value of (-1) - loading 0 of 4
sw 120(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
j endif_32_5	% Go to the end of the else block.
else_32_5    nop	% Start the else block
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 36(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
lw r4, 16(r14)	% Loading the value of x
lw r4, 0(r4)	% Pointer detected. Dereferencing x
lw r5, 20(r14)	% Loading the value of x
lw r5, 0(r5)	% Pointer detected. Dereferencing x
pas115_35    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal
bz r1, pas215_35    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas115_35
pas215_35   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas315_35    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas215_35
pas315_35     add r3, r0, r4    % Put everything into r2 and r3 registers
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 16(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
clt r1, r2, r3	% Evaluate (y < x)
sw 100(r14), r1
lw r1, 100(r14)	% Loading the value of (y < x)
bz r1, else_35_9	% If (y < x).
addi r1, r0, 1	% Storing 1
sb 84(r14), r1
addi r1, r0, 0	% Storing 0
sb 85(r14), r1
addi r1, r0, 0	% Storing 0
sb 86(r14), r1
addi r1, r0, 0	% Storing 0
sb 87(r14), r1
lw r2, 84(r14)	% Calculating (-1)
muli r2, r2, -1
sw 88(r14), r2
lw r1, 88(r14)	% Store the put value of (-1) - loading 0 of 4
sw 120(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
j endif_35_9	% Go to the end of the else block.
else_35_9    nop	% Start the else block
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
lw r2, 16(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 20(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
lw r4, 32(r14)	% Loading the value of y
lw r4, 0(r4)	% Pointer detected. Dereferencing y
lw r5, 36(r14)	% Loading the value of y
lw r5, 0(r5)	% Pointer detected. Dereferencing y
pas119_38    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal
bz r1, pas219_38    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas119_38
pas219_38   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas319_38    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas219_38
pas319_38     add r3, r0, r4    % Put everything into r2 and r3 registers
lw r2, 16(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 32(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
cge r1, r2, r3	% Evaluate (x >= y)
sw 72(r14), r1
lw r1, 72(r14)	% Loading the value of (x >= y)
bz r1, else_38_13	% If (x >= y).
addi r1, r0, 1	% Storing 1
sb 84(r14), r1
addi r1, r0, 0	% Storing 0
sb 85(r14), r1
addi r1, r0, 0	% Storing 0
sb 86(r14), r1
addi r1, r0, 0	% Storing 0
sb 87(r14), r1
lw r2, 84(r14)	% Calculating (-1)
muli r2, r2, -1
sw 88(r14), r2
lw r1, 88(r14)	% Store the put value of (-1) - loading 0 of 4
sw 120(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
j endif_38_13	% Go to the end of the else block.
else_38_13    nop	% Start the else block
addi r1, r0, 8	% Start to calculate the offset for y
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 32(r14)
add r1, r1, r2
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 16(r14)
add r1, r1, r2
sw 16(r14), r1
addi r1, r1, 4
sw 20(r14), r1
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 36(r14)	% Loading the value of y
lw r3, 0(r3)	% Pointer detected. Dereferencing y
lw r4, 16(r14)	% Loading the value of x
lw r4, 0(r4)	% Pointer detected. Dereferencing x
lw r5, 20(r14)	% Loading the value of x
lw r5, 0(r5)	% Pointer detected. Dereferencing x
pas123_41    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal
bz r1, pas223_41    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas123_41
pas223_41   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas323_41    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas223_41
pas323_41     add r3, r0, r4    % Put everything into r2 and r3 registers
lw r2, 32(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 16(r14)	% Loading the value of x
lw r3, 0(r3)	% Pointer detected. Dereferencing x
cle r1, r2, r3	% Evaluate (y <= x)
sw 108(r14), r1
lw r1, 108(r14)	% Loading the value of (y <= x)
bz r1, else_41_17	% If (y <= x).
addi r1, r0, 1	% Storing 1
sb 84(r14), r1
addi r1, r0, 0	% Storing 0
sb 85(r14), r1
addi r1, r0, 0	% Storing 0
sb 86(r14), r1
addi r1, r0, 0	% Storing 0
sb 87(r14), r1
lw r2, 84(r14)	% Calculating (-1)
muli r2, r2, -1
sw 88(r14), r2
lw r1, 88(r14)	% Store the put value of (-1) - loading 0 of 4
sw 120(r14), r1	% Store the put value of (-1) - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
j endif_41_17	% Go to the end of the else block.
else_41_17    nop	% Start the else block
addi r1, r0, 57	% Storing 57
sb 80(r14), r1
addi r1, r0, 48	% Storing 48
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r1, 80(r14)	% Store the put value of 12345 - loading 0 of 4
sw 120(r14), r1	% Store the put value of 12345 - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
endif_41_17    nop	% End the else block
endif_38_13    nop	% End the else block
endif_35_9    nop	% End the else block
endif_32_5    nop	% End the else block
hlt
