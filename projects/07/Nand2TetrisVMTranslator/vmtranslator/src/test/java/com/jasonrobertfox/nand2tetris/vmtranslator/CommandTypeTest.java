package com.jasonrobertfox.nand2tetris.vmtranslator;

import static org.junit.Assert.*;

import org.junit.Test;

public class CommandTypeTest
{

  @Test
  public void ensureCorrectCommandTypesExist()
  {
    assertNotNull(CommandType.valueOf("PUSH"));
    assertNotNull(CommandType.valueOf("ARITHMETIC"));
  }

}
