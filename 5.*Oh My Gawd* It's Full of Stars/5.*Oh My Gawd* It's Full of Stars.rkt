#|5.*Oh My Gawd*: It's Full of Stars|#



#| The First Five (final version) Commandments: |#


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
rember* is a function that takes two arguments, an atom a and a list l.
rember* removes all occurences of a from the list no matter what.
|#

(define rember*
  (lambda (a l)
    (cond
      ((null? l) (quote()))
      ((atom? (car l))
       (cond
         ((eq? (car l) a)
          (rember* a (cdr l)))
         (else (cons (car l)
                     (rember* a (cdr l))))))
      (else (cons (rember* a (car l))
                  (rember* a (cdr l)))))))

;Below are some examples of applying rember*
;try solving them by writing down the definition of the function rember*
;and referring to the definition of the function rember*

(rember* 'cup '((coffee) cup ((tea) cup) (and (hick)) cup))

(rember* 'cup '((coffee cup) cup ((tea cup) cup) cup (and cup (hick cup)) cup))

(rember* 'cup '((coffee) ((tea)) (and (hick))))

(rember* 'sauce '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))
(newline)


#|
insertR* is a function that takes three arguments, the atoms new and old,
and a list l. insertR* inserts the atom new to the right of old
regardless of where old occurs.
|#

(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) (quote()))
      ((atom? (car l))
       (cond
         ( (eq? (car l) old)
           (cons old
                 (cons new
                       (insertR* new old
                                 (cdr l)))))
         (else (cons (car l)
                     (insertR* new old
                               (cdr l))))))
      (else ( cons (insertR* new old
                             (car l))
                   (insertR* new old
                             (cdr l)))))))

;Below is an example of applying insertR*
;try solving it by writing down the definition of the function insertR*
;and referring to the definition of the function insertR*

(insertR* 'roast 'chuck '((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood))
(newline)


#|
##########################################################################
#                                                                        #
#                          The First Commandment                         #
#                                                                        #
#                            (final revision)                            #
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
all *-functions are similar in the sense that they all ask three questions
and recur with the car as well as with the cdr, whenever the car is a list.

This is because all *-functions work on lists that are either:
- empty,
- an atom consed onto a list, or
- a list consed onto a list.
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
occur* is a function that takes two arguments, an atom a and a list l.
occur* counts the number of times the atom a is found in l.
|#

(define occur*
  (lambda (a l)
    (cond
      ((null? l) 0)
      ((atom? (car l))
       (cond
         ((eq? (car l) a)
          (add1 (occur* a (cdr l))))
         (else (occur* a (cdr l)))))
      (else (+ (occur* a (car l))
            (occur* a (cdr l)))))))

;Below is an example of applying occur*
;try solving it by writing down the definition of the function occur*
;and referring to the definition of the function occur*

(occur* 'banana '((banana) (split ((((banana ice))) (cream (banana)) sherbet)) (banana) (bread) (banana brandy)))
(newline)

#|
subst* is a function that takes three arguments, the atoms new and old,
and a list l. subst* replaces the atom old with the atom new
regardless of where old occurs.
|#

(define subst*
  (lambda (new old l)
    (cond
      ((null? l) (quote()))
      ((atom? (car l))
      (cond
        ((eq? (car l) old)
         (cons new
               (subst* new old (cdr l))))
        (else (cons (car l)
                    (subst* new old
                            (cdr l))))))
  (else
   (cons (subst* new old (car l))
         (subst* new old (cdr l)))))))


;Below is an example of applying subst*
;try solving it by writing down the definition of the function subst*
;and referring to the definition of the function subst*

(subst* 'orange 'banana '((banana) (split ((((banana ice))) (cream (banana)) sherbet)) (banana) (bread) (banana brandy)))
(newline)


#|
insertL* is a function that takes three arguments, the atoms new and old,
and a list l. insertL* inserts the atom new to the left of old
regardless of where old occurs.
|#

(define insertL*
  (lambda (new old l)
    (cond
      ((null? l) (quote()))
      ((atom? (car l))
       (cond
         ( (eq? (car l) old)
           (cons new
                 (cons old
                       (insertL* new old
                                 (cdr l)))))
         (else (cons (car l)
                     (insertL* new old
                               (cdr l))))))
      (else ( cons (insertL* new old
                             (car l))
                   (insertL* new old
                             (cdr l)))))))

;Below is an example of applying insertR*
;try solving it by writing down the definition of the function insertR*
;and referring to the definition of the function insertR*

(insertL* 'pecker 'chuck '((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood))
(newline)


#|
member* is a function that takes two arguments, an atom a and a list l.
member* returns true if the atom a appears in the list l.
|#

(define member*
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
       (or (eq? (car l) a)
           (member* a (cdr l))))
      (else (or (member* a (car l))
                (member* a (cdr l)))))))

;Below is an example of applying member*
;try solving it by writing down the definition of the function member*
;and referring to the definition of the function member*

