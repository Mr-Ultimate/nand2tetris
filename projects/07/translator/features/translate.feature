Feature: Translate a vm file into an asm file
  In order to abstract hardware implementation from higher level code
  As a hack system developer
  I want to compile vm code into assembly code

  Scenario: I can translate an empty file
    Given an empty file named "source.vm"
    When I run `translate source.vm`
    Then the stdout should contain "Translated the contents of \"source.vm\" to \"source.asm\"."
    And the exit status should be 0

  Scenario: I can translate a directory of empty files
    Given an empty file named "vm_files/source.vm"
    And an empty file named "vm_files/source2.vm"
    When I run `translate vm_files`
    Then the stdout should contain "Translated the contents of \"vm_files\" to \"vm_files.asm\"."
    And the exit status should be 0

  Scenario: Simple Add
    Given a file derived from project file "StackArithmetic/SimpleAdd/SimpleAdd.vm"
    When I run `translate SimpleAdd.vm`
    Then a file named "SimpleAdd.asm" should exist
    And the file "SimpleAdd.asm" should contain exactly:
      """
      @7
      D=A
      @SP
      AM=M+1
      A=A-1
      M=D
      @8
      D=A
      @SP
      AM=M+1
      A=A-1
      M=D
      @SP
      AM=M-1
      D=M
      A=A-1
      M=D+M

      """

  Scenario: Stack Test
    Given a file derived from project file "StackArithmetic/StackTest/StackTest.vm"
    When I run `translate StackTest.vm`
    Then a file named "StackTest.asm" should exist
