
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

  public void writePush(String segment, String index)
  {
    writeLine(String.format("@%s", index));
    writeLine("D=A");
    writeLine("@SP");
    writeLine("AM=M+1");
    writeLine("A=A-1");
    writeLine("M=D");
  }

  public void writeArithmetic(String string)
  {
    writeLine("@SP");
    writeLine("AM=M-1");
    writeLine("D=M");
    writeLine("M=0");
    writeLine("A=A-1");
    writeLine("M=D+M");
  }
  
  public void close() throws IOException{
    this.writer.close();
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
