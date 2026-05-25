#set page(numbering: "1", number-align: right)
#set list(marker: ("#", "-"))

#align(center)[
  #set par(leading: 1em, spacing: 1.2em)
  #text(size: 1.5em, weight: "bold", "Bottom-Up Parsing")\
  #text(
    size: 1.2em,
    weight: "semibold",
    datetime(day: 26, month: 3, year: 2026).display("[day] [month repr:long], [year]"),
  )
]
#line(length: 100%)
#v(2em)

== Bottom-up parsing
#line()
- Our objective is to construct a parse tree for an input string beginning at the leaves (_bottom_) and working _up_ towards the root.
- At each reduction step, a particular substring matching the right side of a production is replaced by the symbol on the left of the production and if the substring is chosen correctly at each step, a right-most derivation is traced out in reverse.
- For example, consider a grammar with the following production rules:
  $ S & -> a A B c \
  A & -> A b c | b \
  B & -> d $,
  The bottom-up parsing for the input string $a b b c d e$ is
  $
    a b b c d c => a A b c d c => a A d c => a A B c => S
  $
#v(1em)

== Handle
#line()
- A handle of a right sentential form $gamma$ is a production $A -> beta$ and a position in $gamma$ where the string $beta$ may be found and replaced by $A$ to produce the previous right sentential form in a right-most derivation of $gamma$.
- For example, consider the following sentential forms:
  $ S =>^* alpha A w => alpha beta w $
  then $A -> beta$ and the position following $alpha$ is a handle of $alpha beta w$.
- In the previous example:
  $ a b b c d c => a A b c d c $
  a handle of $a b b c d c$ is the production $A -> b$ at position 2.\
- Likewise, in the case of:
  $ a A b c d c => a A d c $
  a handle of $a A b c d c$ is the production $A -> A b c$ at position 2.
#v(1em)

== Handle pruning
#line()
- We start with the string of terminals $w$ that we wish to parse.
- If $w$ is a sentence of the grammar at hand, then $w = gamma_n$ where $gamma_n$ is the $n^"th"$ right sentential form of some as yet unknown right-most derivation.
  $ S = gamma_0 => gamma_1 => gamma_2 ... => gamma_n = w $
- To reconstruct this derivation in reverse order, we locate the handle $beta_n$ in $gamma_n$ and replace $beta_n$ with the left side of some production $A_n -> beta_n$ to obtain the $n-1^"th"$ right sentential form $gamma_(n-1)$.
- We then repeat this procedure and if by continuing this we produce a right sentential form consisting only of the start symbol $S$, then we halt and announce successful completion of parsing. The reverse of the sequence of productions used in the reduction is the right-most derivation of the input string.
- For example, consider a grammar with the following production rules:
  $
    E & -> E + E \
    E & -> E * E \
    E & -> (E) \
    E & -> "id"
  $
  and the input string: $"id"_1 + "id"_2 * "id"_3$\
  #figure(
    table(
      columns: (1fr, 1fr, 1fr),
      table.header(
        align(center)[*Right sentential form*], align(center)[*Handle*], align(center)[*Reduction production*]
      ),
      [$"id"_1 + "id"_2 * "id"_3$], [$"id"_1$], [$E -> "id"$],
      [$E + "id"_2 * "id"_3$], [$"id"_2$], [$E -> "id"$],
      [$E + E * "id"_3$], [$"id"_3$], [$E -> "id"$],
      [$E + E * E$], [$E * E$], [$E -> E * E$],
      [$E + E$], [$E + E$], [$E -> E + E$],
      [$E$], [-], [-],
    ),
    caption: [Reductions made by shift-reduce parser],
  )
#v(1em)