(member* 'chips '((potato) (chips ((with) fish) (chips))))
(newline)


#|
leftmost is a function that finds the leftmost atom in a non-empty
list of S-expressions that does not contain the empty list.

leftmost works on lists of S-expressions, but it is not a *-function since it only recurs on the car
|#

(define leftmost
  (lambda (l)
    (cond
      ((atom? (car l)) (car l))
      (else (leftmost (car l))))))

;Below are some examples of applying leftmost
;try solving them by writing down the definition of the function leftmost
;and referring to the definition of the function leftmost

(leftmost '((potato) (chips ((with) fish) (chips))))

(leftmost '(((hot) (tuna (and))) cheese))       
(newline)


#|
Explaining what OR does:
  (or ...) asks questions one at a time until it finds one that is true.
  Then (or ...) stops, making its value true. If it cannot find a
  true argument, the value of (or ...) is false.

Explaining what AND does:
  (and ...) asks questions one at a time until it finds one whose value is false.
  Then (and ...) stops with false. If none of the expressions are false, (and ...)
  is true.

One of the arguments of (and ...) and (or ...) is not considered because (and ...)
stops if the first argument has the value #f, and (or ...) stops if the first
argument has the value #t.
|#


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
An S-expression is either an atom or a (possibly empty) list of S-expressions.

equal checks whether two S-expressions are the same.

equal can be written as:

(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2))
       (eqan? s1 s2))
      ((atom? s1) #f)
      ((atom? s2) #f)
      (else (eqlist? s1 s2)))))

equal can be simplified as:
|#

(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2))
       (eqan? s1 s2))
      ((or (atom? s1) (atom? s2))
       #f)
      (else (eqlist? s1 s2)))))


#|
eqlist? is a function that determines if two lists are equal.

eqlist? can be written as:

(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((and (null? l1) (atom? (car l2))) #f)
      ((null? l1) #f)
      ((and (atom? (car l1)) (null? l2)) #f)
      ((and (atom? (car l1)) (atom? (car l2)))
       (and (eq? (car l1) (car l2))
            (eqlist? (cdr l1) (cdr l2))))
      ((atom? (car l1)) #f)
      ((null? l2) #f)
      ((atom? (car l2)) #f)
      (else
        (and (eqlist? (car l1) (car l2))
             (eqlist? (cdr l1) (cdr l2)))))))

eqlist? can then be rewritten as:

(define eqlist? 
  (lambda (l1 l2)
    (cond
      ((and (null? l1)(null? l2)) #t)
      ((or (null? l1)(null? l2)) #f)
      ((and (atom? (car l1))(atom? (car l2)))
       (and (eqan? (car l1)(car l2))(eqlist? (cdr l1)(cdr l2))))
      ((or (atom? (car l1))(atom? (car l2))) #f)
      (else
       (and (eqlist? (car l1)(car l2))
            (eqlist? (cdr l1)(cdr l2)))))))

eqlist? can be rewritten using equal as:
|#

(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      (else
       (and (equal? (car l1) (car l2))
            (eqlist? (cdr l1) (cdr l2)))))))

;Below are some examples of applying eqlist?
;try solving them by writing down the definition of the function eqlist?
;and referring to the definition of the function eqlist?

(eqlist? '(strawberry ice cream) '(strawberry ice cream))

(eqlist? '(strawberry ice cream) '(strawberry cream ice))

(eqlist? '(banana ((split))) '((banana) (split)))

(eqlist? '(beef ((sausage)) (and (soda))) '(beef ((salami)) (and (soda))))

(eqlist? '(beef ((sausage)) (and (soda))) '(beef ((sausage)) (and (soda))))
(newline)


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
rember is modified wherein we replaced lat by a list of S-expressions, and a by any S-expression.

rember can be written as:

(define rember
  (lambda (s l)
    (cond
      ((null? l) (quote()))
      ((atom? (car l))
       (cond
         ((equal? (car l) s) (cdr l))
         (else (cons (car l)
                     (rember s (cdr l))))))
      (else (cond
              ((equal? (car l) s) (cdr l))
              (else (cons (car l)
                          (rember s
                                  (cdr l)))))))))

rember can be rewritten as:

(define rember
  (lambda (s l)
    (cond
      ((null? l) (quote()))
      (else (cond
              ((equal? (car l) s) (cdr l))
              (else (cons (car l)
                          (rember s
                                  (cdr l)))))))))

rember can be simplified as:
|#

(define rember
  (lambda (s l)
    (cond
      ((null? l) (quote()))
      ((equal? (car l) s) (cdr l))
      (else (cons (car l)
                  (rember s (cdr l)))))))


#|
When functions are correct and well-designed,
we can think about them  easily. Which saves
us the time from getting it wrong.

All functions that use eq? and = can be generalized
by replacing eq? and = by the function equal?.
(Given that we disregard the trivial example of eqan?.)
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