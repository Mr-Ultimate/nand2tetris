@announcd
Feature: Show command line errors for invalid input
  In order to know how to use the translator
  As a hack system developer
  I want helpful error messages when I provide invalid input to the program

  Scenario: I provide no arguments
    When I run `translate`
    Then the program aborts with "You must provide a file or directory to translate."

  Scenario: I provide a file name that does not exist
    When I run `translate not_exist.txt`
    Then the program aborts with "The file: \"not_exist.txt\" was not found."

  Scenario: I provide a file with an invalid extension

