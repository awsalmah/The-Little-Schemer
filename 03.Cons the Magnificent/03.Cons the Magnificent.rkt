#|3.Cons the Magnificent|#



#| The First Four (preliminary) Commandments: |#


#|
##########################################################################
#                                                                        #
#                          The First Commandment                         #
#                                                                        #
#                              (preliminary)                             #
#          Always ask null? as the first question in expressing          #
#          any function.                                                 #
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
#                              (preliminary)                             #
#        Always change at least one argument while recurring. It         #
#        must be changed to be closer to termination. The changing       #
#        argument must be tested in the termination condition:           #
#        when using cdr, test termination with null?.                    #
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


#|
Explaining (rember a lat):

;rember stands for remove a member

rember is a function that takes an atom and a lat as its arguments,
and makes a new lat with the first occurence of the atom in the
old lat removed.

alternatively rember can be defined as:

The function rember checked each atom of the lat, one at a time,
to see if it was the same as the atom, we saved it to be consed to the final value later.
When rember found the atom and, it dropped it, and consed the previous atoms back onto the rest of the lat.

#|
##########################################################################
#                                                                        #
#                          The Second Commandment                        #
#                                                                        #
#                         Use cons to build lists.                       #
#                                                                        #
##########################################################################
|#

Functions like rember can always be simplified,
but are not simplified right away because then
the function's structure does not coincide with 
its argument's structure.

Thus, rember can be defined as:

(define rember
   (lambda(a lat)
     (cond
        ((null? lat) (quote()))
        (else (cond
                   ((eq? (car lat) a) (cdr lat))
                   (else (cons (car lat)
			(rember a
  			    (cdr lat)))))))))

Or more simply:

(define rember
   (lambda(a lat)
     (cond
        ((null? lat) (quote()))
        ((eq? (car lat) a) (cdr lat))
        (else (cons (car lat)
	         (rember a (cdr lat)))))))


|#

#|The line below defines rember?|#

(define rember
   (lambda(a lat)
     (cond
        ((null? lat) (quote()))
        ((eq? (car lat) a) (cdr lat))
        (else (cons (car lat)
	         (rember a (cdr lat)))))))


;below are some examples:
;try solving them by writing down the definition of the function rember?
;and referring to the definition of the function rember?

(rember 'a '())

(rember 'bacon '(bacon lettuce and tomato))

(rember 'and '(bacon lettuce and tomato))
(newline)


#|
Explaining (firsts l):

The function firsts takes one argument, a list,
which is either a null list or contains only non-empty lists.
It binds another list composed of the first S-expression of each internal list.
|#

#|The line below defines (firsts l)|#

(define firsts
  ( lambda(l)
     (cond
       ((null? l) (quote()))
       (else (cons (car (car l)) (firsts (cdr l)))))))

;below are some examples:
;try solving them by writing down the definition of the function firsts
;and referring to the definition of the function firsts

