"""Implement an algorithm that generates 9-by-9 BombKnightSudoku inputs (i.e., k=3) that: 
1. have exactly 10 cells filled with a number between 1 and 9, 
2. and have a unique solution. 
That is, your algorithm should output a generator that iterates over BombKnightSudoku inputs with the required properties.

Your algorithm should use the approach of translating this problem to an answer set program P, 
calling an ASP solver (i.e., clingo) to find answer sets for P, 
and translating these answer sets to BombKnightSudoku inputs with the required properties.

(To be clear: you may not 'hardcode' a list of BombKnightSudoku inputs in the answer set program P.)
There are two variants of this assignment: a harder variant (d.I) and an easier variant (d.II). 
You may choose which variant you would like to solve. 
If you opt for the harder variant (d.I), you can get a maximum of 3 points for this assignment. 
If you opt for the easier variant (d.II), you can get a maximum of 2 points for this assignment. 

### (d.I) Harder variant (2pts):

To solve the harder variant, your answer set program *P* should be such that for **each** BombKnightSudoku input *I* 
with the required properties, there is an answer set of *P* that corresponds to *I*. 
For this, you should express in *P* the constraints 
1. (that exactly 10 cells are filled) and 
2. (that the input has a unique solution).
*Hint:* Use the technique of saturation to express constraint 2.

### (d.II) Easier variant (1pt):

To solve the easier variant, your answer set program *P* only needs to be such that for **a subset of** 
BombKnightSudoku inputs *I* with the required properties, there is an answer set of *P* that corresponds to *I*. 
For this, you could express in *P*, in addition to the constraint 
1. (that exactly 10 cells are filled), 
some other property that entails constraint 
2. (that the input has a unique solution).
""""
