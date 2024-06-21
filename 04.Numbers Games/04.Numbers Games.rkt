#|4.Numbers Games|#



#| The First Five (first revision) Commandments: |#


#|
##########################################################################
#                                                                        #
#                          The First Commandment                         #
#                                                                        #
#                            (first revision)                            #
#          When recurring on a list of atoms, lat, ask two questions     #
#          about it: (null? lat) and else.                               #
#          When recurring on a number, n, ask two questions about        #
#          it: (zero? n) and else.                                       #
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
#                             (first revision)                           #
#        Always change at least one argument while recurring. It         #
#        must be changed to be closer to termination. The changing       #
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


#|All numbers are atoms, ie: 14, -3, and 3.14159 but the only numbers we will use are the nonnegative integers(Natural Numbers).|#

(atom? 14)

(atom? -3)

(atom? 3.14159)
(newline)

#|add1 is a function that takes a number as an input and adds 1 to it |#

(define add1
  (lambda (n)
    (+ n 1)))

;Below are some examples of applying add1
;try solving them by writing down the definition of the function add1
;and referring to the definition of the function add1

(add1 67)
(newline)

#|sub1 is a function that takes a number as an input and subtracts 1 from it|#

(define sub1
  (lambda (n)
    (- n 1)))

;Below are some examples of applying sub1
;try solving them by writing down the definition of the function sub1
;and referring to the definition of the function sub1

(sub1 5)

(sub1 0)
(newline)


#|zero? is a primitive function that checks whether or not a given input is equal to zero|#

(zero? 0)

(zero? 1492)
(newline)


#|
Explaining o+:
  o+ is a function that takes two numbers as arguments and adds them, it reduces the second argument until it hits zero.
  It adds one to the result as many times as it did to cause the second one to reach zero.

  o+ doesn't violate the First commandment because we can treat zero? like null? since zero? asks if a number is empty
  and null? asks if a list is empty.

  Since zero? is like null?, this also means that add1 is like cons. add1 builds numbers similar to how cons builds lists.
|# 

(define o+
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (add1(o+ n (sub1 m)))))))

;Below are some examples of applying o+
;try solving them by writing down the definition of the function o+
;and referring to the definition of the function o+

(o+ 46 12)
(newline)


#|
Explaining o-:
  o- is a function that takes two numbers as arguments and subtracts them, it reduces the second argument until it hits zero.
  It subtracts one from the result as many times as it did to cause the second one to reach zero
|#

(define o-
  ( lambda (n m)
     (cond
       ((zero? m) n)
       (else (sub1 (o- n (sub1 m)))))))

;Below are some examples of applying o-
;try solving them by writing down the definition of the function o-
;and referring to the definition of the function o-

(o- 5 9)

(o- 14 3)

(o- 17 9)

(o- 18 25)
(newline)


#|
A tup(tup is short for tuple) is a list of atoms(numbers). A tup is defined as being either an empty list, or it contains a number and a rest that is also a tup.

addtup builds a number by totaling all the numbers in its argument.

RECALL THAT: a lat is defined as being either an empty list, or it contains an atom, (car lat), and a rest, (cdr lat), that is also a lat.

A number is defined as being either zero or it is one added to a rest, where rest again is a number.
|#


#|
##########################################################################
#                                                                        #
#                          The First Commandment                         #
#                                                                        #
#                            (first revision)                            #
#          When recurring on a list of atoms, lat, ask two questions     #
#          about it: (null? lat) and else.                               #
#          When recurring on a number, n, ask two questions about        #
#          it: (zero? n) and else.                                       #
#                                                                        #
##########################################################################
|#


(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (o+ (car tup) (addtup (cdr tup)))))))

;Below are some examples of applying addtup
;try solving them by writing down the definition of the function addtup
;and referring to the definition of the function addtup

