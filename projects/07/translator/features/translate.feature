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
