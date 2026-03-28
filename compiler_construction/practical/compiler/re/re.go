package re

type RE struct {
	expr string
}

func NewRE(expression string) RE {
	return RE{expr: expression}
}
