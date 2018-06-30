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
addi r14, r0, 4352  % Set the stack pointer
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
pas112_7    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal	% Calculating (x * y)
bz r1, pas212_7    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas112_7
pas212_7   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas312_7    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas212_7
pas312_7   divi r2, r2, 10000      % Make sure it's in the right for for performing multiplication
addi r3, r3, 4
divi r4, r4, 10000
addi r5, r5, 4
add r3, r3, r5
mul r2, r2, r4     % Perform (x * y)
addi r6, r0, 10000     % Make 100,000,000
muli r6, r6, 10000
cgei r7, r2, 0         % If we're dealing with a positive number, store the sign.
bnz r7, pas412_7
addi r7, r0, -1       % Otherwise, it's negative. Store the sign.
muli r2, r2, -1       % Also make r2 positive for now.
pas412_7 clt r1, r2, r6        % While realval < 100,000
bz r1, pas512_7
ceqi r1, r2, 0     % And also not 0
bnz r1, pas512_7
subi r3, r3, 1     % Shift it.
muli r2, r2, 10
j pas412_7
pas512_7    muli r6, r6, 10    % Make 1,000,000,000
pas612_7    cge r1, r2, r6     % While realval >= 1,000,000,000
bz r1, pas712_7
ceqi r1, r2, 0     % And also not 0
bnz r1, pas712_7
addi r3, r3, 1     % Shift it.
divi r2, r2, 10
j pas612_7
pas712_7   mul r2, r2, r7     % Apply the sign.
sw 40(r14), r2     % Store the new float val
sw 44(r14), r3
lw r1, 40(r14)	% Store the put value of (x * y) - loading 0 of 8
sw 92(r14), r1	% Store the put value of (x * y) - storing 0 of 8
lw r1, 44(r14)	% Store the put value of (x * y) - loading 4 of 8
sw 96(r14), r1	% Store the put value of (x * y) - storing 4 of 8
addi r14, r14, 88
jl r15, putf_func
subi r14, r14, 88
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
lw r2, 24(r14)	% Calculating (-10.0)
muli r2, r2, -1
sw 48(r14), r2
lw r2, 28(r14)	% Calculating (-10.0)
sw 52(r14), r2
lw r1, 48(r14)	% x=(-10.0) - loading 0 of 8
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 52(r14)	% x=(-10.0) - loading 4 of 8
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
pas112_11    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal	% Calculating (x * y)
bz r1, pas212_11    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas112_11
pas212_11   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas312_11    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas212_11
pas312_11   divi r2, r2, 10000      % Make sure it's in the right for for performing multiplication
addi r3, r3, 4
divi r4, r4, 10000
addi r5, r5, 4
add r3, r3, r5
mul r2, r2, r4     % Perform (x * y)
addi r6, r0, 10000     % Make 100,000,000
muli r6, r6, 10000
cgei r7, r2, 0         % If we're dealing with a positive number, store the sign.
bnz r7, pas412_11
addi r7, r0, -1       % Otherwise, it's negative. Store the sign.
muli r2, r2, -1       % Also make r2 positive for now.
pas412_11 clt r1, r2, r6        % While realval < 100,000
bz r1, pas512_11
ceqi r1, r2, 0     % And also not 0
bnz r1, pas512_11
subi r3, r3, 1     % Shift it.
muli r2, r2, 10
j pas412_11
pas512_11    muli r6, r6, 10    % Make 1,000,000,000
pas612_11    cge r1, r2, r6     % While realval >= 1,000,000,000
bz r1, pas712_11
ceqi r1, r2, 0     % And also not 0
bnz r1, pas712_11
addi r3, r3, 1     % Shift it.
divi r2, r2, 10
j pas612_11
pas712_11   mul r2, r2, r7     % Apply the sign.
sw 40(r14), r2     % Store the new float val
sw 44(r14), r3
lw r1, 40(r14)	% Store the put value of (x * y) - loading 0 of 8
sw 92(r14), r1	% Store the put value of (x * y) - storing 0 of 8
lw r1, 44(r14)	% Store the put value of (x * y) - loading 4 of 8
sw 96(r14), r1	% Store the put value of (x * y) - storing 4 of 8
addi r14, r14, 88
jl r15, putf_func
subi r14, r14, 88
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
lw r2, 24(r14)	% Calculating (-10.0)
muli r2, r2, -1
sw 48(r14), r2
lw r2, 28(r14)	% Calculating (-10.0)
sw 52(r14), r2
lw r1, 48(r14)	% x=(-10.0) - loading 0 of 8
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 52(r14)	% x=(-10.0) - loading 4 of 8
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
lw r2, 24(r14)	% Calculating (-10.0)
muli r2, r2, -1
sw 48(r14), r2
lw r2, 28(r14)	% Calculating (-10.0)
sw 52(r14), r2
lw r1, 48(r14)	% y=(-10.0) - loading 0 of 8
lw r2, 32(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 52(r14)	% y=(-10.0) - loading 4 of 8
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
pas112_15    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal	% Calculating (x * y)
bz r1, pas212_15    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas112_15
pas212_15   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas312_15    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas212_15
pas312_15   divi r2, r2, 10000      % Make sure it's in the right for for performing multiplication
addi r3, r3, 4
divi r4, r4, 10000
addi r5, r5, 4
add r3, r3, r5
mul r2, r2, r4     % Perform (x * y)
addi r6, r0, 10000     % Make 100,000,000
muli r6, r6, 10000
cgei r7, r2, 0         % If we're dealing with a positive number, store the sign.
bnz r7, pas412_15
addi r7, r0, -1       % Otherwise, it's negative. Store the sign.
muli r2, r2, -1       % Also make r2 positive for now.
pas412_15 clt r1, r2, r6        % While realval < 100,000
bz r1, pas512_15
ceqi r1, r2, 0     % And also not 0
bnz r1, pas512_15
subi r3, r3, 1     % Shift it.
muli r2, r2, 10
j pas412_15
pas512_15    muli r6, r6, 10    % Make 1,000,000,000
pas612_15    cge r1, r2, r6     % While realval >= 1,000,000,000
bz r1, pas712_15
ceqi r1, r2, 0     % And also not 0
bnz r1, pas712_15
addi r3, r3, 1     % Shift it.
divi r2, r2, 10
j pas612_15
pas712_15   mul r2, r2, r7     % Apply the sign.
sw 40(r14), r2     % Store the new float val
sw 44(r14), r3
lw r1, 40(r14)	% Store the put value of (x * y) - loading 0 of 8
sw 92(r14), r1	% Store the put value of (x * y) - storing 0 of 8
lw r1, 44(r14)	% Store the put value of (x * y) - loading 4 of 8
sw 96(r14), r1	% Store the put value of (x * y) - storing 4 of 8
addi r14, r14, 88
jl r15, putf_func
subi r14, r14, 88
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
pas112_19    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal	% Calculating (x / y)
bz r1, pas212_19    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas112_19
pas212_19   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas312_19    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas212_19
pas312_19   divi r2, r2, 10000      % Make sure it's in the right for for performing multiplication
addi r3, r3, 4
divi r4, r4, 10000
addi r5, r5, 4
sub r3, r3, r5
div r2, r2, r4     % Perform (x / y)
addi r6, r0, 10000     % Make 100,000,000
muli r6, r6, 10000
cgei r7, r2, 0         % If we're dealing with a positive number, store the sign.
bnz r7, pas412_19
addi r7, r0, -1       % Otherwise, it's negative. Store the sign.
muli r2, r2, -1       % Also make r2 positive for now.
pas412_19 clt r1, r2, r6        % While realval < 100,000
bz r1, pas512_19
ceqi r1, r2, 0     % And also not 0
bnz r1, pas512_19
subi r3, r3, 1     % Shift it.
muli r2, r2, 10
j pas412_19
pas512_19    muli r6, r6, 10    % Make 1,000,000,000
pas612_19    cge r1, r2, r6     % While realval >= 1,000,000,000
bz r1, pas712_19
ceqi r1, r2, 0     % And also not 0
bnz r1, pas712_19
addi r3, r3, 1     % Shift it.
divi r2, r2, 10
j pas612_19
pas712_19   mul r2, r2, r7     % Apply the sign.
sw 56(r14), r2     % Store the new float val
sw 60(r14), r3
lw r1, 56(r14)	% Store the put value of (x / y) - loading 0 of 8
sw 92(r14), r1	% Store the put value of (x / y) - storing 0 of 8
lw r1, 60(r14)	% Store the put value of (x / y) - loading 4 of 8
sw 96(r14), r1	% Store the put value of (x / y) - storing 4 of 8
addi r14, r14, 88
jl r15, putf_func
subi r14, r14, 88
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
lw r2, 24(r14)	% Calculating (-10.0)
muli r2, r2, -1
sw 48(r14), r2
lw r2, 28(r14)	% Calculating (-10.0)
sw 52(r14), r2
lw r1, 48(r14)	% x=(-10.0) - loading 0 of 8
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 52(r14)	% x=(-10.0) - loading 4 of 8
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
pas112_23    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal	% Calculating (x / y)
bz r1, pas212_23    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas112_23
pas212_23   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas312_23    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas212_23
pas312_23   divi r2, r2, 10000      % Make sure it's in the right for for performing multiplication
addi r3, r3, 4
divi r4, r4, 10000
addi r5, r5, 4
sub r3, r3, r5
div r2, r2, r4     % Perform (x / y)
addi r6, r0, 10000     % Make 100,000,000
muli r6, r6, 10000
cgei r7, r2, 0         % If we're dealing with a positive number, store the sign.
bnz r7, pas412_23
addi r7, r0, -1       % Otherwise, it's negative. Store the sign.
muli r2, r2, -1       % Also make r2 positive for now.
pas412_23 clt r1, r2, r6        % While realval < 100,000
bz r1, pas512_23
ceqi r1, r2, 0     % And also not 0
bnz r1, pas512_23
subi r3, r3, 1     % Shift it.
muli r2, r2, 10
j pas412_23
pas512_23    muli r6, r6, 10    % Make 1,000,000,000
pas612_23    cge r1, r2, r6     % While realval >= 1,000,000,000
bz r1, pas712_23
ceqi r1, r2, 0     % And also not 0
bnz r1, pas712_23
addi r3, r3, 1     % Shift it.
divi r2, r2, 10
j pas612_23
pas712_23   mul r2, r2, r7     % Apply the sign.
sw 56(r14), r2     % Store the new float val
sw 60(r14), r3
lw r1, 56(r14)	% Store the put value of (x / y) - loading 0 of 8
sw 92(r14), r1	% Store the put value of (x / y) - storing 0 of 8
lw r1, 60(r14)	% Store the put value of (x / y) - loading 4 of 8
sw 96(r14), r1	% Store the put value of (x / y) - storing 4 of 8
addi r14, r14, 88
jl r15, putf_func
subi r14, r14, 88
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
lw r2, 24(r14)	% Calculating (-10.0)
muli r2, r2, -1
sw 48(r14), r2
lw r2, 28(r14)	% Calculating (-10.0)
sw 52(r14), r2
lw r1, 48(r14)	% x=(-10.0) - loading 0 of 8
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 52(r14)	% x=(-10.0) - loading 4 of 8
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
lw r2, 24(r14)	% Calculating (-10.0)
muli r2, r2, -1
sw 48(r14), r2
lw r2, 28(r14)	% Calculating (-10.0)
sw 52(r14), r2
lw r1, 48(r14)	% y=(-10.0) - loading 0 of 8
lw r2, 32(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 52(r14)	% y=(-10.0) - loading 4 of 8
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
pas112_27    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal	% Calculating (x / y)
bz r1, pas212_27    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas112_27
pas212_27   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas312_27    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas212_27
pas312_27   divi r2, r2, 10000      % Make sure it's in the right for for performing multiplication
addi r3, r3, 4
divi r4, r4, 10000
addi r5, r5, 4
sub r3, r3, r5
div r2, r2, r4     % Perform (x / y)
addi r6, r0, 10000     % Make 100,000,000
muli r6, r6, 10000
cgei r7, r2, 0         % If we're dealing with a positive number, store the sign.
bnz r7, pas412_27
addi r7, r0, -1       % Otherwise, it's negative. Store the sign.
muli r2, r2, -1       % Also make r2 positive for now.
pas412_27 clt r1, r2, r6        % While realval < 100,000
bz r1, pas512_27
ceqi r1, r2, 0     % And also not 0
bnz r1, pas512_27
subi r3, r3, 1     % Shift it.
muli r2, r2, 10
j pas412_27
pas512_27    muli r6, r6, 10    % Make 1,000,000,000
pas612_27    cge r1, r2, r6     % While realval >= 1,000,000,000
bz r1, pas712_27
ceqi r1, r2, 0     % And also not 0
bnz r1, pas712_27
addi r3, r3, 1     % Shift it.
divi r2, r2, 10
j pas612_27
pas712_27   mul r2, r2, r7     % Apply the sign.
sw 56(r14), r2     % Store the new float val
sw 60(r14), r3
lw r1, 56(r14)	% Store the put value of (x / y) - loading 0 of 8
sw 92(r14), r1	% Store the put value of (x / y) - storing 0 of 8
lw r1, 60(r14)	% Store the put value of (x / y) - loading 4 of 8
sw 96(r14), r1	% Store the put value of (x / y) - storing 4 of 8
addi r14, r14, 88
jl r15, putf_func
subi r14, r14, 88
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
addi r1, r0, 144	% Storing 144
sb 64(r14), r1
addi r1, r0, 178	% Storing 178
sb 65(r14), r1
addi r1, r0, 91	% Storing 91
sb 66(r14), r1
addi r1, r0, 7	% Storing 7
sb 67(r14), r1
addi r1, r0, 249	% Storing 249
sb 68(r14), r1
addi r1, r0, 255	% Storing 255
sb 69(r14), r1
addi r1, r0, 255	% Storing 255
sb 70(r14), r1
addi r1, r0, 255	% Storing 255
sb 71(r14), r1
lw r1, 64(r14)	% x=12.345 - loading 0 of 8
lw r2, 16(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 68(r14)	% x=12.345 - loading 4 of 8
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
sb 72(r14), r1
addi r1, r0, 49	% Storing 49
sb 73(r14), r1
addi r1, r0, 119	% Storing 119
sb 74(r14), r1
addi r1, r0, 40	% Storing 40
sb 75(r14), r1
addi r1, r0, 249	% Storing 249
sb 76(r14), r1
addi r1, r0, 255	% Storing 255
sb 77(r14), r1
addi r1, r0, 255	% Storing 255
sb 78(r14), r1
addi r1, r0, 255	% Storing 255
sb 79(r14), r1
lw r1, 72(r14)	% y=67.89 - loading 0 of 8
lw r2, 32(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 76(r14)	% y=67.89 - loading 4 of 8
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
pas112_32    cgt r1, r3, r5     % While r3 > r5, shift it until they're equal	% Calculating (y * x)
bz r1, pas212_32    % Otherwise, continue.
addi r5, r5, 1
divi r4, r4, 10
j pas112_32
pas212_32   cgt r1, r5, r3      % While r5 > r3, shift it until they're equal
bz r1, pas312_32    % Otherwise, continue.
addi r3, r3, 1
divi r2, r2, 10
j pas212_32
pas312_32   divi r2, r2, 10000      % Make sure it's in the right for for performing multiplication
addi r3, r3, 4
divi r4, r4, 10000
addi r5, r5, 4
add r3, r3, r5
mul r2, r2, r4     % Perform (y * x)
addi r6, r0, 10000     % Make 100,000,000
muli r6, r6, 10000
cgei r7, r2, 0         % If we're dealing with a positive number, store the sign.
bnz r7, pas412_32
addi r7, r0, -1       % Otherwise, it's negative. Store the sign.
muli r2, r2, -1       % Also make r2 positive for now.
pas412_32 clt r1, r2, r6        % While realval < 100,000
bz r1, pas512_32
ceqi r1, r2, 0     % And also not 0
bnz r1, pas512_32
subi r3, r3, 1     % Shift it.
muli r2, r2, 10
j pas412_32
pas512_32    muli r6, r6, 10    % Make 1,000,000,000
pas612_32    cge r1, r2, r6     % While realval >= 1,000,000,000
bz r1, pas712_32
ceqi r1, r2, 0     % And also not 0
bnz r1, pas712_32
addi r3, r3, 1     % Shift it.
divi r2, r2, 10
j pas612_32
pas712_32   mul r2, r2, r7     % Apply the sign.
sw 80(r14), r2     % Store the new float val
sw 84(r14), r3
lw r1, 80(r14)	% Store the put value of (y * x) - loading 0 of 8
sw 92(r14), r1	% Store the put value of (y * x) - storing 0 of 8
lw r1, 84(r14)	% Store the put value of (y * x) - loading 4 of 8
sw 96(r14), r1	% Store the put value of (y * x) - storing 4 of 8
addi r14, r14, 88
jl r15, putf_func
subi r14, r14, 88
hlt
