Project 1 - Prefix Calculator
Course: CS4337
Language: Racket

This project implements a prefix-notation calculator that supports addition, multiplication, division, and negation. It runs in both interactive and batch modes and maintains a history of previous results that can be referenced using $n syntax

The program follows a functional desgin using recursion and immutable data. Functions/Parts include a tokenizer, evaluator, and a REPL loop. 

Files
- project1.rkt
- devlog.md
- README.md

How to Run
Start the calculator in interactive mode by typing in terminal 
racket prokject1.rkt
You should then see a '>' which indicates you are in interactive mode of the project
For batch mode type in terminal
racket project1.rkt -b < input.txt