== Stack implementation of shift-reducing parser
#line()
- A convenient way to implement a shift-reduce parser is to use a stack to hold grammar symbols and an input buffer to hold the string $w$ to be parsed (we use $\$$ to mark the top of the stack and the right-end marker).
  #figure(
    table(
      columns: (2fr, 1fr, 1fr),
      align: (left, left, right),
      table.header([], align(center)[*Stack*], align(center)[*Input*]),
      [Initially stack is empty and $w$ is in the input], [$\$$], [$w\$$],
      [Finally stack contains the start symbol], [$\$S$], [$\$$],
    ),
    caption: [State of shift-reduce parser],
  )
- There are four possible actions a shift-reduce parser can make:
  + _Shift_: Shift the next input symbol onto the top of the stack
  + _Reduce_: The right end of the string to be reduced must be at the top of the stack. Locate the left end of the string within the stack and decide with what non-terminal to replace the string.
  + _Accept_: Announce successful completion of the parsing.
  + _Error_: Discover a syntax error and call an error recovery routine.
  #figure(
    table(
      columns: (1fr, 1fr, 1fr),
      align: (left, right, left),
      table.header(align(center)[*Stack*], align(center)[*Input*], align(center)[*Action*]),
      [$\$$], [$"id"_1 + "id"_2 * "id"_3 \$$], [_Shift_],
      [$\$ "id"_1$], [$"" + "id"_2 * "id"_3 \$$], [_Reduce_ by $E -> "id"$],
      [$\$ E$], [$"" + "id"_2 * "id"_3 \$$], [_Shift_],
      [$\$ E +$], [$"id"_2 * "id"_3 \$$], [_Shift_],
      [$\$ E + "id"_2$], [$"" * "id"_3 \$$], [_Reduce_ by $E -> "id"$],
      [$\$ E + E$], [$"" * "id"_3 \$$], [_Shift_],
      [$\$ E + E *$], [$"id"_3 \$$], [_Shift_],
      [$\$ E + E * "id"_3$], [$\$$], [_Reduce_ by $E -> "id"$],
      [$\$ E + E * E$], [$\$$], [_Reduce_ by $E -> E * E$],
      [$\$ E + E$], [$\$$], [_Reduce_ by $E -> E + E$],
      [$\$ E$], [$\$$], [_Accept_],
    ),
    caption: [Shift-reduce table],
  )
#v(1em)

== LR($k$) parsing
#line()
- It is an efficient bottom-up parsing technique that can be used to parse a large class of context-free grammars.
- The _L_ is for left-right scanning of input.
- The _R_ is for constructing the right-most derivation in reverse.
- $k$ is for the number of input symbols of lookahead that are used in making parsing decisions. When ($k$) is omitted, it is assumed to be 1.

#v(1em)
== LR parser
#line()

#figure(
  image(height: 20em, "assets/lr_parser.png"),
  caption: [Structure of LR parser],
)
- The LR parser consists of an input, an output, a stack, a driver program and a parsing table which has two parts: _ACTION_ and _GOTO_
#v(1em)

== LR parsing algorithm
#line()
*Input:* An input string $w$ and an LR-parsing table with functions $"ACTION"$ and $"GOTO"$ for a grammar $G$.\
*Output:* If $w$ is in $L(G)$, the reduction steps of a bottom-up parse for $w$, otherwise an error.

*Method:* Initially, the parser has $s_0$ on its stack, where $s_0$ is the initial state, and $w\$$ in the input buffer.

let $a$ be the first symbol of $w\$$;\
while (1) {\
#h(1em) let $s$ be the state on top of the stack;\
#h(1em) if ($"ACTION"[s, a]$ = $"Shift" t$) {\
#h(2em) push $a$ and $t$ onto the stack;\
#h(1em) } else if ($"ACTION"[s, a]$ = $"Reduce" A -> beta$) {\
#h(2em) pop $2|beta|$ symbols off the stack;\
#h(2em) let state $t$ now be on top of the stack;\
#h(2em) push $A$ and $"GOTO"[t, A]$ onto the stack;\
#h(2em) output the production $A -> beta$;\
#h(1em) } else if ($"ACTION"[s, a]$ = $"Accept"$) break;\
#h(1em) else call error-recovery routine;\
}
#v(1em)

