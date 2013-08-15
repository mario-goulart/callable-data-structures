(module callable-strings (make-callable-string)

(import chicken scheme)
(use lolevel)

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
       (set-callable-string! getter pos val)))))

) ;; end module
