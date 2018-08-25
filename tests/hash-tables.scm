(cond-expand
  (chicken-4
   (use callable-hash-tables srfi-69))
  (chicken-5
   (import (chicken sort))
   (import callable-hash-tables srfi-69))
  (else
   (error "Unsupported CHICKEN version.")))

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

;; type predicate
(test-assert (callable-hash-table? h))
(test-assert (not (callable-hash-table? (lambda () 'foo))))

;; empty initial object
(define c (make-callable-hash-table))
(test-assert (null? (hash-table->alist (c))))
(set! (c 'foo) 42)
(test 42 (c 'foo))


(test-end "hash-tables")
