
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
  
  @Test
  public void itCanTranslateAPushConstantCommand(){
    testCodeWriter.writePush("constant", 123);
    assertOutputEquals("@123\nD=A\n@SP\nAM=M+1\nA=A-1\nM=D\n");
    

  }
  
  @Test
  public void itCanTranslateAnAddCommand(){
    testCodeWriter.writeArithmetic("add");
    assertOutputEquals("@SP\nAM=M-1\nD=M\nM=0\nA=A-1\nM=D+M\n");
  }
  

  private void assertOutputEquals(String expected)
  {
    assertEquals(expected, testWriter.toString());
  }

}
