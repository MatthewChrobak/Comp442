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