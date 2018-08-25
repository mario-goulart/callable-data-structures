(cond-expand
  (chicken-4
   (use callable-vectors))
  (chicken-5
   (import callable-vectors))
  (else
   (error "Unsupported CHICKEN version.")))

(test-begin "vectors")

(define v (make-callable-vector 'a 'b 'c))

(test 'a (v 0))
(test 'b (v 1))
(test 'c (v 2))

(set! (v 1) 'z)

(test 'z (v 1))

(test '#(a z c) (v))

;; type predicate
(test-assert (callable-vector? v))
(test-assert (not (callable-vector? (lambda () 'foo))))

(test-end "vectors")
