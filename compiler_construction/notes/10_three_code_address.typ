#set page(numbering: "1", number-align: right)
#set list(marker: ("#", "-"))

#align(center)[
  #set par(leading: 1em, spacing: 1.2em)
  #text(size: 1.5em, weight: "bold", "Intermediate Code Generation")\
  #text(
    size: 1.2em,
    weight: "semibold",
    datetime(day: 5, month: 5, year: 2026).display("[day] [month repr:long], [year]"),
  )
]
#line(length: 100%)
#v(2em)


== Three-address codes
#line()

- It is a sequence of statements of the general form
  $ x = y "op" z $
  where $x$, $y$ and $z$ are names, constants, or compiler generated temporaries and $"op"$ stands for any operator.
- Example: A source language expression like
  $ x + y * z $ might be translated into a sequence
  $
    t_1 & = y * z \
    t_2 & = x + t_1
  $
  where $t_1$ and $t_2$ are temporaries.
- Consider the assignment statement.
  $ a = b * -c + b * -c $
  #figure(caption: [Syntax tree], image("assets/syntax_tree.png", height: 20em))
  Three address code:
  #grid(
    rows: 3,
    row-gutter: 0.8em,
    columns: 2,
    column-gutter: 2em,
    [$t_1 = "minus" c$], [$t_2 = b * t_1$],
    [$t_3 = "minus" c$], [$t_4 = b * t_3$],
    [$t_5 = t_2 + t_4$], [$a & = t_5$],
  )
#v(1em)

== Some common three-address codes
#line()

+ Assignment statements of the form
  $ x = y "op" z $
  where $"op"$ is a binary operator.
+ Assignment instruction of the form
  $ x = "op" y $
  where $"op"$ is a unary operator.
+ Copy statements of the form
  $ x = y $
  where the value of $y$ is copied to $x$.
+ The unconditional jump
  $ "goto" L $
  The three-address statement with label $L$ is the next to be executed.
+ Conditional jumps such as
  $ "if" x "relop" y "goto" L $
+ Indexed assignments of the form
  $ x = y[i] $
  This statement sets $x$ to the value in the location $i$ units beyond location $y$.
  $ x[i] = y $
  This statement sets the location $i$ units beyond $x$ to $y$.
+ Address and pointer assignements of the form
  $ x = \& y $
  This statement stores the location of $y$ in $x$. (There is a distinction between the meaning of identifiers on the left and right sides of an assignment. In each of the assignments, $i = 5$ and $i = i+1$, the right side specifies an integer value while the left side specifies where the value is to be stored. The term _r-value_ are what we usually think as values while _l-values_ are locations.)
  $ x = *y $
  In this statement, presumably $y$ is a pointer or a temporary whose _r-value_ is a location. The _r-value_ of $x$ is made equal to the contents of the location.
  $ *x = y $
  This statement sets the _r-value_ of the object pointed to by $x$ to the _r-value_ of $y$.
#v(1em)

== Implementation of three-address codes
#line()

=== Quadruples
- A _quadruple_ is a record structure with four fields which are called $"op"$, $"arg"_1$, $"arg"_2$ and $"result"$.
- The three address statement, $ x = y(z) $ is represented by replacing $y$ in $"arg"_1$, $z$ in $"arg"_2$ and $x$ in result.
- Statements with unary expressions like $x = -y$ or $x = y$ do not use $"arg"_2$.
- The quadruples for the assignment $ a = b * -c + b * -c $ are:
  #align(center, figure(image("assets/quadruple.png", height: 6cm), caption: [Quadruple structure]))

=== Triples
- Here three-address statements can be represented by records with only three fields $"op"$, $"arg"_1$ and $"arg"_2$.
- The fields $"arg"_1$ and $"arg"_2$ for the argument of $"op"$ are either pointers to the symbol table (for program defined names or constants) or pointers into the triple structure (for temporary values).
- Parenthesized numbers represent pointers into the triple structures while symbol table pointers are represented by the names itself.
- #align(center, figure(image("assets/triple.png", height: 6cm), caption: [Triple structure]))

=== Indirect triples
- Another implementation of three-address code that has been considered is that of listing pointers to triples rather than listing the triples themselves.
- Example: Let us use an array _statements_ to list pointers to triples in the desired order.
#v(1em)

Translate the following expression:
$ a * -(b + c) $
into a syntax table, three-address code and quadruple.
