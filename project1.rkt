#lang racket

;;Mode detection from mode.rkt
(define prompt?
   (let [(args (current-command-line-arguments))]
     (cond
       [(= (vector-length args) 0) #t]
       [(string=? (vector-ref args 0) "-b") #f]
       [(string=? (vector-ref args 0) "--batch") #f]
       [else #t])))

;; Tokenizer
(define (whitespace? ch)
    (or (char-whitespace? ch) (char=? ch #\tab)))

(define (string->tokens s)
  (define len (string-length s))
  (define (loop i acc)
    (cond
      [(>= i len) (reverse acc)]
      [else
       (define ch (string-ref s i))
       (cond
         [(whitespace? ch) (loop (add1 i) acc)]
         [(char=? ch #\+) (loop (add1 i) (cons 'plus acc))]
         [(char=? ch #\*) (loop (add1 i) (cons 'mult acc))]
         [(char=? ch #\/) (loop (add1 i) (cons 'div acc))]
         [(char=? ch #\-) (loop (add1 i) (cons 'neg acc))]
         [(char=? ch #\$)
          (define-values (digits j)
            (let loop2 ((j (add1 i)) (acc ""))
              (if (and (< j len) (char-numeric? (string-ref s j)))
                  (loop2 (add1 j) (string-append acc (string (string-ref s j))))
                  (values acc j))))
          (if (string=? digits "")
              #f
              (loop j (cons (cons 'hist (string->number digits)) acc)))]
         [(char-numeric? ch)
          (define-values (num-str j)
            (let loopnum ((j i) (acc ""))
              (if (and (< j len)
                       (let ([cj (string-ref s j)])
                         (or (char-numeric? cj) (char=? cj #\.))))
                  (loopnum (add1 j) (string-append acc (string (string-ref s j))))
                  (values acc j))))
          (loop j (cons (cons 'num (string->number num-str)) acc))]
         [else #f])]))
  (loop 0 '()))  

