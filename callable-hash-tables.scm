(module callable-hash-tables (make-callable-hash-table callable-hash-table?)

(import scheme)
(cond-expand
  (chicken-4
   (import chicken)
   (use srfi-69 lolevel))
  (chicken-5
   (import (chicken base)
           (chicken memory representation))
   (import srfi-69))
  (else
   (error "Unsupported CHICKEN version.")))

(define +none+
  (list 'none))

(define (set-callable-hash-table! hash key value)
  (let ((items (procedure-data hash)))
    (hash-table-set! items key value)))

(define (make-callable-hash-table . args)
  (let* ((items (apply alist->hash-table (if (null? args)
                                             '(())
                                             args)))
         (getter
          (extend-procedure
           (lambda (#!optional (key +none+) default)
             (if (eq? key +none+)
                 items
                 (let ((val (hash-table-ref/default items key +none+)))
                   (if (eq? val +none+)
                       default
                       val))))
           items)))
    (getter-with-setter
     getter
     (lambda (key val)
       (set-callable-hash-table! getter key val))
     "callable-hash-table")))

(define (callable-hash-table? obj)
  (and (procedure? obj)
       (eq? (procedure-information obj) 'callable-hash-table)))

) ;; end module
