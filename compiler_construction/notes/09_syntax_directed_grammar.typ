#set page(numbering: "1", number-align: right)
#set list(marker: ("#", "-"))

#align(center)[
  #set par(leading: 1em, spacing: 1.2em)
  #text(size: 1.5em, weight: "bold", "Syntax-Directed Translation")\
  #text(
    size: 1.2em,
    weight: "semibold",
    datetime(day: 21, month: 4, year: 2026).display("[day] [month repr:long], [year]"),
  )
]
#line(length: 100%)
#v(2em)

== Attributes
#line()
- To translate a programming language construct, a compiler may need to keep track of many quantities besides the code generated for the construct. E.g. the compiler may need to know the type of the construct or the location of the first instruction in the target code or the number of instructions.
- We can define attributes associated with the constructs. An attribute may represent any quantity. E.g. a string, a type, a memory location, etc.
#v(1em)

== Semantic rules
#line()
- We associate information with programming language construct by attaching attributes to the grammar symbols representing the constructs. Values for attributes are computed by semantic rules (associated with the grammar productions).
- For example, an infix-to-postfix translator might have the following production and rule:
  #align(center, grid(
    rows: 2,
    row-gutter: 1em,
    columns: 2,
    column-gutter: 2em,
    [Production], [Semantic rule],
    [$ E -> E_1 + T $], [$ E."code" = E_1."code" || T."code" || + $],
  ))
  The production has two non-terminals, $E$ and $T$ (the subscript in $E_1$ is used to distinguish the $E$ in head from the $E$ in body). Both $E$ and $T$ have attribute $"code"$. The semantic rule specifies that the $"code"$ of $E$ can be formed by concatenating the $"code"$ of the $E$ in body, the $"code"$ of $T$ and $+$.
#v(1em)

== Syntax-directed definition
#line()
- This specifies the translation of a construct in terms of attributes associated with its syntactic components.
- It uses a context-free grammar to specify the syntactic structure of the input.
- With each grammar symbol, it associates a set of attributes and with each production, a set of semantic rules for computing the values of the attributes associated with the symbols appearing in that production.
- A parse tree showing the attribute values at each node is called *annotated*.
#v(1em)

=== Synthesized attributes
- An attribute is said to be synthesized if its values at a parse tree node is computed/determined from attribute values at the children of the node in the parse tree.

=== Inherent attributes
- An inherent attribute is one whose value is computed from the attribute values at the parent and/or siblings of that node.

=== Example

#v(1em)

== Dependency Graph
#line()
- If an attribute $b$ at a node in a parse tree depends on an attribute $c$, then the semantic rule for $b$ at that node must be evaluated after the semantic rule that defines $c$.
- The inter-dependencies among the inherited and synthesized attributes at the nodes in a parse tree can be depicted by a directed graph called a *dependency graph*.
- Example: Consider the production and a corresponding semantic rule:
$ E -> E_1 + E_2 $
$ E."val" = E_1."val" + E_2."val" $
$E."val"$ is synthesized from $E_1."val"$ and $E_2."val"$. Draw the dependency graph for the parse tree.

- The translation steps are:
  + Construct the parse tree by using the grammar.
  + Construct the dependency graph.
  + Obtain the evaluation order.
  + Evaluate the semantic rules for translation of the input string.
