// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Start a loop
// If the keyboard value is 0, loop through each pixel and zero it
// If the keyboard value is not 0, loop through each pixel value and darken it

@color
M=0                 // Initialize color to zero

@SCREEN
D=A                 // Set D to address of first screen word

@sw
M=D                 // Initialize screen address of first word

(LOOP)

    @KBD
    D=M             // Set D to the value of the keyboard register

    @NOT_PRESSED
    D;JEQ           // Goto NOT_PRESSED if keyboard register is zero, else...

    @color
    M=-1            // Set the color to black

    @END_IF
    0;JMP           // End conditional

(NOT_PRESSED)

    @color
    M=0             // Set the color to white

(END_IF)

    @sw
    D=M             // Set D to the current screen word address

    @24576
    D=D-A           // Subtract max screen address

    @RESET_SW
    D;JEQ           // Goto RESET_SW if sw has reached the max

    @color
    D=M             // Set D to the color value

    @sw
    A=M
    M=D             // Set the current screen word to the color value

    @sw
    M=M+1           // Increment the screen word

    @LOOP
    0;JMP           // Restart the loop

(RESET_SW)

    @SCREEN
    D=A             // Set D to first screen word address

    @sw
    M=D             // Reset the screen word address

    @LOOP
    0;JMP           // Restart the loop

