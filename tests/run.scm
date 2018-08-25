(cond-expand
  (chicken-4
   (use test))
  (chicken-5
   (import test))
  (else
   (error "Unsupported CHICKEN version.")))

(test-begin "callable-data-structures")
(include "hash-tables")
(include "vectors")
(include "strings")
(include "lists")
(include "alists")
(test-end "callable-data-structures")

(test-exit)
