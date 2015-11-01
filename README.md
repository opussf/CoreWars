# CoreWars

## Overview
CoreWars[1] is a game where two programs battle for control of a section of memory.
Combatants write programs in Redcode[2], and pit them against each other.
The first program to be eliminated from memory, or execute a null statement, loses.

## History
In May 1984, A.K.Dewdney introduced Corewar in Scientific American's[4] Computer Recreations column.
Along with D.G.Jones, Dewdney produced the original Core War Guidelines[5].

## Bringing this to WoW
The desire to bring this to World of Warcraft[3] is solely for fun, and a challenge.
I wish to keep CoreWars as a two player game, but allow each player to challenge many other players.

## Game Play
As much of the idea of the original game play will try to be preserved.
There will be some that will have to be different based on the nature of the environment.

### Creating a program
Each player can independently author and test their programs.
A text editor and sample MARS will let the player try their programs out.
This simulator will have the ability for controlling the memory size of the test field.

The player can also remove programs of their own at will.



### Starting a challenge
Player A will challenge Player B.
Player B will accept, or deny the challege.
Player B will propose a memory size (defaults to 8000).
Player A will accept, or deny the memory size.
The memory size will remain constant for the duration of the combat between these two players.

### Combat
Player A and Player B will write, or choose a program from their library.
Player A and Player B will submit their program.
Both players will receive, and store, the other's program, and combat will comence.

Combat will take place on both machines at the same time, with syncing between the clients.
Final results will be displayed to both players, with some stats.

Statistics of each program, and each player will be recorded.

In case of one or both of the clients crashing mid combat, the remaining machine will finish the combat, with a tenative result.
When communication is restored, the crashed computer can then independently finish (or restart) the combat, and check with the non-crashed computer.

If a hard crash (no data saved) has occured, the non-crashing computer can then send all the data needed to:
A) Recover both the programs
B) Simulate the combat
C) Offer and check the results of the outcome.

### Rules
The original spirit of the game, with a second player, was to write two programs, and have them combat.
Writing the programs would take place seperately, and the programs would not be 'known' to the opponent until after it was used.

Note that this does not prohibit proactivly changing your own program, thus assuming that the opponent only has submitted a program that would beat your last program.
This only prohibits each player from first receiving the opposing program, and then writing code to beat it.

### Results and statistics


### Longer Combat


[1]: http://www.corewars.org/index.html "Corewars.org"
[2]: http://vyznev.net/corewar/guide.html "Redcode"
[3]: http://us.battle.net/wow/en/ "World Of Warcraft"
[4]: http://corewar.co.uk/vogtmann/index.htm
[5]: http://corewar.co.uk/standards/cwg.txt
