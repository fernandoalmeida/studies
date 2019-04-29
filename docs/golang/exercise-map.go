package main

import (
	"golang.org/x/tour/wc"
	"strings"
)

func WordCount(s string) map[string]int {
	words := strings.Fields(s)
	m := map[string]int{}

	for _, w := range words {
		n, exists := m[w]

		if exists {
			m[w] = n + 1
		} else {
			m[w] = 1
		}
	}

	return m
}

func main() {
	wc.Test(WordCount)
}
