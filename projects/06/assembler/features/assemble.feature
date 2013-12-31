Feature: Translate asm to hack
  In order to have a hack binary program
  As student of nand2tetris
  I want to translate an asm file

  Scenario:
    Given the asm file "add/Add.asm"
    When I run `assemble Add.asm`
    Then a correct "Add.hack" should exist


