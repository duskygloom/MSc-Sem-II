package recognizer

import (
	"bufio"
)

func IsIdentifier(r *bufio.Reader) (bool, error) {
	c, err := r.ReadByte()
	if err != nil {
		return false, readerError
	}

	if isLetter(c) || c == '_' {
		for true {
			c, err = r.ReadByte()
			if err != nil {
				return false, readerError
			}

			if isLetter(c) || isDigit(c) || c == '_' {
				continue
			} else if isDelim(c) {
				return true, nil
			} else {
				return false, nil
			}
		}
	}

	return false, nil
}
