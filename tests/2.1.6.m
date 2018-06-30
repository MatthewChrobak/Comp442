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
addi r1, r0, 0	% Storing 0
sb 172(r14), r1
addi r1, r0, 0	% Storing 0
sb 173(r14), r1
addi r1, r0, 0	% Storing 0
sb 174(r14), r1
addi r1, r0, 0	% Storing 0
sb 175(r14), r1
lw r1, 172(r14)	% int i = 0 - loading 0 of 4
sw 168(r14), r1	% int i = 0 - storing 0 of 4
j forcond_23_5
for_23_5    nop	% Start the for loop
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 1	% Storing 1
sb 180(r14), r1
addi r1, r0, 0	% Storing 0
sb 181(r14), r1
addi r1, r0, 0	% Storing 0
sb 182(r14), r1
addi r1, r0, 0	% Storing 0
sb 183(r14), r1
lw r2, 176(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 180(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (i + 1)
sw 184(r14), r1
lw r1, 184(r14)	% i=(i + 1) - loading 0 of 4
lw r2, 176(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_23_5   nop
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 10	% Storing 10
sb 188(r14), r1
addi r1, r0, 0	% Storing 0
sb 189(r14), r1
addi r1, r0, 0	% Storing 0
sb 190(r14), r1
addi r1, r0, 0	% Storing 0
sb 191(r14), r1
lw r2, 176(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 188(r14)	% Loading the value of 10
clt r1, r2, r3	% Evaluate (i < 10)
sw 192(r14), r1
lw r1, 192(r14)	% Loading the value of (i < 10)
bz r1, endfor_23_5
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 8	% Start to calculate the offset for foo[i]
lw r2, 176(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 16	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 196(r14), r1
addi r1, r1, 4
sw 200(r14), r1
addi r1, r1, 4
sw 204(r14), r1
addi r1, r1, 4
sw 208(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 212(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo[i].x
lw r2, 196(r14)
add r1, r1, r2
lw r2, 212(r14)
add r1, r1, r2
sw 216(r14), r1
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
lw r1, 176(r14)	% foo[i].x=i - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 216(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 8	% Start to calculate the offset for foo[i]
lw r2, 176(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 16	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 196(r14), r1
addi r1, r1, 4
sw 200(r14), r1
addi r1, r1, 4
sw 204(r14), r1
addi r1, r1, 4
sw 208(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 220(r14), r1
addi r1, r1, 4
sw 224(r14), r1
addi r1, r1, 4
sw 228(r14), r1
addi r1, r0, 0	% Start to calculate the offset for y
sw 232(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo[i].element.y
lw r2, 196(r14)
add r1, r1, r2
lw r2, 220(r14)
add r1, r1, r2
lw r2, 232(r14)
add r1, r1, r2
sw 236(r14), r1
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 10	% Storing 10
sb 188(r14), r1
addi r1, r0, 0	% Storing 0
sb 189(r14), r1
addi r1, r0, 0	% Storing 0
sb 190(r14), r1
addi r1, r0, 0	% Storing 0
sb 191(r14), r1
lw r2, 176(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 188(r14)	% Loading the value of 10
mul r1, r2, r3	% Calculating (i * 10)
sw 240(r14), r1
lw r1, 240(r14)	% foo[i].element.y=(i * 10) - loading 0 of 4
lw r2, 236(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 8	% Start to calculate the offset for foo[i]
lw r2, 176(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 16	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 196(r14), r1
addi r1, r1, 4
sw 200(r14), r1
addi r1, r1, 4
sw 204(r14), r1
addi r1, r1, 4
sw 208(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 220(r14), r1
addi r1, r1, 4
sw 224(r14), r1
addi r1, r1, 4
sw 228(r14), r1
addi r1, r0, 4	% Start to calculate the offset for z
sw 244(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo[i].element.z
lw r2, 196(r14)
add r1, r1, r2
lw r2, 220(r14)
add r1, r1, r2
lw r2, 244(r14)
add r1, r1, r2
sw 248(r14), r1
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 100	% Storing 100
sb 252(r14), r1
addi r1, r0, 0	% Storing 0
sb 253(r14), r1
addi r1, r0, 0	% Storing 0
sb 254(r14), r1
addi r1, r0, 0	% Storing 0
sb 255(r14), r1
lw r2, 176(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 252(r14)	% Loading the value of 100
mul r1, r2, r3	% Calculating (i * 100)
sw 256(r14), r1
lw r1, 256(r14)	% foo[i].element.z=(i * 100) - loading 0 of 4
lw r2, 248(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 8	% Start to calculate the offset for foo[i]
lw r2, 176(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 16	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 196(r14), r1
addi r1, r1, 4
sw 200(r14), r1
addi r1, r1, 4
sw 204(r14), r1
addi r1, r1, 4
sw 208(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 220(r14), r1
addi r1, r1, 4
sw 224(r14), r1
addi r1, r1, 4
sw 228(r14), r1
addi r1, r0, 8	% Start to calculate the offset for other
sw 260(r14), r1
addi r1, r0, 0	% Start to calculate the offset for val
sw 264(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo[i].element.other.val
lw r2, 196(r14)
add r1, r1, r2
lw r2, 220(r14)
add r1, r1, r2
lw r2, 260(r14)
add r1, r1, r2
lw r2, 264(r14)
add r1, r1, r2
sw 268(r14), r1
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 232	% Storing 232
sb 272(r14), r1
addi r1, r0, 3	% Storing 3
sb 273(r14), r1
addi r1, r0, 0	% Storing 0
sb 274(r14), r1
addi r1, r0, 0	% Storing 0
sb 275(r14), r1
lw r2, 176(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 272(r14)	% Loading the value of 1000
mul r1, r2, r3	% Calculating (i * 1000)
sw 276(r14), r1
lw r1, 276(r14)	% foo[i].element.other.val=(i * 1000) - loading 0 of 4
lw r2, 268(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
j for_23_5
endfor_23_5    nop
addi r1, r0, 0	% Storing 0
sb 172(r14), r1
addi r1, r0, 0	% Storing 0
sb 173(r14), r1
addi r1, r0, 0	% Storing 0
sb 174(r14), r1
addi r1, r0, 0	% Storing 0
sb 175(r14), r1
lw r1, 172(r14)	% int i = 0 - loading 0 of 4
sw 168(r14), r1	% int i = 0 - storing 0 of 4
j forcond_30_5
for_30_5    nop	% Start the for loop
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 1	% Storing 1
sb 180(r14), r1
addi r1, r0, 0	% Storing 0
sb 181(r14), r1
addi r1, r0, 0	% Storing 0
sb 182(r14), r1
addi r1, r0, 0	% Storing 0
sb 183(r14), r1
lw r2, 176(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 180(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (i + 1)
sw 184(r14), r1
lw r1, 184(r14)	% i=(i + 1) - loading 0 of 4
lw r2, 176(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_30_5   nop
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 10	% Storing 10
sb 188(r14), r1
addi r1, r0, 0	% Storing 0
sb 189(r14), r1
addi r1, r0, 0	% Storing 0
sb 190(r14), r1
addi r1, r0, 0	% Storing 0
sb 191(r14), r1
lw r2, 176(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 188(r14)	% Loading the value of 10
clt r1, r2, r3	% Evaluate (i < 10)
sw 192(r14), r1
lw r1, 192(r14)	% Loading the value of (i < 10)
bz r1, endfor_30_5
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 8	% Start to calculate the offset for foo[i]
lw r2, 176(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 16	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 196(r14), r1
addi r1, r1, 4
sw 200(r14), r1
addi r1, r1, 4
sw 204(r14), r1
addi r1, r1, 4
sw 208(r14), r1
addi r1, r0, 0	% Start to calculate the offset for x
sw 212(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo[i].x
lw r2, 196(r14)
add r1, r1, r2
lw r2, 212(r14)
add r1, r1, r2
sw 216(r14), r1
lw r1, 216(r14)	% Store the put value of foo[i].x - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 284(r14), r1	% Store the put value of foo[i].x - storing 0 of 4
addi r14, r14, 280
jl r15, puti_func
subi r14, r14, 280
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 8	% Start to calculate the offset for foo[i]
lw r2, 176(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 16	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 196(r14), r1
addi r1, r1, 4
sw 200(r14), r1
addi r1, r1, 4
sw 204(r14), r1
addi r1, r1, 4
sw 208(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 220(r14), r1
addi r1, r1, 4
sw 224(r14), r1
addi r1, r1, 4
sw 228(r14), r1
addi r1, r0, 0	% Start to calculate the offset for y
sw 232(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo[i].element.y
lw r2, 196(r14)
add r1, r1, r2
lw r2, 220(r14)
add r1, r1, r2
lw r2, 232(r14)
add r1, r1, r2
sw 236(r14), r1
lw r1, 236(r14)	% Store the put value of foo[i].element.y - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 284(r14), r1	% Store the put value of foo[i].element.y - storing 0 of 4
addi r14, r14, 280
jl r15, puti_func
subi r14, r14, 280
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 8	% Start to calculate the offset for foo[i]
lw r2, 176(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 16	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 196(r14), r1
addi r1, r1, 4
sw 200(r14), r1
addi r1, r1, 4
sw 204(r14), r1
addi r1, r1, 4
sw 208(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 220(r14), r1
addi r1, r1, 4
sw 224(r14), r1
addi r1, r1, 4
sw 228(r14), r1
addi r1, r0, 4	% Start to calculate the offset for z
sw 244(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo[i].element.z
lw r2, 196(r14)
add r1, r1, r2
lw r2, 220(r14)
add r1, r1, r2
lw r2, 244(r14)
add r1, r1, r2
sw 248(r14), r1
lw r1, 248(r14)	% Store the put value of foo[i].element.z - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 284(r14), r1	% Store the put value of foo[i].element.z - storing 0 of 4
addi r14, r14, 280
jl r15, puti_func
subi r14, r14, 280
addi r1, r0, 168	% Start to calculate the offset for i
sw 176(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 176(r14)
add r1, r1, r2
sw 176(r14), r1
addi r1, r0, 8	% Start to calculate the offset for foo[i]
lw r2, 176(r14)	% Getting the index [i]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 16	% Multiply by the size.
add r1, r1, r2	% Add the index i
sw 196(r14), r1
addi r1, r1, 4
sw 200(r14), r1
addi r1, r1, 4
sw 204(r14), r1
addi r1, r1, 4
sw 208(r14), r1
addi r1, r0, 4	% Start to calculate the offset for element
sw 220(r14), r1
addi r1, r1, 4
sw 224(r14), r1
addi r1, r1, 4
sw 228(r14), r1
addi r1, r0, 8	% Start to calculate the offset for other
sw 260(r14), r1
addi r1, r0, 0	% Start to calculate the offset for val
sw 264(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for foo[i].element.other.val
lw r2, 196(r14)
add r1, r1, r2
lw r2, 220(r14)
add r1, r1, r2
lw r2, 260(r14)
add r1, r1, r2
lw r2, 264(r14)
add r1, r1, r2
sw 268(r14), r1
lw r1, 268(r14)	% Store the put value of foo[i].element.other.val - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 284(r14), r1	% Store the put value of foo[i].element.other.val - storing 0 of 4
addi r14, r14, 280
jl r15, puti_func
subi r14, r14, 280
j for_30_5
endfor_30_5    nop
lw r15, 0(r14)	% Load the return address, and return.
jr r15
entry
addi r14, r0, 2400  % Set the stack pointer
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
