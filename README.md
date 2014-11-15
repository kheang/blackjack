# Blackjack

This ruby project is a simple blackjack game that runs in the command-line interface.  The game was a weekend project after completing week 1 of The Iron Yard Academy's (TIY) Ruby on Rails track in Durham, NC.

## Assignment Requirements

Verbatim from TIY instructor: Create a game of blackjack that one person plays on the command line against a computer dealer.

**Requirements**
* The game should start the player with $100 and bets are $10. (Bonus: allow variable bets.)
* The only valid moves are hit and stand. (Bonus: allow double-downs.)
* Allow the player to keep playing as long as they have money.
* You can assume the dealer reshuffles all cards after every round. (Bonus: don't shuffle cards until you run out. This allows for card counting.)
* This game should be fully object-oriented.
* Use Wren (https://github.com/cndreisbach/wren) to create the initial project.

## Lessons Applied

This game was an exercise in creating ruby classes ('Card', 'Deck', 'Wallet', 'Hand', and 'Game') and methods ('deal','show_cards','eval_turn', to name a few).

## Run

To run the game from your terminal, enter the following:

```
ruby lib/blackjack.rb
```

## Ideas for Improvement

I would love to do the following when I have some time:

* Revisit my code and refactor it
* Instead of having this run in the terminal, run in the browser and use javascript to render cards