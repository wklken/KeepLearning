package main

import (
	"errors"
	"fmt"
)

/*

type error interface {
    Error() string
}


*/

func get_error() (int, error) {
	return 0, errors.New("test of errors new")
}

// 自定义error

type SyntaxError struct {
	msg    string
	Offset int64
}

func (e *SyntaxError) Error() string {
	return e.msg
}

func get_defined_error() SyntaxError {
	return SyntaxError{"Defined error", 100}
}

func main() {

	_, err := get_error()
	if err != nil {
		fmt.Println("error:", err)
	}

	err2 := get_defined_error()
	fmt.Println("error:", err2)
	fmt.Println("Offset:", err2.Offset)

}
