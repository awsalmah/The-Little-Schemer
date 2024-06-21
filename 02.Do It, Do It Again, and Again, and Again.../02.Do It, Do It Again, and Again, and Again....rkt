#|2.Do It, Do It Again, and Again, and Again...|#


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


#|Every lat is a list of atoms|#

#|The line below defines lat?|#
(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))

;Below are some examples of applying lat?
;try solving them by writing down the definition of the function lat?
;and referring to the definition of the function lat?
(lat? '())

(lat? '(Jack Sprat could eat not chicken fat))

(lat? '(((Jack) Sprat could eat not chicken fat)))

(lat? '(bacon and eggs))

(lat? '(bacon (and eggs)))
(newline)

#|
Explaining (lat? l):

Note:
  (cond...) asks questions;
  (lambda...) creates a function; and
  (define...) gives it a name.

lat? looks at each S-expression in a list, in turn, and asks if each S-expression is an atom,
until it runs out of S-expressions. If it runs out without encountering a list, the value is
#t. If it finds a list, the value is #f - false.

The answer for the application of (lat? l) is determined by answering the questions asked about (lat? l)

((null? l) #t):
  (null? l) asks if the argument l is the null list.
  If it is, the value of the application is true.
  If it is not, we ask the next question.

((atom? (car l)) (lat? (cdr l))):

  (atom? (car l)) asks if the first S-expression of the list is an atom.
  If (car l) is an atom, we want to know if the rest of l is also composed only of atoms.
  If (car l) is not an atom, we ask the next question.

  (lat? (cdr l)) finds out if the rest of the list l is composed only of atoms,
  by referring to the function with a new argument.

(else #f)))):

  else asks if else is true. If else is true, then the answer is #f.

  else is always true!

  else --> OF COURSE!

  else is the last question because we do not need to ask any more questions.
  We do not need to ask any more questions because a list can be empty,
  can have an atom in the first position, or can have a list in the first position.

  ))) are the closing parenthesis or matching parenthesis of (cond ..., (lambda ..., and
  (define ..., which appear at the beginning of a function definition.
|#


;(or ...) asks two questions, one at a time. If the first one is true it stops and answers true.
;Otherwise it asks the second question and answers with whatever the second question answers.
;Below are some examples:
(or (null? '()) (null? '(a)))

(or (null? '()) (null? '(d e f g)))

(or (null? '(a b c)) (null? '(atom)))
(newline)

;member? checks if an atom a is a member of the list lat

#|The line below defines member?|#
(define member?
  (lambda (a lat)
    (cond
      ((null? lat ) #f)
      (else (or (eq? (car lat) a)
	         (member? a (cdr lat)))))))

#|
Explaining (member? l):

The answer for the application of (member? a lat) is determined by answering the questions asked by (member? a lat).

((null? lat ) #f):
  (null? lat) is the first question asked by (member? a lat) as well as by lat?
  (null? lat) asks if lat is the null list. If it is, the value is #f.
  If not, we ask the next question.

(else (or (eq? (car lat) a)
	         (member? a (cdr lat)))))))
  
  else:
    else is the next question, yes it is a question. Yes really.
    else is the next question because we do not need to ask any more questions.
    else is a question whose value is alwayus true.

  (else (or (eq? (car lat) a) (member? a (cdr lat)))):
    
    Now that we know that lat is not null?, we have to find out whether the car
    of lat is the same atom as a, or whether a is somewhere in the rest of lat.
    The answer (or (eq? (car lat) a) (member? a (cdr lat))) does this.

    If (eq? (car lat) a) is false, then we Recur - refer to the function with new arguments.
|#

;below are some examples:
;try solving them by writing down the definition of the function member?
;and referring to the definition of the function member?

(member? 'a '(a))

(member? 'tea '(coffee tea or milk))

(member? 'tea '((coffee) (tea) or milk))

(member? 'tea '((coffee) tea or milk))

(member? 'poached '(fried eggs and scrambled eggs))

(member? 'meat '(mashed potatoes and meat gravy))

(member? 'meat '(mashed potatoes and meat gravy))
(newline)


; ==> Do you believe all this? Then you may rest! <==


#|
##########################################################################
#                                                                        #
#                         This space for doodling                        #
#                                                                        #
##########################################################################
|#


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