Feature: Show command line errors for invalid input
  In order to know how to use the translator
  As a hack system developer
  I want helpful error messages when I provide invalid input to the program

  Scenario: I provide no arguments
    When I run `translate`
    Then the program aborts with "You must provide a file or directory to translate."

  Scenario: I provide a file name that does not exist
    When I run `translate not_exist.txt`
    Then the program aborts with "Error: \"not_exist.txt\" was not found."

  Scenario: I provide a directory which does not exist
    When I run `translate not_exist`
    Then the program aborts with "Error: \"not_exist\" was not found."

  Scenario: I provide a file with an invalid extension
    Given an empty file named "bad_extension.txt"
    When I run `translate bad_extension.txt`
    Then the program aborts with "Error: The file \"bad_extension.txt\" must have a .vm extension."

  Scenario: I provide an empty directory
    Given a directory named "vm_files"
    When I run `translate vm_files`
    Then the program aborts with "Error: The directory \"vm_files\" does not contain any *.vm files."

  Scenario: I provide a directory with no vm files
    Given an empty file named "vm_files/bad_extension.txt"
    When I run `translate vm_files`
    Then the program aborts with "Error: The directory \"vm_files\" does not contain any *.vm files."


