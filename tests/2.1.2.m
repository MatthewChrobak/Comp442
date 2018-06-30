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
addi r1, r0, 4048	% Start to calculate the offset for num
sw 4068(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for num
lw r2, 4068(r14)
add r1, r1, r2
sw 4068(r14), r1
addi r1, r0, 0	% Storing 0
sb 4072(r14), r1
addi r1, r0, 0	% Storing 0
sb 4073(r14), r1
addi r1, r0, 0	% Storing 0
sb 4074(r14), r1
addi r1, r0, 0	% Storing 0
sb 4075(r14), r1
lw r1, 4072(r14)	% num=0 - loading 0 of 4
lw r2, 4068(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Storing 0
sb 4072(r14), r1
addi r1, r0, 0	% Storing 0
sb 4073(r14), r1
addi r1, r0, 0	% Storing 0
sb 4074(r14), r1
addi r1, r0, 0	% Storing 0
sb 4075(r14), r1
lw r1, 4072(r14)	% int i = 0 - loading 0 of 4
sw 4052(r14), r1	% int i = 0 - storing 0 of 4
j forcond_9_5
for_9_5    nop	% Start the for loop
addi r1, r0, 4052	% Start to calculate the offset for i
sw 4076(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 4076(r14)
add r1, r1, r2
sw 4076(r14), r1
addi r1, r0, 4052	% Start to calculate the offset for i
sw 4076(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 4076(r14)
add r1, r1, r2
sw 4076(r14), r1
addi r1, r0, 1	% Storing 1
sb 4080(r14), r1
addi r1, r0, 0	% Storing 0
sb 4081(r14), r1
addi r1, r0, 0	% Storing 0
sb 4082(r14), r1
addi r1, r0, 0	% Storing 0
sb 4083(r14), r1
lw r2, 4076(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 4080(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (i + 1)
sw 4084(r14), r1
lw r1, 4084(r14)	% i=(i + 1) - loading 0 of 4
lw r2, 4076(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_9_5   nop
addi r1, r0, 4052	% Start to calculate the offset for i
sw 4076(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 4076(r14)
add r1, r1, r2
sw 4076(r14), r1
addi r1, r0, 10	% Storing 10
sb 4088(r14), r1
addi r1, r0, 0	% Storing 0
sb 4089(r14), r1
addi r1, r0, 0	% Storing 0
sb 4090(r14), r1
addi r1, r0, 0	% Storing 0
sb 4091(r14), r1
lw r2, 4076(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 4088(r14)	% Loading the value of 10
clt r1, r2, r3	% Evaluate (i < 10)
sw 4092(r14), r1
lw r1, 4092(r14)	% Loading the value of (i < 10)
bz r1, endfor_9_5
addi r1, r0, 4052	% Start to calculate the offset for i
sw 4076(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 4076(r14)
add r1, r1, r2
sw 4076(r14), r1
addi r1, r0, 8	% Start to calculate the offset for array[i]
lw r2, 4076(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 4096(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for array[i]
lw r2, 4096(r14)
add r1, r1, r2
sw 4096(r14), r1
addi r1, r0, 4052	% Start to calculate the offset for i
sw 4076(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 4076(r14)
add r1, r1, r2
sw 4076(r14), r1
lw r1, 4076(r14)	% array[i]=i - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 4096(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 4052	% Start to calculate the offset for i
sw 4076(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 4076(r14)
add r1, r1, r2
sw 4076(r14), r1
addi r1, r0, 8	% Start to calculate the offset for array[i]
lw r2, 4076(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 4096(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for array[i]
lw r2, 4096(r14)
add r1, r1, r2
sw 4096(r14), r1
lw r1, 4096(r14)	% Store the put value of array[i] - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 4156(r14), r1	% Store the put value of array[i] - storing 0 of 4
addi r14, r14, 4152
jl r15, puti_func
subi r14, r14, 4152
j for_9_5
endfor_9_5    nop
addi r1, r0, 0	% Storing 0
sb 4072(r14), r1
addi r1, r0, 0	% Storing 0
sb 4073(r14), r1
addi r1, r0, 0	% Storing 0
sb 4074(r14), r1
addi r1, r0, 0	% Storing 0
sb 4075(r14), r1
lw r1, 4072(r14)	% int x = 0 - loading 0 of 4
sw 4056(r14), r1	% int x = 0 - storing 0 of 4
j forcond_14_5
for_14_5    nop	% Start the for loop
addi r1, r0, 4056	% Start to calculate the offset for x
sw 4100(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 4100(r14)
add r1, r1, r2
sw 4100(r14), r1
addi r1, r0, 4056	% Start to calculate the offset for x
sw 4100(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 4100(r14)
add r1, r1, r2
sw 4100(r14), r1
addi r1, r0, 1	% Storing 1
sb 4080(r14), r1
addi r1, r0, 0	% Storing 0
sb 4081(r14), r1
addi r1, r0, 0	% Storing 0
sb 4082(r14), r1
addi r1, r0, 0	% Storing 0
sb 4083(r14), r1
lw r2, 4100(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 4080(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (x + 1)
sw 4104(r14), r1
lw r1, 4104(r14)	% x=(x + 1) - loading 0 of 4
lw r2, 4100(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_14_5   nop
addi r1, r0, 4056	% Start to calculate the offset for x
sw 4100(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 4100(r14)
add r1, r1, r2
sw 4100(r14), r1
addi r1, r0, 5	% Storing 5
sb 4108(r14), r1
addi r1, r0, 0	% Storing 0
sb 4109(r14), r1
addi r1, r0, 0	% Storing 0
sb 4110(r14), r1
addi r1, r0, 0	% Storing 0
sb 4111(r14), r1
lw r2, 4100(r14)	% Loading the value of x
lw r2, 0(r2)	% Pointer detected. Dereferencing x
lw r3, 4108(r14)	% Loading the value of 5
clt r1, r2, r3	% Evaluate (x < 5)
sw 4112(r14), r1
lw r1, 4112(r14)	% Loading the value of (x < 5)
bz r1, endfor_14_5
addi r1, r0, 0	% Storing 0
sb 4072(r14), r1
addi r1, r0, 0	% Storing 0
sb 4073(r14), r1
addi r1, r0, 0	% Storing 0
sb 4074(r14), r1
addi r1, r0, 0	% Storing 0
sb 4075(r14), r1
lw r1, 4072(r14)	% int y = 0 - loading 0 of 4
sw 4060(r14), r1	% int y = 0 - storing 0 of 4
j forcond_15_9
for_15_9    nop	% Start the for loop
addi r1, r0, 4060	% Start to calculate the offset for y
sw 4116(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 4116(r14)
add r1, r1, r2
sw 4116(r14), r1
addi r1, r0, 4060	% Start to calculate the offset for y
sw 4116(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 4116(r14)
add r1, r1, r2
sw 4116(r14), r1
addi r1, r0, 1	% Storing 1
sb 4080(r14), r1
addi r1, r0, 0	% Storing 0
sb 4081(r14), r1
addi r1, r0, 0	% Storing 0
sb 4082(r14), r1
addi r1, r0, 0	% Storing 0
sb 4083(r14), r1
lw r2, 4116(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 4080(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (y + 1)
sw 4120(r14), r1
lw r1, 4120(r14)	% y=(y + 1) - loading 0 of 4
lw r2, 4116(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_15_9   nop
addi r1, r0, 4060	% Start to calculate the offset for y
sw 4116(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 4116(r14)
add r1, r1, r2
sw 4116(r14), r1
addi r1, r0, 10	% Storing 10
sb 4088(r14), r1
addi r1, r0, 0	% Storing 0
sb 4089(r14), r1
addi r1, r0, 0	% Storing 0
sb 4090(r14), r1
addi r1, r0, 0	% Storing 0
sb 4091(r14), r1
lw r2, 4116(r14)	% Loading the value of y
lw r2, 0(r2)	% Pointer detected. Dereferencing y
lw r3, 4088(r14)	% Loading the value of 10
clt r1, r2, r3	% Evaluate (y < 10)
sw 4124(r14), r1
lw r1, 4124(r14)	% Loading the value of (y < 10)
bz r1, endfor_15_9
addi r1, r0, 0	% Storing 0
sb 4072(r14), r1
addi r1, r0, 0	% Storing 0
sb 4073(r14), r1
addi r1, r0, 0	% Storing 0
sb 4074(r14), r1
addi r1, r0, 0	% Storing 0
sb 4075(r14), r1
lw r1, 4072(r14)	% int z = 0 - loading 0 of 4
sw 4064(r14), r1	% int z = 0 - storing 0 of 4
j forcond_16_13
for_16_13    nop	% Start the for loop
addi r1, r0, 4064	% Start to calculate the offset for z
sw 4128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 4128(r14)
add r1, r1, r2
sw 4128(r14), r1
addi r1, r0, 4064	% Start to calculate the offset for z
sw 4128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 4128(r14)
add r1, r1, r2
sw 4128(r14), r1
addi r1, r0, 1	% Storing 1
sb 4080(r14), r1
addi r1, r0, 0	% Storing 0
sb 4081(r14), r1
addi r1, r0, 0	% Storing 0
sb 4082(r14), r1
addi r1, r0, 0	% Storing 0
sb 4083(r14), r1
lw r2, 4128(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 4080(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (z + 1)
sw 4132(r14), r1
lw r1, 4132(r14)	% z=(z + 1) - loading 0 of 4
lw r2, 4128(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_16_13   nop
addi r1, r0, 4064	% Start to calculate the offset for z
sw 4128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 4128(r14)
add r1, r1, r2
sw 4128(r14), r1
addi r1, r0, 20	% Storing 20
sb 4136(r14), r1
addi r1, r0, 0	% Storing 0
sb 4137(r14), r1
addi r1, r0, 0	% Storing 0
sb 4138(r14), r1
addi r1, r0, 0	% Storing 0
sb 4139(r14), r1
lw r2, 4128(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 4136(r14)	% Loading the value of 20
clt r1, r2, r3	% Evaluate (z < 20)
sw 4140(r14), r1
lw r1, 4140(r14)	% Loading the value of (z < 20)
bz r1, endfor_16_13
addi r1, r0, 4056	% Start to calculate the offset for x
sw 4100(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 4100(r14)
add r1, r1, r2
sw 4100(r14), r1
addi r1, r0, 4060	% Start to calculate the offset for y
sw 4116(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 4116(r14)
add r1, r1, r2
sw 4116(r14), r1
addi r1, r0, 4064	% Start to calculate the offset for z
sw 4128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 4128(r14)
add r1, r1, r2
sw 4128(r14), r1
addi r1, r0, 48	% Start to calculate the offset for multiArray[x][y][z]
lw r2, 4100(r14)	% Getting the index [x]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 10	% Multiply by the chunk size 10
muli r2, r2, 20	% Multiply by the chunk size 20
add r1, r1, r2	% Add the index x
lw r2, 4116(r14)	% Getting the index [y]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 20	% Multiply by the chunk size 20
add r1, r1, r2	% Add the index y
lw r2, 4128(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 4144(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for multiArray[x][y][z]
lw r2, 4144(r14)
add r1, r1, r2
sw 4144(r14), r1
addi r1, r0, 4048	% Start to calculate the offset for num
sw 4068(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for num
lw r2, 4068(r14)
add r1, r1, r2
sw 4068(r14), r1
lw r1, 4068(r14)	% multiArray[x][y][z]=num - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 4144(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 4048	% Start to calculate the offset for num
sw 4068(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for num
lw r2, 4068(r14)
add r1, r1, r2
sw 4068(r14), r1
addi r1, r0, 4048	% Start to calculate the offset for num
sw 4068(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for num
lw r2, 4068(r14)
add r1, r1, r2
sw 4068(r14), r1
addi r1, r0, 1	% Storing 1
sb 4080(r14), r1
addi r1, r0, 0	% Storing 0
sb 4081(r14), r1
addi r1, r0, 0	% Storing 0
sb 4082(r14), r1
addi r1, r0, 0	% Storing 0
sb 4083(r14), r1
lw r2, 4068(r14)	% Loading the value of num
lw r2, 0(r2)	% Pointer detected. Dereferencing num
lw r3, 4080(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (num + 1)
sw 4148(r14), r1
lw r1, 4148(r14)	% num=(num + 1) - loading 0 of 4
lw r2, 4068(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 4056	% Start to calculate the offset for x
sw 4100(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 4100(r14)
add r1, r1, r2
sw 4100(r14), r1
addi r1, r0, 4060	% Start to calculate the offset for y
sw 4116(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 4116(r14)
add r1, r1, r2
sw 4116(r14), r1
addi r1, r0, 4064	% Start to calculate the offset for z
sw 4128(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 4128(r14)
add r1, r1, r2
sw 4128(r14), r1
addi r1, r0, 48	% Start to calculate the offset for multiArray[x][y][z]
lw r2, 4100(r14)	% Getting the index [x]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 10	% Multiply by the chunk size 10
muli r2, r2, 20	% Multiply by the chunk size 20
add r1, r1, r2	% Add the index x
lw r2, 4116(r14)	% Getting the index [y]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 20	% Multiply by the chunk size 20
add r1, r1, r2	% Add the index y
lw r2, 4128(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 4144(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for multiArray[x][y][z]
lw r2, 4144(r14)
add r1, r1, r2
sw 4144(r14), r1
lw r1, 4144(r14)	% Store the put value of multiArray[x][y][z] - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 4156(r14), r1	% Store the put value of multiArray[x][y][z] - storing 0 of 4
addi r14, r14, 4152
jl r15, puti_func
subi r14, r14, 4152
j for_16_13
endfor_16_13    nop
j for_15_9
endfor_15_9    nop
j for_14_5
endfor_14_5    nop
lw r15, 0(r14)	% Load the return address, and return.
jr r15
entry
addi r14, r0, 2204  % Set the stack pointer
addi r1, r0, 0	% Start to calculate the offset for result
sw 4(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for result
lw r2, 4(r14)
add r1, r1, r2
sw 4(r14), r1
addi r7, r14, 0	% This is to calculate the data offset for any potential member functions.
addi r14, r14, 12
jl r15, function_Foo	% Call the function Foo
subi r14, r14, 12
lw r1, 16(r14)	% Retrieve the returnvalue - loading 0 of 4
sw 8(r14), r1	% Retrieve the returnvalue - storing 0 of 4
addi r7, r14, 0	% This is to calculate the data offset for any potential member functions.
addi r1, r14, 0	% Calculating the REAL offset for Foo()
addi r1, r14, 8	% Get the function call's pointer
lw r2, 8(r14)
sw 8(r14), r2
lw r1, 8(r14)	% result=Foo() - loading 0 of 4
lw r2, 4(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
hlt
