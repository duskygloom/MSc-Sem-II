#set list(marker: ("#", "%", "-"))
#set page(number-align: right, numbering: "1")

#align(center, [
  = Fuzzy Logic
])

#v(2em)

== Classic logic
- In classical (binary) logic, a proposition can be either true or false. We may say that the truth value of a proposition $P$, $T(P)$, is a function which maps to either true (1) or false (0).
  $ T(P) -> {0, 1} $
- Alternatively, we can think of propositions as a set $X$ within a universe $U$.
  $ T: X subset.eq U -> {0, 1} $

=== Logical connectives

#table(
  columns: (8em, 8em, 1fr),
  table.header([*Connective*], [*Expression*], [*Simplified*]),
  [Conjunction], $A and B$, [Logical AND],
  [Disjunction], $A or B$, [Logical OR],
  [Negation], $not A$, [Logical NOT],
  [Implication], $A -> B$, [If A is true, B cannot be false, i.e. $not A or B$],
  [Equivalence], $A <-> B$, [$A -> B and B -> A$],
)

=== Sets and logic

- Consider two sets $A$ and $B$ defined on universe $X$. We can define two propositions $P$ and $Q$ such that:
  $
    P & : x in A \
    Q & : x in B
  $
- In terms of truth value:
  $
    T(P) & = cases(
             1 #h(2em) & "if" x in A,
             0 #h(2em) & "if" x in.not A
           ) \
    T(Q) & = cases(
             1 #h(2em) & "if" x in B,
             0 #h(2em) & "if" x in.not B
           )
  $
- Note that $T(P) = chi_A (x)$.

- Using logical connectives
  #table(
    columns: (8em, 1fr),
    [Conjunction], $ T(P and Q) = "min"(T(P), T(Q)) $,
    [Disjunction], $ T(P and Q) = "max"(T(P), T(Q)) $,
    [Negation], $ T(not P) = 1 - T(P) $,
    [Implication], $ T(P -> Q) = T(not P) or T(Q) $,
    [Equivalence], $ T(P <-> Q) = T(P) = T(Q) $,
  )


=== Compound proposition

- If proposition $P$ and $Q$ are defined on sets $A$ and $B$ respectively ($A$ and $B$ have universe $X$ and $Y$ respectively), then IF $A$, THEN $B$ or $P -> Q$ can be denoted by the relation:
  $ R = (A times B) union (overline(A) times Y) $

- Similarly, IF $A$, THEN $B$, ELSE $C$, where $C$ is also defined on universe $Y$, can be denoted by the relation:
  $ R = (A times B) union (overline(A) times C) $

#v(1em)

== Tautology
- Tautologies are compound propositions which are always true.
- Some common tautologies
  $ A union overline(A) <-> X $
  $ A union X; overline(A) union X <-> X $
  $
                        (A and (A -> B)) -> B & #h(4em) "(modus ponens)" \
    (overline(B) and (A -> B)) -> overline(A) & #h(4em) "(modus tollens)"
  $

=== Proof of modus ponens
$
  & (A and (A -> B)) -> B \
  & not(A and (A -> B)) or B                 &     #h(4em) "(implication)" \
  & not A or not(A -> B) or B                & #h(4em) "(de Morgan's law)" \
  & not A or not(not A or B) or B            &     #h(4em) "(implication)" \
  & not A or (A and not B) or B              & #h(4em) "(de Morgan's law)" \
  & ((not A or A) and (not A or not B)) or B &  #h(4em) "(distributivity)" \
  & ("true" and (not A or not B)) or B       &  #h(4em) "(domination law)" \
  & (not A or not B) or B                    &  #h(4em) "(domination law)" \
  & not A or (not B or B)                    &   #h(4em) "(associativity)" \
  & not A or "true"                          &  #h(4em) "(domination law)" \
  & "true"                                   &  #h(4em) "(domination law)"
$

=== Proof of modus tollens
$
  & (not B and (A -> B)) -> not A \
  & not(not B and (A -> B)) or not A     &     #h(4em) "(implication)" \
  & B or not(A -> B) or not A            & #h(4em) "(de Morgan's law)" \
  & B or not(not A or B) or not A        &     #h(4em) "(implication)" \
  & B or (A and not B) or not A          & #h(4em) "(de Morgan's law)" \
  & ((B or A) and (B or not B)) or not A &  #h(4em) "(distributivity)" \
  & ((B or A) and "true") or not A       &  #h(4em) "(domination law)" \
  & (B or A) or not A                    &  #h(4em) "(domination law)" \
  & B or (A or not A)                    &  #h(4em) "(distributivity)" \
  & B or "true"                          &  #h(4em) "(domination law)" \
  & "true"                               &  #h(4em) "(domination law)"
$

#v(1em)

== Contradiction
- A contradiction is a proposition which is always false.
- E.g. $A inter overline(A)$, $A inter phi.alt$, $overline(A) inter phi.alt$, etc.

#v(1em)

== Fuzzy logic
- Fuzzy logic deals with multivalued logic.
- A fuzzy logic proposition, $P$, is a statement without clearly defined boundaries.
- The truth value, $T(P)$, maps to any real value from $[0, 1]$.
  $ T: X subset.eq U -> [0, 1] $
- Fuzzy propositions are associated to fuzzy sets.
  $
    & P: x in A \
    & => T(P) = mu_A (x) | 0 <= mu_A (x) <= 1
  $

#v(1em)

== Approximate reasoning
- Approximate reasoning is used to infer information from imprecise propositions.
- It is an extension of predicate calculus. Predicate calculus reasons using precise propositions, where as approximate reasoning is suitable even for vague and half truths.
- If we are given a fuzzy linguistic proposition of the form $"IF" A "THEN" B$, then we can find the relation between $A$ and $B$, with their universe of discourse $X$ and $Y$ respectively, similar to how we did in the case of classical logic:
  $ R = (A times B) union (overline(A) times Y) $
  After that, if we are given a new set of antecedents $A'$, then we can find the new set of consequences $B'$ by using composition:
  $ B' = A' circle R $
