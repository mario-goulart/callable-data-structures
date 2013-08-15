(module callable-data-structures ()

(import chicken scheme)

(use callable-hash-tables
     callable-vectors
     callable-strings
     callable-lists)

(reexport callable-hash-tables
          callable-vectors
          callable-strings
          callable-lists)

) ;; end module