(addtup '(1 2 3))

(addtup '(2 11 3 79 47 6))

(addtup '(8 55 5 555))

(addtup '(3 5 2 8))

(addtup '(15 6 7 12 3))
(newline)


#|
##########################################################################
#                                                                        #
#                          The Fourth Commandment                        #
#                                                                        #
#                             (first revision)                           #
#        Always change at least one argument while recurring. It         #
#        must be changed to be closer to termination. The changing       #
#        argument must be tested in the termination condition:           #
#                                                                        #
#        When using cdr, test termination with null? and                 #
#        when using sub1, test termination with zero?.                   #
#                                                                        #
##########################################################################
|#


#| (x n m) builds up a number by adding n up m times. |#

(define *
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else ( o+ n (* n (sub1 m)))))))

;Below are some examples of *
;try solving them by writing down the definition of the function *
;and referring to the definition of the function *

(* 5 3)

(* 13 4)

(* 12 3)
(newline)


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
tup+ is a function that takes two tups as arguments, and adds the first number
of tup1 to the first number of tup2, then it adds the second number of tup1 to
the second number of tup2, and so on, building a tup of the answers, for tups
of the same length.

tup+ recurs on both of its arguments.

The order of terminal conditions does NOT matter.

tup+ can be define as:

(define tup+
  (lambda (tup1 tup2)
    (cond
      ((and (null? tup1) (null? tup2))
       (quote()))
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else (cons (o+ (car tup1) (car tup2)) (tup+ (cdr tup1) (cdr tup2)))))))

or more simply:
|#

(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else (cons (o+ (car tup1) (car tup2)) (tup+ (cdr tup1) (cdr tup2)))))))

;Below are some examples of applying tup+
;try solving them by writing down the definition of the function tup+
;and referring to the definition of the function tup+

(tup+ '(3 6 9 11 4) '(8 5 2 0 7))

(tup+ '(2 3) '(4 6))

(tup+ '(3 7) '(4 6))

(tup+ '(3 7) '(4 6 8 1))

(tup+ '(3 7 8 1) '(4 6))
(newline)


#|
The order of the terminal conditions in > and in < matters
> can be defined as:
|#

