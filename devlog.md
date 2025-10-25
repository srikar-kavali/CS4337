Development Log

October, 22 2025 5:42 pm - Inital thoughts and setup

The project requires a prefix-notation calculator implemented in Haskell. The program must:
- Evaluate prefix expressions (operators: `+`, `*`, `/` (integer division), unary `-`).
- Support history references `$n` (1-based).
- Operate in interactive or batch mode (`-b` / `--batch`).
- Print results prefixed by history id: `1: 3.0`, etc.
- Print errors as `Error: Invalid Expression`.
- Treat extra tokens left after a parsed expression as an error.

Plan
1. Create repo and add this devlog.md.
2. Implement tokenization: convert input String → [Token].
3. Implement a recursive evalExpr :: [Token] -> History -> Either Error (Value, [Token]).
   - Returns Left on error, or Right (value, remainingTokens).
4. Implement REPL loop which:
   - Reads a line.
   - If quit → exit.
   - Else tokenizes & calls evalExpr.
   - On success: prepend result to history, print id: value.
   - On error: print Error: Invalid Expression.
   - For batch mode, suppress prompts.
5. Write unit tests for:
   - Tokenizer
   - evalExpr on numbers, unary, binary, $n
   - Error cases (division by zero, leftover tokens, bad $n)
6. Finish README and submit zipped repository.

October, 23 2025 6:36 pm - Changing from Haskell to Racket and adding mode.rkt to project
- Found out project is supposed to be in racket so have to pivot plan. 
- Added mode.rkt code to my prokect1.rkt file

October 23, 2025 11:39 pm - Implementing tokenizer
- I started working on the tokenizer, which is part of the calculator that breaks the input string into tokens that the evaluator can then process. Implementing the tokenization aspect of the project was tricky, since the expressions can be directly after one another with no spaces, so I had to figure out a workaround for that
- I did this by scanning the string character by character and then builts the tokens manually.
- I did run into some problems when trying to implement this. My first attempt, I ran into problem with the history references, Since I needed to grab all the digits after reading the '$' as one token. I first tried a nested loop which used an index to manually move through string, but it would get lost after the history reference. Another issue was when handling decimals. Because of this I had to use a smaller helper look whih append digits or single dots until I would hit a non-digit character. I also confused (cons 'num n) and (cons 'num n) which was super frustrating and confusing. 

October 24, 2025 6:41 pm - Implementing Evaluator
- Started working on evaluator, which is supposed to process a list of tokens and compute the result, while returning a pair '(list result remainig-tokens). I also have to do this recursively whihc was a bit more challenging to execute. For example, handling the errors like missing operands, dividing by 0, or invalid history references were all things I had to handle. 
- Approach was
If its a number, return (list number remaining-tokens)
If its $n, fetch history
If its and opertor like +, recursively evaluate the next two expressions
If its a unary -, evaulate one expression and negate it

- Struggles
First issues were with returning the values. I had to use a list, but I kept forgetting to check if the result of the recursive call was #f (error) before ebery checking. I fixed this by having conditional checks.
Another problem was integer division. Fixed this by truncating the operands before computing and then converting back to inexact. 
Lastly for the history lookups, I first was indexing the history list directly, but it reversed the ordering since the newer results are at the front. I fixed this by reversing first then looking up the history. 

- This was the most challenging part so far, because I had to make sure to use recursion which was more challenging and confusing at times. 
