package lexer

import (
	"bufio"
	"io"
)

func getIdentifier(reader *bufio.Reader) Token {
	t := Token{Type: T_IDEN}

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
			if ch == '_' || isAlpha(ch) {
				t.lexeme.WriteByte(ch)
				state = 1
			} else {
				err := reader.UnreadByte() // rollback
				if err != nil {
					return NewToken(T_FAILURE, err.Error())
				}
				return NewToken(T_FAILURE, "identifier should start with alphabet or underscore") // failure
			}
		case 1:
			if ch == '_' || isAlpha(ch) || isDigit(ch) {
				t.lexeme.WriteByte(ch)
			} else {
				err := reader.UnreadByte() // rollback
				if err != nil {
					return NewToken(T_FAILURE, err.Error())
				}
				finalState = true // stop
			}
		default:
			return NewToken(T_FAILURE, "reached an invalid state")
		}
	}

	return t
}
