
package com.jasonrobertfox.nand2tetris.vmtranslator;

import static org.junit.Assert.*;

import org.junit.Rule;
import org.junit.Test;
import org.junit.contrib.java.lang.system.Assertion;
import org.junit.contrib.java.lang.system.ExpectedSystemExit;
import org.junit.contrib.java.lang.system.StandardOutputStreamLog;

public class CLITest
{
  private static final String EOL = System.getProperty("line.separator");
  private static final String NON_EXISTANT_FILE = "nofile.txt";

  @Rule
  public final ExpectedSystemExit exit = ExpectedSystemExit.none();

  @Rule
  public final StandardOutputStreamLog log = new StandardOutputStreamLog();

  @Test
  public void itShouldShowUsageForNoArgument()
  {
    expectAbortWithMessage(String.format("Must provide a *.vm file or directory.%n", EOL));
    CLI.main(new String[] {});
  }

  @Test
  public void itShouldErrorForANotFoundFile()
  {
    expectAbortWithMessage(String.format("The file: %s does not exist.%n", NON_EXISTANT_FILE, EOL));
    CLI.main(NON_EXISTANT_FILE);
  }

  private void expectAbortWithMessage(final String errorMessage)
  {
    exit.expectSystemExitWithStatus(1);
    exit.checkAssertionAfterwards(new Assertion() {
      public void checkAssertion()
      {
        assertEquals(errorMessage, log.getLog());
      }
    });
  }
}
