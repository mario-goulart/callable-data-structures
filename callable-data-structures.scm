(module callable-data-structures ()

(import scheme)
(cond-expand
  (chicken-4
   (import chicken)
   (use callable-hash-tables
        callable-vectors
        callable-strings
        callable-lists
        callable-alists))
  (chicken-5
   (import (chicken module))
   (import callable-hash-tables
           callable-vectors
           callable-strings
           callable-lists
           callable-alists))
  (else
   (error "Unsupported CHICKEN version.")))

(reexport callable-hash-tables
          callable-vectors
          callable-strings
          callable-lists
          callable-alists)

) ;; end module
