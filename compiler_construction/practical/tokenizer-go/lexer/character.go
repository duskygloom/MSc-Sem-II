package lexer

import (
	"bufio"
	"io"
)

func getChar(reader *bufio.Reader) Token {
	t := Token{Type: T_CHAR}

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
			if ch == '\'' {
				t.lexeme.WriteByte('\'')
				state = 1
			} else {
				err := reader.UnreadByte() // rollback
				if err != nil {
					return NewToken(T_FAILURE, err.Error())
				}
				return NewToken(T_FAILURE, "char should start with '")
			}
		case 1:
			if ch == '\\' {
				t.lexeme.WriteByte('\\')
				state = 2
			} else {
				t.lexeme.WriteByte(ch)
				state = 3
			}
		case 2:
			t.lexeme.WriteByte(ch)
			state = 3
		case 3:
			if ch == '\'' {
				t.lexeme.WriteByte('\'')
				finalState = true // stop
			} else {
				return NewToken(T_FAILURE, "char should end with '")
			}
		default:
			return NewToken(T_FAILURE, "reached an invalid state")
		}
	}

	return t
}
