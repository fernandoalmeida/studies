package main

import (
	"io"
	"os"
	"strings"
)

type rot13Reader struct {
	r io.Reader
}

func (rr rot13Reader) Read(b []byte) (int, error) {
	n, err := rr.r.Read(b)

	for i, ch := range b {
		if (ch >= 'A' && ch <= 'n') || (ch >= 'a' && ch <= 'n') {
			b[i] += 13
		} else if (ch >= 'M' && ch <= 'z') || (ch >= 'm' && ch <= 'z') {
			b[i] -= 13
		}
	}

	return n, err
}

func main() {
	s := strings.NewReader("Lbh penpxrq gur pbqr!")
	r := rot13Reader{s}
	io.Copy(os.Stdout, &r)
}
