#set list(marker: ("#", "%", "-"))
#set page(numbering: "1", number-align: right)

#align(center, [
  = Fuzzy Sets
])

#v(2em)

#table(
  columns: (10em, 1fr),
  table.header([*Term*], [*Description*]),
  [Universe of discourse],
  [Set of all information on a given problem. Once the universe is defined, we can define events on the information in the set.],
)

#v(1em)

== Fuzzy set
- A fuzzy set, $A$, is a set of ordered pairs $(x, mu_A (x))$ where $x in X$, $X$ is the universe of discourse of $A$, and $mu_A (x) in [0, 1]$ represents the membership value of $x$, i.e. a vague measurement of the availability of $x$ in $A$.
  $ A = {(x_1, mu_A (x_1)), (x_2, mu_A (x_2)), ..., (x_n, mu_A (x_n))} $
- This idea is unlike classical or crisp sets, where for any value $x$, we know for sure if it is available in a crisp set $A$.
- According to the Zadeh notation, a fuzzy set is represented as:
  $ A = (mu_A (x_1)) / x_1 + (mu_A (x_2)) / x_2 + ... + (mu_A (x_n)) / x_n = sum_(i = 1)^n (mu_A (x_i)) / x_i $
- If $X$ is continuous:
  $ A(x) = integral_x (mu_A (x)) / x $
- Note that $mu(x_i) / x_i$ represents the ordered pair $mu(x_i), x_i$, and not division.\
  Similarly, $sum$ and $integral$ represent union of ordered pairs, and not actual summation or integration.

#v(1em)

== Fuzzy set operations

+ Cardinality
  $ "Cardinality of" A: |A| = sum_(x in X) mu_A (x) $

+ Relative cardinality
  $ "Relative cardinality of" A: |A|_"rel" = (|A|) / (|X|) $

+ Subset
  $
    A "is a subset of" B:
    A subset.eq B = mu_A (x) <= mu_B (x) space forall x in X_A union X_B
  $

+ Compliment
  $
    "Complement of" A:
    overline(A) = sum_(x in X) (1 - mu_x) / x
  $

+ Union
  $
    "Union of" A "and" B:
    A union B = sum_(x in X_A union X_B) ("max"(mu_A (x), mu_B (x))) / x
  $

+ Intersection
  $
    "Intersection of" A "and" B:
    A union B = sum_(x in X_A union X_B) ("min"(mu_A (x), mu_B (x))) / x
  $

#v(1em)

== Fuzzy set properties

+ Commutativity
  $
    A union B & = B union A \
    A inter B & = B inter A
  $

+ Associativity
  $
    A union (B union C) & = (A union B) union C \
    A inter (B inter C) & = (A inter B) inter C
  $

+ Distributivity
  $
    A union (B inter C) & = (A union B) inter (A union C) \
    A inter (B union C) & = (A inter B) union (A inter C)
  $

+ Idempotency
  $
    A union A & = A \
    A inter A & = A
  $

+ Involution
  $ overline(overline(A)) = A $

+ De Morgan's law
  $
    overline(A union B) & = overline(A) inter overline(B) \
    overline(A inter B) & = overline(A) union overline(B)
  $

+ Law of absorption
  $
    A union (A inter B) & = A \
    A inter (A union B) & = A
  $
