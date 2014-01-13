
package com.jasonrobertfox.nand2tetris.vmtranslator;

import static org.junit.Assert.*;

import java.io.StringWriter;

import org.junit.Before;
import org.junit.Test;

public class CodeWriterTest
{

  private static final String VALID_INPUT_FILE_NAME = "testFile";
  private CodeWriter testCodeWriter;
  private StringWriter testWriter;

  @Before
  public void setUp()
  {
    testWriter = new StringWriter();
    testCodeWriter = new CodeWriter(testWriter);
  }

  @Test
  public void itCanBeInitializedWithAWriter()
  {
    assertNotNull(testCodeWriter);
  }

  @Test
  public void settingTheFileNameAddsCommentToOutput()
  {
    testCodeWriter.setFileName(VALID_INPUT_FILE_NAME);
    assertOutputEquals(String.format("// %s\n", VALID_INPUT_FILE_NAME));
  }

  private void assertOutputEquals(String expected)
  {
    assertEquals(expected, testWriter.toString());
  }

}
