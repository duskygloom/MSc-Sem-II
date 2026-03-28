package recognizer

import (
	"bufio"
)

func IsNumber(r *bufio.Reader) (bool, error) {
	c, err := r.ReadByte()
	if err != nil {
		return false, readerError
	}

	if isDigit(c) {
		for true {
			c, err = r.ReadByte()
			if err != nil {
				return false, readerError
			}

			if isDigit(c) {
				continue
			} else if isDelim(c) {
				return true, nil
			} else {
				return false, readerError
			}
		}
	}

	return false, readerError
}