(firsts '((apple peach pumpkin) (plum pear cherry) (grape raisin pea) (bean carrot eggplant)))

(firsts '((a b) (c d) (e f)))

(firsts '())

(firsts '((five plums) (four) (eleven green oranges)))

(firsts '(((five plums)four) (eleven green oranges) ((no) more)))
(newline)


#|

Q&A about some of the different parts of a function:


Why (define function_name 
      ( lambda (argument(s))
          ...))

Because we always state the function name, (lambda, and the argument(s) of the function.


Why (cond ...)

Because we need to ask questions about the actual arguments.

Why ((null? l) ...)

The First Commandment.


Why (else

The last question is always else.


Why (cons

Because we are building a list - The Second Commandment.


Why )))

Because these are the matching parentheses for
(cond, (lambda, and (define, and they always
appear at the end of a function definition.
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
Explaining (insertR new old lat):
The function insertR takes three arguments: the atoms new and old, and a lat.
insertR builds a lat with new inserted to the right of the first occurence
of old.
|#

#|The line below defines insertR|#

(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      (else(cond
             ((eq? (car lat) old)
             (cons (car lat)
                   (cons new (cdr lat))))
             (else (cons (car lat)
                         (insertR new old (cdr lat)))))))))

;below are some examples:
;try solving them by writing down the definition of the function insertR
;and referring to the definition of the function insertR

(insertR 'topping 'fudge '(ice cream with fudge for dessert))

(insertR 'jalapeno 'and '(tacos tamales and salsa))

(insertR 'e 'd '(a b c d f g d h))
(newline)


#|
Explaining (insertL new old lat):
The function insertL takes three arguments: the atoms new and old, and a lat.
insertL builds a lat with new inserted to the left of the first occurence
of old.
|#

#|The line below defines insertL|#

(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      (else(cond
             ((eq? (car lat) old)
             (cons new
                   (cons old (cdr lat))))
             (else (cons (car lat)
                         (insertL new old (cdr lat)))))))))

;below are some examples:
;try solving them by writing down the definition of the function insertL
;and referring to the definition of the function insertL

(insertL 'topping 'fudge '(ice cream with fudge for dessert))

(insertL 'jalapeno 'and '(tacos tamales and salsa))

(insertL 'e 'd '(a b c d f g d h))
(newline)


#|
Explaining (subst new old lat):
The function subst takes three arguments: the atoms new and old, and a lat.
subst builds a lat where new replaces the first occurence of the atom old in lat.
|#

#|The line below defines subst|#

(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      (else(cond
             ((eq? (car lat) old)
             (cons new (cdr lat)))
             (else (cons (car lat)
                         (subst new old (cdr lat)))))))))

;below are some examples:
;try solving them by writing down the definition of the function subst
;and referring to the definition of the function subst

(subst 'topping 'fudge '(ice cream with fudge for dessert))

(subst 'jalapeno 'and '(tacos tamales and salsa))

(subst 'e 'd '(a b c d f g d h))
(newline)



#|
##########################################################################
#                                                                        #
#                  Go cons a piece of cake onto your mouth.              #
#                                                                        #
##########################################################################
|#



#|
Explaining (subst2 new o1 o2 lat):
The function subst2 takes four arguments: the atoms new, o1, o2, and a lat.
subst2 builds a lat where new replaces either the first occurence
of the atom o1 or the first occurence of the atom o2 in lat.
|#

#|The line below defines subst2|#

(define subst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat) (quote()))
      (else(cond
             ((eq? (car lat) o1)
              (cons new (cdr lat)))
             ((eq? (car lat) o2)
              (cons new (cdr lat)))
             (else (cons (car lat)
                         (subst2 new o1 o2 (cdr lat)))))))))

;below are some examples:
;try solving them by writing down the definition of the function subst2
;and referring to the definition of the function subst2

(subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))

(subst2 'sprinkles 'candy 'topping '(banana ice cream with candy and chocolate topping))
(newline)



#|
##########################################################################
#                                                                        #
#       If you got the last function, go and repeat the cake-consing.    #
#                                                                        #
##########################################################################
|#



#|
Explaining (multirember a lat):
The function multirember is a function that takes an atom and a lat as its arguments,
and makes a new lat with every occurence of the atom in the old lat removed.
|#

#|The line below defines multirember|#

(define multirember
   (lambda(a lat)
     (cond
        ((null? lat) (quote()))
        ((eq? (car lat) a) (multirember a (cdr lat)))
        (else (cons (car lat)
	         (multirember a (cdr lat)))))))


;below are some examples:
;try solving them by writing down the definition of the function multirember
;and referring to the definition of the function multirember

(multirember 'a '(a a a c a d a ba a))

(multirember 'cup '(coffee cup tea cup and hick cup))
(newline)


#|
Explaining (multiinsertR new old lat):
The function multiinsertR takes three arguments: the atoms new and old, and a lat.
insertL builds a lat with new inserted to the right of every occurence of old.
|#

#|The line below defines multiinsertR|#

(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      (else(cond
             ((eq? (car lat) old)
             (cons (car lat)
                   (cons new (multiinsertR new old (cdr lat)))))
             (else (cons (car lat)
                         (multiinsertR new old (cdr lat)))))))))
;below are some examples:
;try solving them by writing down the definition of the function multiinsertR
;and referring to the definition of the function multiinsertR

(multiinsertR 'a 'b '(b c d b e b f b))

(multiinsertR 'topping 'fudge '(ice cream with fudge and chocolate fudge for dessert))
(newline)


#|
Explaining (multiinsertL new old lat):
The function multiinsertL takes three arguments: the atoms new and old, and a lat.
insertL builds a lat with new inserted to the left of every occurence of old.
|#

#|The line below defines multiinsertL|#

(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      (else(cond
             ((eq? (car lat) old)
             (cons new
                   (cons old (multiinsertL new old (cdr lat)))))
             (else (cons (car lat)
                         (multiinsertL new old (cdr lat)))))))))

;below are some examples:
;try solving them by writing down the definition of the function multiinsertL
;and referring to the definition of the function multiinsertL

(multiinsertL 'a 'b '(b c d b e b f b))

(multiinsertL 'fudge 'topping '(ice cream with topping and chocolate topping for dessert))
(newline)


#|
Explaining (multisubst new old lat):
The function multisubst takes three arguments: the atoms new and old, and a lat.
multisubst builds a lat where new replaces every occurence of the atom old in lat.
|#

#|The line below defines multisubst|#

(define multisubst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      (else(cond
             ((eq? (car lat) old)
              (cons new
                    (multisubst new old
                      (cdr lat))))
             (else (cons (car lat)
                         (multisubst new old
                           (cdr lat)))))))))

;below are some examples:
;try solving them by writing down the definition of the function multisubst
;and referring to the definition of the function multisubst

(multisubst 'a 'd '(a b c d e f d g h))

(multisubst 'mug 'cup '(coffee cup tea cup and a plain ol cup o water))
(newline)


#|
##########################################################################
#                                                                        #
#                          The Fourth Commandment                        #
#                                                                        #
#                              (preliminary)                             #
#        Always change at least one argument while recurring. It         #
#        must be changed to be closer to termination. The changing       #
#        argument must be tested in the termination condition:           #
#        when using cdr, test termination with null?.                    #
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
