
package com.jasonrobertfox.nand2tetris.vmtranslator;

import static org.junit.Assert.*;

import org.junit.Test;

public class CommandTest
{

  @Test
  public void test()
  {
    assertNotNull(Command.valueOf("PUSH"));
    assertNotNull(Command.valueOf("ADD"));
    assertNotNull(Command.valueOf("SUB"));
    assertNotNull(Command.valueOf("NEG"));
    assertNotNull(Command.valueOf("EQ"));
    assertNotNull(Command.valueOf("GT"));
    assertNotNull(Command.valueOf("LT"));
    assertNotNull(Command.valueOf("AND"));
    assertNotNull(Command.valueOf("OR"));
    assertNotNull(Command.valueOf("NOT"));
  }

}
