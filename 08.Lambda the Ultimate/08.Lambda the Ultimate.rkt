#|8.Lambda the Ultimate|#



#| The Ten Commandments: |#


#|
##########################################################################
#                                                                        #
#                          The First Commandment                         #
#                                                                        #
#                            (final version)                             #
#          When recurring on a list of atoms, lat, ask two questions     #
#          about it: (null? lat) and else.                               #
#          When recurring on a number, n, ask two questions about        #
#          it: (zero? n) and else.                                       #
#          When recurring on a list of S-expressions, l, ask three       #
#          questions about it: (null? n), (atom? (car l)) and else.      #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                          The Second Commandment                        #
#                                                                        #
#                         Use cons to build lists.                       #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                          The Third Commandment                         #
#                                                                        #
#        When building a list, describe the first typical element,       #
#        and then cons it onto the natural recursion.                    #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                          The Fourth Commandment                        #
#                                                                        #
#                             (final version)                            #
#        Always change at least one argument while recurring.            #
#        When recurring on a list of atoms, lat, use (cdr lat). When     #
#        recurring on a number, n, use (sub1 n). And when recurring      #
#        on a list of S-expressions, l, use (car l) and (cdr l) if       #
#        neither (null? l) nor (atom? (car l)) are true.                 #
#                                                                        #
#        It must be changed to be closer to termination. The changing    #
#        argument must be tested in the termination condition:           #
#                                                                        #
#        When using cdr, test termination with null? and                 #
#        when using sub1, test termination with zero?.                   #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                          The Fifth Commandment                         #
#                                                                        #
#        When building a value with o+, always use 0 for the value       #
#        of the terminating line, for adding 0 does not change the       #
#        value of an addition.                                           #
#                                                                        #
#        When building a value with *, always use 1 for the value        #
#        of the terminating line, for multiplying by 1 does not          #
#        change the value of a multiplication.                           #
#                                                                        #
#        When building a value with cons, always consider () for         #
#        the value of the terminating line.                              #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                           The Sixth Commandment                        #
#                                                                        #
#               Simplify only after the function is correct.             #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                          The Seventh Commandment                       #
#                                                                        #
#        Recur on the subparts that are of the same nature:              #
#        on the sublists of a list.                                      #
#        on the subexpressions of an arithmetic expression.              #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                         The Eighth Commandment                         #
#                                                                        #
#            Use help functions to abstract from representation.         #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                         The Ninth Commandment                          #
#                                                                        #
#              Abstract common patterns with a new function.             #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                         The Tenth Commandment                          #
#                                                                        #
#        Build functions to collect more than one value at a time.       #
#                                                                        #
##########################################################################
|#



#lang racket


#|The line below defines atom?|#
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

#|
To find out whether your Scheme has the correct
definition of atom?, try (atom? (quote()))
and make sure it returns #f
|#
(atom? (quote()))
(newline)


#|
rember-f is a function that takes 3 arguments: test?, a, and l.
rember-f uses test? to check if (car l) is equal to a and then
rember-f removes the first occurence of a from l.

rember-f can behave like:  rember with =
                           rember with equal?
                           rember with eq?

rember-f can be written as:

(define rember-f
  (lambda (test? a l)
    (cond
      ((null? l) (quote()))
      (else
       (cond
         ((test? (car l) a) (cdr l))
       (else (cons (car l) (rember-f test? a (cdr l)))))))))

don't forget The Sixth Commandment:
|#

(define rember-f
  (lambda (test? a l)
    (cond
      ((null? l) (quote()))
      ((test? (car l) a) (cdr l))
      (else
       (cons (car l) (rember-f test? a (cdr l)))))))

;Below are some examples of applying rember-f
;try solving them by writing down the definition of the function rember-f
;and referring to the definition of the function rember-f

(rember-f eq? 'a '(b c a))

(rember-f equal? 'c '(b c a))

(rember-f = '5 '(6 2 5 3))

(rember-f eq? 'jelly '(jelly beans are good))

(rember-f equal? '(pop corn) '(lemonade (pop corn) and (cake)))
(newline)


#|
Functions can return lists and atoms.
Functions can also return functions.

(lambda (a l) . . . ) is a function of two arguments: a and l.

(lambda (a)           is a function that takes an argument a
  (lambda (x)         and returns the function 
    (eq? x a)))         (lambda (x)
                          (eq? x a))

This is called "Curry-ing" and not "Schonfinkel-ing".

The complete function is defined below:
|#

(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? x a))))

