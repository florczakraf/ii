#lang racket

(define (atom? a) (not (pair? a)))

(define (count-atoms lst)
  (cond ((null? lst) 0)
        ((atom? lst) 1)
        (else
         (+ (count-atoms (car lst))
            (count-atoms (cdr lst))))))

(count-atoms (list 1 (cons (cons 2 3) 4) 5 6))