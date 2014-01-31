
package com.jasonrobertfox.nand2tetris.vmtranslator;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.EnumMap;

public class Parser
{

  private String nextLine;
  private BufferedReader reader;
  private EnumMap<Command, CommandType> commandMap;
  private String[] currentLineTokens;

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
    currentLineTokens = nextLine.split("\\s");
    readNextLine();

  }

  public CommandType commandType()
  {
    String token = currentLineTokens[0].toUpperCase();
    return commandMap.get(Command.valueOf(token));
  }

  public Object getFirstArgument()
  {
    if (currentLineTokens.length == 1) {
      return Command.valueOf(currentLineTokens[0].toUpperCase());
    } else {
      return currentLineTokens[1];
    }
  }

  public String getSecondArgument()
  {
    return currentLineTokens.length == 3 ? currentLineTokens[2] : null;
  }

  private void readNextLine()
  {
    // TODO: This is a mess, clean it up
    try {
      String rawLine = reader.readLine();
      if (rawLine != null) {
        String cleanedLine = rawLine.replaceAll("//.*", "").trim();
        if (cleanedLine.isEmpty() ){
          readNextLine();
        }else{
          nextLine = cleanedLine;
        }
      } else {
        nextLine = rawLine;
      }
    } catch (IOException e) {
      e.printStackTrace(); // TODO: Figure out what do do with this.
    }
  }

  private void initializeCommandMap()
  {
    commandMap = new EnumMap<Command, CommandType>(Command.class);
    commandMap.put(Command.ADD, CommandType.ARITHMETIC);
    commandMap.put(Command.SUB, CommandType.ARITHMETIC);
    commandMap.put(Command.NEG, CommandType.ARITHMETIC);
    commandMap.put(Command.EQ, CommandType.ARITHMETIC);
    commandMap.put(Command.GT, CommandType.ARITHMETIC);
    commandMap.put(Command.LT, CommandType.ARITHMETIC);
    commandMap.put(Command.AND, CommandType.ARITHMETIC);
    commandMap.put(Command.OR, CommandType.ARITHMETIC);
    commandMap.put(Command.NOT, CommandType.ARITHMETIC);
    commandMap.put(Command.PUSH, CommandType.PUSH);
  }

}
