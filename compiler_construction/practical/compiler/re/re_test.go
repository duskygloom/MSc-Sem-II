package re

import (
	"fmt"
	"testing"
)

func TestConcat(t *testing.T) {
	x := []string{"", "0", "alex", "(a|b)*abb", "(a|b)*aba*(a|ba)*", "(a|b)*(aba)*(a|ba)*"}
	y := []string{"", "0", "a.l.e.x", "(a|b)*.a.b.b", "(a|b)*.a.b.a*.(a|b.a)*", "(a|b)*.(a.b.a)*.(a|b.a)*"}
	for i := range x {
		concated := concatedExpr(x[i])
		if concated != y[i] {
			t.Errorf("expected %s for %s, found %s", y[i], x[i], concated)
		}
	}
}

func TestPostfix(t *testing.T) {
	x := []string{"", "0", "a.l.e.x", "(a|b)*.a.b.b", "(a|b)*.a.b.a*.(a|b.a)*", "(a|b)*.(a.b.a)*.(a|b.a)*"}
	y := []string{"", "0", "al.e.x.", "ab|*a.b.b.", "ab|*a.b.a*.aba.|*.", "ab|*ab.a.*.aba.|*."}
	for i := range x {
		postfix := infixToPostfix(x[i])
		if postfix != y[i] {
			t.Errorf("expected %s for %s, found %s", y[i], x[i], postfix)
		}
	}
}

func TestParsing(t *testing.T) {
	x := []string{"", "a", "abba", "(a|b)*abb", "(a|b)*aba*(a|ba)*", "(a|b)*(aba)*(a|ba)*"}
	for i := range x {
		root, err := parseRE(x[i], []byte{'a', 'b'})
		if err != nil {
			t.Errorf("encountered %v when parsing %s", err, x[i])
		} else {
			fmt.Printf("%s: %s\n", x[i], root.string())
		}
	}
}
