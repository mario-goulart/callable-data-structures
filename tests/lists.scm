(use callable-lists)

(test-begin "lists")

(define l (make-callable-list 'a 'b 'c))

(test 'a (l 0))
(test 'b (l 1))
(test 'c (l 2))

(set! (l 1) 'z)

(test 'z (l 1))

(test '(a z c) (l))

;; type predicate
(test-assert (callable-list? l))
(test-assert (not (callable-list? (lambda () 'foo))))

(test-end "lists")
