#|1.Toys|#


#|
The lang line below specifies what language should
be used to interpret the source code in the file.
|#
#lang racket

;To work with scheme you need to define atom?, sub1, and add1.


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
An atom is an element that's not a cons-pair
and that is not null. That includes:

1.Numbers
2.Strings
3.Symbols
4.Booleans
5.Characters

All atoms are S-expressions.

(atom? s) is just another way to ask "Is s an atom?"

atom? takes one argument. The argument can be any S-expression.
|#

;use atom? to check if something is an atom.

(atom? "atom")    ; "atom" is an atom because it is a string of characters
(atom? 'atom)    ; beginning with a letter.

(atom? 1492)      ; 1492 is an atom because it is a string of digits.

(atom? "u")       ; "u" is an atom because it is a string of one character
                  ; which is a letter.

(atom? "*abc$")   ; "*abc$" is an atom because it is a string of characters
                  ; beginning with a lterrer or a special character other
                  ; than a left "(" or a right ")" parenthesis.

;To print an empty line similar to using \n in c do this :
(newline)


#|
A list is nothing more than a sequence of items enclosed by parenthesis.

All lists are S-expressions.

The null (or empty) list is a special S-expression where
zero S-expressions are enclosed by parenthesis.

Below are some examples of lists:
|#

'()                                          ;this is a special S-expression where zero S-expressions are enclosed by parenthesis.
                                            
'(atom)                                      ;this is an atom enclosed by  parenthesis
                                         
'(atom turkey or)                            ;this is a collection of atoms enclosed by parenthesis
                                            
'((atom turkey) or)                          ;two S-expressions enclosed by parenthesis
                                            
'(how are you doing so far)                  ;this is a collection of s-expressions enclosed by parenthesis
                                            
'(((how) are) ((you) (doing so)) far)        ;this is a collection of s-expressions enclosed by parenthesis

'(atom)
(newline)


#|
car is an acronym from the phrase Contents of the Address part of the Register.

The car of a pair is its first item. And in case of lists it’s the head of the list.
car is non-destructive which means it doesn’t mutate the pair by removing the first
item from it, it only echoes what it is. Car takes any non-empty list as an argument.

You cannot ask for the car of an atom.

You cannot ask for the car of the empty list.

(car l) is just another way to ask for "the car of the list l"

############################################################################
#                                                                          #
#                             The Law of Car                               #
#          The primitive car is defined only for non-empty lists.          #
#                                                                          #
############################################################################

Below are some examples of asking for car:
|#

(car'(atom))

(car '(a b c))

(car '((a b c) x y z))

(car '(((hotdogs)) (and) (pickle) relish))

(car(car '(((hotdogs)) (and) (pickle) relish)))
(newline)


#|
cdr is an acronym from the phrase Contents of the Decrement part of the Register.
The cdr function returns the second element of the pair which in case of lists is
the list’s tail. Like car, cdr does not remove any elements from the list.
Like car, cdr takes any non-empty list as an argument.

“cdr” is pronounced as “could-er”.

You cannot ask for the cdr of an atom.

You cannot ask for the cdr of the null list.

############################################################################
#                                                                          #
#                             The Law of Cdr                               #
#          The primitive cdr is defined only for non-empty lists.          #
#           The cdr of a non-empty list is always another list.            #
#                                                                          #
############################################################################

Below are some examples of asking for cdr:
|#

(cdr '(a b c))

(cdr '(hamburger))

(cdr '((x) t r))

(cdr '((b) (x y) (c)))

(car (cdr '((b) (x y) (c))))

(cdr (cdr '((b) (x y) (c))))
(newline)


#|
cons takes two arguments, the first one is any S-expression; the second one is any list.

cons adds any S-expression to the front of the list.

the cons of the atom a and the list l can also be written as: cons(a,l) read: "cons the atom a onto the list l".

############################################################################
#                                                                          #
#                             The Law of Cons                              #
#                  The primitive cons takes two arguments.                 #
#    The second argument to cons must be a list. The result is a list.     #
#                                                                          #
############################################################################

Below are some examples of using cons:
|#

(cons 'peanut '(butter and jelly))

(cons '(banana and) '(peanut butter and jelly))

(cons '((help) this) '(is (very) hard to learn))

(cons '(a b (c)) '())

(cons'(a) (car '((b) c d)))

(cons '(a) (cdr '((b) c d)))
(newline)


#|
(null? l) is the same as asking “Is it true that the list l is the null list?”.

In practice, (null? α) is false for everything, except the empty list.

############################################################################
#                                                                          #
#                              The Law of Null?                            #
#           The primitive null? is defined only for for lists.             #
#                                                                          #
############################################################################

Below are some examples of using null?:
|#

(null? (quote()))

(null? '(a b c))

(null? (cdr'(a)))
(newline)


#|
(eq? a1 a2) is just another way to ask “Are a1 and a2 the same non-numeric atom?”

eq? takes two arguments. Both of them must be non-numeric atoms.

In practice, lists may be arguments of eq?. Two lists are eq? if they are the same list.

In practice, some numbers may be arguments of eq?

##########################################################################
#                                                                        #
#                              The Law of Eq?                            #
#                 The primitive eq? takes two arguments.                 #
#                    Each must be a non-numeric atom.                    #
#                                                                        #
##########################################################################

Below are some examples of using eq?:
|#

(eq? 'Harry 'Harry)

(eq? 'margarine 'butter)

(eq? (car'(Mary had a little lamb)) (car'(Mary b c)))

(eq? '(a b c) '(a b c))              ;in practice, some lists may be arguments of eq?
                                     ;Two lists are eq? if they are the same list.

(define x '(a b))
(eq? x x)

(eq? 6 7)                            ;in practice, some numbers may be arguments of eq?

(eq? 67 67)

(eq? (cdr '(soured milk)) 'milk)
(eq? (car(cdr '(soured milk))) 'milk)
(newline)


; ==> Now go make yourself a peanut butter and jelly sandwich. <== 


#|
#############################################################################
#                                                                           #
#                          This space reserved for                          #
#                                                                           #
#                               JELLY STAINS!                               #
#                                                                           #
#############################################################################
|#