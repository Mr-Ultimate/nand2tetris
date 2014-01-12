
package com.jasonrobertfox.nand2tetris.vmtranslator;

import static org.junit.Assert.*;

import java.io.File;
import java.io.IOException;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.contrib.java.lang.system.Assertion;
import org.junit.contrib.java.lang.system.ExpectedSystemExit;
import org.junit.contrib.java.lang.system.StandardOutputStreamLog;
import org.junit.rules.TemporaryFolder;

public class CLITest
{
  private static final String EOL = System.getProperty("line.separator");
  private static final String NON_EXISTANT_FILE = "nofile.txt";
  private static final String BAD_EXTENSION = ".bad";
  private static final String VALID_FILE_NAME = "vmsource";

  private File badExtensionFile;
  
  @Rule
  public final ExpectedSystemExit exit = ExpectedSystemExit.none();

  @Rule
  public final StandardOutputStreamLog log = new StandardOutputStreamLog();

  @Rule
  public TemporaryFolder testFolder = new TemporaryFolder();
  
  
  @Before
  public void setUp() throws IOException {
      badExtensionFile = File.createTempFile(VALID_FILE_NAME,BAD_EXTENSION);
  }

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

  @Test
  public void itShouldErrorForInvalidExtension() throws IOException
  {
    expectAbortWithMessage(String.format("The file: %s must have a .vm extension.%n",  badExtensionFile.getName(), EOL));
    CLI.main(badExtensionFile.getCanonicalPath());
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
