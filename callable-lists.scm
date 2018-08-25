(module callable-lists (make-callable-list callable-list?)

(import scheme)
(cond-expand
  (chicken-4
   (import chicken)
   (use lolevel))
  (chicken-5
   (import (chicken base)
           (chicken fixnum)
           (chicken memory representation)))
  (else
   (error "Unsupported CHICKEN version.")))

(define +none+
  (list 'none))

(define (list-set! l pos val)
  (if (fx= pos 0)
      (set-car! l val)
      (list-set! (cdr l) (- pos 1) val)))

(define (set-callable-list! l pos value)
  (let* ((items (procedure-data l))
         (len (length items)))
    (when (> pos len)
      (error 'set-callable-list! "Out of range" pos))
    (list-set! items pos value)))

(define (make-callable-list . items)
  (let ((getter
         (extend-procedure
          (lambda (#!optional (pos +none+))
            (if (eq? pos +none+)
                items
                (list-ref items pos)))
          items)))
    (getter-with-setter
     getter
     (lambda (pos val)
       (set-callable-list! getter pos val))
     "callable-list")))

(define (callable-list? obj)
  (and (procedure? obj)
       (eq? (procedure-information obj) 'callable-list)))

) ;; end module
