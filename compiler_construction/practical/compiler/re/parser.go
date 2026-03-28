package re

import (
	"compiler/stack"
	"fmt"
	"slices"
	"strings"
)

func isOperator(c byte) bool {
	return strings.ContainsRune("(.*|)", rune(c))
}

func concatedExpr(expression string) string {
	var s strings.Builder
	if len(expression) > 0 {
		s.WriteByte(expression[0])
	}
	for i := 1; i < len(expression); i++ {
		before, after := expression[i-1], expression[i]
		if !isOperator(before) && !isOperator(after) {
			s.WriteByte('.')
		} else if before == ')' && after == '(' {
			s.WriteByte('.')
		} else if before == '*' && after == '(' {
			s.WriteByte('.')
		} else if before == '*' && !isOperator(after) {
			s.WriteByte('.')
		} else if !isOperator(before) && after == '(' {
			s.WriteByte('.')
		} else if before == ')' && !isOperator(after) {
			s.WriteByte('.')
		}
		s.WriteByte(expression[i])
	}
	return s.String()
}

// returns -1 if not a valid operator
func precedenceOf(c byte) int {
	switch c {
	case '|':
		return 0
	case '.':
		return 1
	case '*':
		return 2
	default:
		return -1
	}
}

func infixToPostfix(expression string) string {
	var postfix strings.Builder
	var s stack.Stack[byte]
	for _, c := range expression {
		if !isOperator(byte(c)) {
			postfix.WriteByte(byte(c))
		} else if c == '(' {
			s.Push(byte(c))
		} else if c == ')' {
			for !s.IsEmpty() {
				top := s.Pop()
				if top == '(' {
					break
				} else {
					postfix.WriteByte(top)
				}
			}
		} else {
			// pop all operators of higher precedence
			for !s.IsEmpty() {
				top := s.Peek()
				if precedenceOf(top) < precedenceOf(byte(c)) {
					break
				} else {
					postfix.WriteByte(top)
					s.Pop()
				}
			}
			s.Push(byte(c)) // push the current operator
		}
	}
	// add remaining operators to postfix
	for !s.IsEmpty() {
		top := s.Pop()
		postfix.WriteByte(top)
	}
	return postfix.String()
}

func parseRE(expression string, symbols []byte) (*node, error) {
	if expression == "" {
		return newEmptyNode(), nil
	}

	concated := concatedExpr(expression)
	postfix := infixToPostfix(concated)

	var s stack.Stack[*node]

	for _, c := range postfix {
		switch c {
		case '.':
			if s.Length() < 2 {
				return nil, exprError
			}
			b := s.Pop()
			a := s.Pop()
			s.Push(newConcatNode(a, b))
		case '|':
			if s.Length() < 2 {
				return nil, exprError
			}
			b := s.Pop()
			a := s.Pop()
			s.Push(newUnionNode(a, b))
		case '*':
			if s.Length() < 1 {
				return nil, exprError
			}
			a := s.Pop()
			s.Push(newStarNode(a))
		default:
			if slices.Contains(symbols, byte(c)) {
				s.Push(newSymbolNode(byte(c)))
			} else {
				return nil, fmt.Errorf("unknown symbol: %c", byte(c))
			}
		}
	}

	if s.Length() != 1 {
		return nil, exprError
	}
	return s.Pop(), nil
}
