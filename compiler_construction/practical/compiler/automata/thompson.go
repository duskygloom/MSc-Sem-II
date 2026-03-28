package automata

import (
	"fmt"
	"maps"
)

func Concat(a, b *Automata) (*Automata, error) {
	if len(a.f) != 1 || len(b.f) != 1 {
		return nil, fmt.Errorf("multiple initial or final states found")
	}

	transitions := a.delta
	maps.Copy(transitions, b.delta)
	transitions[transtion_key_t{s: a.f[0], c: Epsilon}] = []state_t{b.q0}

	c := NewAutomata(a.nq+b.nq, a.sigma, transitions, a.q0, b.f)
	return c, nil
}

func Union(a, b *Automata) (*Automata, error) {
	if len(a.f) != 1 || len(b.f) != 1 {
		return nil, fmt.Errorf("multiple initial or final states found")
	}

	transitions := a.delta
	maps.Copy(transitions, b.delta)
	initial := state_t(a.nq + b.nq)
	final := state_t(a.nq + b.nq + 1)
	transitions[transtion_key_t{s: initial, c: Epsilon}] = []state_t{0, state_t(a.nq)}
	transitions[transtion_key_t{s: state_t(a.nq - 1), c: Epsilon}] = []state_t{final}
	transitions[transtion_key_t{s: state_t(a.nq + b.nq - 1), c: Epsilon}] = []state_t{final}

	c := NewAutomata(a.nq+b.nq+2, a.sigma, transitions, initial, []state_t{final})
	return c, nil
}

func Star(a *Automata) (*Automata, error) {
	if len(a.f) != 1 {
		return nil, fmt.Errorf("multiple initial or final states found")
	}

	transitions := a.delta
	initial := state_t(a.nq)
	final := state_t(a.nq + 1)
	transitions[transtion_key_t{s: initial, c: Epsilon}] = []state_t{0, final}
	transitions[transtion_key_t{s: state_t(a.nq - 1), c: Epsilon}] = []state_t{0}

	c := NewAutomata(a.nq+2, a.sigma, transitions, initial, []state_t{final})
	return c, nil
}
