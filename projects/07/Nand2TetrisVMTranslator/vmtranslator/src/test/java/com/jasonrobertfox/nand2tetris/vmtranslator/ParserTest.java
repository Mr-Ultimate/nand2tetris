package com.jasonrobertfox.nand2tetris.vmtranslator;

import static org.junit.Assert.*;

import java.io.BufferedReader;
import java.io.StringReader;

import org.junit.Test;

public class ParserTest
{

  @Test
  public void itCanBeConstructedWithBufferedReader()
  {
    Parser testParser = initializeTestParserWithData("a command");
    assertNotNull(testParser);
  }
  
  @Test
  public void hasMoreCommandsReturnsFalseForEmptyReader(){
    Parser testParser = initializeTestParserWithData("");
    assertFalse(testParser.hasMoreCommands());
  }
  
  @Test
  public void hasMoreCommandsReturnsTrueForNonEmptyReader(){
    Parser testParser = initializeTestParserWithData("a command");
    assertTrue(testParser.hasMoreCommands());
  }
  
  @Test
  public void advanceLoadsTheNextCommand(){
    Parser testParser = initializeTestParserWithData("a command");
    testParser.advance();
    assertFalse(testParser.hasMoreCommands());
  }
  
  private Parser initializeTestParserWithData(String data){
    StringReader stringReader = new StringReader(data);
    BufferedReader bufferedReader = new BufferedReader(stringReader);
    return new Parser(bufferedReader);
  }

}
