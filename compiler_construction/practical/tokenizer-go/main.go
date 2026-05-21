package main

import (
	"bufio"
	"compiler/lexer"
	"fmt"
	"os"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("you did not specify a source file")
		return
	}

	fpath := os.Args[1]
	fp, err := os.Open(fpath)
	if err != nil {
		fmt.Print("cannot open file: ")
		fmt.Println(fpath)
		return
	}
	defer fp.Close()

	reader := bufio.NewReader(fp)

	for true {
		t := lexer.NextToken(reader)
		fmt.Print(t.String() + " ")
		if t.Type == lexer.T_FAILURE {
			fmt.Println()
			return
		}
	}
}
