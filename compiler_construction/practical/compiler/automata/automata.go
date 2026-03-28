package automata

import (
	"strings"
)

type state_t int

type transtion_key_t struct {
	s state_t
	c byte
}

type transition_t map[transtion_key_t][]state_t

const Epsilon byte = 0

type Automata struct {
	nq    int
	sigma []byte
	delta transition_t
	q0    state_t
	f     []state_t
}

func NewAutomata(numStates int, symbols []byte, transition transition_t, initial state_t, final []state_t) *Automata {
	return &Automata{nq: numStates, sigma: symbols, delta: transition, q0: initial, f: final}
}

func NewAutomataWithSymbol(symbols []byte, symbol byte) *Automata {
	transitions := make(transition_t, 1)
	transitions[transtion_key_t{s: 0, c: symbol}] = []state_t{state_t(1)}
	return &Automata{nq: 2, sigma: symbols, delta: transitions, q0: state_t(0), f: []state_t{state_t(1)}}
}

func (m *Automata) String() string {
	var s strings.Builder
	if len(m.sigma) > 0 {
		s.WriteByte(m.sigma[0])
		for i := 1; i < len(m.sigma); i++ {
			s.WriteString(", ")
			s.WriteByte(m.sigma[i])
		}
	}
	return "Automata[" + s.String() + "]"
}
