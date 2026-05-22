package lexer

import (
	"bufio"
	"io"
)

/* A BASE AUTOMATA FUNCTION
 * COPY THIS TO CREATE NEW AUTOMATA
 * DONT USE DIRECTLY
 */
func getGeneric(reader *bufio.Reader) Token {
	t := Token{Type: T_FAILURE}

	state := 0
	finalState := false

	for !finalState {
		ch, err := reader.ReadByte()
		if err == io.EOF {
			reader.UnreadByte()
			finalState = true // end normally during EOF
		} else if err != nil {
			return NewToken(T_FAILURE, err.Error())
		}

		switch state {
		case 0:
			if ch == '$' {
				t.lexeme.WriteByte('$')
			} else {
				err := reader.UnreadByte() // rollback
				if err != nil {
					return NewToken(T_FAILURE, err.Error())
				}
			}
			finalState = true // stop
		default:
			return NewToken(T_FAILURE, "reached an invalid state")
		}
	}

	return t
}
