package main

import (
	"bufio"
	"compiler/re"
	"compiler/recognizer"
	"fmt"
	"os"
)

func main() {
	nfaMain()
}

func nfaMain() {
	symbols := []byte{'0', '1'}
	m, err := re.AutomataFromRe("0", symbols)
	if err != nil {
		fmt.Println(err.Error())
	} else {
		fmt.Println(m.String())
	}
}

func recognizerMain() {
	stdinReader := bufio.NewReader(os.Stdin)
	fmt.Print("Test identifier => ")
	isIden, err := recognizer.IsIdentifier(stdinReader)
	if err != nil {
		fmt.Println(err)
	} else if isIden {
		fmt.Println("It is an identifier!")
	} else {
		fmt.Println("It is not an identifier.")
	}

	stdinReader.Discard(stdinReader.Buffered())

	fmt.Print("Test number => ")
	isNum, err := recognizer.IsNumber(stdinReader)
	if err != nil {
		fmt.Println(err)
	} else if isNum {
		fmt.Println("It is a number!")
	} else {
		fmt.Println("It is not a number.")
	}
}
