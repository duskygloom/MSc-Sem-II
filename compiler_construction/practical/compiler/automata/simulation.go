package automata

import (
	"compiler/stack"
	"slices"
)

func (m *Automata) AcceptString(s string) bool {
	currentState := m.q0
	for _, c := range s {
		if m.delta[] {

		}
	}
}

func (m *Automata) epsilonClosure(states []state_t) []state_t {
	closure := make([]state_t, len(states))

	var s stack.Stack[state_t]
	for _, v := range states {
		s.Push(v)
	}

	for s.IsEmpty() {
		t := s.Pop()
		if !slices.Contains(closure, t) {
			closure = append(closure, t)
			nextStates := m.delta[transtion_key_t{s: t, c: Epsilon}]
			for _, v := range nextStates {
				s.Push(v)
			}
		}
	}

	return closure
}

func (m *Automata) move(state state_t, c byte) []state_t {
	nextMove := make([]state_t, len(states))

	for _, state := range states {
		nextStates := m.delta[transtion_key_t{s: t, c: state}]
		for _, nextState := range nextStates {
			nextMove = append(nextMove, nextState)
		}
	}

	return nextMove
}
