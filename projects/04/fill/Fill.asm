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

@last
M=0                 // Initialize a prior color to zero

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

    @color
    D=M             // Load D with the color

    @last
    D=D-M           // Color - last color (0--1=1) (-1--1=0) (-1-0=-1) (0-0=0)

    @LOOP
    D;JEQ           // Loop if color hasn't changed

    @color
    D=M

    @last
    M=D             // Set last to the current color

    @SCREEN
    D=A             // Set D to first screen word address

    @sw
    M=D             // Set sw to the first screen word address

(SCREEN_LOOP)

    @sw
    D=M             // Set D to the current screen word address

    @24576
    D=D-A           // Subtract max screen address

    @LOOP
    D;JEQ           // Exit screen loop if sw has reached the max

    @color
    D=M             // Set D to the color value

    @sw
    A=M             // Set the A register to the address from sw
    M=D             // Set the current screen word to the color value

    @sw
    M=M+1           // Increment the screen word

    @SCREEN_LOOP
    0;JMP           // Repeat screen loop


