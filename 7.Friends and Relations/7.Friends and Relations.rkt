#|7.Friends and Relations|#



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


#|
##########################################################################
#                                                                        #
#                         The Eighth Commandment                         #
#                                                                        #
#            Use help functions to abstract from representation.         #
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


;member? checks if an atom a is a member of the list lat

#|The line below defines member?|#
(define member?
  (lambda (a lat)
    (cond
      ((null? lat ) #f)
      (else (or (eq? (car lat) a)
	         (member? a (cdr lat)))))))


#|The line below defines multirember|#

(define multirember
   (lambda(a lat)
     (cond
        ((null? lat) (quote()))
        ((eq? (car lat) a) (multirember a (cdr lat)))
        (else (cons (car lat)
	         (multirember a (cdr lat)))))))


#|
For the time being, think of a set as a lat, or as
a list of unique atoms (no atom appears more than once).

set can be written as:

(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      (else
       (cond
         ((member? (car lat) (cdr lat)) #f)
       (else (set? (cdr lat))))))))

it can be further simplified as:
|#

(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else (set? (cdr lat))))))

;Below are some examples of applying set?
;try solving them by writing down the definition of the function set?
;and referring to the definition of the function set?

(set? '(a))

(set? '(a a))

(set? '(apple peaches apple plum))

(set? '(apple peaches pears plums))

(set? '(apple 3 pear 4 9 apple 3 4))
(newline)


#|
makeset is a function that takes a lat as its argument
and returns a new lat that is a set(no atom appears more than once).
|#

(define makeset
  (lambda (lat)
    (cond
      ((null? lat) (quote()))
       ((member? (car lat) (cdr lat))
        (makeset (cdr lat)))
       ((cons (car lat) (makeset (cdr lat)))))))

;Below are some examples of applying makeset
;try solving them by writing down the definition of the function makeset
;and referring to the definition of the function makeset

(makeset '())

(makeset '(a a))

(makeset '(a a b a b d c a c d b d))

(makeset '(apple peach pear peach plum apple lemon peach))

(makeset '(apple 3 pear 4 9 apple 3 4))
(newline)


#|
Below we have a variation of makeset but here we have used multirember:

The function makeset2 remembers to cons the first atom in the lat onto
the result of the natural recursion, after removing all ocucurences
of the first atom from the rest of the lat.
|#

(define makeset2
  (lambda (lat)
    (cond
      ((null? lat) (quote()))
      (else (cons (car lat)
                  (makeset
                   (multirember (car lat)
                                (cdr lat))))))))

;Below are some examples of applying makeset
;try solving them by writing down the definition of the function makeset
;and referring to the definition of the function makeset

(makeset2 '())

(makeset2 '(a a))

(makeset2 '(a a b a b d c a c d b d))

(makeset2 '(apple peach pear peach plum apple lemon peach))

(makeset2 '(apple 3 pear 4 9 apple 3 4))
(newline)


#|
subset? is a function that checks if each atom in set1 is also in set2

subset? can be written as:

(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      (else
       (cond
         ((member? (car set1) set2)
          (subset? (cdr set1) set2))
         (else #f))))))

it can also be rewritten as:

(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      ((member? (car set1) set2)
       (subset? (cdr set1) set2))
      (else #f))))

it can be further simplified as:
|#

(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      (else
       (and (member? (car set1) set2)
            ((subset? (cdr set1) set2)))))))

;Below are some examples of applying subset?
;try solving them by writing down the definition of the function subset?
;and referring to the definition of the function subset?

(subset? '() '())

(subset? '() '(a))

(subset? '(4 pounds of horseradish) '(four pounds chicken and 5 ounces horseradish))
(newline)


#|
eqset? is a function that checks if 2 sets contain the same atoms
or more accurately, are equal.

eqset? can be written as:

(define eqset?
  (lambda (set1 set2)
    (cond
      ((subset? set1 set2)
       (subset? set2 set1))
      (else #f))))

it can also be written as:
|#

(define eqset?
  (lambda (set1 set2)
    (cond
      (else (and (subset? set1 set2) (subset? set2 set1))))))

;Below are some examples of applying eqset?
;try solving them by writing down the definition of the function eqset?
;and referring to the definition of the function eqset?

(eqset? '() '())

(eqset? '() '(a))

;(eqset? '(6 large chickens with wings) '(6 chickens with large wings)) ;tk dont forget to fix this later
(newline)


#|
intersect? returns true if at least one atom from set1 is in set2.

it can be written as:

(define intersect?
  (lambda (set1 set2)
    (cond
      ((null? set1) #f)
      (else
       (cond
         ((member? (car set1) set2) #t)
         (else (intersect? (cdr set1) set2)))))))

it can also be written as:

(define intersect?
  (lambda (set1 set2)
    (cond
      ((null? set1) #f)
      ((member? (car set1) set2 #t))
      (else (intersect? (cdr set1) set2)))))

it can also be written as:
|#

(define intersect?
  (lambda (set1 set2)
    (cond
      ((null? set1) #f)
      (else (or (member? (car set1) set2)
                (intersect? (cdr set1) set2))))))

;Below are some examples of applying intersect?
;try solving them by writing down the definition of the function intersect?
;and referring to the definition of the function intersect?

(intersect? '() '())

(intersect? '() '(a))

(intersect? '(a) '(a))

(intersect? '(stewed tomatoes and macaroni) '(macaroni and cheese))
(newline)


#|
intersect is a function that returns the atoms that are found in set1 and set2
|#

(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1) (quote()))
      ((member? (car set1) set2)
       (cons (car set1) (intersect (cdr set1) set2)))
       (else (intersect (cdr set1) set2)))))

;Below are some examples of applying intersect
;try solving them by writing down the definition of the function intersect
;and referring to the definition of the function intersect

(intersect '() '())

(intersect '() '(a))

(intersect '(a) '(a))

(intersect '(stewed tomatoes and macaroni) '(macaroni and cheese))
(newline)


#|
union is a function that returns all the atoms in set1 and set2
|#

(define union
  (lambda (set1 set2)
    (cond
      ((null? set1) set2)
      ((member? (car set1) set2)
       (union (cdr set1) set2))
      (else
       (cons (car set1) (union (cdr set1) set2))))))

;Below are some examples of applying union
;try solving them by writing down the definition of the function union
;and referring to the definition of the function union

(union '() '())

(union '() '(a))

(union '(a) '(a b c))

(union '(a) '(b c d))

(union '(stewed tomatoes and macaroni) '(macaroni and cheese))
(newline)


#|
setdiff(short for set difference) is a function that returns all the atoms in set1 that are not in set2.
|#

(define setdiff
  (lambda (set1 set2)
    (cond
      ((null? set1) (quote()))
      ((member? (car set1) set2)
       (setdiff (cdr set1) set2))
      (else
       (cons (car set1) (setdiff (cdr set1) set2))))))

;Below are some examples of applying setdiff
;try solving them by writing down the definition of the function setdiff
;and referring to the definition of the function setdiff

(setdiff '() '())

(setdiff '(x a) '(a))

(setdiff '(a) '(a b c))

(setdiff '(a) '(b c d))

(setdiff '(stewed tomatoes and macaroni) '(macaroni and cheese))
(newline)


#|
intersectall is a function that returns the elements found in all parts of the list.
|#

(define intersectall
  (lambda (l-set)
    (cond
      ((null? (cdr l-set)) (car l-set))
      (else (intersect (car l-set)
                       (intersectall (cdr l-set)))))))

;Below are some examples of applying intersectall
;try solving them by writing down the definition of the function intersectall
;and referring to the definition of the function intersectall

(intersectall '((a b c) (c a d e) (e f g h a b)))

(intersectall '((6 pears and) (3 peaches and 6 peppers) (8 pears and 6 plums) (and 6 prunes with some apples)))
(newline)


#|
A pair is a list with only two atoms.

A pair in scheme (or Lisp) is a different but related object.
|#

;Below are some examples of applying pair
;try solving them by writing down the definition of the function pair
;and referring to the definition of the function pair

(pair? '(pear pear))

(pair? '(3 7))

(pair? '((2) (pair))) ;this is true because it is a list with only two S-expressions.

(pair? '(full (house)))
(newline)


#|
a-pair is a (non-primitive) function that determines whether or not a list is a pair.
|#

(define a-pair?
  (lambda (x)
    (cond
      ((atom? x) #f)
      ((null? x) #f)
      ((null? (cdr x)) #f)
      ((null? (cdr (cdr x))) #t)
      (else #f))))

;Below are some examples of applying a-pair?
;try solving them by writing down the definition of the function a-pair?
;and referring to the definition of the function a-pair?

(a-pair? '(pear pear))

(a-pair? '(3 7))

(a-pair? '((2) (pair))) ;this is true because it is a list with only two S-expressions.

(a-pair? '(full (house)))
(newline)


#|
Take the car of the pair to refer to the first S-expression of a pair.

Take the car of the cdr of the pair to refer to the second S-expression of a pair.

Cons the first atom onto the cons of the second atom onto () to build a pair of atoms.

Cons the first S-expression onto the cons of the second S-expression onto () to build a pair of S-expressions.

The below functions(first, second, and build) will be used to improve readability:
|#

(define first
  (lambda (p)
    (cond
      (else (car p)))))

(define second
  (lambda (p)
    (cond
      (else (car (cdr p))))))

(define build
  (lambda (s1 s2)
    (cond
      (else (cons s1
                  (cons s2 (quote())))))))

;the above functions can be redefined as one-liners by deleting cond and else(refer to the derfinition of third to see an example of it)

(define third
  (lambda (l)
    (car (cdr (cdr l)))))


#|The line below defines (firsts l)|#

(define firsts
  ( lambda(l)
     (cond
       ((null? l) (quote()))
       (else (cons (car (car l)) (firsts (cdr l)))))))


#|
A rel(short for relation) is a list of pairs.

Some examples of rels are:
((apples peaches) (pumpkin pie))
((4 3) (4 2) (7 6 ) (6 2) (3 4))

But the following are not rels:
(apples peaches pumpkin pie)
((apples peaches) (pumpkin pie) (apples peaches))

A fun(short for function) determines if a rel is a function.

A finite function is a list of pairs in which no first element of any pair is the same as any other first element.

fun is not a full function as it allows the second item of a pair to be appear more than once.
|#

(define fun?
  (lambda (rel)
    (set? (firsts rel))))

;Below are some examples of applying fun?
;try solving them by writing down the definition of the function fun?
;and referring to the definition of the function fun?

(fun? '())

(fun? '((4 3) (4 2) (7 6) (6 2) (3 4)))

(fun? '((8 3) (4 2) (7 6) (6 2) (3 4)))

(fun? '((d 4) (b 0) (b 9) (e 5) (g 4)))      
(newline)


#|
revrel is a function that swaps the positions of the first and of the second elements in a rel.

notice how representations aids readability in the function definition below:
|#

(define revrel
  (lambda (rel)
    (cond
      ((null? rel) (quote()))
      (else (cons (build
                   (second (car rel))
                   (first (car rel)))
                   (revrel (cdr rel)))))))

;Below are some examples of applying revrel
;try solving them by writing down the definition of the function revrel
;and referring to the definition of the function revrel

(revrel '())

(revrel '((8 a) (pumpkin pie) (got sick)))

(revrel '((d 4) (b 0) (b 9) (e 5) (g 4)))      
(newline)


#|
revpair reverses the two components of a pair.
|#

(define revpair
  (lambda (pair)
    (build (second pair) (first pair))))

;we can use revpair to help in representing revrel

(define revrel1
  (lambda (rel)
    (cond
      ((null? rel) (quote()))
      (else (cons (revpair (car rel))
                  (revrel1 (cdr rel)))))))

;Below are some examples of applying revrel1
;try solving them by writing down the definition of the function revrel1
;and referring to the definition of the function revrel1

(revrel1 '())

(revrel1 '((8 a) (pumpkin pie) (got sick)))

(revrel1 '((d 4) (b 0) (b 9) (e 5) (g 4)))      
(newline)


#|
seconds is just like firsts, but it returns the second element of every pair instead of the first.
|#
(define seconds
  ( lambda(l)
     (cond
       ((null? l) (quote()))
       (else (cons (car (cdr (car l))) (seconds (cdr l)))))))

;Below are some examples of applying seconds
;try solving them by writing down the definition of the function seconds
;and referring to the definition of the function seconds

(seconds '())

(seconds '((4 3) (4 2) (7 6) (6 2) (3 4)))

(seconds '((8 3) (4 2) (7 6) (6 2) (3 4)))

(seconds '((d 4) (b 0) (b 9) (e 5) (g 4)))      
(newline)


#|
fullfun returns true if the list consisting of the second elements of every pair is a set.
|#

(define fullfun?
  (lambda(fun)
    (set? (seconds fun))))

;Below are some examples of applying fullfun?
;try solving them by writing down the definition of the function fullfun?
;and referring to the definition of the function fullfun?

(fullfun? '())

(fullfun? '((8 3) (4 2) (7 6) (6 2) (3 4)))

(fullfun? '((8 3) (4 8) (7 6) (6 2) (3 4)))

(fullfun? '((grape raisin) (plum prune) (stewed prune)))

(fullfun? '((grape raisin) (plum prune) (stewed grape)))
(newline)


#|
one-to-one is another name for fullfun.

it can be rewritten as:
|#

(define one-to-one?
  (lambda (fun)
    (fun? (revrel fun))))

;Below are some examples of applying one-to-one?
;try solving them by writing down the definition of the function one-to-one?
;and referring to the definition of the function one-to-one?

(one-to-one? '())

(one-to-one? '((8 3) (4 2) (7 6) (6 2) (3 4)))

(one-to-one? '((8 3) (4 8) (7 6) (6 2) (3 4)))

(one-to-one? '((grape raisin) (plum prune) (stewed prune)))

(one-to-one? '((grape raisin) (plum prune) (stewed grape)))
(newline)


; ==> Is ((chocolate chip) (doughy cookie)) a one-to-one function? <==
;                 ==> Yes, and you deserve one now! <==

;                        ==> Go and get one! <==

;                 ==> Or better yet, make your own. <==

#|
##########################################################################
#                                                                        #
# (define cookies                                                        #
#  (lambda ()                                                            #
#   (bake                                                                #
#    (quote (350 degrees))                                               #
#    (quote (12 minutes))                                                #
#    (mix                                                                #
#     (quote (walnuts 1 cup))                                            #
#     (quote (chocolate-chips 16 ounces))                                #
#     (mix                                                               #
#      (mix                                                              #
#       (quote (flour 2 cups))                                           #
#       (quote (oatmeal 2 cups))                                         #
#       (quote (salt .5 teaspoon))                                       #
#       (quote (baking-powder 1 teaspoon))                               #
#       (quote (baking-soda 1 teaspoon))                                 #
#       (mix                                                             #
#        (quote (eggs 2 large))                                          #
#        (quote (vanilla 1 teaspoon))                                    #
#        (cream                                                          #
#         (quote (butter 1 cup))                                         #
#         (quote (sugar 2 cups))))))))))                                 #
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