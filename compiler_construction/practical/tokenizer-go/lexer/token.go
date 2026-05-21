package lexer

import "strings"

type TokenType int

const (
	T_IDEN TokenType = iota
	T_INT
	T_FLOAT

	T_HASH
	T_LESSER
	T_GREATER
	T_PLUS
	T_MINUS
	T_STAR
	T_SLASH

	T_DOT
	T_LEFTBRACKET
	T_RIGHTBRACKET
	T_LEFTBRACE
	T_RIGHTBRACE
	T_DBLQUOTE
	T_SNGLQUOTE

	T_SPACE
	T_TAB
	T_NEWLINE

	T_OTHER
	T_CHAR
	T_STRING
	T_COMMENT
	T_EOF
	T_FAILURE
)

var tokenValues = []string{
	"IDENTIFIER",
	"INTEGER",
	"FLOAT",

	"HASH",
	"LESSER",
	"GREATER",
	"PLUS",
	"MINUS",
	"STAR",
	"SLASH",

	"DOT",
	"LEFTBRACKET",
	"RIGHTBRACKET",
	"LEFTBRACE",
	"RIGHTBRACE",
	"DBLQUOTE",
	"SNGLQUOTE",

	"SPACE",
	"TAB",
	"NEWLINE",

	"OTHER",
	"CHAR",
	"STRING",
	"COMMENT",
	"EOF",
	"FAILURE",
}

type Token struct {
	Type   TokenType
	lexeme strings.Builder
}

func NewToken(tokType TokenType, lexeme string) Token {
	t := Token{Type: tokType}
	t.lexeme.WriteString(lexeme)
	return t
}

func (t Token) Lexeme() string {
	return t.lexeme.String()
}

func (t Token) String() string {
	s := tokenValues[t.Type]
	if t.lexeme.Len() == 0 {
		return s
	} else {
		return tokenValues[t.Type] + "(" + t.Lexeme() + ")"
	}
}
