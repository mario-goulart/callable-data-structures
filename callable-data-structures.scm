(module callable-data-structures ()

(import chicken scheme)

(use callable-hash-tables
     callable-vectors
     callable-strings
     callable-lists
     callable-alists)

(reexport callable-hash-tables
          callable-vectors
          callable-strings
          callable-lists
          callable-alists)

) ;; end module
