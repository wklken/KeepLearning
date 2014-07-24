package main

import (
	"fmt"
	"regexp"
)

/*

是否匹配

func Match(pattern string, b []byte) (mached bool, err error)

func MatchReader(pattern string, r io.RuneReader) (matched bool, err error)

func MatchString(pattern string, s string) (matched bool, err error)

------------------

解析正则表达式,

func Compile(expr string) (*Regexp, error)

func CompilePOSIX(expr string) (*Regexp, error)

func MustCompile(str string) *Regexp

func MustCompilePOSIX(str string) *Regexp

-----------------

替换

Replace*


查找

Find*


http://golang.org/pkg/regexp/



*/

func main() {

	if m, _ := regexp.Match("^[0-9]+$", []byte("123")); m {
		fmt.Println("数字")
	} else {
		fmt.Println("not 数字")
	}

	re, _ := regexp.Compile("[0-9]+")
	src := "hello 123 world 456"
	src = re.ReplaceAllString(src, "")
	fmt.Println(src)

}
