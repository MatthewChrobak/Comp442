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
addi r14, r0, 10132  % Set the stack pointer
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 416(r14)
add r1, r1, r2
sw 416(r14), r1
addi r1, r0, 10	% Storing 10
sb 420(r14), r1
addi r1, r0, 0	% Storing 0
sb 421(r14), r1
addi r1, r0, 0	% Storing 0
sb 422(r14), r1
addi r1, r0, 0	% Storing 0
sb 423(r14), r1
lw r1, 420(r14)	% x=10 - loading 0 of 4
lw r2, 416(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 136	% Start to calculate the offset for objX
sw 424(r14), r1
addi r1, r1, 4
sw 428(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for objX.x
lw r2, 424(r14)
add r1, r1, r2
lw r2, 416(r14)
add r1, r1, r2
sw 432(r14), r1
addi r1, r0, 10	% Storing 10
sb 420(r14), r1
addi r1, r0, 0	% Storing 0
sb 421(r14), r1
addi r1, r0, 0	% Storing 0
sb 422(r14), r1
addi r1, r0, 0	% Storing 0
sb 423(r14), r1
lw r1, 420(r14)	% objX.x=10 - loading 0 of 4
lw r2, 432(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 136	% Start to calculate the offset for objX
sw 424(r14), r1
addi r1, r1, 4
sw 428(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 436(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for objX.y
lw r2, 424(r14)
add r1, r1, r2
lw r2, 436(r14)
add r1, r1, r2
sw 440(r14), r1
addi r1, r0, 20	% Storing 20
sb 444(r14), r1
addi r1, r0, 0	% Storing 0
sb 445(r14), r1
addi r1, r0, 0	% Storing 0
sb 446(r14), r1
addi r1, r0, 0	% Storing 0
sb 447(r14), r1
lw r1, 444(r14)	% objX.y=20 - loading 0 of 4
lw r2, 440(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 416(r14)
add r1, r1, r2
sw 416(r14), r1
lw r1, 416(r14)	% Store the put value of x - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of x - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 136	% Start to calculate the offset for objX
sw 424(r14), r1
addi r1, r1, 4
sw 428(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for objX.x
lw r2, 424(r14)
add r1, r1, r2
lw r2, 416(r14)
add r1, r1, r2
sw 432(r14), r1
lw r1, 432(r14)	% Store the put value of objX.x - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of objX.x - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 136	% Start to calculate the offset for objX
sw 424(r14), r1
addi r1, r1, 4
sw 428(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 436(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for objX.y
lw r2, 424(r14)
add r1, r1, r2
lw r2, 436(r14)
add r1, r1, r2
sw 440(r14), r1
lw r1, 440(r14)	% Store the put value of objX.y - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of objX.y - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 4	% Start to calculate the offset for y
sw 436(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 436(r14)
add r1, r1, r2
sw 436(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for x
lw r2, 416(r14)
add r1, r1, r2
sw 416(r14), r1
lw r1, 416(r14)	% y=x - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 436(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 144	% Start to calculate the offset for objY
sw 448(r14), r1
addi r1, r1, 4
sw 452(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for objY
lw r2, 448(r14)
add r1, r1, r2
sw 448(r14), r1
addi r1, r1, 4
sw 452(r14), r1
addi r1, r0, 136	% Start to calculate the offset for objX
sw 424(r14), r1
addi r1, r1, 4
sw 428(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for objX
lw r2, 424(r14)
add r1, r1, r2
sw 424(r14), r1
addi r1, r1, 4
sw 428(r14), r1
lw r1, 424(r14)	% objY=objX - loading 0 of 8
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 448(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 428(r14)	% objY=objX - loading 4 of 8
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 448(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 4	% Start to calculate the offset for y
sw 436(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for y
lw r2, 436(r14)
add r1, r1, r2
sw 436(r14), r1
lw r1, 436(r14)	% Store the put value of y - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of y - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% int i = 0 - loading 0 of 4
sw 408(r14), r1	% int i = 0 - storing 0 of 4
j forcond_36_5
for_36_5    nop	% Start the for loop
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 1	% Storing 1
sb 464(r14), r1
addi r1, r0, 0	% Storing 0
sb 465(r14), r1
addi r1, r0, 0	% Storing 0
sb 466(r14), r1
addi r1, r0, 0	% Storing 0
sb 467(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 464(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (i + 1)
sw 468(r14), r1
lw r1, 468(r14)	% i=(i + 1) - loading 0 of 4
lw r2, 460(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_36_5   nop
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 472(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (i < 4)
sw 476(r14), r1
lw r1, 476(r14)	% Loading the value of (i < 4)
bz r1, endfor_36_5
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% int z = 0 - loading 0 of 4
sw 412(r14), r1	% int z = 0 - storing 0 of 4
j forcond_37_9
for_37_9    nop	% Start the for loop
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 1	% Storing 1
sb 464(r14), r1
addi r1, r0, 0	% Storing 0
sb 465(r14), r1
addi r1, r0, 0	% Storing 0
sb 466(r14), r1
addi r1, r0, 0	% Storing 0
sb 467(r14), r1
lw r2, 480(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 464(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (z + 1)
sw 484(r14), r1
lw r1, 484(r14)	% z=(z + 1) - loading 0 of 4
lw r2, 480(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_37_9   nop
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 480(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 472(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (z < 4)
sw 488(r14), r1
lw r1, 488(r14)	% Loading the value of (z < 4)
bz r1, endfor_37_9
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 8	% Start to calculate the offset for sourceArray[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 492(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for sourceArray[i][z]
lw r2, 492(r14)
add r1, r1, r2
sw 492(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 472(r14)	% Loading the value of 4
mul r1, r2, r3	% Calculating (i * 4)
sw 496(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
lw r2, 496(r14)	% Loading the value of (i * 4)
lw r3, 480(r14)	% Loading the value of z
lw r3, 0(r3)	% Pointer detected. Dereferencing z
add r1, r2, r3	% Calculating ((i * 4) + z)
sw 500(r14), r1
lw r1, 500(r14)	% sourceArray[i][z]=((i * 4) + z) - loading 0 of 4
lw r2, 492(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 152	% Start to calculate the offset for sourceFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 504(r14), r1
addi r1, r1, 4
sw 508(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for sourceFoo[i][z].x
lw r2, 504(r14)
add r1, r1, r2
lw r2, 416(r14)
add r1, r1, r2
sw 512(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 472(r14)	% Loading the value of 4
mul r1, r2, r3	% Calculating (i * 4)
sw 496(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 1	% Storing 1
sb 464(r14), r1
addi r1, r0, 0	% Storing 0
sb 465(r14), r1
addi r1, r0, 0	% Storing 0
sb 466(r14), r1
addi r1, r0, 0	% Storing 0
sb 467(r14), r1
lw r2, 480(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 464(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (z + 1)
sw 484(r14), r1
lw r2, 496(r14)	% Loading the value of (i * 4)
lw r3, 484(r14)	% Loading the value of (z + 1)
add r1, r2, r3	% Calculating ((i * 4) + (z + 1))
sw 516(r14), r1
lw r1, 516(r14)	% sourceFoo[i][z].x=((i * 4) + (z + 1)) - loading 0 of 4
lw r2, 512(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 152	% Start to calculate the offset for sourceFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 504(r14), r1
addi r1, r1, 4
sw 508(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 436(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for sourceFoo[i][z].y
lw r2, 504(r14)
add r1, r1, r2
lw r2, 436(r14)
add r1, r1, r2
sw 520(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 472(r14)	% Loading the value of 4
mul r1, r2, r3	% Calculating (i * 4)
sw 496(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 2	% Storing 2
sb 524(r14), r1
addi r1, r0, 0	% Storing 0
sb 525(r14), r1
addi r1, r0, 0	% Storing 0
sb 526(r14), r1
addi r1, r0, 0	% Storing 0
sb 527(r14), r1
lw r2, 480(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 524(r14)	% Loading the value of 2
add r1, r2, r3	% Calculating (z + 2)
sw 528(r14), r1
lw r2, 496(r14)	% Loading the value of (i * 4)
lw r3, 528(r14)	% Loading the value of (z + 2)
add r1, r2, r3	% Calculating ((i * 4) + (z + 2))
sw 532(r14), r1
lw r1, 532(r14)	% sourceFoo[i][z].y=((i * 4) + (z + 2)) - loading 0 of 4
lw r2, 520(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
j for_37_9
endfor_37_9    nop
j for_36_5
endfor_36_5    nop
addi r1, r0, 72	% Start to calculate the offset for destinationArray
sw 536(r14), r1
addi r1, r1, 4
sw 540(r14), r1
addi r1, r1, 4
sw 544(r14), r1
addi r1, r1, 4
sw 548(r14), r1
addi r1, r1, 4
sw 552(r14), r1
addi r1, r1, 4
sw 556(r14), r1
addi r1, r1, 4
sw 560(r14), r1
addi r1, r1, 4
sw 564(r14), r1
addi r1, r1, 4
sw 568(r14), r1
addi r1, r1, 4
sw 572(r14), r1
addi r1, r1, 4
sw 576(r14), r1
addi r1, r1, 4
sw 580(r14), r1
addi r1, r1, 4
sw 584(r14), r1
addi r1, r1, 4
sw 588(r14), r1
addi r1, r1, 4
sw 592(r14), r1
addi r1, r1, 4
sw 596(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationArray
lw r2, 536(r14)
add r1, r1, r2
sw 536(r14), r1
addi r1, r1, 4
sw 540(r14), r1
addi r1, r1, 4
sw 544(r14), r1
addi r1, r1, 4
sw 548(r14), r1
addi r1, r1, 4
sw 552(r14), r1
addi r1, r1, 4
sw 556(r14), r1
addi r1, r1, 4
sw 560(r14), r1
addi r1, r1, 4
sw 564(r14), r1
addi r1, r1, 4
sw 568(r14), r1
addi r1, r1, 4
sw 572(r14), r1
addi r1, r1, 4
sw 576(r14), r1
addi r1, r1, 4
sw 580(r14), r1
addi r1, r1, 4
sw 584(r14), r1
addi r1, r1, 4
sw 588(r14), r1
addi r1, r1, 4
sw 592(r14), r1
addi r1, r1, 4
sw 596(r14), r1
addi r1, r0, 8	% Start to calculate the offset for sourceArray
sw 600(r14), r1
addi r1, r1, 4
sw 604(r14), r1
addi r1, r1, 4
sw 608(r14), r1
addi r1, r1, 4
sw 612(r14), r1
addi r1, r1, 4
sw 616(r14), r1
addi r1, r1, 4
sw 620(r14), r1
addi r1, r1, 4
sw 624(r14), r1
addi r1, r1, 4
sw 628(r14), r1
addi r1, r1, 4
sw 632(r14), r1
addi r1, r1, 4
sw 636(r14), r1
addi r1, r1, 4
sw 640(r14), r1
addi r1, r1, 4
sw 644(r14), r1
addi r1, r1, 4
sw 648(r14), r1
addi r1, r1, 4
sw 652(r14), r1
addi r1, r1, 4
sw 656(r14), r1
addi r1, r1, 4
sw 660(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for sourceArray
lw r2, 600(r14)
add r1, r1, r2
sw 600(r14), r1
addi r1, r1, 4
sw 604(r14), r1
addi r1, r1, 4
sw 608(r14), r1
addi r1, r1, 4
sw 612(r14), r1
addi r1, r1, 4
sw 616(r14), r1
addi r1, r1, 4
sw 620(r14), r1
addi r1, r1, 4
sw 624(r14), r1
addi r1, r1, 4
sw 628(r14), r1
addi r1, r1, 4
sw 632(r14), r1
addi r1, r1, 4
sw 636(r14), r1
addi r1, r1, 4
sw 640(r14), r1
addi r1, r1, 4
sw 644(r14), r1
addi r1, r1, 4
sw 648(r14), r1
addi r1, r1, 4
sw 652(r14), r1
addi r1, r1, 4
sw 656(r14), r1
addi r1, r1, 4
sw 660(r14), r1
lw r1, 600(r14)	% destinationArray=sourceArray - loading 0 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 604(r14)	% destinationArray=sourceArray - loading 4 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 608(r14)	% destinationArray=sourceArray - loading 8 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 8(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 612(r14)	% destinationArray=sourceArray - loading 12 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 12(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 616(r14)	% destinationArray=sourceArray - loading 16 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 16(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 620(r14)	% destinationArray=sourceArray - loading 20 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 20(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 624(r14)	% destinationArray=sourceArray - loading 24 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 24(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 628(r14)	% destinationArray=sourceArray - loading 28 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 28(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 632(r14)	% destinationArray=sourceArray - loading 32 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 32(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 636(r14)	% destinationArray=sourceArray - loading 36 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 36(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 640(r14)	% destinationArray=sourceArray - loading 40 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 40(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 644(r14)	% destinationArray=sourceArray - loading 44 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 44(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 648(r14)	% destinationArray=sourceArray - loading 48 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 48(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 652(r14)	% destinationArray=sourceArray - loading 52 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 52(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 656(r14)	% destinationArray=sourceArray - loading 56 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 56(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 660(r14)	% destinationArray=sourceArray - loading 60 of 64
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 536(r14)
sw 60(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 280	% Start to calculate the offset for destinationFoo
sw 664(r14), r1
addi r1, r1, 4
sw 668(r14), r1
addi r1, r1, 4
sw 672(r14), r1
addi r1, r1, 4
sw 676(r14), r1
addi r1, r1, 4
sw 680(r14), r1
addi r1, r1, 4
sw 684(r14), r1
addi r1, r1, 4
sw 688(r14), r1
addi r1, r1, 4
sw 692(r14), r1
addi r1, r1, 4
sw 696(r14), r1
addi r1, r1, 4
sw 700(r14), r1
addi r1, r1, 4
sw 704(r14), r1
addi r1, r1, 4
sw 708(r14), r1
addi r1, r1, 4
sw 712(r14), r1
addi r1, r1, 4
sw 716(r14), r1
addi r1, r1, 4
sw 720(r14), r1
addi r1, r1, 4
sw 724(r14), r1
addi r1, r1, 4
sw 728(r14), r1
addi r1, r1, 4
sw 732(r14), r1
addi r1, r1, 4
sw 736(r14), r1
addi r1, r1, 4
sw 740(r14), r1
addi r1, r1, 4
sw 744(r14), r1
addi r1, r1, 4
sw 748(r14), r1
addi r1, r1, 4
sw 752(r14), r1
addi r1, r1, 4
sw 756(r14), r1
addi r1, r1, 4
sw 760(r14), r1
addi r1, r1, 4
sw 764(r14), r1
addi r1, r1, 4
sw 768(r14), r1
addi r1, r1, 4
sw 772(r14), r1
addi r1, r1, 4
sw 776(r14), r1
addi r1, r1, 4
sw 780(r14), r1
addi r1, r1, 4
sw 784(r14), r1
addi r1, r1, 4
sw 788(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo
lw r2, 664(r14)
add r1, r1, r2
sw 664(r14), r1
addi r1, r1, 4
sw 668(r14), r1
addi r1, r1, 4
sw 672(r14), r1
addi r1, r1, 4
sw 676(r14), r1
addi r1, r1, 4
sw 680(r14), r1
addi r1, r1, 4
sw 684(r14), r1
addi r1, r1, 4
sw 688(r14), r1
addi r1, r1, 4
sw 692(r14), r1
addi r1, r1, 4
sw 696(r14), r1
addi r1, r1, 4
sw 700(r14), r1
addi r1, r1, 4
sw 704(r14), r1
addi r1, r1, 4
sw 708(r14), r1
addi r1, r1, 4
sw 712(r14), r1
addi r1, r1, 4
sw 716(r14), r1
addi r1, r1, 4
sw 720(r14), r1
addi r1, r1, 4
sw 724(r14), r1
addi r1, r1, 4
sw 728(r14), r1
addi r1, r1, 4
sw 732(r14), r1
addi r1, r1, 4
sw 736(r14), r1
addi r1, r1, 4
sw 740(r14), r1
addi r1, r1, 4
sw 744(r14), r1
addi r1, r1, 4
sw 748(r14), r1
addi r1, r1, 4
sw 752(r14), r1
addi r1, r1, 4
sw 756(r14), r1
addi r1, r1, 4
sw 760(r14), r1
addi r1, r1, 4
sw 764(r14), r1
addi r1, r1, 4
sw 768(r14), r1
addi r1, r1, 4
sw 772(r14), r1
addi r1, r1, 4
sw 776(r14), r1
addi r1, r1, 4
sw 780(r14), r1
addi r1, r1, 4
sw 784(r14), r1
addi r1, r1, 4
sw 788(r14), r1
addi r1, r0, 152	% Start to calculate the offset for sourceFoo
sw 792(r14), r1
addi r1, r1, 4
sw 796(r14), r1
addi r1, r1, 4
sw 800(r14), r1
addi r1, r1, 4
sw 804(r14), r1
addi r1, r1, 4
sw 808(r14), r1
addi r1, r1, 4
sw 812(r14), r1
addi r1, r1, 4
sw 816(r14), r1
addi r1, r1, 4
sw 820(r14), r1
addi r1, r1, 4
sw 824(r14), r1
addi r1, r1, 4
sw 828(r14), r1
addi r1, r1, 4
sw 832(r14), r1
addi r1, r1, 4
sw 836(r14), r1
addi r1, r1, 4
sw 840(r14), r1
addi r1, r1, 4
sw 844(r14), r1
addi r1, r1, 4
sw 848(r14), r1
addi r1, r1, 4
sw 852(r14), r1
addi r1, r1, 4
sw 856(r14), r1
addi r1, r1, 4
sw 860(r14), r1
addi r1, r1, 4
sw 864(r14), r1
addi r1, r1, 4
sw 868(r14), r1
addi r1, r1, 4
sw 872(r14), r1
addi r1, r1, 4
sw 876(r14), r1
addi r1, r1, 4
sw 880(r14), r1
addi r1, r1, 4
sw 884(r14), r1
addi r1, r1, 4
sw 888(r14), r1
addi r1, r1, 4
sw 892(r14), r1
addi r1, r1, 4
sw 896(r14), r1
addi r1, r1, 4
sw 900(r14), r1
addi r1, r1, 4
sw 904(r14), r1
addi r1, r1, 4
sw 908(r14), r1
addi r1, r1, 4
sw 912(r14), r1
addi r1, r1, 4
sw 916(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for sourceFoo
lw r2, 792(r14)
add r1, r1, r2
sw 792(r14), r1
addi r1, r1, 4
sw 796(r14), r1
addi r1, r1, 4
sw 800(r14), r1
addi r1, r1, 4
sw 804(r14), r1
addi r1, r1, 4
sw 808(r14), r1
addi r1, r1, 4
sw 812(r14), r1
addi r1, r1, 4
sw 816(r14), r1
addi r1, r1, 4
sw 820(r14), r1
addi r1, r1, 4
sw 824(r14), r1
addi r1, r1, 4
sw 828(r14), r1
addi r1, r1, 4
sw 832(r14), r1
addi r1, r1, 4
sw 836(r14), r1
addi r1, r1, 4
sw 840(r14), r1
addi r1, r1, 4
sw 844(r14), r1
addi r1, r1, 4
sw 848(r14), r1
addi r1, r1, 4
sw 852(r14), r1
addi r1, r1, 4
sw 856(r14), r1
addi r1, r1, 4
sw 860(r14), r1
addi r1, r1, 4
sw 864(r14), r1
addi r1, r1, 4
sw 868(r14), r1
addi r1, r1, 4
sw 872(r14), r1
addi r1, r1, 4
sw 876(r14), r1
addi r1, r1, 4
sw 880(r14), r1
addi r1, r1, 4
sw 884(r14), r1
addi r1, r1, 4
sw 888(r14), r1
addi r1, r1, 4
sw 892(r14), r1
addi r1, r1, 4
sw 896(r14), r1
addi r1, r1, 4
sw 900(r14), r1
addi r1, r1, 4
sw 904(r14), r1
addi r1, r1, 4
sw 908(r14), r1
addi r1, r1, 4
sw 912(r14), r1
addi r1, r1, 4
sw 916(r14), r1
lw r1, 792(r14)	% destinationFoo=sourceFoo - loading 0 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 796(r14)	% destinationFoo=sourceFoo - loading 4 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 800(r14)	% destinationFoo=sourceFoo - loading 8 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 8(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 804(r14)	% destinationFoo=sourceFoo - loading 12 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 12(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 808(r14)	% destinationFoo=sourceFoo - loading 16 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 16(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 812(r14)	% destinationFoo=sourceFoo - loading 20 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 20(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 816(r14)	% destinationFoo=sourceFoo - loading 24 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 24(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 820(r14)	% destinationFoo=sourceFoo - loading 28 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 28(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 824(r14)	% destinationFoo=sourceFoo - loading 32 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 32(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 828(r14)	% destinationFoo=sourceFoo - loading 36 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 36(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 832(r14)	% destinationFoo=sourceFoo - loading 40 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 40(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 836(r14)	% destinationFoo=sourceFoo - loading 44 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 44(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 840(r14)	% destinationFoo=sourceFoo - loading 48 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 48(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 844(r14)	% destinationFoo=sourceFoo - loading 52 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 52(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 848(r14)	% destinationFoo=sourceFoo - loading 56 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 56(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 852(r14)	% destinationFoo=sourceFoo - loading 60 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 60(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 856(r14)	% destinationFoo=sourceFoo - loading 64 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 64(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 860(r14)	% destinationFoo=sourceFoo - loading 68 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 68(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 864(r14)	% destinationFoo=sourceFoo - loading 72 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 72(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 868(r14)	% destinationFoo=sourceFoo - loading 76 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 76(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 872(r14)	% destinationFoo=sourceFoo - loading 80 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 80(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 876(r14)	% destinationFoo=sourceFoo - loading 84 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 84(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 880(r14)	% destinationFoo=sourceFoo - loading 88 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 88(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 884(r14)	% destinationFoo=sourceFoo - loading 92 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 92(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 888(r14)	% destinationFoo=sourceFoo - loading 96 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 96(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 892(r14)	% destinationFoo=sourceFoo - loading 100 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 100(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 896(r14)	% destinationFoo=sourceFoo - loading 104 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 104(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 900(r14)	% destinationFoo=sourceFoo - loading 108 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 108(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 904(r14)	% destinationFoo=sourceFoo - loading 112 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 112(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 908(r14)	% destinationFoo=sourceFoo - loading 116 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 116(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 912(r14)	% destinationFoo=sourceFoo - loading 120 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 120(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 916(r14)	% destinationFoo=sourceFoo - loading 124 of 128
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 664(r14)
sw 124(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% int i = 0 - loading 0 of 4
sw 408(r14), r1	% int i = 0 - storing 0 of 4
j forcond_49_5
for_49_5    nop	% Start the for loop
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 1	% Storing 1
sb 464(r14), r1
addi r1, r0, 0	% Storing 0
sb 465(r14), r1
addi r1, r0, 0	% Storing 0
sb 466(r14), r1
addi r1, r0, 0	% Storing 0
sb 467(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 464(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (i + 1)
sw 468(r14), r1
lw r1, 468(r14)	% i=(i + 1) - loading 0 of 4
lw r2, 460(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_49_5   nop
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 472(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (i < 4)
sw 476(r14), r1
lw r1, 476(r14)	% Loading the value of (i < 4)
bz r1, endfor_49_5
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% int z = 0 - loading 0 of 4
sw 412(r14), r1	% int z = 0 - storing 0 of 4
j forcond_50_9
for_50_9    nop	% Start the for loop
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 1	% Storing 1
sb 464(r14), r1
addi r1, r0, 0	% Storing 0
sb 465(r14), r1
addi r1, r0, 0	% Storing 0
sb 466(r14), r1
addi r1, r0, 0	% Storing 0
sb 467(r14), r1
lw r2, 480(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 464(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (z + 1)
sw 484(r14), r1
lw r1, 484(r14)	% z=(z + 1) - loading 0 of 4
lw r2, 480(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_50_9   nop
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 480(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 472(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (z < 4)
sw 488(r14), r1
lw r1, 488(r14)	% Loading the value of (z < 4)
bz r1, endfor_50_9
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 72	% Start to calculate the offset for destinationArray[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 920(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationArray[i][z]
lw r2, 920(r14)
add r1, r1, r2
sw 920(r14), r1
lw r1, 920(r14)	% Store the put value of destinationArray[i][z] - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of destinationArray[i][z] - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z].x
lw r2, 924(r14)
add r1, r1, r2
lw r2, 416(r14)
add r1, r1, r2
sw 932(r14), r1
lw r1, 932(r14)	% Store the put value of destinationFoo[i][z].x - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of destinationFoo[i][z].x - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 436(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z].y
lw r2, 924(r14)
add r1, r1, r2
lw r2, 436(r14)
add r1, r1, r2
sw 936(r14), r1
lw r1, 936(r14)	% Store the put value of destinationFoo[i][z].y - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of destinationFoo[i][z].y - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 72	% Start to calculate the offset for destinationArray[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 920(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationArray[i][z]
lw r2, 920(r14)
add r1, r1, r2
sw 920(r14), r1
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% destinationArray[i][z]=0 - loading 0 of 4
lw r2, 920(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z].x
lw r2, 924(r14)
add r1, r1, r2
lw r2, 416(r14)
add r1, r1, r2
sw 932(r14), r1
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% destinationFoo[i][z].x=0 - loading 0 of 4
lw r2, 932(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 436(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z].y
lw r2, 924(r14)
add r1, r1, r2
lw r2, 436(r14)
add r1, r1, r2
sw 936(r14), r1
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% destinationFoo[i][z].y=0 - loading 0 of 4
lw r2, 936(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
j for_50_9
endfor_50_9    nop
j for_49_5
endfor_49_5    nop
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% int i = 0 - loading 0 of 4
sw 408(r14), r1	% int i = 0 - storing 0 of 4
j forcond_63_5
for_63_5    nop	% Start the for loop
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 1	% Storing 1
sb 464(r14), r1
addi r1, r0, 0	% Storing 0
sb 465(r14), r1
addi r1, r0, 0	% Storing 0
sb 466(r14), r1
addi r1, r0, 0	% Storing 0
sb 467(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 464(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (i + 1)
sw 468(r14), r1
lw r1, 468(r14)	% i=(i + 1) - loading 0 of 4
lw r2, 460(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_63_5   nop
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 472(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (i < 4)
sw 476(r14), r1
lw r1, 476(r14)	% Loading the value of (i < 4)
bz r1, endfor_63_5
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 72	% Start to calculate the offset for destinationArray[i]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 16	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 940(r14), r1
addi r1, r1, 4
sw 944(r14), r1
addi r1, r1, 4
sw 948(r14), r1
addi r1, r1, 4
sw 952(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationArray[i]
lw r2, 940(r14)
add r1, r1, r2
sw 940(r14), r1
addi r1, r1, 4
sw 944(r14), r1
addi r1, r1, 4
sw 948(r14), r1
addi r1, r1, 4
sw 952(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 8	% Start to calculate the offset for sourceArray[i]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 16	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 956(r14), r1
addi r1, r1, 4
sw 960(r14), r1
addi r1, r1, 4
sw 964(r14), r1
addi r1, r1, 4
sw 968(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for sourceArray[i]
lw r2, 956(r14)
add r1, r1, r2
sw 956(r14), r1
addi r1, r1, 4
sw 960(r14), r1
addi r1, r1, 4
sw 964(r14), r1
addi r1, r1, 4
sw 968(r14), r1
lw r1, 956(r14)	% destinationArray[i]=sourceArray[i] - loading 0 of 16
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 940(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 960(r14)	% destinationArray[i]=sourceArray[i] - loading 4 of 16
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 940(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 964(r14)	% destinationArray[i]=sourceArray[i] - loading 8 of 16
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 940(r14)
sw 8(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 968(r14)	% destinationArray[i]=sourceArray[i] - loading 12 of 16
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 940(r14)
sw 12(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 32	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 972(r14), r1
addi r1, r1, 4
sw 976(r14), r1
addi r1, r1, 4
sw 980(r14), r1
addi r1, r1, 4
sw 984(r14), r1
addi r1, r1, 4
sw 988(r14), r1
addi r1, r1, 4
sw 992(r14), r1
addi r1, r1, 4
sw 996(r14), r1
addi r1, r1, 4
sw 1000(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i]
lw r2, 972(r14)
add r1, r1, r2
sw 972(r14), r1
addi r1, r1, 4
sw 976(r14), r1
addi r1, r1, 4
sw 980(r14), r1
addi r1, r1, 4
sw 984(r14), r1
addi r1, r1, 4
sw 988(r14), r1
addi r1, r1, 4
sw 992(r14), r1
addi r1, r1, 4
sw 996(r14), r1
addi r1, r1, 4
sw 1000(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 152	% Start to calculate the offset for sourceFoo[i]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 32	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 1004(r14), r1
addi r1, r1, 4
sw 1008(r14), r1
addi r1, r1, 4
sw 1012(r14), r1
addi r1, r1, 4
sw 1016(r14), r1
addi r1, r1, 4
sw 1020(r14), r1
addi r1, r1, 4
sw 1024(r14), r1
addi r1, r1, 4
sw 1028(r14), r1
addi r1, r1, 4
sw 1032(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for sourceFoo[i]
lw r2, 1004(r14)
add r1, r1, r2
sw 1004(r14), r1
addi r1, r1, 4
sw 1008(r14), r1
addi r1, r1, 4
sw 1012(r14), r1
addi r1, r1, 4
sw 1016(r14), r1
addi r1, r1, 4
sw 1020(r14), r1
addi r1, r1, 4
sw 1024(r14), r1
addi r1, r1, 4
sw 1028(r14), r1
addi r1, r1, 4
sw 1032(r14), r1
lw r1, 1004(r14)	% destinationFoo[i]=sourceFoo[i] - loading 0 of 32
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 972(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 1008(r14)	% destinationFoo[i]=sourceFoo[i] - loading 4 of 32
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 972(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 1012(r14)	% destinationFoo[i]=sourceFoo[i] - loading 8 of 32
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 972(r14)
sw 8(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 1016(r14)	% destinationFoo[i]=sourceFoo[i] - loading 12 of 32
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 972(r14)
sw 12(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 1020(r14)	% destinationFoo[i]=sourceFoo[i] - loading 16 of 32
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 972(r14)
sw 16(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 1024(r14)	% destinationFoo[i]=sourceFoo[i] - loading 20 of 32
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 972(r14)
sw 20(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 1028(r14)	% destinationFoo[i]=sourceFoo[i] - loading 24 of 32
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 972(r14)
sw 24(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 1032(r14)	% destinationFoo[i]=sourceFoo[i] - loading 28 of 32
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 972(r14)
sw 28(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
j for_63_5
endfor_63_5    nop
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% int i = 0 - loading 0 of 4
sw 408(r14), r1	% int i = 0 - storing 0 of 4
j forcond_69_5
for_69_5    nop	% Start the for loop
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 1	% Storing 1
sb 464(r14), r1
addi r1, r0, 0	% Storing 0
sb 465(r14), r1
addi r1, r0, 0	% Storing 0
sb 466(r14), r1
addi r1, r0, 0	% Storing 0
sb 467(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 464(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (i + 1)
sw 468(r14), r1
lw r1, 468(r14)	% i=(i + 1) - loading 0 of 4
lw r2, 460(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_69_5   nop
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 472(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (i < 4)
sw 476(r14), r1
lw r1, 476(r14)	% Loading the value of (i < 4)
bz r1, endfor_69_5
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% int z = 0 - loading 0 of 4
sw 412(r14), r1	% int z = 0 - storing 0 of 4
j forcond_70_9
for_70_9    nop	% Start the for loop
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 1	% Storing 1
sb 464(r14), r1
addi r1, r0, 0	% Storing 0
sb 465(r14), r1
addi r1, r0, 0	% Storing 0
sb 466(r14), r1
addi r1, r0, 0	% Storing 0
sb 467(r14), r1
lw r2, 480(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 464(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (z + 1)
sw 484(r14), r1
lw r1, 484(r14)	% z=(z + 1) - loading 0 of 4
lw r2, 480(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_70_9   nop
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 480(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 472(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (z < 4)
sw 488(r14), r1
lw r1, 488(r14)	% Loading the value of (z < 4)
bz r1, endfor_70_9
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 72	% Start to calculate the offset for destinationArray[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 920(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationArray[i][z]
lw r2, 920(r14)
add r1, r1, r2
sw 920(r14), r1
lw r1, 920(r14)	% Store the put value of destinationArray[i][z] - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of destinationArray[i][z] - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z].x
lw r2, 924(r14)
add r1, r1, r2
lw r2, 416(r14)
add r1, r1, r2
sw 932(r14), r1
lw r1, 932(r14)	% Store the put value of destinationFoo[i][z].x - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of destinationFoo[i][z].x - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 436(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z].y
lw r2, 924(r14)
add r1, r1, r2
lw r2, 436(r14)
add r1, r1, r2
sw 936(r14), r1
lw r1, 936(r14)	% Store the put value of destinationFoo[i][z].y - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of destinationFoo[i][z].y - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 72	% Start to calculate the offset for destinationArray[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 920(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationArray[i][z]
lw r2, 920(r14)
add r1, r1, r2
sw 920(r14), r1
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% destinationArray[i][z]=0 - loading 0 of 4
lw r2, 920(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z].x
lw r2, 924(r14)
add r1, r1, r2
lw r2, 416(r14)
add r1, r1, r2
sw 932(r14), r1
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% destinationFoo[i][z].x=0 - loading 0 of 4
lw r2, 932(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 436(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z].y
lw r2, 924(r14)
add r1, r1, r2
lw r2, 436(r14)
add r1, r1, r2
sw 936(r14), r1
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% destinationFoo[i][z].y=0 - loading 0 of 4
lw r2, 936(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
j for_70_9
endfor_70_9    nop
j for_69_5
endfor_69_5    nop
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% int i = 0 - loading 0 of 4
sw 408(r14), r1	% int i = 0 - storing 0 of 4
j forcond_83_5
for_83_5    nop	% Start the for loop
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 1	% Storing 1
sb 464(r14), r1
addi r1, r0, 0	% Storing 0
sb 465(r14), r1
addi r1, r0, 0	% Storing 0
sb 466(r14), r1
addi r1, r0, 0	% Storing 0
sb 467(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 464(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (i + 1)
sw 468(r14), r1
lw r1, 468(r14)	% i=(i + 1) - loading 0 of 4
lw r2, 460(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_83_5   nop
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 460(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 472(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (i < 4)
sw 476(r14), r1
lw r1, 476(r14)	% Loading the value of (i < 4)
bz r1, endfor_83_5
addi r1, r0, 0	% Storing 0
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% int z = 0 - loading 0 of 4
sw 412(r14), r1	% int z = 0 - storing 0 of 4
j forcond_84_9
for_84_9    nop	% Start the for loop
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 1	% Storing 1
sb 464(r14), r1
addi r1, r0, 0	% Storing 0
sb 465(r14), r1
addi r1, r0, 0	% Storing 0
sb 466(r14), r1
addi r1, r0, 0	% Storing 0
sb 467(r14), r1
lw r2, 480(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 464(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (z + 1)
sw 484(r14), r1
lw r1, 484(r14)	% z=(z + 1) - loading 0 of 4
lw r2, 480(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_84_9   nop
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 4	% Storing 4
sb 472(r14), r1
addi r1, r0, 0	% Storing 0
sb 473(r14), r1
addi r1, r0, 0	% Storing 0
sb 474(r14), r1
addi r1, r0, 0	% Storing 0
sb 475(r14), r1
lw r2, 480(r14)	% Loading the value of z
lw r2, 0(r2)	% Pointer detected. Dereferencing z
lw r3, 472(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (z < 4)
sw 488(r14), r1
lw r1, 488(r14)	% Loading the value of (z < 4)
bz r1, endfor_84_9
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 72	% Start to calculate the offset for destinationArray[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 920(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationArray[i][z]
lw r2, 920(r14)
add r1, r1, r2
sw 920(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 8	% Start to calculate the offset for sourceArray[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 492(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for sourceArray[i][z]
lw r2, 492(r14)
add r1, r1, r2
sw 492(r14), r1
lw r1, 492(r14)	% destinationArray[i][z]=sourceArray[i][z] - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 920(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z]
lw r2, 924(r14)
add r1, r1, r2
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 152	% Start to calculate the offset for sourceFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 504(r14), r1
addi r1, r1, 4
sw 508(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for sourceFoo[i][z]
lw r2, 504(r14)
add r1, r1, r2
sw 504(r14), r1
addi r1, r1, 4
sw 508(r14), r1
lw r1, 504(r14)	% destinationFoo[i][z]=sourceFoo[i][z] - loading 0 of 8
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 924(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
lw r1, 508(r14)	% destinationFoo[i][z]=sourceFoo[i][z] - loading 4 of 8
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 924(r14)
sw 4(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 72	% Start to calculate the offset for destinationArray[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 920(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationArray[i][z]
lw r2, 920(r14)
add r1, r1, r2
sw 920(r14), r1
lw r1, 920(r14)	% Store the put value of destinationArray[i][z] - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of destinationArray[i][z] - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 416(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z].x
lw r2, 924(r14)
add r1, r1, r2
lw r2, 416(r14)
add r1, r1, r2
sw 932(r14), r1
lw r1, 932(r14)	% Store the put value of destinationFoo[i][z].x - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of destinationFoo[i][z].x - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
addi r1, r0, 408	% Start to calculate the offset for i
sw 460(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 460(r14)
add r1, r1, r2
sw 460(r14), r1
addi r1, r0, 412	% Start to calculate the offset for z
sw 480(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for z
lw r2, 480(r14)
add r1, r1, r2
sw 480(r14), r1
addi r1, r0, 280	% Start to calculate the offset for destinationFoo[i][z]
lw r2, 460(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
add r1, r1, r2	% Add the index i
lw r2, 480(r14)	% Getting the index [z]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index z
sw 924(r14), r1
addi r1, r1, 4
sw 928(r14), r1
addi r1, r0, 4	% Start to calculate the offset for y
sw 436(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for destinationFoo[i][z].y
lw r2, 924(r14)
add r1, r1, r2
lw r2, 436(r14)
add r1, r1, r2
sw 936(r14), r1
lw r1, 936(r14)	% Store the put value of destinationFoo[i][z].y - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1040(r14), r1	% Store the put value of destinationFoo[i][z].y - storing 0 of 4
addi r14, r14, 1036
jl r15, puti_func
subi r14, r14, 1036
j for_84_9
endfor_84_9    nop
j for_83_5
endfor_83_5    nop
hlt
