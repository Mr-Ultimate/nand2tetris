@announce
Feature: Translate asm to hack
  In order to have a hack binary program
  As student of nand2tetris
  I want to translate an asm file

  Scenario:
    Given a file derived from project file "add/Add.asm"
    When I run `assemble Add.asm`
    Then the assembled file "Add.hack" should be created
    And its content should match the project file "add/Add.hack"


