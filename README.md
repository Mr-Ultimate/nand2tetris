#Nand2Tetris Project Work
Building a computer from first principles! [http://www.nand2tetris.org/](http://www.nand2tetris.org/)

##Project Notes

###Project 0
No notes recorded.

###Project 1
My very first logic gate: "not." The first of many small building blocks derived from the "Nand" gate. I expect it will be cool to look back on this once the project is complete:

    CHIP Not {
        IN in;
        OUT out;

        PARTS:
        Nand(a = in, b = in, out = out);
    }


###Project 2
There was a little difficulty in figuring out how to set the output flags of the ALU chip. I had to dig around to discover that you can set multiple output buses for a particular chip. For example:

    Mux16(
        a = functioned,
        b = outputNeg,
        sel = no,
        out = out,
        out[15] = ng,
        out[0..7] = half1,
        out[8..15] = half2
    );

Above you'll see that the output of that chip goes to the main output, one of the pins splits off to `ng`, and then each half of the bus also splits off to the sub-buses `half1` and `half2`.

###Project 3
It appears there might be an error in the source code, the original `RAM16K.hdl` file has this specification for the address:

    IN in[16], load, address[14]

However, 14 bits was not sufficient to address all the memory locations. You need 3 to address the included RAM4K units, and then 12 for the address needs of those units. The only change needed was to change the 14 to 15. (And then all the tests pass.)

    IN in[16], load, address[15]
