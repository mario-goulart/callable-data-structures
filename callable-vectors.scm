(module callable-vectors (make-callable-vector)

(import chicken scheme)
(use lolevel)

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
       (set-callable-vector! getter pos val)))))

) ;; end module
