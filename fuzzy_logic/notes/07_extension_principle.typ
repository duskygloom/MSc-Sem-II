#set list(marker: ("#", "%", "-"))
#set page(number-align: right, numbering: "1")

#align(center, [
  = Extension Principle
])

#v(2em)

== Fuzzy vector
- Fuzzy vector is a vector containing fuzzy membership values.
- If there is a fuzzy set $A$ defined on universe of discourse $X = {x_1, x_2, ..., x_n}$, then fuzzy vector
  $
    bold(a) & = {mu_A (x_1), mu_A (x_2), ..., mu_A (x_n)} \
            & = {mu_A (x_i) | 1 <= i <= n}
  $

#v(1em)

== Functions of fuzzy sets
- Let us consider two fuzzy variables $A$ and $B$ defined on universe of discourse $X$ and $Y$ respectively, and a function $B = f(A)$.
  $ B = sum_(y in Y) ("max"_(y = f(x)) mu_A (x)) / y $
- Image set of $A$ can also be found by using composition if the relation $R(A, B)$ is given.
  $
    B = A circle R \
    "or" \
    bold(b) = bold(a) circle R
  $

#v(1em)

== Zadeh's extension principle
- In general, let us consider a function on input fuzzy variables $A_1, A_2, ..., A_n$ defined on universe of discourse $X_1, X_2, ..., X_n$ respectively, and with a single output variable $B$ defined on universe of discourse $Y$.
  $
    B = f(A_1, A_2, ..., A_n) \
    f: P(X_1 times X_2 times ... times X_n) -> P(Y)
  $
- The extension principle says that
  $ B = sum_(y in Y) ("max"_(y = f(x_1, x_2, ..., x_n)) "min"(mu_(A_1) (x_1), mu_(A_2) (x_2), ... mu_(A_n) (x_n))) / y $
  For continuous valued function, replace $"max"$ operation with supermum, $"sup"$.

#v(1em)

== Fuzzy transform

- In the case of $f: underline(A) -> underline(B)$, although the input and output are fuzzy, the function itself is crisp.
- The mapping of a crisp input into a fuzzy output is called fuzzy transform.
  $ underline(f): A -> underline(B) $
  Even if the input is crisp, the output will be fuzzy because the function itself is not crisp.
- If $X$ and $Y$ are finite, then a fuzzy transform $f$ can be represented as a fuzzy relation $R$, or in the form of a matrix:
  #align(center, image("assets/fuzzy_transform.png", height: 8em))
- For a single input $x_i$, the output will be $B_i = f(x_i)$
  $
    B_i = sum_(j = 1)^m (mu_R (i, j)) / y_j \
    "or"\
    bold(b_i) = {r_(i 1), r_(i 2), ..., r_(i m)}
  $
  Hence, the fuzzy image of the element $x_i$ is given by the $i^"th"$ row of the relation matrix $R$.
- To generalize further, let us consider that the input is also fuzzy, i.e. $underline(B) = underline(f)(underline(A))$. In this case, we can use the extension principle.
  $
    mu_B (y) = "max"_(x in X) ("min"(mu_A(x), mu_R (x, y)))\
    "or"\
    bold(b_j) = "max"_(i) ("min"(bold(a_i), r_(i j)) )
  $

#v(1em)

== One-to-one mapping
- If there is a one-to-one crisp mapping between $x subset.eq X$ and $y subset.eq Y$, then for two fuzzy sets $A$ and $B$ with universe of discourse $X$ and $Y$ respectively,
  $
    B = f(A) & = f((mu_A (x_1)) / x_1 + (mu_A (x_2)) / x_2 + ... + (mu_A (x_n)) / x_n ) \
             & = (mu_A (x_1)) / f(x_1) + (mu_A (x_2)) / f(x_2) + ... + (mu_A (x_n)) / f(x_n)
  $

#v(1em)

== Mapping of cartesian products
- Consider two universe of discourse $X$ and $Y$. We need to find $B = f(X, Y)$.
- If the mapping is one-to-one, then we can use a similar equation as in the case of one-to-one mapping between two sets.
  $ B = f(X times Y) = {"min"(x_i, y_j) / f(x_i, y_j) | forall space x_i in X, y_j in Y} $
- But, if the mapping is not one-to-one, then we have to use the extension principle.
  $ mu_B (z) = {"max"_(z = f(x_i, y_j)) "min"(mu_(X) (x_i), mu_(Y) (y_j)) | forall space x_i in X, y_j in Y} $