(define >
  (lambda (n m)
    (cond
      ((zero? n) #f)
      ((zero? m) #t)
      (else (> (sub1 n) (sub1 m))))))

;Below are some examples of applying >
;try solving them by writing down the definition of the function >
;and referring to the definition of the function >

(> 12 3)

(> 12 133)

(> 120 11)
(newline)

#|
< can be defined as:
|#

(define <
  (lambda (n m)
    (cond
      ((zero? m) #f)
      ((zero? n) #t)
      (else (< (sub1 n) (sub1 m))))))

;Below are some examples of applying <
;try solving them by writing down the definition of the function <
;and referring to the definition of the function <

(> 12 3)

(> 4 6)

(> 8 3)

(> 6 6)
(newline)


#|
The function = can be defined using > and <, as can be seen below.

We now have = for atoms that are numbers and
we now have eq? for the others.
|#

(define =
  (lambda ( n m)
    (cond
      ((> n m) #f)
      ((< n m) #f)
    (else #t))))

;Below are some examples of applying =
;try solving them by writing down the definition of the function =
;and referring to the definition of the function =

(= 1 2)

(= 3 2)

(= 2 2)
(newline)

#|
The function (^ n m) takes two arguments, n and the exponent m
and computes the result of multiplying n by itself m times.
|#

(define ^
  (lambda (n m)
    (cond
      ((zero? m) 1)
      (else (* n (^ n (sub1 m)))))))

;Below are some examples of applying ^
;try solving them by writing down the definition of the function ^
;and referring to the definition of the function ^

(^ 2 3)

(^ 3 2)

(^ 5 0)
(newline)


#|
The function o/ divides the first argument by the second one.
It does this by counting how many times the second argument
fits into the first one.
|#

(define o/
  (lambda (n m)
    (cond
      ((< n m) 0)
      (else (add1 (o/ (o- n m) m))))))

;Below are some examples of applying o/
;try solving them by writing down the definition of the function o/
;and referring to the definition of the function o/

(o/ 15 5)

(o/ 15 4)

(o/ 15 3)
(newline)


#|
##########################################################################
#                                                                        #
#         Wouldn't a (ham and cheese on rye) be good right now?          #
#                         Don't forget the mustard!                      #
#                                                                        #
##########################################################################
|#


#|
(length lat) is a function that takes a lat as an
input and counts the number of atoms in the lat
|#

(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 ( length (cdr lat)))))))

;Below are some examples of applying length
;try solving them by writing down the definition of the function length
;and referring to the definition of the function length

(length '())

(length '(a))

(length '(a b c d e))

(length '(hotdogs with mustard sauerkraut and pickles))

(length '(ham and cheese on rye))
(newline)


#|
(pick n lat) is a function that takes two arguments: n and lat,
where n is a number and lat is a list of atoms, and it returns
the atom in the lat at position n.
|#

(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

;Below are some examples of applying pick
;try solving them by writing down the definition of the function pick
;and referring to the definition of the function pick

(pick 4 '(lasagna spaghetti ravioli macaroni meatball))

(pick 1 '(a))
(newline)


#|
(rempick n lat) is a function that takes two arguments: n and lat,
where n is a number and lat is a list of atoms, and it returns
the lat with the atom in position n removed.
|#

(define rempick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (cdr lat))
      (else (cons (car lat)
                  (rempick (sub1 n) (cdr lat)))))))

;Below are some examples of applying rempick
;try solving them by writing down the definition of the function rempick
;and referring to the definition of the function rempick

(rempick 4 '(lasagna spaghetti ravioli macaroni meatball))

(rempick 3 '(hotdogs with hot mustard))
(newline)


#|
(number? n) is a primitive function that checks whether or not its argument is a number.

number?, add1, sub1, zero?, car, cdr, cons, null?, eq?, and atom? are all examples of primitive functions.
|#

(number? 1)

(number? 'tomato)

(number? 76)
(newline)


#|
no-nums is a function which gives as a final value a lat obtained by removing all the numbers from the lat.
|#

(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote()))
      (else (cond
              ((number? (car lat)) (no-nums (cdr lat)))
              (else (cons (car lat) (no-nums (cdr lat)))))))))

;Below are some examples of applying no-nums
;try solving them by writing down the definition of the function no-nums
;and referring to the definition of the function no-nums

(no-nums '())

(no-nums '(1 2 3 4 5))

(no-nums '(5 pears 6 prunes 9 dates))
(newline)


#|
all-nums is a function which extracts a tup from a lat using all the numbers in the lat.
|#

(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote()))
      (else
       (cond
         ((number? (car lat))
          (cons (car lat) (all-nums (cdr lat))))
         (else (all-nums (cdr lat))))))))

;Below are some examples of applying all-nums
;try solving them by writing down the definition of the function all-nums
;and referring to the definition of the function all-nums

(all-nums '())

(all-nums '(1 2 3 4 5))

(all-nums '(5 pears 6 prunes 9 dates))
(newline)


#|
The function eqan? returns true if its two arguments are the same atom.

All functions written using eq? can be generalized using eqan?(except for eqan? itself ofcourse).
|#

(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2))
       (= a1 a2))
      ((or (number? a1) (number? a2))
       #f)
      (else (eq? a1 a2)))))

;Below are some examples of applying eqan?
;try solving them by writing down the definition of the function eqan?
;and referring to the definition of the function eqan?

(eqan? 1 1)

(eqan? 1 2)

(eqan? 1 '(1 2 3))

(eqan? 1 'a)

(eqan? 'a 'a)

(eqan? 'a 'b)

(eqan? 'a '(1 2 3))
(newline)


#|
The function occur counts the number of times an atom a appears in a lat.
|#

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      (else
       (cond
         ((eqan? (car lat) a)
          (add1 (occur a (cdr lat))))
         (else (occur a (cdr lat))))))))

;Below are some examples of applying occur
;try solving them by writing down the definition of the function occur
;and referring to the definition of the function occur

(occur 'a '(a b c d e a f g h a i j))

(occur 'z '(a b c d e a f g h a i j))
(newline)

#|
one? checks whether or not a number is equal to one.
|#

(define one?
  (lambda (n)
    (= n 1)))

(one? 0)

(one? 1)

(one? 2)
(newline)


#|
rewriting rempick(which removes the nth atom from a lat) using one?
|#
(define rempick1
  (lambda(n lat)
    (cond
      ((one? n) (cdr lat))
      (else (cons (car lat) (rempick1 (sub1 n) (cdr lat)))))))

(rempick 3 '(lemon meringue salty pie))

(rempick1 4 '(lasagna spaghetti ravioli macaroni meatball))

(rempick1 3 '(hotdogs with hot mustard))
(newline)



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