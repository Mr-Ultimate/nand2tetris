@announce
Feature: Translate asm to hack
  In order to have a hack binary program
  As student of nand2tetris
  I want to translate an asm file

  Scenario:
    Given a file derived from project file "max/Max.asm"
    When I run `assemble Max.asm`
    Then the assembled file "Max.hack" should be created
    And its content should match the project file "max/Max.hack"

  Scenario:
    Given a file derived from project file "pong/PongL.asm"
    When I run `assemble PongL.asm`
    Then the assembled file "PongL.hack" should be created
    And its content should match the project file "pong/PongL.hack"

  Scenario:
    Given a file derived from project file "rect/Rect.asm"
    When I run `assemble Rect.asm`
    Then the assembled file "Rect.hack" should be created
    And its content should match the project file "rect/Rect.hack"
