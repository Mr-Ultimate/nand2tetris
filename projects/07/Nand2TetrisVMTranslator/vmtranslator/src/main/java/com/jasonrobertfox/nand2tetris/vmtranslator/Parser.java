
package com.jasonrobertfox.nand2tetris.vmtranslator;

import java.io.BufferedReader;
import java.io.IOException;

public class Parser
{

  private String nextLine;
  private String currentLine;
  private BufferedReader reader;

  public Parser(BufferedReader reader)
  {
    this.reader = reader;
    readNextLine();
  }

  public boolean hasMoreCommands()
  {
    return nextLine != null ? true : false;
  }

  public void advance()
  {
    currentLine = nextLine;
    readNextLine();

  }

  private void readNextLine()
  {
      try {
        nextLine = reader.readLine();
      } catch (IOException e) {
        e.printStackTrace(); //TODO: Figure out what do do with this. 
      }
  }

}
