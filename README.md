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
I realized that I needed to be careful implementing the larger and larger memory modules, typically you make the next module with 8 of the previous one, although for the 16K you obviously only need 4 of the constituent 4K. At first I blindly used 8!

###Project 4
Writing the "Fill" program was interesting as it presented 3 possible options to create the program. The instructions note:

> You may choose to write code that blackens and clears the screen's pixels in any spatial/visual order, as long as pressing a key continuously for long enough will result in a fully blackened screen, and not pressing any key for long enough will result in a fully cleared screen.

At first I took this to mean "blacken while a key is down, un-blacken while a key is not down."

This results in a main loop that is constantly iterating through each "word" of the screen memory, setting it to whatever color is determined by the key state. This works fine, however often a key will start darkening halfway though this loop, showing a half black half white screen for a short interval.

The alternative implementation uses a sub loop that iterates through the screen, setting the appropriate color, and then returns to check the keyboard again. This has the benefit of darkening or lightening the screen all at once, but there is a slight delay in the effects.

The final iteration of my program used a little bit more memory but improved the execution speed. In this version loop determine the color and checks if it is different from the color from the previous iteration of the loop. If there is no difference, we just restart the loop, if a difference has been found, it's clear that a key has been pressed and thus the "blackening" sub loop is executed.

This iteration is most pleasing as we only update the screen memory when the keyboard actually changes, rather than during every iteration of the loop.

###Project 5
Implementing the memory module was relatively straight forward, but the CPU was much more daunting. I found it helpful to abstract the control responsibilities into two additional chips: "Decoder," and "JumpDirector."

The final implementation of the "computer" chip was very satisfying, they pretty much just plugged together.

###Project 6
The first programming project gave me an opportunity to learn more about assemblers and practice my clean coding skills. I started with a quick and dirty implementation (test driven, of course) and then refactored considerably to better capture the domain objects.

Originally I had encapsulated the encoding logic for specific types of things, like an individual computation mnemonic, for example. This seemed more confusing and creating a series of instruction objects prevailed.

There remains some duplication and methods that are larger than I would like. It would be worth pulling out the error exceptions into their own construct and standardizing them, as well as pulling apart the CLI application from the main loops.

###Project 7
Originally began this by playing around with Java but that was getting me nowhere. Switched back to ruby so I could focus on the concepts and not also learning a new language, will need to dedicate a separate project to that.
