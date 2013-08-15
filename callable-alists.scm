(module callable-alists (make-callable-alist)

(import chicken scheme)
(use lolevel data-structures)

(define +none+
  (list 'none))

(define (set-callable-alist! alist key value)
  (let ((items (procedure-data alist)))
    (set! items (alist-update! key value items))))

(define (make-callable-alist alist)
  (let ((getter
         (extend-procedure
          (lambda (#!optional (key +none+) test default)
            (if (eq? key +none+)
                alist
                (let ((val (alist-ref key alist (or test eqv?) +none+)))
                  (if (eq? val +none+)
                      default
                      val))))
          alist)))
    (getter-with-setter
     getter
     (lambda (key val)
       (set-callable-alist! getter key val)))))

) ;; end module