== Example 1
#line()
A grammar $G$ contains the following production rules:
$
  E & -> E + T #h(4em) & E & -> T \
  T & -> T * F #h(4em) & T & -> F \
  F & -> (E) #h(4em)   & F & -> "id"
$

#figure(
  table(
    columns: (1fr,) * 10,

    table.cell(
      rowspan: 2,
      align: center + horizon,
    )[*State*],

    table.cell(
      colspan: 6,
      align: center + horizon,
    )[*Action*],

    table.cell(
      colspan: 3,
      align: center + horizon,
    )[*Goto*],

    [id], [+], [\*], [(], [)], [\$], [$E$], [$T$], [$F$],

    [0], [$s_5$], [], [], [$s_4$], [], [], [1], [2], [3],
    [1], [], [$s_6$], [], [], [], [$"Accept"$], [], [], [],
    [2], [], [$r_2$], [$s_7$], [], [$r_2$], [$r_2$], [], [], [],
    [3], [], [$r_4$], [$r_4$], [], [$r_4$], [$r_4$], [], [], [],
    [4], [$s_5$], [], [], [$s_4$], [], [], [8], [2], [3],
    [5], [], [$r_6$], [$r_6$], [], [$r_6$], [$r_6$], [], [], [],
    [6], [$s_5$], [], [], [$s_4$], [], [], [9], [3], [],
    [7], [$s_5$], [], [], [$s_4$], [], [], [], [], [10],
    [8], [], [$s_6$], [], [], [$s_11$], [], [], [], [],
    [9], [], [$r_1$], [$s_7$], [], [$r_1$], [$r_1$], [], [], [],
    [10], [], [$r_3$], [$r_3$], [], [$r_3$], [$r_3$], [], [], [],
    [11], [], [$r_5$], [$r_5$], [], [$r_5$], [$r_5$], [], [], [],
  ),
  caption: [Parsing table for $G$],
)

#figure(
  caption: [Moves of an LR parser on $"id" + "id" * "id"$],
  table(
    columns: (2em, 1fr, 1fr, 1fr),
    align: (center, left, right, left),
    table.header([], align(center, [*STACK*]), align(center, [*INPUT*]), align(center, [*ACTION*])),

    [1], [0], [$"id" + "id" * "id" \$$], [$"Shift"$],
    [2], [0 $"id"$ 5], [$"" + "id" * "id" \$$], [$"Reduce by" F -> "id"$],
    [3], [0 $F$ 3], [$"" + "id" * "id" \$$], [$"Reduce by" T -> F$],
    [4], [0 $T$ 2], [$"" + "id" * "id" \$$], [$"Reduce by" E -> T$],
    [5], [0 $E$ 1], [$"" + "id" * "id" \$$], [$"Shift"$],
    [6], [0 $E$ 1 $+$ 6], [$"id" * "id" \$$], [$"Shift"$],
    [7], [0 $E$ 1 $+$ 6 $"id"$ 5], [$"" * "id" \$$], [$"Reduce by" F -> "id"$],
    [8], [0 $E$ 1 $+$ 6 $F$ 3], [$"" * "id" \$$], [$"Reduce by" T -> F$],
    [9], [0 $E$ 1 $+$ 6 $T$ 9], [$"" * "id" \$$], [$"Shift"$],
    [10], [0 $E$ 1 $+$ 6 $T$ 9 $*$ 7], [$"id" \$$], [$"Shift"$],
    [11], [0 $E$ 1 $+$ 6 $T$ 9 $*$ 7 $"id"$ 5], [$\$$], [$"Reduce by" F -> "id"$],
    [12], [0 $E$ 1 $+$ 6 $T$ 9 $*$ 7 $F$ 10], [$\$$], [$"Reduce by" T -> T * F$],
    [13], [0 $E$ 1 $+$ 6 $T$ 9], [$\$$], [$"Reduce by" E -> E + T$],
    [14], [0 $E$ 1], [$\$$], [$"Accept"$],
  ),
)
