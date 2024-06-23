#|6.Shadows|#



#| The First Eight Commandments: |#


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
For the purpose of this chapter, an arithmetic expression is either
an atom(including numbers), or two arithmetic expressions
combined by +, *, or ^.
|#


#|
numbered? is a function that determines whether a representation of an arithmetic
expression contains only numbers besides the +, *, and ^.

it can be defined as:

(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      ((eq? (car (cdr aexp)) '+)
       (and (numbered? (car aexp))
            (numbered?
             (car (cdr (cdr aexp))))))
      ((eq? (car (cdr aexp)) '*)
       (and (numbered? (car aexp))
            (numbered?
             (car (cdr (cdr aexp))))))
       ((eq? (car (cdr aexp)) '^)
        (and (numbered? (car aexp))
            (numbered?
             (car (cdr (cdr aexp)))))))))

since aexp was already understood
to be an arithmetic expression,
it can be simplified as:
|#

(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      (else
       (and (numbered? (car aexp))
            (numbered?
             (car (cdr (cdr aexp)))))))))

;Below are some examples of applying numbered?
;try solving them by writing down the definition of the function numbered?
;and referring to the definition of the function numbered?

(numbered? '1)

(numbered? '3)

(numbered? '(1 + 3))

(numbered? '(1 + 3 * 4))

(numbered? 'cookie)

(numbered? '(3 ^ y + 5))

(numbered? '(n + 3))

(numbered? '(1 + 5 * 3))
(newline)


#|
(value nexp) returns what we think is the natural
value of a numbered arithmetic expression

value can be written as:
|#

(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (car (cdr nexp)) '+)
       (+ ( value (car nexp))
           (value (car (cdr (cdr nexp))))))
      ((eq? (car (cdr nexp)) 'x)
       (* ( value (car nexp))
           (value (car (cdr (cdr nexp))))))
      ((eq? (car (cdr nexp)) '^)
       (expt ( value (car nexp))
           (value (car (cdr (cdr nexp)))))))))

;Below are some examples of applying value
;try solving them by writing down the definition of the function value
;and referring to the definition of the function value

(define u 13)
(value u)

(define x '(1 + 3))
(value x)

(define u1 '(1 + (3 ^ 4)))
(value u1)

(define z 'cookie)
(value z)

 
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
There are many different representations of arithmetic expressions.

We can use help functions to abstract from representations.

help functions make our lives much easier and do so by hiding the representation.
|#

;1st-sub-exp returns the 1st sub expression.
;if the first question is also the last question,
;then we can get by without (cond ...) and without else

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

(define value1
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (operator nexp) '+)
       (+ (value1 (1st-sub-exp nexp))
          (value1 (2nd-sub-exp nexp))))
      ((eq? (operator nexp) 'x)
       (* (value1 (1st-sub-exp nexp))
          (value1 (2nd-sub-exp nexp))))
      (else
       (expt (value1 (1st-sub-exp nexp))
          (value1 (2nd-sub-exp nexp)))))))

;Below are some examples of applying value1
;try solving them by writing down the definition of the function value1
;and referring to the definition of the function value1

(value1 '(+ (x 3 6)(^ 8 2)))

(value1 '(+ 3 4))

(value1 '(+ 1 3))
(newline)

#|
we can use this value1 function for the first representation
of arithmetic expressions by changing 1st-sub-exp and operator

where:

(define 1st-sub-exp
  (lambda (aexp)
    (car aexp)))

(define operator
  (lambda (aexp)
    (car (cdr aexp))))
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


;We have seen representations before, but we didn't mention them being representations.
;Truth values and Numbers are two such entities that we have used for representation.

;We use the symbol 4 to represent the concept four.
;We use this symbol because we are accustomed to arabic representations.
;We need 4 primitives for numbers: number?, zero?, add1?, and sub1?.
;We will use () to represent zero.
;(()) to represent one.
;(()()) to represent two.
;(()()()) to represent three.

;the below function tests for zero

(define sero?
  (lambda(n)
    (null? n)))

(sero? '())
(sero? '(()))
(newline)

;the function below is like add1

(define edd1
  (lambda(n)
    (cons '() n)))

(edd1 '())
(edd1 '(()))
(newline)

;the function below is like sub1

(define zub1
  (lambda(n)
    (cdr n)))

;(zub1 '()) ; - - - -  Recall The Law of Cdr
(zub1 '(()))
(newline)

;the function below is like o+ for this representation

(define oo+
  (lambda (n m)
    (cond
      ((sero? m) n)
      (else (edd1 (oo+ n (zub1 m)))))))

;the function lat is defined below

(define lat?
  (lambda(l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))

(lat? '(1 2 3))

;(lat? '(1 2 3)) returns true...
;but
;(lat? ((()) (()()) (()()())) ) is very false

;is that bad? You must beware of shadows.


#|
##########################################################################
#                                                                        #
#                           Beware of shadows.                           #
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