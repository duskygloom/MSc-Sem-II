package re

import "fmt"

type node_type_t int

const (
	concat node_type_t = iota
	union
	star
	symbol
	empty
)

type node struct {
	ntype node_type_t
	value byte
	a, b  *node
}

func newConcatNode(a, b *node) *node {
	return &node{ntype: concat, value: '.', a: a, b: b}
}

func newUnionNode(a, b *node) *node {
	return &node{ntype: union, value: '|', a: a, b: b}
}

func newStarNode(a *node) *node {
	return &node{ntype: star, value: '*', a: a}
}

func newSymbolNode(c byte) *node {
	return &node{ntype: symbol, value: c}
}

func newEmptyNode() *node {
	return &node{ntype: empty}
}

func (n node) string() string {
	s := ""
	switch n.ntype {
	case empty:
		s += ""
	case symbol:
		s += string(n.value)
	case star:
		child := n.a.string()
		s += fmt.Sprintf("%c -> [%s]", n.value, child)
	default:
		child := n.a.string() + ", " + n.b.string()
		s += fmt.Sprintf("%c -> [%s]", n.value, child)
	}
	return s
}
