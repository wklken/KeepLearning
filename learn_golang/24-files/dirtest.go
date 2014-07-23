package main

import (
	"fmt"
	"os"
)

/*
目录操作

mkdir
func Mkdir(name string, perm FileMode) error

mkdir -p
func MkdirAll(path string, perm FileMode) error

rm
func Remove(name string) error

rm -rf
func RemoveAll(path string) error

*/

func main() {
	os.Mkdir("test", 0777)

	os.MkdirAll("test/t1/t2", 0777)

	err := os.Remove("test")
	if err != nil {
		fmt.Println(err)
	}

	os.RemoveAll("test")
}
