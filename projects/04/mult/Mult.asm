// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[3], respectively.)

// Count up through R1, each time adding R0 to the output.
// R1 "times" R0

@i
M=0         // Set i to 0

@R2
M=0         // Set output, R2 to 0

(LOOP)

    @i
    D=M         // Set D to the value of i

    @R1
    D=D-M       // Set D to i - the value of R1, some negative value

    @END
    D;JEQ       // Goto END if i has converged to the value of R1

    @R0
    D=M         // Set D to the value of R0

    @R2
    M=D+M       // Add R0 to the existing value of R2

    @i
    M=M+1       // Increment i

    @LOOP
    0;JMP       // Goto beginning of LOOP

(END)

    @END
    0;JMP       // Infinite loop
