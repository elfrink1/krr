def contradiction(sudoku_possible_values, k):            
        
        """
        Checks if the search ran into a contradiction.
        Inputs: 
            - sudoku_possible_values: all the possible values from the current step of the game.
            - k: the size of the grid.
        Output:
            - A boolean variable: True if we run into a contradiction and False otherwise.
        """
        
        # Contradiction type 1: some cell has no further possible values. If yes then you should return True.
        # Further contradictions. (What other contradictions should you consider here?)”

        # YOUR CODE HERE


        #TODO Type 1 contradiction: check that the value list for any cell is 0-length.
        

        #TODO Define efficient way to check all possible combinations of possible values
        # Maybe we should use numpy so the checks can also be efficient? it makes the extraction a lot easier.
        #TODO apply this restriction to row, column, knight range, bomb range

        def check_digits(l_in, k=3):
            # checks all digits are still possible list
            # if not, returns True
            return len(set(l_in)) != range(k**2 + 1)

        def get_bomb(spv, cell, k):
            bomb = {value for j in [1, 0, -1] if 0 < cell[1] + j < k**2 \
                for i in [1, 0, -1] if 0 < cell[0] + i < k**2 \
                    for value in spv[cell[0]+i][cell[1]+j]}
            return bomb

        def get_knight(spv, cell, k):
            knight1 = [value for j in [2, -2] if 0 < cell[1] + j < k**2 \
                for i in [1, -1] if 0 < cell[0] + i < k**2 \
                    for value in spv[cell[0]+i][cell[1]+j]]

            knight2 = [value for j in [1, -1] if 0 < cell[1] + j < k**2 \
                for i in [2, -2] if 0 < cell[0] + i < k**2 \
                    for value in spv[cell[0]+i][cell[1]+j]]

            knight = knight1 + knight2
            return knight


        def doubles(l_in, cell_value):
            conflict_values = {values[0] for values in l_in if len(values) == 1}
            if cell_value in conflict_values:
                return true
            return False

        spv = sudoku_possible_values        

        for i in range(k):
            row = [value for col in spv[i] for value in col]
            if check_digits(row):
                return True

            column = [value for j in range(k) for value in spv[j][i]]
            if check_digits(column):
                return True

            for j in range(k):

                cell = spv[j][i]
                if len(cell) == 0: #Type 1 contradiction
                    return True

                if len(cell == 1):
                    bomb = get_bomb(spv, (j, i), k)
                    if doubles(bomb, cell):
                        return True

                    knight = get_knight(spv, (j, i), k)
                    if doubles(knight, cell):
                        return True

                if i%3 == 1 and j % 3 == 1:
                    block = get_bomb(spv, (j, i), k).extend(spv[j][i])  
                    if check_digits(block):
                        return True

                


        # Otherwise: no contradiction is found
        return False