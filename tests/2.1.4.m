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
addi r1, r0, 8	% Start to calculate the offset for object
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r1, 4
sw 40(r14), r1
addi r1, r0, 4	% Start to calculate the offset for x
sw 44(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for object.x
lw r2, 32(r14)
add r1, r1, r2
lw r2, 44(r14)
add r1, r1, r2
sw 48(r14), r1
addi r1, r0, 10	% Storing 10
sb 52(r14), r1
addi r1, r0, 0	% Storing 0
sb 53(r14), r1
addi r1, r0, 0	% Storing 0
sb 54(r14), r1
addi r1, r0, 0	% Storing 0
sb 55(r14), r1
lw r1, 52(r14)	% object.x=10 - loading 0 of 4
lw r2, 48(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 8	% Start to calculate the offset for object
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r1, 4
sw 40(r14), r1
addi r1, r0, 0	% Start to calculate the offset for y
sw 56(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for object.y
lw r2, 32(r14)
add r1, r1, r2
lw r2, 56(r14)
add r1, r1, r2
sw 60(r14), r1
addi r1, r0, 20	% Storing 20
sb 64(r14), r1
addi r1, r0, 0	% Storing 0
sb 65(r14), r1
addi r1, r0, 0	% Storing 0
sb 66(r14), r1
addi r1, r0, 0	% Storing 0
sb 67(r14), r1
lw r1, 64(r14)	% object.y=20 - loading 0 of 4
lw r2, 60(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 8	% Start to calculate the offset for object
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r1, 4
sw 40(r14), r1
addi r1, r0, 8	% Start to calculate the offset for z
sw 68(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for object.z
lw r2, 32(r14)
add r1, r1, r2
lw r2, 68(r14)
add r1, r1, r2
sw 72(r14), r1
addi r1, r0, 25	% Storing 25
sb 76(r14), r1
addi r1, r0, 0	% Storing 0
sb 77(r14), r1
addi r1, r0, 0	% Storing 0
sb 78(r14), r1
addi r1, r0, 0	% Storing 0
sb 79(r14), r1
lw r1, 76(r14)	% object.z=25 - loading 0 of 4
lw r2, 72(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 20	% Start to calculate the offset for otherObject
sw 80(r14), r1
addi r1, r1, 4
sw 84(r14), r1
addi r1, r1, 4
sw 88(r14), r1
addi r1, r0, 4	% Start to calculate the offset for x
sw 44(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for otherObject.x
lw r2, 80(r14)
add r1, r1, r2
lw r2, 44(r14)
add r1, r1, r2
sw 92(r14), r1
addi r1, r0, 30	% Storing 30
sb 96(r14), r1
addi r1, r0, 0	% Storing 0
sb 97(r14), r1
addi r1, r0, 0	% Storing 0
sb 98(r14), r1
addi r1, r0, 0	% Storing 0
sb 99(r14), r1
lw r1, 96(r14)	% otherObject.x=30 - loading 0 of 4
lw r2, 92(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 20	% Start to calculate the offset for otherObject
sw 80(r14), r1
addi r1, r1, 4
sw 84(r14), r1
addi r1, r1, 4
sw 88(r14), r1
addi r1, r0, 0	% Start to calculate the offset for y
sw 56(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for otherObject.y
lw r2, 80(r14)
add r1, r1, r2
lw r2, 56(r14)
add r1, r1, r2
sw 100(r14), r1
addi r1, r0, 40	% Storing 40
sb 104(r14), r1
addi r1, r0, 0	% Storing 0
sb 105(r14), r1
addi r1, r0, 0	% Storing 0
sb 106(r14), r1
addi r1, r0, 0	% Storing 0
sb 107(r14), r1
lw r1, 104(r14)	% otherObject.y=40 - loading 0 of 4
lw r2, 100(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 20	% Start to calculate the offset for otherObject
sw 80(r14), r1
addi r1, r1, 4
sw 84(r14), r1
addi r1, r1, 4
sw 88(r14), r1
addi r1, r0, 8	% Start to calculate the offset for z
sw 68(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for otherObject.z
lw r2, 80(r14)
add r1, r1, r2
lw r2, 68(r14)
add r1, r1, r2
sw 108(r14), r1
addi r1, r0, 45	% Storing 45
sb 112(r14), r1
addi r1, r0, 0	% Storing 0
sb 113(r14), r1
addi r1, r0, 0	% Storing 0
sb 114(r14), r1
addi r1, r0, 0	% Storing 0
sb 115(r14), r1
lw r1, 112(r14)	% otherObject.z=45 - loading 0 of 4
lw r2, 108(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 8	% Start to calculate the offset for object
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r1, 4
sw 40(r14), r1
addi r1, r0, 4	% Start to calculate the offset for x
sw 44(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for object.x
lw r2, 32(r14)
add r1, r1, r2
lw r2, 44(r14)
add r1, r1, r2
sw 48(r14), r1
lw r1, 48(r14)	% Store the put value of object.x - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 120(r14), r1	% Store the put value of object.x - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
addi r1, r0, 8	% Start to calculate the offset for object
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r1, 4
sw 40(r14), r1
addi r1, r0, 0	% Start to calculate the offset for y
sw 56(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for object.y
lw r2, 32(r14)
add r1, r1, r2
lw r2, 56(r14)
add r1, r1, r2
sw 60(r14), r1
lw r1, 60(r14)	% Store the put value of object.y - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 120(r14), r1	% Store the put value of object.y - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
addi r1, r0, 8	% Start to calculate the offset for object
sw 32(r14), r1
addi r1, r1, 4
sw 36(r14), r1
addi r1, r1, 4
sw 40(r14), r1
addi r1, r0, 8	% Start to calculate the offset for z
sw 68(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for object.z
lw r2, 32(r14)
add r1, r1, r2
lw r2, 68(r14)
add r1, r1, r2
sw 72(r14), r1
lw r1, 72(r14)	% Store the put value of object.z - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 120(r14), r1	% Store the put value of object.z - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
addi r1, r0, 20	% Start to calculate the offset for otherObject
sw 80(r14), r1
addi r1, r1, 4
sw 84(r14), r1
addi r1, r1, 4
sw 88(r14), r1
addi r1, r0, 4	% Start to calculate the offset for x
sw 44(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for otherObject.x
lw r2, 80(r14)
add r1, r1, r2
lw r2, 44(r14)
add r1, r1, r2
sw 92(r14), r1
lw r1, 92(r14)	% Store the put value of otherObject.x - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 120(r14), r1	% Store the put value of otherObject.x - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
addi r1, r0, 20	% Start to calculate the offset for otherObject
sw 80(r14), r1
addi r1, r1, 4
sw 84(r14), r1
addi r1, r1, 4
sw 88(r14), r1
addi r1, r0, 0	% Start to calculate the offset for y
sw 56(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for otherObject.y
lw r2, 80(r14)
add r1, r1, r2
lw r2, 56(r14)
add r1, r1, r2
sw 100(r14), r1
lw r1, 100(r14)	% Store the put value of otherObject.y - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 120(r14), r1	% Store the put value of otherObject.y - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
addi r1, r0, 20	% Start to calculate the offset for otherObject
sw 80(r14), r1
addi r1, r1, 4
sw 84(r14), r1
addi r1, r1, 4
sw 88(r14), r1
addi r1, r0, 8	% Start to calculate the offset for z
sw 68(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for otherObject.z
lw r2, 80(r14)
add r1, r1, r2
lw r2, 68(r14)
add r1, r1, r2
sw 108(r14), r1
lw r1, 108(r14)	% Store the put value of otherObject.z - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 120(r14), r1	% Store the put value of otherObject.z - storing 0 of 4
addi r14, r14, 116
jl r15, puti_func
subi r14, r14, 116
lw r15, 0(r14)	% Load the return address, and return.
jr r15
entry
addi r14, r0, 1512  % Set the stack pointer
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
