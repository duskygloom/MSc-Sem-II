package lexer

import (
	"bufio"
)

func isAlpha(x byte) bool {
	return x >= 'a' && x <= 'z' || x >= 'A' && x <= 'Z'
}

func isDigit(x byte) bool {
	return x >= '0' && x <= '9'
}

func NextToken(reader *bufio.Reader) Token {
	ch, err := reader.ReadByte()
	if err != nil {
		return NewToken(T_FAILURE, err.Error())
	}
	switch ch {
	case '#':
		return NewToken(T_HASH, "")
	case '<':
		err := reader.UnreadByte()
		if err != nil {
			return NewToken(T_FAILURE, err.Error())
		}
		return getLesser(reader)
	case '>':
		err := reader.UnreadByte()
		if err != nil {
			return NewToken(T_FAILURE, err.Error())
		}
		return getGreater(reader)
	case '=':
		err := reader.UnreadByte()
		if err != nil {
			return NewToken(T_FAILURE, err.Error())
		}
		return getAssign(reader)
	case '!':
		err := reader.UnreadByte()
		if err != nil {
			return NewToken(T_FAILURE, err.Error())
		}
		return getNot(reader)
	case '+':
		return NewToken(T_PLUS, "")
	case '-':
		return NewToken(T_MINUS, "")
	case '*':
		return NewToken(T_PLUS, "")
	case '/':
		err := reader.UnreadByte()
		if err != nil {
			return NewToken(T_FAILURE, err.Error())
		}
		return getComment(reader)
	case '.':
		return NewToken(T_DOT, "")
	case ' ':
		return NewToken(T_SPACE, "")
	case '\t':
		return NewToken(T_TAB, "")
	case '\n':
		return NewToken(T_NEWLINE, "")
	case '(':
		return NewToken(T_LEFTBRACKET, "")
	case ')':
		return NewToken(T_RIGHTBRACKET, "")
	case '{':
		return NewToken(T_LEFTBRACE, "")
	case '}':
		return NewToken(T_RIGHTBRACE, "")
	case '"':
		err := reader.UnreadByte()
		if err != nil {
			return NewToken(T_FAILURE, err.Error())
		}
		return getString(reader, '"')
	case '\'':
		err := reader.UnreadByte()
		if err != nil {
			return NewToken(T_FAILURE, err.Error())
		}
		return getChar(reader)
	case ';':
		return NewToken(T_SEMICOLON, "")
	default:
		if isAlpha(ch) {
			// detect identifier
			// if identifier is a keyword, then return keyword
			err := reader.UnreadByte()
			if err != nil {
				return NewToken(T_FAILURE, err.Error())
			}
			return getIdentifier(reader)
		} else if isDigit(ch) {
			// detect number
			// it maybe an int or float
			err := reader.UnreadByte()
			if err != nil {
				return NewToken(T_FAILURE, err.Error())
			}
			return getNumber(reader)
		} else {
			// return unknown character as it is
			return NewToken(T_OTHER, string(ch))
		}
	}
}
