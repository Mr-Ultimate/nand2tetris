
package com.jasonrobertfox.nand2tetris.vmtranslator;

import java.io.File;

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

  }

}
