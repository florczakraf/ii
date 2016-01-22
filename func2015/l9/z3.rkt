#lang racket
(require racket/draw)

(define (mk-mobile left right) (cons left right))
(define (mk-branch length struct) (cons length struct))

;1.
(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (cdr mobile))
(define (branch-length branch) (car branch))
(define (branch-struct branch) (cdr branch))

;2.

(define (weight mobile)
  (define (branch-weight branch)
    (let ([struct (branch-struct branch)])
      (if (number? struct)
          struct
          (weight struct)
          )
      )
    )
  (if (number? mobile)
      mobile
      (+ (branch-weight (left-branch mobile))
         (branch-weight (right-branch mobile)))))


(define (balanced? mobile)
  (if (number? mobile) #t
      (letrec (
               (left (left-branch mobile))
               (right (right-branch mobile))
               (struct-left (branch-struct left))
               (struct-right (branch-struct right))
               )
        (and
         (balanced? struct-left)
         (balanced? struct-right)
         (=
          (* (branch-length left) (weight struct-left))
          (* (branch-length right) (weight struct-right))
          )
         )
        )
      )
  )

;3.

(define (left-length mobile)
  (if (number? mobile) 0
      (let ((left (left-branch mobile)))
        (+ (branch-length left)
           (left-length (branch-struct left))
           )
        )
      )
  )

(define (right-length mobile)
  (if (number? mobile) 0
      (let ((right (right-branch mobile)))
        (+ (branch-length right)
           (left-length (branch-struct right))
           )
        )
      )
  )

(define (depth mobile)
  (if (number? mobile) 1
      (+ 1
         (max (depth (branch-struct (left-branch mobile)))
              (depth (branch-struct (right-branch mobile)))
              )
         )
      )
  )

(define SPACE 50)
(define UNIT (/ SPACE 6))

(define (draw mobile)
  (define target (make-bitmap 640 480))
  (define dc (new bitmap-dc% [bitmap target]))
  (define (draw-weight x y weight)
    (send dc draw-rectangle (- x UNIT) y (* 2 UNIT) (* weight UNIT))
    )
  (define (draw-struct x y struct)
    (if (number? struct)
        (draw-weight x y struct)
        (letrec
            (
             (left (left-branch struct))
             (right (right-branch struct))
             (left-x (- x (* UNIT (branch-length left))))
             (new-y (+ y UNIT))
             (right-x (+ x (* UNIT (branch-length right))))
             )
          (send dc draw-line x y left-x y)
          (send dc draw-line left-x y left-x new-y)
          (send dc draw-line x y right-x y)
          (send dc draw-line right-x y right-x new-y)
          (draw-struct left-x new-y (branch-struct left))
          (draw-struct right-x new-y (branch-struct right))
          )))
  (draw-struct 320 10 mobile)
  (send dc draw-line 320 0 320 10)
  (send target save-file "mobile.png" 'png)
  )

;testy

(define test1 (mk-mobile (mk-branch 5 (mk-mobile (mk-branch 2 (mk-mobile (mk-branch 4 6) (mk-branch 1 1))) (mk-branch 2 1))) (mk-branch 4 10)))
(define bal (mk-mobile (mk-branch 1 1) (mk-branch 1 1)))
(define bal2 (mk-mobile (mk-branch 3 bal) (mk-branch 3 bal)))

(= (weight test1) 6)
(= (weight bal) 2)
(eq? (balanced? test1) #f)
(eq? (balanced? bal) #t)
(eq? (balanced? bal2) #t)

(draw test1)