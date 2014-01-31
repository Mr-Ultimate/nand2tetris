
package com.jasonrobertfox.nand2tetris.vmtranslator;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import org.apache.commons.io.FilenameUtils;

public class CLI
{

  private static final String SOURCE_EXTENSION = "vm";

  public static void main(String... args)
  {
    if (args.length == 0) {
      System.out.println("Must provide a *.vm file or directory.");
      System.exit(1);
    }

    String path = args[0];
    File source = new File(path);
    if (!source.exists()) {
      System.out.println(String.format("The file: %s does not exist.", path));
      System.exit(1);
    }

    if (source.isFile() && !FilenameUtils.isExtension(source.getName(), SOURCE_EXTENSION)) {
      System.out
          .println(String.format("The file: %s must have a .vm extension.", source.getName()));
      System.exit(1);
    }

    BufferedReader reader;
    try {
      reader = new BufferedReader(new FileReader(source));
      Parser parser = new Parser(reader);
      
      String fileNameWithOutExt = FilenameUtils.removeExtension(source.getName());
      
      
      CodeWriter codeWriter = new CodeWriter(new FileWriter(String.format("%s.asm",
          fileNameWithOutExt)));

      codeWriter.setFileName(fileNameWithOutExt);
      while (parser.hasMoreCommands()) {

        parser.advance();

        CommandType type = parser.commandType();

        if (type == CommandType.ARITHMETIC) {
          codeWriter.writeArithmetic(null);
        } else if (type == CommandType.PUSH) {
          codeWriter.writePush(parser.getFirstArgument().toString(), parser.getSecondArgument());
        } else {
          System.out.println("Unimplemented Command Type");
          System.exit(1);
        }

      }
      
      codeWriter.close();
      System.out.println("Translation Finished!");
      System.exit(0);

    } catch (FileNotFoundException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

  }

}
