package main

import "golang.org/x/tour/reader"

type MyReader struct{}

func (r MyReader) Read(b []byte) (int, error) {
	n := len(b)

	for i := 0; i < n; i++ {
		b[i] = 'A'
	}

	return n, nil
}

func main() {
	reader.Validate(MyReader{})
}
