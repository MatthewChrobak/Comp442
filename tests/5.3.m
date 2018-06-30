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
addi r14, r0, 1820  % Set the stack pointer
addi r1, r0, 1	% Storing 1
sb 0(r14), r1
addi r1, r0, 0	% Storing 0
sb 1(r14), r1
addi r1, r0, 0	% Storing 0
sb 2(r14), r1
addi r1, r0, 0	% Storing 0
sb 3(r14), r1
addi r1, r0, 2	% Storing 2
sb 4(r14), r1
addi r1, r0, 0	% Storing 0
sb 5(r14), r1
addi r1, r0, 0	% Storing 0
sb 6(r14), r1
addi r1, r0, 0	% Storing 0
sb 7(r14), r1
addi r1, r0, 3	% Storing 3
sb 8(r14), r1
addi r1, r0, 0	% Storing 0
sb 9(r14), r1
addi r1, r0, 0	% Storing 0
sb 10(r14), r1
addi r1, r0, 0	% Storing 0
sb 11(r14), r1
addi r1, r0, 5	% Storing 5
sb 12(r14), r1
addi r1, r0, 0	% Storing 0
sb 13(r14), r1
addi r1, r0, 0	% Storing 0
sb 14(r14), r1
addi r1, r0, 0	% Storing 0
sb 15(r14), r1
addi r1, r0, 4	% Storing 4
sb 16(r14), r1
addi r1, r0, 0	% Storing 0
sb 17(r14), r1
addi r1, r0, 0	% Storing 0
sb 18(r14), r1
addi r1, r0, 0	% Storing 0
sb 19(r14), r1
lw r2, 12(r14)	% Loading the value of 5
lw r3, 16(r14)	% Loading the value of 4
div r1, r2, r3	% Calculating (5 / 4)
sw 20(r14), r1
lw r2, 8(r14)	% Loading the value of 3
lw r3, 20(r14)	% Loading the value of (5 / 4)
mul r1, r2, r3	% Calculating (3 * (5 / 4))
sw 24(r14), r1
lw r2, 4(r14)	% Loading the value of 2
lw r3, 24(r14)	% Loading the value of (3 * (5 / 4))
sub r1, r2, r3	% Calculating (2 - (3 * (5 / 4)))
sw 28(r14), r1
lw r2, 0(r14)	% Loading the value of 1
lw r3, 28(r14)	% Loading the value of (2 - (3 * (5 / 4)))
add r1, r2, r3	% Calculating (1 + (2 - (3 * (5 / 4))))
sw 32(r14), r1
addi r1, r0, 0	% Storing 0
sb 36(r14), r1
addi r1, r0, 0	% Storing 0
sb 37(r14), r1
addi r1, r0, 0	% Storing 0
sb 38(r14), r1
addi r1, r0, 0	% Storing 0
sb 39(r14), r1
lw r2, 36(r14)	% Calculating (-0)
muli r2, r2, -1
sw 40(r14), r2
addi r1, r0, 200	% Storing 200
sb 44(r14), r1
addi r1, r0, 0	% Storing 0
sb 45(r14), r1
addi r1, r0, 0	% Storing 0
sb 46(r14), r1
addi r1, r0, 0	% Storing 0
sb 47(r14), r1
lw r1, 44(r14)	% Loading the value of 200
not r1, r1	% Invert the sign
sw 48(r14), r1
lw r1, 48(r14)	% Loading the value of (not 200)
not r1, r1	% Invert the sign
sw 52(r14), r1
lw r2, 40(r14)	% Loading the value of (-0)
lw r3, 52(r14)	% Loading the value of (not (not 200))
or r1, r2, r3	% Calculating ((-0) or (not (not 200)))
sw 56(r14), r1
lw r2, 32(r14)	% Loading the value of (1 + (2 - (3 * (5 / 4))))
lw r3, 56(r14)	% Loading the value of ((-0) or (not (not 200)))
clt r1, r2, r3	% Evaluate ((1 + (2 - (3 * (5 / 4)))) < ((-0) or (not (not 200))))
sw 60(r14), r1
lw r1, 60(r14)	% Store the put value of ((1 + (2 - (3 * (5 / 4)))) < ((-0) or (not (not 200)))) - loading 0 of 4
sw 128(r14), r1	% Store the put value of ((1 + (2 - (3 * (5 / 4)))) < ((-0) or (not (not 200)))) - storing 0 of 4
addi r14, r14, 124
jl r15, puti_func
subi r14, r14, 124
addi r1, r0, 1	% Storing 1
sb 0(r14), r1
addi r1, r0, 0	% Storing 0
sb 1(r14), r1
addi r1, r0, 0	% Storing 0
sb 2(r14), r1
addi r1, r0, 0	% Storing 0
sb 3(r14), r1
addi r1, r0, 2	% Storing 2
sb 4(r14), r1
addi r1, r0, 0	% Storing 0
sb 5(r14), r1
addi r1, r0, 0	% Storing 0
sb 6(r14), r1
addi r1, r0, 0	% Storing 0
sb 7(r14), r1
addi r1, r0, 3	% Storing 3
sb 8(r14), r1
addi r1, r0, 0	% Storing 0
sb 9(r14), r1
addi r1, r0, 0	% Storing 0
sb 10(r14), r1
addi r1, r0, 0	% Storing 0
sb 11(r14), r1
addi r1, r0, 5	% Storing 5
sb 12(r14), r1
addi r1, r0, 0	% Storing 0
sb 13(r14), r1
addi r1, r0, 0	% Storing 0
sb 14(r14), r1
addi r1, r0, 0	% Storing 0
sb 15(r14), r1
addi r1, r0, 4	% Storing 4
sb 16(r14), r1
addi r1, r0, 0	% Storing 0
sb 17(r14), r1
addi r1, r0, 0	% Storing 0
sb 18(r14), r1
addi r1, r0, 0	% Storing 0
sb 19(r14), r1
lw r2, 12(r14)	% Loading the value of 5
lw r3, 16(r14)	% Loading the value of 4
div r1, r2, r3	% Calculating (5 / 4)
sw 20(r14), r1
lw r2, 8(r14)	% Loading the value of 3
lw r3, 20(r14)	% Loading the value of (5 / 4)
mul r1, r2, r3	% Calculating (3 * (5 / 4))
sw 24(r14), r1
lw r2, 4(r14)	% Loading the value of 2
lw r3, 24(r14)	% Loading the value of (3 * (5 / 4))
sub r1, r2, r3	% Calculating (2 - (3 * (5 / 4)))
sw 28(r14), r1
lw r2, 0(r14)	% Loading the value of 1
lw r3, 28(r14)	% Loading the value of (2 - (3 * (5 / 4)))
add r1, r2, r3	% Calculating (1 + (2 - (3 * (5 / 4))))
sw 32(r14), r1
addi r1, r0, 0	% Storing 0
sb 36(r14), r1
addi r1, r0, 0	% Storing 0
sb 37(r14), r1
addi r1, r0, 0	% Storing 0
sb 38(r14), r1
addi r1, r0, 0	% Storing 0
sb 39(r14), r1
lw r2, 36(r14)	% Calculating (-0)
muli r2, r2, -1
sw 40(r14), r2
addi r1, r0, 200	% Storing 200
sb 44(r14), r1
addi r1, r0, 0	% Storing 0
sb 45(r14), r1
addi r1, r0, 0	% Storing 0
sb 46(r14), r1
addi r1, r0, 0	% Storing 0
sb 47(r14), r1
lw r1, 44(r14)	% Loading the value of 200
not r1, r1	% Invert the sign
sw 48(r14), r1
lw r1, 48(r14)	% Loading the value of (not 200)
not r1, r1	% Invert the sign
sw 52(r14), r1
lw r2, 40(r14)	% Loading the value of (-0)
lw r3, 52(r14)	% Loading the value of (not (not 200))
and r1, r2, r3	% Calculating ((-0) and (not (not 200)))
sw 64(r14), r1
lw r2, 32(r14)	% Loading the value of (1 + (2 - (3 * (5 / 4))))
lw r3, 64(r14)	% Loading the value of ((-0) and (not (not 200)))
cle r1, r2, r3	% Evaluate ((1 + (2 - (3 * (5 / 4)))) <= ((-0) and (not (not 200))))
sw 68(r14), r1
lw r1, 68(r14)	% Store the put value of ((1 + (2 - (3 * (5 / 4)))) <= ((-0) and (not (not 200)))) - loading 0 of 4
sw 128(r14), r1	% Store the put value of ((1 + (2 - (3 * (5 / 4)))) <= ((-0) and (not (not 200)))) - storing 0 of 4
addi r14, r14, 124
jl r15, puti_func
subi r14, r14, 124
addi r1, r0, 1	% Storing 1
sb 0(r14), r1
addi r1, r0, 0	% Storing 0
sb 1(r14), r1
addi r1, r0, 0	% Storing 0
sb 2(r14), r1
addi r1, r0, 0	% Storing 0
sb 3(r14), r1
addi r1, r0, 2	% Storing 2
sb 4(r14), r1
addi r1, r0, 0	% Storing 0
sb 5(r14), r1
addi r1, r0, 0	% Storing 0
sb 6(r14), r1
addi r1, r0, 0	% Storing 0
sb 7(r14), r1
addi r1, r0, 2	% Storing 2
sb 4(r14), r1
addi r1, r0, 0	% Storing 0
sb 5(r14), r1
addi r1, r0, 0	% Storing 0
sb 6(r14), r1
addi r1, r0, 0	% Storing 0
sb 7(r14), r1
lw r2, 4(r14)	% Loading the value of 2
lw r3, 4(r14)	% Loading the value of 2
mul r1, r2, r3	% Calculating (2 * 2)
sw 72(r14), r1
addi r1, r0, 3	% Storing 3
sb 8(r14), r1
addi r1, r0, 0	% Storing 0
sb 9(r14), r1
addi r1, r0, 0	% Storing 0
sb 10(r14), r1
addi r1, r0, 0	% Storing 0
sb 11(r14), r1
lw r2, 72(r14)	% Loading the value of (2 * 2)
lw r3, 8(r14)	% Loading the value of 3
sub r1, r2, r3	% Calculating ((2 * 2) - 3)
sw 76(r14), r1
addi r1, r0, 7	% Storing 7
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 76(r14)	% Loading the value of ((2 * 2) - 3)
lw r3, 80(r14)	% Loading the value of 7
add r1, r2, r3	% Calculating (((2 * 2) - 3) + 7)
sw 84(r14), r1
lw r2, 0(r14)	% Loading the value of 1
lw r3, 84(r14)	% Loading the value of (((2 * 2) - 3) + 7)
add r1, r2, r3	% Calculating (1 + (((2 * 2) - 3) + 7))
sw 88(r14), r1
addi r1, r0, 1	% Storing 1
sb 0(r14), r1
addi r1, r0, 0	% Storing 0
sb 1(r14), r1
addi r1, r0, 0	% Storing 0
sb 2(r14), r1
addi r1, r0, 0	% Storing 0
sb 3(r14), r1
addi r1, r0, 1	% Storing 1
sb 0(r14), r1
addi r1, r0, 0	% Storing 0
sb 1(r14), r1
addi r1, r0, 0	% Storing 0
sb 2(r14), r1
addi r1, r0, 0	% Storing 0
sb 3(r14), r1
lw r2, 0(r14)	% Calculating (-1)
muli r2, r2, -1
sw 92(r14), r2
lw r1, 92(r14)	% Loading the value of (-1)
not r1, r1	% Invert the sign
sw 96(r14), r1
lw r2, 0(r14)	% Loading the value of 1
lw r3, 96(r14)	% Loading the value of (not (-1))
and r1, r2, r3	% Calculating (1 and (not (-1)))
sw 100(r14), r1
lw r2, 88(r14)	% Loading the value of (1 + (((2 * 2) - 3) + 7))
lw r3, 100(r14)	% Loading the value of (1 and (not (-1)))
cgt r1, r2, r3	% Evaluate ((1 + (((2 * 2) - 3) + 7)) > (1 and (not (-1))))
sw 104(r14), r1
lw r1, 104(r14)	% Store the put value of ((1 + (((2 * 2) - 3) + 7)) > (1 and (not (-1)))) - loading 0 of 4
sw 128(r14), r1	% Store the put value of ((1 + (((2 * 2) - 3) + 7)) > (1 and (not (-1)))) - storing 0 of 4
addi r14, r14, 124
jl r15, puti_func
subi r14, r14, 124
addi r1, r0, 1	% Storing 1
sb 0(r14), r1
addi r1, r0, 0	% Storing 0
sb 1(r14), r1
addi r1, r0, 0	% Storing 0
sb 2(r14), r1
addi r1, r0, 0	% Storing 0
sb 3(r14), r1
addi r1, r0, 2	% Storing 2
sb 4(r14), r1
addi r1, r0, 0	% Storing 0
sb 5(r14), r1
addi r1, r0, 0	% Storing 0
sb 6(r14), r1
addi r1, r0, 0	% Storing 0
sb 7(r14), r1
addi r1, r0, 2	% Storing 2
sb 4(r14), r1
addi r1, r0, 0	% Storing 0
sb 5(r14), r1
addi r1, r0, 0	% Storing 0
sb 6(r14), r1
addi r1, r0, 0	% Storing 0
sb 7(r14), r1
lw r2, 4(r14)	% Loading the value of 2
lw r3, 4(r14)	% Loading the value of 2
mul r1, r2, r3	% Calculating (2 * 2)
sw 72(r14), r1
addi r1, r0, 3	% Storing 3
sb 8(r14), r1
addi r1, r0, 0	% Storing 0
sb 9(r14), r1
addi r1, r0, 0	% Storing 0
sb 10(r14), r1
addi r1, r0, 0	% Storing 0
sb 11(r14), r1
lw r2, 72(r14)	% Loading the value of (2 * 2)
lw r3, 8(r14)	% Loading the value of 3
sub r1, r2, r3	% Calculating ((2 * 2) - 3)
sw 76(r14), r1
addi r1, r0, 7	% Storing 7
sb 80(r14), r1
addi r1, r0, 0	% Storing 0
sb 81(r14), r1
addi r1, r0, 0	% Storing 0
sb 82(r14), r1
addi r1, r0, 0	% Storing 0
sb 83(r14), r1
lw r2, 76(r14)	% Loading the value of ((2 * 2) - 3)
lw r3, 80(r14)	% Loading the value of 7
sub r1, r2, r3	% Calculating (((2 * 2) - 3) - 7)
sw 108(r14), r1
lw r2, 0(r14)	% Loading the value of 1
lw r3, 108(r14)	% Loading the value of (((2 * 2) - 3) - 7)
add r1, r2, r3	% Calculating (1 + (((2 * 2) - 3) - 7))
sw 112(r14), r1
addi r1, r0, 1	% Storing 1
sb 0(r14), r1
addi r1, r0, 0	% Storing 0
sb 1(r14), r1
addi r1, r0, 0	% Storing 0
sb 2(r14), r1
addi r1, r0, 0	% Storing 0
sb 3(r14), r1
addi r1, r0, 1	% Storing 1
sb 0(r14), r1
addi r1, r0, 0	% Storing 0
sb 1(r14), r1
addi r1, r0, 0	% Storing 0
sb 2(r14), r1
addi r1, r0, 0	% Storing 0
sb 3(r14), r1
lw r2, 0(r14)	% Calculating (-1)
muli r2, r2, -1
sw 92(r14), r2
lw r1, 92(r14)	% Loading the value of (-1)
not r1, r1	% Invert the sign
sw 96(r14), r1
lw r2, 0(r14)	% Loading the value of 1
lw r3, 96(r14)	% Loading the value of (not (-1))
or r1, r2, r3	% Calculating (1 or (not (-1)))
sw 116(r14), r1
lw r2, 112(r14)	% Loading the value of (1 + (((2 * 2) - 3) - 7))
lw r3, 116(r14)	% Loading the value of (1 or (not (-1)))
clt r1, r2, r3	% Evaluate ((1 + (((2 * 2) - 3) - 7)) < (1 or (not (-1))))
sw 120(r14), r1
lw r1, 120(r14)	% Store the put value of ((1 + (((2 * 2) - 3) - 7)) < (1 or (not (-1)))) - loading 0 of 4
sw 128(r14), r1	% Store the put value of ((1 + (((2 * 2) - 3) - 7)) < (1 or (not (-1)))) - storing 0 of 4
addi r14, r14, 124
jl r15, puti_func
subi r14, r14, 124
hlt
