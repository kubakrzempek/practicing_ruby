#Rapid Prototyping

A goal is a bit of code that implements a small chunk of a Tetris-like game.

Link to an article is [here](https://practicingruby.com/articles/rapid-prototyping)
The article - or should I say the author - walks reader through thought process from the initial idea to the small bit of code.

My plan: develop it to playable game in terminal.

##The Planning Phase

1. ####target set of requirements for a prototype

    * syncing user input with screen output seems to be too much for now,
    * placing piece on the screen and letting the 'gravity' to do the work would require to implement collision detection - for later,
    * key is narrow down the problem to the action that happens when a piece collides with a junk on the grid,
    * whole concept consists of turning active piece into inactive junk, and then removing completed rows.

2. ####sleep on it and see if any unknowns surface. :)

## The Requirements Phase

1. ####>A good prototype does not come from a top-down or bottom-up design, but instead comes from starting in the middle and building outwards

    * small vertical slice of the problem force you to think about many aspects, but not in a way 'whole problem at once'
    * this allows gathered knowledge - and probably - a good chunk of code to be reused
    * start with behaviour the user can observe
    * think in terms of features, not functions and objects

2. ####Consider two cases
    * CASE 1: Removing completed lines
    * CASE 2: Collision without any completed lines

3. ####With goals outlined - write simple program.

## The Coding Phase

1. ####Relax your standard on testing and writing clean code - these get in the way until you grasp basic understanding

From now on the comments on code are within commits' messages.