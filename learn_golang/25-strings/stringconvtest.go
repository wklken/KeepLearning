package main

import (
	"fmt"
	"strconv"
)

func main() {

	// Append , 转换并添加到现有字符串
	str := make([]byte, 0, 1000)

	str = strconv.AppendInt(str, 4567, 10)
	str = strconv.AppendBool(str, false)
	str = strconv.AppendQuote(str, "abcdefg")
	str = strconv.AppendQuoteRune(str, '单')

	fmt.Println(string(str))

	// Format 把其他类型转成字符串
	a := strconv.FormatBool(false)
	b := strconv.FormatFloat(123.23, 'g', 12, 64)
	c := strconv.FormatInt(1234, 10)
	d := strconv.FormatUint(12345, 10)
	e := strconv.Itoa(1023)

	fmt.Println(a, b, c, d, e)

	// Parse 把字符串转为其他类型

	a1, err := strconv.ParseBool("false")
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println(a1)
	}

	b1, err := strconv.ParseFloat("123.23", 64)

	c1, err := strconv.ParseInt("1234", 10, 64)

	d1, err := strconv.ParseUint("12345", 10, 64)

	fmt.Println(a1, b1, c1, d1)

}
