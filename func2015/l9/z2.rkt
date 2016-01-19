#lang racket

(define (atom? a) (not (pair? a)))

(define (count-atoms lst)
  (cond ((null? lst) 0)
        (else
         (let
             ((result (count-atoms (cdr lst))))
           (if (atom? (car lst))
               (+ 1 result)
               result)))))

(count-atoms '(1 (cons (cons 2 3) 4) "aaa" 9))