# Dynamic-branch-predictor-in-pipelined-processors


This is a (2,2) branch predictor for pipelined processors./
We have used a 4 state FSM and last two outcomes to entry into the Branch History Table./
Go through the simulation pdf to get a better understanding.
Given above is the verilog code and the test bench. Depending on the input mode different things are done on the ZedBoard:
00 - Reset
01 - Branch transitions in the BHT 
10 - Display the FSM status of the BHT entries
11 - prediction mode
