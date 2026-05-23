package lexer

import (
	"bufio"
	"io"
)

func getAssign(reader *bufio.Reader) Token {
	t := Token{Type: T_ASSIGN}

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
			if ch == '=' {
				state = 1
			} else {
				err := reader.UnreadByte() // rollback
				if err != nil {
					return NewToken(T_FAILURE, err.Error())
				}
			}
		case 1:
			if ch == '=' {
				t.Type = T_EQUAL
				finalState = true
			} else {
				err := reader.UnreadByte() // rollback
				if err != nil {
					return NewToken(T_FAILURE, err.Error())
				}
				finalState = true
			}
		default:
			return NewToken(T_FAILURE, "reached an invalid state")
		}
	}

	return t
}
