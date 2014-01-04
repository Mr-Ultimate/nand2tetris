Feature: Translate asm to hack
  In order to have a hack binary program
  As student of nand2tetris
  I want to translate an asm file

  Scenario:
    Given a file derived from project file "add/Add.asm"
    When I run `assemble Add.asm`
    Then the assembled file "Add.hack" should be created
    And its content should match the project file "add/Add.hack"

  Scenario:
    Given a file derived from project file "max/MaxL.asm"
    When I run `assemble MaxL.asm`
    Then the assembled file "MaxL.hack" should be created
    And its content should match the project file "max/MaxL.hack"

  Scenario:
    Given a file derived from project file "pong/PongL.asm"
    When I run `assemble PongL.asm`
    Then the assembled file "PongL.hack" should be created
    And its content should match the project file "pong/PongL.hack"

  Scenario:
    Given a file derived from project file "rect/RectL.asm"
    When I run `assemble RectL.asm`
    Then the assembled file "RectL.hack" should be created
    And its content should match the project file "rect/RectL.hack"
