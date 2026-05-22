package lexer

import (
	"bufio"
	"io"
)

func getComment(reader *bufio.Reader) Token {
	t := Token{Type: T_COMMENT}

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
			if ch == '/' {
				t.lexeme.WriteByte('/')
				state = 1
			} else {
				err := reader.UnreadByte() // rollback
				if err != nil {
					return NewToken(T_FAILURE, err.Error())
				}
				return NewToken(T_FAILURE, "comment should start with /")
			}
		case 1:
			switch ch {
			case '/':
				t.lexeme.WriteByte('/')
				state = 2
			case '*':
				t.lexeme.WriteByte('*')
				state = 3
			default:
				err := reader.UnreadByte() // rollback
				if err != nil {
					return NewToken(T_FAILURE, err.Error())
				}
				t.Type = T_SLASH
				finalState = true // stop
			}
		case 2:
			if ch == '\n' {
				err := reader.UnreadByte() // rollback
				if err != nil {
					return NewToken(T_FAILURE, err.Error())
				}
				finalState = true // stop
			} else {
				t.lexeme.WriteByte(ch)
			}
		case 3:
			if ch == '*' {
				t.lexeme.WriteByte('*')
				state = 4
			} else {
				t.lexeme.WriteByte(ch)
			}
		case 4:
			if ch == '/' {
				t.lexeme.WriteByte('/')
				finalState = true // stop
			} else {
				t.lexeme.WriteByte(ch)
				state = 3
			}
		default:
			return NewToken(T_FAILURE, "reached an invalid state")
		}
	}

	return t
}
