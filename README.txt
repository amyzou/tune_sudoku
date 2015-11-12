Sudoku solving!

My algorithm solves sudokus the way I do it, when I am working on a puzzle. It first raises an InvalidBoardError if the board it is given is not a valid Sudoku board. Then, it recursively looks for remaining empty spots on the board, and then chooses the easiest spot to solve, which is the spot with the least possible values that can be validly inserted into the board. It tries to solve the new board with the guess added to the board. When it reaches no more empty spots + a valid board, the board is considered solved and the value is returned.

If, at any point, a board ends up with a space that has no valid values, then an exception is thrown. This exception is caught and the next guess is tried. If all guess are tried and there is still no valid and completed board, then the board is deemed unsolvable and the exception is propagated up.  

Runtime

If n is the Sudoku size (the traditional 9), and m is the number of empty spaces, the average runtime is O(m!n^3). This is because for every empty space, the board (n^2) is searched for the best place to make a guess, and then there is n choices are tried for the guess. For every guess, there are m-1 remaining spaces to try.

The best runtime is O(1). In this case, there is already a solved board, so it is quickly returned.

The worst runtime is O((n^2)!n^3). In this case, m is n^2, as the entire board is empty. That means that each space must be tried.

Thoughts and considerations

This solution was designed to be fairly simple to understand and readable. It could be optimized, but since the sudoku board is constrained on size, readability/maintainbility seemed more important than small optimizations in speed. One optimization, for example, would be to keep track of the spaces throughout and update the possible guesses for each one as guesses are made, instead of searching the entire grid for all the empty spaces again. This would require far more complex algorithm though, and would likely be harder to understand. 

Some assumptions were also made in order to save time. The sudoku board creation expects a nested array, and no validation is done to make sure that the input is correct. The board is also fixed to a 9x9 sudoku board, and would be a bit painful to update, since indices and offsets are based off of the board.

## That's all, folks!