(eq?-c 'salad) ;returns a function that takes x as an argument and compares whether or not it is eq? to salad.

(define eq?-salad (eq?-c 'salad)) ;we just gave the returned function a name.

(eq?-salad 'salad)  ;we dont really need to give the function a name, alternatively we could have just done:
                    ;((eq?-c 'salad) 'salad)

;rewrite rember-f as a function of one argument test?:
(define rember-f1
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) (quote()))
        ((test? (car l) a) (cdr l))
        (else
         (cons (car l) ((rember-f1 test?) a (cdr l))))))))

(define rember-eq? (rember-f1 eq?))

(rember-eq? 'tuna '(tuna salad is good))

(rember-eq? 'tuna '(shrimp salad and tuna salad))

(rember-eq? 'eq? '(equal? eq? eqan? eqlist? eqpair?))

(rember-eq? 'a '(b c a))

(rember-eq? 'c '(b c a))

(rember-eq? '5 '(6 2 5 3))

(rember-eq? 'jelly '(jelly beans are good))

(rember-eq? '(pop corn) '(lemonade (pop corn) and (cake)))
(newline)

;rewrite and test insertL-f as a function of one argument test?:

(define insertL-f
  (lambda (test?)
    (lambda (new old lat)
      (cond
        ((null? lat) (quote()))
        ((test? (car lat) old)
         (cons new (cons old (cdr lat))))
        (else (cons (car lat) ((insertL-f test?) new old (cdr lat))))))))


