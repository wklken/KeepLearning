package main

import (
	"fmt"
	"strings"
)

func main() {

	// contains
	fmt.Println(strings.Contains("abcdefg", "abc"))
	fmt.Println(strings.Contains("abcdefg", "123"))

	// join
	s := []string{"hello", "world"}
	fmt.Println(strings.Join(s, ","))

	// index
	fmt.Println(strings.Index("abcdefg", "def"))
	fmt.Println(strings.Index("abcdefg", "123"))

	//Repeat
	fmt.Println(strings.Repeat("nana", 2))

	//replace
	fmt.Println(strings.Replace("oink oink oink", "oink", "moo", -1))

	//split
	fmt.Println(strings.Split("a, b, c", ","))

	//trim
	fmt.Println(strings.Trim("##abc## ", "# "))

	// fields

	fmt.Println(strings.Fields(" foo bar baz   "))

}
