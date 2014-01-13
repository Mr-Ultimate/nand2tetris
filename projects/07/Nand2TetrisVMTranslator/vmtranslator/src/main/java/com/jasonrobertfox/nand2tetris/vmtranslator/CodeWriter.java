
package com.jasonrobertfox.nand2tetris.vmtranslator;

import java.io.IOException;
import java.io.Writer;

public class CodeWriter
{

  private Writer writer;

  public CodeWriter(Writer writer)
  {
    this.writer = writer;
  }

  public void setFileName(String fileName)
  {
    writeComment(fileName);
  }

  private void writeLine(String line)
  {
    try {
      writer.write(String.format("%s\n", line));
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

  private void writeComment(String comment)
  {
    writeLine(String.format("// %s", comment));
  }

}
