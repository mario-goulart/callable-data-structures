(use callable-alists)

(test-begin "alists")

(define a (make-callable-alist '((foo . 1) (bar . 2))))
(define b (make-callable-alist '((baz . 3) (quux . 4))))

(test 1 (a 'foo))
(test 2 (a 'bar))

(set! (a 'foo) 42)

(test 42 (a 'foo))

(test '(2 42) (sort (map cdr (a)) <))

(test '((baz . 3) (quux . 4)) (b))

;; add a new item
(set! (a 'baz) 43)
(test 43 (a 'baz))

;; type predicate
(test-assert (callable-alist? a))
(test-assert (not (callable-alist? (lambda () 'foo))))

(test-end "alists")
