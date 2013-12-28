#I'm building a computer from first principles!

This is the course: [http://www.nand2tetris.org/](http://www.nand2tetris.org/)

##Project Notes

###Project 0
No notes recorded.

###Project 1
No notes recorded.

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
