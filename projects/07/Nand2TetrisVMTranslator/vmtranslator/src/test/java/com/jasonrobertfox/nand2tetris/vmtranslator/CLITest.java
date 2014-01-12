package com.jasonrobertfox.nand2tetris.vmtranslator;

import static org.junit.Assert.*;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import org.junit.Rule;
import org.junit.Test;
import org.junit.contrib.java.lang.system.ExpectedSystemExit;

public class CLITest
{
  private static final String EOL = System.getProperty("line.separator");
  private static final String NON_EXISTANT_FILE = "nofile.txt";

  @Rule
  public final ExpectedSystemExit exit = ExpectedSystemExit.none();
  
  
  @Test
  public void itShouldShowUsageForNoArgument()
  {
    ByteArrayOutputStream bytes = new ByteArrayOutputStream();
    PrintStream console = System.out;
    try {
      System.setOut(new PrintStream(bytes));
      CLI.main(new String[]{});
    } finally {
      System.setOut(console);
    }
    assertEquals(String.format("Must provide a *.vm file or directory.%n", EOL), bytes.toString());
  }
  
//  @Test
//  public void itShouldErrorForANotFoundFile()
//  {
//    ByteArrayOutputStream bytes = new ByteArrayOutputStream();
//    PrintStream console = System.out;
//    try {
//      System.setOut(new PrintStream(bytes));
//      CLI.main(NON_EXISTANT_FILE);
//    } finally {
//      System.setOut(console);
//    }
//    assertEquals(String.format("The file: %s does not exist.%n", NON_EXISTANT_FILE, EOL), bytes.toString());
//  }
}
