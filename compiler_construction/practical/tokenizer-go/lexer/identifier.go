package lexer

import (
	"bufio"
	"io"
	"slices"
)

/*
 * Data Types
 * int, char, float, double, void
 * Control Flow
 * if, else, switch, case, default, for, while, do, break, continue, goto
 * Storage Classes
 * auto, extern, register, static
 * Type Modifiers
 * signed, unsigned, short, long
 * User-defined Types
 * struct, union, enum, typedef
 * Others
 * const, volatile, return, sizeof
 */

var keywordsList = []string{
	// control flow
	"if", "else", "switch", "case", "default",
	"for", "while", "do", "break", "continue",
	"goto", "return",

	// data types
	"int", "char", "float", "double", "void",

	// type modifiers
	"signed", "unsigned", "short", "long",

	// user-defined structures
	"struct", "union", "enum", "typedef",

	// storage classes
	"auto", "extern", "register", "static",

	// others
	"const", "volatile", "sizeof",
}

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
				if slices.Contains(keywordsList, t.Lexeme()) {
					t.Type = T_KEYWORD
				}
				finalState = true // stop
			}
		default:
			return NewToken(T_FAILURE, "reached an invalid state")
		}
	}

	return t
}
