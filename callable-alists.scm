(module callable-alists (make-callable-alist callable-alist?)

(import scheme)
(cond-expand
  (chicken-4
   (import chicken)
   (use data-structures lolevel))
  (chicken-5
   (import (chicken base)
           (chicken memory representation)))
  (else
   (error "Unsupported CHICKEN version.")))

(define +none+
  (list 'none))

(define (set-callable-alist! callable-alist key value)
  (let ((items (procedure-data callable-alist)))
    (set-car! items (alist-update! key value (car items)))))

(define (make-callable-alist #!optional (alist '()) #!key (test eqv?))
  (let* ((alist (list (if (null? alist)
                          '()
                          alist)))
         (getter
          (extend-procedure
           (lambda (#!optional (key +none+) default)
             (if (eq? key +none+)
                 (car alist)
                 (let ((val (alist-ref key (car alist) test +none+)))
                   (if (eq? val +none+)
                       default
                       val))))
           alist)))
    (getter-with-setter
     getter
     (lambda (key val)
       (set-callable-alist! getter key val))
     "callable-alist")))

(define (callable-alist? obj)
  (and (procedure? obj)
       (eq? (procedure-information obj) 'callable-alist)))

) ;; end module
