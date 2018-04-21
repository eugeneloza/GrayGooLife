The end of Life is neigh... Gray Goo is coming.

Compiles to: Windows, Linux, Android

# Short introduction

The game is a mix between a well-known Life game and real-time strategy written in Free Pascal + Lazarus + Castle Game Engine.
Player can spawn Life game objects in the battlefield to destroy enemies and eliminate gray goo.

Rules are similar to Life game:

If a cell has 1 or less neighbours it dies.
If a cell has 4 or more neighbours it dies.
If a cell has 2 or 3 neighbours it lives.

If a dead space with 3 neigbours becomes a living cell.

Now the difference:

If a cell of color A has 2 cells of color B and one of color A it becomes of color B.
If a living cell was born with non-single-colored cells it is a GrayGoo (gray color).
If a GrayGoo cell touches a colored cell it becomes its color in case there are no other colors around.

No installation is required, just extract all files to one folder and play.
You may need to set "executable" bit in Linux.

# Linux

Libraries required for the game (Linux: Debian/Ubuntu package reference):
libopenal1
libpng
zlib1g
libvorbis
libfreetype6
libgtkglext1
You'll also need OpenGL drivers for your videocard. Usually it is libgl1-mesa-dev.
You also need X-system and GTK at least version 2, however, you are very likely to have it already installed :)