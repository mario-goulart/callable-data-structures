(use callable-strings)

(test-begin "strings")

(define s (make-callable-string #\b #\a #\r))

(test #\b (s 0))
(test #\a (s 1))
(test #\r (s 2))

(set! (s 0) #\f)

(test #\f (s 0))

(test "far" (s))

;; type predicate
(test-assert (callable-string? s))
(test-assert (not (callable-string? (lambda () 'foo))))

(test-end "strings")
