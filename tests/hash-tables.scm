(use callable-hash-tables)

(test-begin "hash-tables")

(define h (make-callable-hash-table '((foo . 1) (bar . 2))))

(test 1 (h 'foo))
(test 2 (h 'bar))

(set! (h 'foo) 42)

(test 42 (h 'foo))

(define n (make-callable-hash-table '((1 . foo) (2 . bar)) test: =))

(test 'foo (n 1))
(test 'bar (n 2))

(test '(1 2) (sort (map car (hash-table->alist (n))) <))

(test-end "hash-tables")
