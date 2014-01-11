
package com.jasonrobertfox.nand2tetris.vmtranslator;

import static org.junit.Assert.*;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import org.junit.Test;

public class CLITest
{
  private static final String EOL = System.getProperty("line.separator");

  @Test
  public void itShouldShowUsageForNoArgument()
  {
    ByteArrayOutputStream bytes = new ByteArrayOutputStream();
    PrintStream console = System.out;
    try {
      System.setOut(new PrintStream(bytes));
      CLI.main(new String[] {});
    } finally {
      System.setOut(console);
    }
    assertEquals(String.format("Must provide a *.vm file or directory.%n", EOL), bytes.toString());
  }
}
