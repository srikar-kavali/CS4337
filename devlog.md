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

October, 23 2025 6:36 pm - Chanigng from Haskell to Racket and adding mode.rkt to project
- Found out project is supposed to be in racket so have to pivot plan. 
- Added mode.rkt code to my prokect1.rkt file



