#set list(marker: ("#", "%", "-"))
#set page(number-align: right, numbering: "1")

#align(center, [
  = Defuzzification
])

#v(2em)

== Lambda cut
- Lambda cut of a fuzzy set $A$ is denoted as $A_lambda$ where $0 <= lambda <= 1$.
- It is a crisp set of all elements which have membership values greater than or equal to $lambda$.
  $ A_lambda = {x | mu_A (x) >= lambda} $

=== Properties of lambda cuts
+ $(A union B)_lambda = A_lambda union B_lambda$
+ $(A inter B)_lambda = A_lambda inter B_lambda$
+ $overline(A)_lambda eq.not overline(A_lambda)$ except when $lambda = 0.5$.
+ If $alpha >= lambda$ and $0 <= alpha <= 1$, then $A_alpha subset.eq A_lambda$.

=== Membership
- Membership features, i.e. core, support and boundary, can be denoted by lambda cuts.
  + $"core"_A = A_1$
  + $"supp"_A = A_(0+)$
  + $"bound"_A = A_(0+) - A_1$

=== Lambda cut for fuzzy relations
- Lambda cut for a fuzzy relation $R$ can be defined similar to that of fuzzy sets.
  $ R_lambda = {(x, y) | mu_R (x, y) >= lambda} $

=== Nearest ordinary set
- Any $lambda$-cut of a fuzzy set $A$ is called a nearest ordinary set of $A$.
- Note that there can be an infinite number of nearest ordinary sets of $A$.

=== Index of fuzziness
- The difference of a fuzzy set $A$ from its nearest ordinary set is a measure of the index of fuzziness of $A$, $nu(A)$.
  $ nu(A) = 2 / n^k dot d(A, A_lambda) $
- In the case of Hamming distance,
  $ nu(A) = 2 / n dot sum_(x in X)|A(x) - A_lambda (x)| $

#v(1em)

== Defuzzification
- Defuzzification is the conversion of a fuzzy quantity to a precise quantity.

=== Defuzzification methods
+ Max membership method
  - For a fuzzy set $A$ defined on universe $X$, the defuzzified value $x^*$ is the element with the maximum membership value, i.e.
    $ x^* = x | mu_A (x) = h(A) $
  - Simplest method.

+ Mean max method
  - For a fuzzy set $A$ defined on universe $X$, the defuzzified value $x^*$ is the mean of the elements with the maximum membership value, i.e.
    $ x^* = "mean"(x_1, x_2, ..., x_k) | mu_A (x_i) = h(A) #h(2em) forall space 1 <= i <= k $
  - Similar to max membership method. Applicable when there are plateau or multiple peaks.

+ Centroid method
  - For a fuzzy set $A$ defined on universe $X$, the defuzzified value $x^*$ is described by the equation:
    $ x^* = frac(integral x dot mu_A (x) space d x, integral mu_A (x) space d x) $
  - Most accurate, but involves intensive calculation.

+ Weighted average method
  - For a fuzzy set $A$ defined on universe $X$, the defuzzified value $x^*$ is described by the equation:
    $ x^* = frac(sum_(x in X) x dot mu_A (x), sum_(x in X) mu_A (x)) $
  - Less computationally extensive than centroid method. There is some geometric approximation involved here, so it is applicable for symmetric membership functions.

+ Center of sums method
  - If there is a union of fuzzy sets $A_1$, $A_2$, ..., $A_n$, then the centroid of each, then we can find $x^*$ from the equation:
    $
      x^* &= frac(integral overline(x) dot sum_(k = 1)^n mu_(A_k) (x) space d x, integral sum_(k = 1)^n mu_(A_k) (x) space d x)\
      &= frac(sum_(k = 1)^n overline(x) dot integral mu_(A_k) (x) space d x, sum_(k = 1)^n integral mu_(A_k) (x) space d x)
    $
  - In this method, the intersecting regions are calculated twice, which may cause some deflection from the result obtained using centroid method.

+ Center of highest area
  - In this method, only the membership function with the highest area, say $A_k$, is chosen. Its center is considered as $x^*$.
    $ x^* = frac(integral x dot mu_(A_k) (x) space d x, integral mu_(A_k) (x) space d x) $

+ First (or last) of maxima
  - In this method, the first element, say $x_alpha$, or the last element, say $x_omega$, is chosen as $x^*$.
    $
      x_alpha & = "min"({x | mu_A (x) = h(x)}) \
      x_omega & = "max"({x | mu_A (x) = h(x)})
    $
