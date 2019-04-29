package main

import "golang.org/x/tour/pic"

func Pic(dx, dy int) [][]uint8 {
	s := make([][]uint8, dy)

	for i := 0; i < dy; i++ {
		s[i] = make([]uint8, dx)
	}

	return s
}

func main() {
	pic.Show(Pic)
}
