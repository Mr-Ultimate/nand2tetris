
package com.jasonrobertfox.nand2tetris.vmtranslator;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.EnumMap;

public class Parser
{

  private String nextLine;
  private String currentLine;
  private BufferedReader reader;
  private EnumMap<Command, CommandType> commandMap;

  public Parser(BufferedReader reader)
  {
    initializeCommandMap();
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

  public CommandType commandType()
  {
    return commandMap.get(Command.valueOf(currentLine.toUpperCase()));
  }

  
  public Object getFirstArgument()
  {
    return Command.valueOf(currentLine.toUpperCase());
  }
  
  
  private void readNextLine()
  {
    try {
      String rawLine = reader.readLine();
      if (rawLine != null){
        nextLine = rawLine.replaceAll("//.*", "").trim();
      }else{
        nextLine = rawLine;
      }
    } catch (IOException e) {
      e.printStackTrace(); // TODO: Figure out what do do with this.
    }
  }

  private void initializeCommandMap()
  {
    commandMap = new EnumMap<Command, CommandType>(Command.class);
    commandMap.put(Command.NOT, CommandType.ARITHMETIC);
  }



}
