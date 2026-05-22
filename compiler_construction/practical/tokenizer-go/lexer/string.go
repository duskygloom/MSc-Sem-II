package lexer

import (
	"bufio"
	"io"
)

func getString(reader *bufio.Reader, delim byte) Token {
	t := Token{Type: T_STRING}

	state := 0
	finalState := false

	for !finalState {
		ch, err := reader.ReadByte()
		if err == io.EOF {
			finalState = true // end normally during EOF
		} else if err != nil {
			return NewToken(T_FAILURE, err.Error())
		}

		switch state {
		case 0:
			if ch == delim {
				t.lexeme.WriteByte(delim)
				state = 1
			} else {
				err := reader.UnreadByte() // rollback
				if err != nil {
					return NewToken(T_FAILURE, err.Error())
				}
				return NewToken(T_FAILURE, "string should start with delimeter: "+string(delim)) // failure
			}
		case 1:
			switch ch {
			case '\\':
				t.lexeme.WriteByte('\\')
				state = 2
			case delim:
				t.lexeme.WriteByte(delim)
				finalState = true // stop
			default:
				t.lexeme.WriteByte(ch)
			}
		case 2:
			t.lexeme.WriteByte(ch)
			state = 1
		default:
			return NewToken(T_FAILURE, "reached an invalid state")
		}
	}

	return t
}
