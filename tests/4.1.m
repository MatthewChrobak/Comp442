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
addi r14, r0, 4952  % Set the stack pointer
addi r1, r0, 1440	% Start to calculate the offset for i
sw 1464(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 1464(r14)
add r1, r1, r2
sw 1464(r14), r1
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% i=0 - loading 0 of 4
lw r2, 1464(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% int a = 0 - loading 0 of 4
sw 1444(r14), r1	% int a = 0 - storing 0 of 4
j forcond_15_5
for_15_5    nop	% Start the for loop
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1472(r14)	% Loading the value of a
lw r2, 0(r2)	% Pointer detected. Dereferencing a
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (a + 1)
sw 1480(r14), r1
lw r1, 1480(r14)	% a=(a + 1) - loading 0 of 4
lw r2, 1472(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_15_5   nop
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1472(r14)	% Loading the value of a
lw r2, 0(r2)	% Pointer detected. Dereferencing a
lw r3, 1476(r14)	% Loading the value of 1
clt r1, r2, r3	% Evaluate (a < 1)
sw 1484(r14), r1
lw r1, 1484(r14)	% Loading the value of (a < 1)
bz r1, endfor_15_5
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% int b = 0 - loading 0 of 4
sw 1448(r14), r1	% int b = 0 - storing 0 of 4
j forcond_16_9
for_16_9    nop	% Start the for loop
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1488(r14)	% Loading the value of b
lw r2, 0(r2)	% Pointer detected. Dereferencing b
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (b + 1)
sw 1492(r14), r1
lw r1, 1492(r14)	% b=(b + 1) - loading 0 of 4
lw r2, 1488(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_16_9   nop
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 2	% Storing 2
sb 1496(r14), r1
addi r1, r0, 0	% Storing 0
sb 1497(r14), r1
addi r1, r0, 0	% Storing 0
sb 1498(r14), r1
addi r1, r0, 0	% Storing 0
sb 1499(r14), r1
lw r2, 1488(r14)	% Loading the value of b
lw r2, 0(r2)	% Pointer detected. Dereferencing b
lw r3, 1496(r14)	% Loading the value of 2
clt r1, r2, r3	% Evaluate (b < 2)
sw 1500(r14), r1
lw r1, 1500(r14)	% Loading the value of (b < 2)
bz r1, endfor_16_9
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% int c = 0 - loading 0 of 4
sw 1452(r14), r1	% int c = 0 - storing 0 of 4
j forcond_17_13
for_17_13    nop	% Start the for loop
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1504(r14)	% Loading the value of c
lw r2, 0(r2)	% Pointer detected. Dereferencing c
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (c + 1)
sw 1508(r14), r1
lw r1, 1508(r14)	% c=(c + 1) - loading 0 of 4
lw r2, 1504(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_17_13   nop
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 3	% Storing 3
sb 1512(r14), r1
addi r1, r0, 0	% Storing 0
sb 1513(r14), r1
addi r1, r0, 0	% Storing 0
sb 1514(r14), r1
addi r1, r0, 0	% Storing 0
sb 1515(r14), r1
lw r2, 1504(r14)	% Loading the value of c
lw r2, 0(r2)	% Pointer detected. Dereferencing c
lw r3, 1512(r14)	% Loading the value of 3
clt r1, r2, r3	% Evaluate (c < 3)
sw 1516(r14), r1
lw r1, 1516(r14)	% Loading the value of (c < 3)
bz r1, endfor_17_13
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% int d = 0 - loading 0 of 4
sw 1456(r14), r1	% int d = 0 - storing 0 of 4
j forcond_18_17
for_18_17    nop	% Start the for loop
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1520(r14)	% Loading the value of d
lw r2, 0(r2)	% Pointer detected. Dereferencing d
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (d + 1)
sw 1524(r14), r1
lw r1, 1524(r14)	% d=(d + 1) - loading 0 of 4
lw r2, 1520(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_18_17   nop
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 4	% Storing 4
sb 1528(r14), r1
addi r1, r0, 0	% Storing 0
sb 1529(r14), r1
addi r1, r0, 0	% Storing 0
sb 1530(r14), r1
addi r1, r0, 0	% Storing 0
sb 1531(r14), r1
lw r2, 1520(r14)	% Loading the value of d
lw r2, 0(r2)	% Pointer detected. Dereferencing d
lw r3, 1528(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (d < 4)
sw 1532(r14), r1
lw r1, 1532(r14)	% Loading the value of (d < 4)
bz r1, endfor_18_17
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% int e = 0 - loading 0 of 4
sw 1460(r14), r1	% int e = 0 - storing 0 of 4
j forcond_19_21
for_19_21    nop	% Start the for loop
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1536(r14)	% Loading the value of e
lw r2, 0(r2)	% Pointer detected. Dereferencing e
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (e + 1)
sw 1540(r14), r1
lw r1, 1540(r14)	% e=(e + 1) - loading 0 of 4
lw r2, 1536(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_19_21   nop
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 5	% Storing 5
sb 1544(r14), r1
addi r1, r0, 0	% Storing 0
sb 1545(r14), r1
addi r1, r0, 0	% Storing 0
sb 1546(r14), r1
addi r1, r0, 0	% Storing 0
sb 1547(r14), r1
lw r2, 1536(r14)	% Loading the value of e
lw r2, 0(r2)	% Pointer detected. Dereferencing e
lw r3, 1544(r14)	% Loading the value of 5
clt r1, r2, r3	% Evaluate (e < 5)
sw 1548(r14), r1
lw r1, 1548(r14)	% Loading the value of (e < 5)
bz r1, endfor_19_21
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 0	% Start to calculate the offset for simpleArray[a][b][c][d][e]
lw r2, 1472(r14)	% Getting the index [a]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 2	% Multiply by the chunk size 2
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index a
lw r2, 1488(r14)	% Getting the index [b]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index b
lw r2, 1504(r14)	% Getting the index [c]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index c
lw r2, 1520(r14)	% Getting the index [d]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index d
lw r2, 1536(r14)	% Getting the index [e]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index e
sw 1552(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for simpleArray[a][b][c][d][e]
lw r2, 1552(r14)
add r1, r1, r2
sw 1552(r14), r1
addi r1, r0, 1440	% Start to calculate the offset for i
sw 1464(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 1464(r14)
add r1, r1, r2
sw 1464(r14), r1
lw r1, 1464(r14)	% simpleArray[a][b][c][d][e]=i - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 1552(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 480	% Start to calculate the offset for complexArray[a][b][c][d][e]
lw r2, 1472(r14)	% Getting the index [a]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 2	% Multiply by the chunk size 2
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index a
lw r2, 1488(r14)	% Getting the index [b]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index b
lw r2, 1504(r14)	% Getting the index [c]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index c
lw r2, 1520(r14)	% Getting the index [d]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index d
lw r2, 1536(r14)	% Getting the index [e]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index e
sw 1556(r14), r1
addi r1, r1, 4
sw 1560(r14), r1
addi r1, r0, 0	% Start to calculate the offset for val1
sw 1564(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for complexArray[a][b][c][d][e].val1
lw r2, 1556(r14)
add r1, r1, r2
lw r2, 1564(r14)
add r1, r1, r2
sw 1568(r14), r1
addi r1, r0, 1440	% Start to calculate the offset for i
sw 1464(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 1464(r14)
add r1, r1, r2
sw 1464(r14), r1
lw r1, 1464(r14)	% complexArray[a][b][c][d][e].val1=i - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 1568(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 480	% Start to calculate the offset for complexArray[a][b][c][d][e]
lw r2, 1472(r14)	% Getting the index [a]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 2	% Multiply by the chunk size 2
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index a
lw r2, 1488(r14)	% Getting the index [b]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index b
lw r2, 1504(r14)	% Getting the index [c]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index c
lw r2, 1520(r14)	% Getting the index [d]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index d
lw r2, 1536(r14)	% Getting the index [e]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index e
sw 1556(r14), r1
addi r1, r1, 4
sw 1560(r14), r1
addi r1, r0, 4	% Start to calculate the offset for val2
sw 1572(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for complexArray[a][b][c][d][e].val2
lw r2, 1556(r14)
add r1, r1, r2
lw r2, 1572(r14)
add r1, r1, r2
sw 1576(r14), r1
addi r1, r0, 1440	% Start to calculate the offset for i
sw 1464(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 1464(r14)
add r1, r1, r2
sw 1464(r14), r1
lw r1, 1464(r14)	% complexArray[a][b][c][d][e].val2=i - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
lw r2, 1576(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
addi r1, r0, 1440	% Start to calculate the offset for i
sw 1464(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 1464(r14)
add r1, r1, r2
sw 1464(r14), r1
addi r1, r0, 1440	% Start to calculate the offset for i
sw 1464(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for i
lw r2, 1464(r14)
add r1, r1, r2
sw 1464(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1464(r14)	% Loading the value of i
lw r2, 0(r2)	% Pointer detected. Dereferencing i
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (i + 1)
sw 1580(r14), r1
lw r1, 1580(r14)	% i=(i + 1) - loading 0 of 4
lw r2, 1464(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
j for_19_21
endfor_19_21    nop
j for_18_17
endfor_18_17    nop
j for_17_13
endfor_17_13    nop
j for_16_9
endfor_16_9    nop
j for_15_5
endfor_15_5    nop
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% int a = 0 - loading 0 of 4
sw 1444(r14), r1	% int a = 0 - storing 0 of 4
j forcond_30_5
for_30_5    nop	% Start the for loop
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1472(r14)	% Loading the value of a
lw r2, 0(r2)	% Pointer detected. Dereferencing a
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (a + 1)
sw 1480(r14), r1
lw r1, 1480(r14)	% a=(a + 1) - loading 0 of 4
lw r2, 1472(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_30_5   nop
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1472(r14)	% Loading the value of a
lw r2, 0(r2)	% Pointer detected. Dereferencing a
lw r3, 1476(r14)	% Loading the value of 1
clt r1, r2, r3	% Evaluate (a < 1)
sw 1484(r14), r1
lw r1, 1484(r14)	% Loading the value of (a < 1)
bz r1, endfor_30_5
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% int b = 0 - loading 0 of 4
sw 1448(r14), r1	% int b = 0 - storing 0 of 4
j forcond_31_9
for_31_9    nop	% Start the for loop
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1488(r14)	% Loading the value of b
lw r2, 0(r2)	% Pointer detected. Dereferencing b
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (b + 1)
sw 1492(r14), r1
lw r1, 1492(r14)	% b=(b + 1) - loading 0 of 4
lw r2, 1488(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_31_9   nop
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 2	% Storing 2
sb 1496(r14), r1
addi r1, r0, 0	% Storing 0
sb 1497(r14), r1
addi r1, r0, 0	% Storing 0
sb 1498(r14), r1
addi r1, r0, 0	% Storing 0
sb 1499(r14), r1
lw r2, 1488(r14)	% Loading the value of b
lw r2, 0(r2)	% Pointer detected. Dereferencing b
lw r3, 1496(r14)	% Loading the value of 2
clt r1, r2, r3	% Evaluate (b < 2)
sw 1500(r14), r1
lw r1, 1500(r14)	% Loading the value of (b < 2)
bz r1, endfor_31_9
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% int c = 0 - loading 0 of 4
sw 1452(r14), r1	% int c = 0 - storing 0 of 4
j forcond_32_13
for_32_13    nop	% Start the for loop
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1504(r14)	% Loading the value of c
lw r2, 0(r2)	% Pointer detected. Dereferencing c
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (c + 1)
sw 1508(r14), r1
lw r1, 1508(r14)	% c=(c + 1) - loading 0 of 4
lw r2, 1504(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_32_13   nop
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 3	% Storing 3
sb 1512(r14), r1
addi r1, r0, 0	% Storing 0
sb 1513(r14), r1
addi r1, r0, 0	% Storing 0
sb 1514(r14), r1
addi r1, r0, 0	% Storing 0
sb 1515(r14), r1
lw r2, 1504(r14)	% Loading the value of c
lw r2, 0(r2)	% Pointer detected. Dereferencing c
lw r3, 1512(r14)	% Loading the value of 3
clt r1, r2, r3	% Evaluate (c < 3)
sw 1516(r14), r1
lw r1, 1516(r14)	% Loading the value of (c < 3)
bz r1, endfor_32_13
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% int d = 0 - loading 0 of 4
sw 1456(r14), r1	% int d = 0 - storing 0 of 4
j forcond_33_17
for_33_17    nop	% Start the for loop
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1520(r14)	% Loading the value of d
lw r2, 0(r2)	% Pointer detected. Dereferencing d
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (d + 1)
sw 1524(r14), r1
lw r1, 1524(r14)	% d=(d + 1) - loading 0 of 4
lw r2, 1520(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_33_17   nop
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 4	% Storing 4
sb 1528(r14), r1
addi r1, r0, 0	% Storing 0
sb 1529(r14), r1
addi r1, r0, 0	% Storing 0
sb 1530(r14), r1
addi r1, r0, 0	% Storing 0
sb 1531(r14), r1
lw r2, 1520(r14)	% Loading the value of d
lw r2, 0(r2)	% Pointer detected. Dereferencing d
lw r3, 1528(r14)	% Loading the value of 4
clt r1, r2, r3	% Evaluate (d < 4)
sw 1532(r14), r1
lw r1, 1532(r14)	% Loading the value of (d < 4)
bz r1, endfor_33_17
addi r1, r0, 0	% Storing 0
sb 1468(r14), r1
addi r1, r0, 0	% Storing 0
sb 1469(r14), r1
addi r1, r0, 0	% Storing 0
sb 1470(r14), r1
addi r1, r0, 0	% Storing 0
sb 1471(r14), r1
lw r1, 1468(r14)	% int e = 0 - loading 0 of 4
sw 1460(r14), r1	% int e = 0 - storing 0 of 4
j forcond_34_21
for_34_21    nop	% Start the for loop
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 1	% Storing 1
sb 1476(r14), r1
addi r1, r0, 0	% Storing 0
sb 1477(r14), r1
addi r1, r0, 0	% Storing 0
sb 1478(r14), r1
addi r1, r0, 0	% Storing 0
sb 1479(r14), r1
lw r2, 1536(r14)	% Loading the value of e
lw r2, 0(r2)	% Pointer detected. Dereferencing e
lw r3, 1476(r14)	% Loading the value of 1
add r1, r2, r3	% Calculating (e + 1)
sw 1540(r14), r1
lw r1, 1540(r14)	% e=(e + 1) - loading 0 of 4
lw r2, 1536(r14)
sw 0(r2), r1	% Pointer detected. Storing the value in the dereferenced location.
forcond_34_21   nop
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 5	% Storing 5
sb 1544(r14), r1
addi r1, r0, 0	% Storing 0
sb 1545(r14), r1
addi r1, r0, 0	% Storing 0
sb 1546(r14), r1
addi r1, r0, 0	% Storing 0
sb 1547(r14), r1
lw r2, 1536(r14)	% Loading the value of e
lw r2, 0(r2)	% Pointer detected. Dereferencing e
lw r3, 1544(r14)	% Loading the value of 5
clt r1, r2, r3	% Evaluate (e < 5)
sw 1548(r14), r1
lw r1, 1548(r14)	% Loading the value of (e < 5)
bz r1, endfor_34_21
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 0	% Start to calculate the offset for simpleArray[a][b][c][d][e]
lw r2, 1472(r14)	% Getting the index [a]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 2	% Multiply by the chunk size 2
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index a
lw r2, 1488(r14)	% Getting the index [b]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index b
lw r2, 1504(r14)	% Getting the index [c]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index c
lw r2, 1520(r14)	% Getting the index [d]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index d
lw r2, 1536(r14)	% Getting the index [e]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 4	% Multiply by the size.
add r1, r1, r2	% Add the index e
sw 1552(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for simpleArray[a][b][c][d][e]
lw r2, 1552(r14)
add r1, r1, r2
sw 1552(r14), r1
lw r1, 1552(r14)	% Store the put value of simpleArray[a][b][c][d][e] - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1588(r14), r1	% Store the put value of simpleArray[a][b][c][d][e] - storing 0 of 4
addi r14, r14, 1584
jl r15, puti_func
subi r14, r14, 1584
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 480	% Start to calculate the offset for complexArray[a][b][c][d][e]
lw r2, 1472(r14)	% Getting the index [a]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 2	% Multiply by the chunk size 2
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index a
lw r2, 1488(r14)	% Getting the index [b]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index b
lw r2, 1504(r14)	% Getting the index [c]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index c
lw r2, 1520(r14)	% Getting the index [d]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index d
lw r2, 1536(r14)	% Getting the index [e]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index e
sw 1556(r14), r1
addi r1, r1, 4
sw 1560(r14), r1
addi r1, r0, 0	% Start to calculate the offset for val1
sw 1564(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for complexArray[a][b][c][d][e].val1
lw r2, 1556(r14)
add r1, r1, r2
lw r2, 1564(r14)
add r1, r1, r2
sw 1568(r14), r1
lw r1, 1568(r14)	% Store the put value of complexArray[a][b][c][d][e].val1 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1588(r14), r1	% Store the put value of complexArray[a][b][c][d][e].val1 - storing 0 of 4
addi r14, r14, 1584
jl r15, puti_func
subi r14, r14, 1584
addi r1, r0, 1444	% Start to calculate the offset for a
sw 1472(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for a
lw r2, 1472(r14)
add r1, r1, r2
sw 1472(r14), r1
addi r1, r0, 1448	% Start to calculate the offset for b
sw 1488(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for b
lw r2, 1488(r14)
add r1, r1, r2
sw 1488(r14), r1
addi r1, r0, 1452	% Start to calculate the offset for c
sw 1504(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for c
lw r2, 1504(r14)
add r1, r1, r2
sw 1504(r14), r1
addi r1, r0, 1456	% Start to calculate the offset for d
sw 1520(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for d
lw r2, 1520(r14)
add r1, r1, r2
sw 1520(r14), r1
addi r1, r0, 1460	% Start to calculate the offset for e
sw 1536(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for e
lw r2, 1536(r14)
add r1, r1, r2
sw 1536(r14), r1
addi r1, r0, 480	% Start to calculate the offset for complexArray[a][b][c][d][e]
lw r2, 1472(r14)	% Getting the index [a]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 2	% Multiply by the chunk size 2
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index a
lw r2, 1488(r14)	% Getting the index [b]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 3	% Multiply by the chunk size 3
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index b
lw r2, 1504(r14)	% Getting the index [c]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 4	% Multiply by the chunk size 4
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index c
lw r2, 1520(r14)	% Getting the index [d]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
muli r2, r2, 5	% Multiply by the chunk size 5
add r1, r1, r2	% Add the index d
lw r2, 1536(r14)	% Getting the index [e]
lw r2, 0(r2)	% Pointer deteced - dereferencing
muli r2, r2, 8	% Multiply by the size.
add r1, r1, r2	% Add the index e
sw 1556(r14), r1
addi r1, r1, 4
sw 1560(r14), r1
addi r1, r0, 4	% Start to calculate the offset for val2
sw 1572(r14), r1
addi r1, r14, 0	% Calculating the REAL offset for complexArray[a][b][c][d][e].val2
lw r2, 1556(r14)
add r1, r1, r2
lw r2, 1572(r14)
add r1, r1, r2
sw 1576(r14), r1
lw r1, 1576(r14)	% Store the put value of complexArray[a][b][c][d][e].val2 - loading 0 of 4
lw r1, 0(r1)	% Pointer detected. Dereferencing.
sw 1588(r14), r1	% Store the put value of complexArray[a][b][c][d][e].val2 - storing 0 of 4
addi r14, r14, 1584
jl r15, puti_func
subi r14, r14, 1584
j for_34_21
endfor_34_21    nop
j for_33_17
endfor_33_17    nop
j for_32_13
endfor_32_13    nop
j for_31_9
endfor_31_9    nop
j for_30_5
endfor_30_5    nop
hlt