((insertL-f eq?) 'topping 'fudge '(ice cream with fudge for dessert))

((insertL-f eq?)'jalapeno 'and '(tacos tamales and salsa))

((insertL-f eq?) 'e 'd '(a b c d f g d h))
(newline)

;rewrite and test insertR-f as a function of one argument test?:

(define insertR-f
  (lambda (test?)
    (lambda (new old lat)
      (cond
        ((null? lat) (quote()))
        ((test? (car lat) old)
         (cons old (cons new (cdr lat))))
        (else (cons (car lat) ((insertR-f test?) new old (cdr lat))))))))


((insertR-f eq?) 'topping 'fudge '(ice cream with fudge for dessert))

((insertR-f eq?)'jalapeno 'and '(tacos tamales and salsa))

((insertR-f eq?) 'e 'd '(a b c d f g d h))
(newline)

#|
seqL is a function that takes 3 arguments and conses the first argument
onto the result of consing the second argument onto the third argument.
|#

(define seq-L
  (lambda (new old l)
    (cons new (cons old l))))

#|
seqR is a function that takes 3 arguments and conses the second argument
onto the result of consing the first argument onto the third argument.
|#

(define seq-R
  (lambda (new old l)
    (cons old (cons new l))))

;rewrite and test insert-g as a function of one argument seq:

(define insert-g
  (lambda (seq)
    (lambda (new old l)
      (cond
        ((null? l) (quote()))
        ((eq? (car l) old)
         (seq new old (cdr l)))
        (else (cons (car l) ((insert-g seq) new old (cdr l))))))))

(define insert-L (insert-g seq-L))

(insert-L 'topping 'fudge '(ice cream with fudge for dessert))

(insert-L'jalapeno 'and '(tacos tamales and salsa))

(insert-L 'e 'd '(a b c d f g d h))
(newline)

((insert-g seq-R) 'topping 'fudge '(ice cream with fudge for dessert))

((insert-g seq-R)'jalapeno 'and '(tacos tamales and salsa))

((insert-g seq-R) 'e 'd '(a b c d f g d h))
(newline)

;this is considered better than the above method because you do not need to remember as many names
(define insert-L1
  (insert-g
   (lambda(new old l)
     (cons new (cons old l)))))

(insert-L1 'topping 'fudge '(ice cream with fudge for dessert))

(insert-L1'jalapeno 'and '(tacos tamales and salsa))

(insert-L1 'e 'd '(a b c d f g d h))
(newline)

#|
seqS is a function that takes 3 arguments and replaces the second
argument by consing the first argument onto the third argument.
|#

(define seqS
  (lambda (new old l)
    (cons new l)))


#|
##########################################################################
#                                                                        #
#                         The Ninth Commandment                          #
#                                                                        #
#              Abstract common patterns with a new function.             #
#                                                                        #
##########################################################################
|#


#|atom-to-function is a function that takes one argument x,
and returns the function +, or  * or expt, depending
on its input. atom-to-function will be used to
rewrite value.
|#

(define atom-to-function
  (lambda (x)
    (cond
      ((eq? x '+) +)
      ((eq? x 'x) *)
      (else expt))))

(atom-to-function '+) ;returns the function +
(newline)

;1st-sub-exp returns the 1st sub expression.

(define 1st-sub-exp
  (lambda (aexp)
    (car (cdr aexp))))

;2nd-sub-exp returns the 2nd sub expression.

(define 2nd-sub-exp
  (lambda (aexp)
    (car (cdr (cdr aexp)))))

;operator replaces (car aexp)

(define operator
  (lambda (aexp)
    (car aexp)))

(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (operator nexp) '+)
       (+ (value (1st-sub-exp nexp))
          (value (2nd-sub-exp nexp))))
      ((eq? (operator nexp) 'x)
       (* (value (1st-sub-exp nexp))
          (value (2nd-sub-exp nexp))))
      (else
       (expt (value (1st-sub-exp nexp))
          (value (2nd-sub-exp nexp)))))))

(value '(+ 5 3))

(define value1
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      (else
       ((atom-to-function
         (operator nexp))
        (value1 (1st-sub-exp nexp))
        (value1 (2nd-sub-exp nexp)))))))

(value1 '(+ 5 3))
(newline)


#|
##########################################################################
#                                                                        #
#       Time for an apple?       One a day keeps the doctor away.        #
#                                                                        #
##########################################################################
|#


#|
multirember is a function that removes multiple occurences of the same
word from a lat. 

multirember-f takes one argument and returns a function that works in
the same way as multirember does.

both functions are defined below:
|#

(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote()))
      ((eq? (car lat) a)
       (multirember a (cdr lat)))
      (else (cons (car lat) (multirember a (cdr lat)))))))

(multirember 'tuna '(shrimp salad tuna salad and tuna))

(define multirember-f
  (lambda (test?)
    (lambda (a lat)
      (cond
        ((null? lat) (quote()))
        ((test? (car lat) a)
         ((multirember-f test?) a (cdr lat)))
        (else (cons (car lat) ((multirember-f test?) a (cdr lat))))))))

(define multirember-eq? (multirember-f eq?))

(multirember-eq? 'tuna '(shrimp salad tuna salad and tuna))
(newline)

;we can combine test? and a by creating a function of one argument
;that could compare that argument with a
;in the function below, a is tuna

(define eq?-tuna
  (eq?-c 'tuna))

;multiremberT is similar to multirember-f but instead of taking test?
;and returning a function, it takes a function and a lat.

(define multiremberT
  (lambda (test? lat)
    (cond
      ((null? lat) (quote()))
      ((test? (car lat))
       (multiremberT test? (cdr lat)))
      (else (cons (car lat) (multiremberT test? (cdr lat)))))))

(multiremberT eq?-tuna '(shrimp salad tuna salad and tuna))
(newline)


#|
multirember&co is a function that looks at every atom of the lat to see whether it is eq? to a.
Those atoms that are not are collected in one list ls1, the others for which the answer is true
are collected in a second list ls2. Finally, it determines the value of (f ls1 ls2).

col, short for "collector", and is sometimes called a continuation.
|#

(define multirember&co
  (lambda (a lat col)
    (cond
      ((null? lat)
       (col (quote()) (quote())))
      ((eq? (car lat) a)
       (multirember&co a
                       (cdr lat)
                       (lambda (newlat seen)
                         (col newlat
                              (cons (car lat) seen)))))
      (else
       (multirember&co a
                       (cdr lat)
                       (lambda (newlat seen)
                         (col (cons (car lat) newlat)
                              seen)))))))

;a-friend is a function that takes two arguments and checks
;whether or not the second argument is the empty list.

(define a-friend
  (lambda (x y)
    (null? y)))

(multirember&co 'tuna '(strawberries tuna and swordfish) a-friend)

(multirember&co 'tuna '(and tuna) a-friend)

(multirember&co 'tuna '(tuna) a-friend)

(multirember&co 'tuna '() a-friend)

#|new-friend

(define new-friend
  (lambda (newlat seen)
    (col newlat
         (cons (car lat) seen))))
|#

#|latest-friend

(define latest-friend
  (lambda (newlat seen)
    (a-friend (cons 'and newlat) seen)))
|#

;last-friend is a function that takes 2 arguments, and returns the length of the first one.
(define last-friend
  (lambda (x y)
    (length x)))

(multirember&co 'tuna '(strawberries tuna and swordfish) last-friend)
(newline)


#|
##########################################################################
#                                                                        #
#       Yes!                     It's a strange meal, but we have seen   #
#                                foreign foods before.                   #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                         The Tenth Commandment                          #
#                                                                        #
#        Build functions to collect more than one value at a time.       #
#                                                                        #
##########################################################################
|#


;recall multiinsertL

(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      ((eq? (car lat) old)
       (cons new
             (cons old
                   (multiinsertL new old (cdr lat)))))
      (else (cons (car lat) (multiinsertL new old (cdr lat)))))))

;recall multiinsertR

(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      ((eq? (car lat) old)
       (cons old
             (cons new
                   (multiinsertR new old (cdr lat)))))
      (else (cons (car lat) (multiinsertR new old (cdr lat)))))))

;multiinsertLR is a function that inserts new to the left of oldL
;and to the right of oldR in lat if oldL and oldR are different.

(define multiinsertLR
  (lambda (new oldL oldR lat)
    (cond
      ((null? lat) (quote()))
      ((eq? (car lat) oldL)
       (cons new
             (cons oldL
                   (multiinsertLR new oldL oldR (cdr lat)))))
      ((eq? (car lat) oldR)
       (cons oldR
             (cons new
                   (multiinsertLR new oldL oldR (cdr lat)))))
      (else (cons (car lat) (multiinsertLR new oldL oldR (cdr lat)))))))

;multiinsertLR&co is to multiinsertLR what multirember&co is to multirember.
;It takes one more argument than multiinsertLR and that argument is the
;collector function.

(define multiinsertLR&co
  (lambda (new oldL oldR lat col)
    (cond
      ((null? lat)
       (col (quote()) 0 0))
      ((eq? (car lat) oldL)
       (multiinsertLR&co new oldL oldR
                         (cdr lat)
                         (lambda (newlat L R)
                           (col (cons new
                                      (cons oldL newlat))
                                (add1 L) R))))
      ((eq? (car lat) oldR)
       (multiinsertLR&co new oldL oldR
                         (cdr lat)
                         (lambda (newlat L R)
                           (col (cons oldR (cons new newlat))
                                L (add1 R)))))
    (else
     (multiinsertLR&co new oldL oldR
                       (cdr lat)
                       (lambda (newlat L R)
                         (col (cons (car lat) newlat)
                              L R )))))))
(define col
  (lambda (lat L R)
    lat))

(multiinsertLR&co 'salty 'fish 'chips '(chips and fish or fish and chips) col)
(newline)

#|
##########################################################################
#                                                                        #
#         Is this healthy?       Looks like lots of salt. Perhaps        #
#                                dessert is sweeter.                     #
#                                                                        #
##########################################################################
|#


#|
*-functions are functions that work on lists
that are either:
- empty,
- an atom consed onto a list, or
- a list consed onto a list.
|#


;even returns true if a number is even and false otherwise.
;(define even?
;  (lambda (n)
;    (= (* (/ n 2) 2) n)))

;evens-only* removes all odd numbers from a list of nested lists.
(define evens-only*
  (lambda (l)
    (cond
      ((null? l) (quote()))
      ((atom? (car l))
       (cond
         ((even? (car l))
          (cons (car l) (evens-only* (cdr l))))
         (else (evens-only* (cdr l)))))
      (else (cons (evens-only* (car l))
                  (evens-only* (cdr l)))))))

(evens-only* '((9 1 2 8) 3 10 ((9 9) 7 6) 2))

;evens-only*&co visits every number in the car of l and collects the list without odd numbers,
;the product of the even numbers,and the sum of the odd numbers.

(define evens-only*&co
  (lambda (l col)
    (cond
      ((null? l) (col (quote()) 1 0))
      ((atom? (car l))
       (cond
         ((even? (car l))
          (evens-only*&co (cdr l)
                          (lambda (newl p s)
                            (col (cons (car l) newl)
                                 (* (car l) p) s))))
         (else (evens-only*&co (cdr l)
                               (lambda (newl p s)
                                 (col newl
                                      p (+ (car l) s)))))))
      (else
       (evens-only*&co (car l)
                        (lambda (al ap as)
                          (evens-only*&co (cdr l)
                                          (lambda (dl dp ds)
                                            (col (cons al dl)
                                                 (* ap dp)
                                                 (+ as ds))))))))))

(define the-last-friend
  (lambda (newl product sum)
    (cons sum
          (cons product
                newl))))

(evens-only*&co '((9 1 2 8) 3 10 ((9 9) 7 6) 2) the-last-friend)


#|
##########################################################################
#                                                                        #
#  Whew! Is your brain           Go eat a pretzel; don't                 #
#  twisted up now ?              forget the mustard.                     #
#                                                                        #
##########################################################################
|#



#| The Five Rules: |#


#|
##########################################################################
#                                                                        #
#                            The Law of Car                              #
#         The primitive car is defined only for non-empty lists.         #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                            The Law of Cdr                              #
#         The primitive cdr is defined only for non-empty lists.         #
#          The cdr of a non-empty list is always another list.           #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                            The Law of Cons                             #
#                 The primitive cons takes two arguments.                #
#   The second argument to cons must be a list. The result is a list.    #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                             The Law of Null?                           #
#         The primitive null? is defined only for for lists.             #
#                                                                        #
##########################################################################
|#


#|
##########################################################################
#                                                                        #
#                              The Law of Eq?                            #
#                 The primitive eq? takes two arguments.                 #
#                    Each must be a non-numeric atom.                    #
#                                                                        #
##########################################################################
|#