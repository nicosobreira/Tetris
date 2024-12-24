# Tetris

## How to Play

You probably already know, just move the pieces, clear lines and make points.

## Controls

ESC toggle between game and menu.

### In Game

| Key | Action |
|:-: | - |
| a | Go left |
| s | Go down |
| d | Go right |
| w | Force down |
| e | Rotate clockwise |
| q | Rotate counter clockwise |

### On Menu

| Key | Action |
| :-: | - |
| r | Restart game |
| q | Quit game |

*EXTRA* Pressing *d* gives debug info on terminal

---

## TODO

- [ ] Create main menu.
- [ ] Add sound effects.
- [x] The game velocity need to be increment depending on the score.
- [ ] The score need to be render above the arena.
- [x] Remove "floating numbers" in functions, and put then in variables.
- [ ] On sweep line make and animation to slow disappear.
- [ ] When lost make an animation with blocks falling.

### EXTRA

- [x] Use `love.graphics.retangle()` instead of `sprites`.

## MAYBE

- [x] Every `Arena` have a `Block` inside, so instead of having the two separate group them **together**.

## FIX

- [ ] Fix the modes change (alive, menu).
