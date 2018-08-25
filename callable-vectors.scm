(module callable-vectors (make-callable-vector callable-vector?)

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

(define (set-callable-vector! v pos value)
  (let ((items (procedure-data v)))
    (vector-set! items pos value)))

(define (make-callable-vector . items)
  (let* ((items (list->vector items))
         (getter
          (extend-procedure
           (lambda (#!optional (pos +none+))
             (if (eq? pos +none+)
                 items
                 (vector-ref items pos)))
           items)))
    (getter-with-setter
     getter
     (lambda (pos val)
       (set-callable-vector! getter pos val))
     "callable-vector")))

(define (callable-vector? obj)
  (and (procedure? obj)
       (eq? (procedure-information obj) 'callable-vector)))

) ;; end module
