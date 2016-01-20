#lang racket

(define (deriv expr var)
  (simplify (derivative expr var)))

;helpers
(define (sum? expr)
  (and
   (pair? expr)
   (eqv? (car expr) '+)))

(define (prod? expr)
  (and
   (pair? expr)
   (eqv? (car expr) '*)))

;for basic derivation
(define (derivative expr var)
  (cond ((eq? expr var) 1)
        ((list? expr)
         (let
             ([left (cadr expr)]
              [right (caddr expr)])
           (if (sum? expr)
               (list '+
                     (derivative left var)
                     (derivative right var))
               (list '+
                     (list '*
                           (derivative left var)
                           right)
                     (list '*
                           left
                           (derivative right var))))))
        (else 0)))
          

;for simplifying

(define (simplify-sum expr)
  (let
      ([left (simplify (cadr expr))]
       [right (simplify (caddr expr))])
    (cond
      ((equal? 0 left) right)
      ((equal? 0 right) left)
      ((and (number? left) (number? right)) (+ left right))
      (else (list '+ left right)))))

(define (simplify-prod expr)
  (let
      ([left (simplify (cadr expr))]
       [right (simplify (caddr expr))])
    (cond
      ((or (equal? left 0) (equal? right 0)) 0)
      ((equal? left 1) right)
      ((equal? right 1) left)
      ((and (number? left) (number? right)) (* left right))
      (else (list '* left right)))))

(define (simplify expr)
  (cond
    ((sum? expr) (simplify-sum expr))
    ((prod? expr) (simplify-prod expr))
    (else expr)))


;testy
(deriv '(* x y) 'x)
(derivative '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)
(derivative '(* (* x y) (+ x 3)) 'x)

(deriv 'x 'x)
(deriv 'y 'x)
(deriv '(* (+ 3.4 5) (* x x)) 'x)