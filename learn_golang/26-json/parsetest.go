package main

import (
	"encoding/json"
	"fmt"
)

/*

解析json

func Unmarshal(data []byte, v interface{}) error


*/

type Server struct {
	ServerName string
	ServerIP   string
}

type Serverslice struct {
	Servers []Server
}

func main() {

	// 1. 解析到结构体, 知道具体结构的情况下
	var s Serverslice

	str := `{"servers": [{"serverName": "S_VPN", "serverIP": "127.0.0.1"}, {"serverName": "B_VPN", "serverIP": "127.0.0.2"}]}`

	// 过程: 1. 找Tag含Foo的 -> 2.找字段名是Foo的 -> 3.找类似FoO/FoO等大小不敏感的到处字段
	json.Unmarshal([]byte(str), &s)

	fmt.Println(s)

	// 2. 解析到interface, 不知道被解析的数据格式

	b := []byte(`{"Name": "Wed", "Age": 6, "Parents": ["Gomez", "Morticia"]}`)

	var f interface{}

	err := json.Unmarshal(b, &f)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Println(f)

	// 通过断言方式
	m := f.(map[string]interface{})
	for k, v := range m {
		switch vv := v.(type) {
		case string:
			fmt.Println(k, "is string", vv)
		case int:
			fmt.Println(k, "is int", vv)
		case []interface{}:
			fmt.Println(k, "is an array")
			for i, u := range vv {
				fmt.Println(i, u)
			}
		default:
			fmt.Println(k, "is of a type I dont't know", vv)
		}
	}

}
