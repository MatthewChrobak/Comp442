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
lw r15, 0(r14)	% Load the return address, and return.
jr r15
entry
addi r14, r0, 2348  % Set the stack pointer
addi r1, r0, 0	% Start to calculate the offset for foo
sw 432(r14), r1
addi r1, r1, 4
sw 436(r14), r1
addi r1, r1, 4
sw 440(r14), r1
addi r1, r1, 4
sw 444(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 448(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo.x
lw r2, 432(r14)
add r1, r1, r2
lw r2, 448(r14)
add r1, r1, r2
sw 452(r14), r1
addi r1, r0, 1	% Storing 1
sb 456(r14), r1
addi r1, r0, 0	% Storing 0
sb 457(r14), r1
addi r1, r0, 0	% Storing 0
sb 458(r14), r1
addi r1, r0, 0	% Storing 0
sb 459(r14), r1
lw r1, 456(r14)	% foo.x=1 - loading 0 of 4
lw r2, 452(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Start to calculate the offset for foo
sw 432(r14), r1
addi r1, r1, 4
sw 436(r14), r1
addi r1, r1, 4
sw 440(r14), r1
addi r1, r1, 4
sw 444(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 0	% Start to calculate the offset for y
sw 472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo.element.y
lw r2, 432(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 472(r14)
add r1, r1, r2
sw 476(r14), r1
addi r1, r0, 2	% Storing 2
sb 480(r14), r1
addi r1, r0, 0	% Storing 0
sb 481(r14), r1
addi r1, r0, 0	% Storing 0
sb 482(r14), r1
addi r1, r0, 0	% Storing 0
sb 483(r14), r1
lw r1, 480(r14)	% foo.element.y=2 - loading 0 of 4
lw r2, 476(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Start to calculate the offset for foo
sw 432(r14), r1
addi r1, r1, 4
sw 436(r14), r1
addi r1, r1, 4
sw 440(r14), r1
addi r1, r1, 4
sw 444(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 4	% Start to calculate the offset for z
sw 484(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo.element.z
lw r2, 432(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 484(r14)
add r1, r1, r2
sw 488(r14), r1
addi r1, r0, 3	% Storing 3
sb 492(r14), r1
addi r1, r0, 0	% Storing 0
sb 493(r14), r1
addi r1, r0, 0	% Storing 0
sb 494(r14), r1
addi r1, r0, 0	% Storing 0
sb 495(r14), r1
lw r1, 492(r14)	% foo.element.z=3 - loading 0 of 4
lw r2, 488(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Start to calculate the offset for foo
sw 432(r14), r1
addi r1, r1, 4
sw 436(r14), r1
addi r1, r1, 4
sw 440(r14), r1
addi r1, r1, 4
sw 444(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 8	% Start to calculate the offset for other
sw 496(r14), r1
addi r1, r0, 0	% Start to calculate the offset for val
sw 500(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo.element.other.val
lw r2, 432(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 496(r14)
add r1, r1, r2
lw r2, 500(r14)
add r1, r1, r2
sw 504(r14), r1
addi r1, r0, 4	% Storing 4
sb 508(r14), r1
addi r1, r0, 0	% Storing 0
sb 509(r14), r1
addi r1, r0, 0	% Storing 0
sb 510(r14), r1
addi r1, r0, 0	% Storing 0
sb 511(r14), r1
lw r1, 508(r14)	% foo.element.other.val=4 - loading 0 of 4
lw r2, 504(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 16	% Start to calculate the offset for foo2
sw 512(r14), r1
addi r1, r1, 4
sw 516(r14), r1
addi r1, r1, 4
sw 520(r14), r1
addi r1, r1, 4
sw 524(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 8	% Start to calculate the offset for other
sw 496(r14), r1
addi r1, r0, 0	% Start to calculate the offset for val
sw 500(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo2.element.other.val
lw r2, 512(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 496(r14)
add r1, r1, r2
lw r2, 500(r14)
add r1, r1, r2
sw 528(r14), r1
addi r1, r0, 5	% Storing 5
sb 532(r14), r1
addi r1, r0, 0	% Storing 0
sb 533(r14), r1
addi r1, r0, 0	% Storing 0
sb 534(r14), r1
addi r1, r0, 0	% Storing 0
sb 535(r14), r1
lw r1, 532(r14)	% foo2.element.other.val=5 - loading 0 of 4
lw r2, 528(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 16	% Start to calculate the offset for foo2
sw 512(r14), r1
addi r1, r1, 4
sw 516(r14), r1
addi r1, r1, 4
sw 520(r14), r1
addi r1, r1, 4
sw 524(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 0	% Start to calculate the offset for y
sw 472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo2.element.y
lw r2, 512(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 472(r14)
add r1, r1, r2
sw 536(r14), r1
addi r1, r0, 8	% Storing 8
sb 540(r14), r1
addi r1, r0, 0	% Storing 0
sb 541(r14), r1
addi r1, r0, 0	% Storing 0
sb 542(r14), r1
addi r1, r0, 0	% Storing 0
sb 543(r14), r1
lw r1, 540(r14)	% foo2.element.y=8 - loading 0 of 4
lw r2, 536(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 16	% Start to calculate the offset for foo2
sw 512(r14), r1
addi r1, r1, 4
sw 516(r14), r1
addi r1, r1, 4
sw 520(r14), r1
addi r1, r1, 4
sw 524(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 4	% Start to calculate the offset for z
sw 484(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo2.element.z
lw r2, 512(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 484(r14)
add r1, r1, r2
sw 544(r14), r1
addi r1, r0, 4	% Storing 4
sb 508(r14), r1
addi r1, r0, 0	% Storing 0
sb 509(r14), r1
addi r1, r0, 0	% Storing 0
sb 510(r14), r1
addi r1, r0, 0	% Storing 0
sb 511(r14), r1
lw r1, 508(r14)	% foo2.element.z=4 - loading 0 of 4
lw r2, 544(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Start to calculate the offset for foo
sw 432(r14), r1
addi r1, r1, 4
sw 436(r14), r1
addi r1, r1, 4
sw 440(r14), r1
addi r1, r1, 4
sw 444(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 448(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo.x
lw r2, 432(r14)
add r1, r1, r2
lw r2, 448(r14)
add r1, r1, r2
sw 452(r14), r1
addi r1, r0, 0	% Start to calculate the offset for foo
sw 432(r14), r1
addi r1, r1, 4
sw 436(r14), r1
addi r1, r1, 4
sw 440(r14), r1
addi r1, r1, 4
sw 444(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 0	% Start to calculate the offset for y
sw 472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo.element.y
lw r2, 432(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 472(r14)
add r1, r1, r2
sw 476(r14), r1
addi r1, r0, 0	% Start to calculate the offset for foo
sw 432(r14), r1
addi r1, r1, 4
sw 436(r14), r1
addi r1, r1, 4
sw 440(r14), r1
addi r1, r1, 4
sw 444(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 4	% Start to calculate the offset for z
sw 484(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo.element.z
lw r2, 432(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 484(r14)
add r1, r1, r2
sw 488(r14), r1
lw r2, 476(r14)	% Loading the value of foo.element.y
lw r2, 0(r2)	% Pointer detected. Dereferencing foo.element.y
lw r3, 488(r14)	% Loading the value of foo.element.z
lw r3, 0(r3)	% Pointer detected. Dereferencing foo.element.z
add r1, r2, r3	% Calculating (foo.element.y + foo.element.z)
sw 548(r14), r1
lw r2, 452(r14)	% Loading the value of foo.x
lw r2, 0(r2)	% Pointer detected. Dereferencing foo.x
lw r3, 548(r14)	% Loading the value of (foo.element.y + foo.element.z)
mul r1, r2, r3	% Calculating (foo.x * (foo.element.y + foo.element.z))
sw 552(r14), r1
addi r1, r0, 0	% Start to calculate the offset for foo
sw 432(r14), r1
addi r1, r1, 4
sw 436(r14), r1
addi r1, r1, 4
sw 440(r14), r1
addi r1, r1, 4
sw 444(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 8	% Start to calculate the offset for other
sw 496(r14), r1
addi r1, r0, 0	% Start to calculate the offset for val
sw 500(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo.element.other.val
lw r2, 432(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 496(r14)
add r1, r1, r2
lw r2, 500(r14)
add r1, r1, r2
sw 504(r14), r1
lw r2, 552(r14)	% Loading the value of (foo.x * (foo.element.y + foo.element.z))
lw r3, 504(r14)	% Loading the value of foo.element.other.val
lw r3, 0(r3)	% Pointer detected. Dereferencing foo.element.other.val
sub r1, r2, r3	% Calculating ((foo.x * (foo.element.y + foo.element.z)) - foo.element.other.val)
sw 556(r14), r1
addi r1, r0, 16	% Start to calculate the offset for foo2
sw 512(r14), r1
addi r1, r1, 4
sw 516(r14), r1
addi r1, r1, 4
sw 520(r14), r1
addi r1, r1, 4
sw 524(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 8	% Start to calculate the offset for other
sw 496(r14), r1
addi r1, r0, 0	% Start to calculate the offset for val
sw 500(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo2.element.other.val
lw r2, 512(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 496(r14)
add r1, r1, r2
lw r2, 500(r14)
add r1, r1, r2
sw 528(r14), r1
lw r2, 556(r14)	% Loading the value of ((foo.x * (foo.element.y + foo.element.z)) - foo.element.other.val)
lw r3, 528(r14)	% Loading the value of foo2.element.other.val
lw r3, 0(r3)	% Pointer detected. Dereferencing foo2.element.other.val
mul r1, r2, r3	% Calculating (((foo.x * (foo.element.y + foo.element.z)) - foo.element.other.val) * foo2.element.other.val)
sw 560(r14), r1
addi r1, r0, 16	% Start to calculate the offset for foo2
sw 512(r14), r1
addi r1, r1, 4
sw 516(r14), r1
addi r1, r1, 4
sw 520(r14), r1
addi r1, r1, 4
sw 524(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 0	% Start to calculate the offset for y
sw 472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo2.element.y
lw r2, 512(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 472(r14)
add r1, r1, r2
sw 536(r14), r1
addi r1, r0, 16	% Start to calculate the offset for foo2
sw 512(r14), r1
addi r1, r1, 4
sw 516(r14), r1
addi r1, r1, 4
sw 520(r14), r1
addi r1, r1, 4
sw 524(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 460(r14), r1
addi r1, r1, 4
sw 464(r14), r1
addi r1, r1, 4
sw 468(r14), r1
addi r1, r0, 4	% Start to calculate the offset for z
sw 484(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo2.element.z
lw r2, 512(r14)
add r1, r1, r2
lw r2, 460(r14)
add r1, r1, r2
lw r2, 484(r14)
add r1, r1, r2
sw 544(r14), r1
lw r2, 536(r14)	% Loading the value of foo2.element.y
lw r2, 0(r2)	% Pointer detected. Dereferencing foo2.element.y
lw r3, 544(r14)	% Loading the value of foo2.element.z
lw r3, 0(r3)	% Pointer detected. Dereferencing foo2.element.z
div r1, r2, r3	% Calculating (foo2.element.y / foo2.element.z)
sw 564(r14), r1
addi r1, r0, 32	% Start to calculate the offset for array[(((foo.x * (foo.element.y + foo.element.z)) - foo.element.other.val) * foo2.element.other.val)][(foo2.element.y / foo2.element.z)]
lw r2, 560(r14)	% Getting the index [(((foo.x * (foo.element.y + foo.element.z)) - foo.element.other.val) * foo2.element.other.val)]
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 10	% Multiply by the chunk size 10
add r1, r1, r2	% Add the index (((foo.x * (foo.element.y + foo.element.z)) - foo.element.other.val) * foo2.element.other.val)
lw r2, 564(r14)	% Getting the index [(foo2.element.y / foo2.element.z)]
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index (foo2.element.y / foo2.element.z)
sw 568(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for array[(((foo.x * (foo.element.y + foo.element.z)) - foo.element.other.val) * foo2.element.other.val)][(foo2.element.y / foo2.element.z)]
lw r2, 568(r14)
add r1, r1, r2
sw 568(r14), r1
addi r1, r0, 192	% Storing 192
sb 572(r14), r1
addi r1, r0, 158	% Storing 158
sb 573(r14), r1
addi r1, r0, 248	% Storing 248
sb 574(r14), r1
addi r1, r0, 127	% Storing 127
sb 575(r14), r1
lw r1, 572(r14)	% array[(((foo.x * (foo.element.y + foo.element.z)) - foo.element.other.val) * foo2.element.other.val)][(foo2.element.y / foo2.element.z)]=2147000000 - loading 0 of 4
lw r2, 568(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 5	% Storing 5
sb 532(r14), r1
addi r1, r0, 0	% Storing 0
sb 533(r14), r1
addi r1, r0, 0	% Storing 0
sb 534(r14), r1
addi r1, r0, 0	% Storing 0
sb 535(r14), r1
addi r1, r0, 2	% Storing 2
sb 480(r14), r1
addi r1, r0, 0	% Storing 0
sb 481(r14), r1
addi r1, r0, 0	% Storing 0
sb 482(r14), r1
addi r1, r0, 0	% Storing 0
sb 483(r14), r1
addi r1, r0, 32	% Start to calculate the offset for array[5][2]
lw r2, 532(r14)	% Getting the index [5]
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 10	% Multiply by the chunk size 10
add r1, r1, r2	% Add the index 5
lw r2, 480(r14)	% Getting the index [2]
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index 2
sw 576(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for array[5][2]
lw r2, 576(r14)
add r1, r1, r2
sw 576(r14), r1
lw r1, 576(r14)	% Store the put value of array[5][2] - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 584(r14), r1	% Store the put value of array[5][2] - storing 0 of 4
addi r14, r14, 580
jl r15, puti_func
subi r14, r14, 580
hlt
