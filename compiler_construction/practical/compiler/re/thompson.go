package re

import (
	"compiler/automata"
	"compiler/stack"
	"fmt"
	"slices"
)

func AutomataFromRe(expression string, symbols []byte) (*automata.Automata, error) {
	if expression == "" {
		return automata.NewAutomataWithSymbol(symbols, automata.Epsilon), nil
	}

	postfix := infixToPostfix(concatedExpr(expression))
	var s stack.Stack[*automata.Automata]

	for _, c := range postfix {
		switch c {
		case '.':
			if s.Length() < 2 {
				return nil, exprError
			}
			b := s.Pop()
			a := s.Pop()
			automata.Concat(a, b)
		case '|':
			if s.Length() < 2 {
				return nil, exprError
			}
			b := s.Pop()
			a := s.Pop()
			automata.Union(a, b)
		case '*':
			if s.Length() < 1 {
				return nil, exprError
			}
			a := s.Pop()
			automata.Star(a)
		default:
			if slices.Contains(symbols, byte(c)) {
				s.Push(automata.NewAutomataWithSymbol(symbols, byte(c)))
			} else {
				return nil, fmt.Errorf("unknown symbol: %c", c)
			}
		}
	}

	if s.Length() != 1 {
		return nil, exprError
	}
	return s.Pop(), nil
}
