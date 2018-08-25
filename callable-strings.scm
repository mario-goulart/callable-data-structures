(module callable-strings (make-callable-string callable-string?)

(import scheme)
(cond-expand
  (chicken-4
   (import chicken)
   (use lolevel))
  (chicken-5
   (import (chicken base)
           (chicken memory representation)))
  (else
   (error "Unsupported CHICKEN version.")))

(define +none+
  (list 'none))

(define (set-callable-string! v pos value)
  (let ((chars (procedure-data v)))
    (string-set! chars pos value)))

(define (make-callable-string . chars)
  (let* ((items (list->string chars))
         (getter
          (extend-procedure
           (lambda (#!optional (pos +none+))
             (if (eq? pos +none+)
                 items
                 (string-ref items pos)))
           items)))
    (getter-with-setter
     getter
     (lambda (pos val)
       (set-callable-string! getter pos val))
     "callable-string")))

(define (callable-string? obj)
  (and (procedure? obj)
       (eq? (procedure-information obj) 'callable-string)))

) ;; end module
