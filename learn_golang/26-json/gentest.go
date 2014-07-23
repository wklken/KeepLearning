package main

/*

输出JSON数据串

func Marshal(v interface{}) ([]byte, error)

只有在转换成功的时候才会返回书uju
key是string
channel.complex,function不能被编码
嵌套数据不能被编码
指针在编码时会返回指向内容, 空指针输出nil

*/

import (
	"encoding/json"
	"fmt"
)

type Server struct {
	UID        int    //默认会使用字段名
	ID         int    `json:"-"`                  //不输出
	ServerName string `json:"serverName",string`  //输出时转为string
	ServerIP   string `json:"serverIP",omitempty` //为空不输出
}

type Serverslice struct {
	Servers []Server `json:"servers"`
}

func main() {

	var s Serverslice

	s.Servers = append(s.Servers, Server{1, 1001, "B_VPN", "127.0.0.1"})
	s.Servers = append(s.Servers, Server{2, 1002, "S_VPN", ""})

	b, err := json.Marshal(s)
	if err != nil {
		fmt.Println("json err:", err)
	}

	fmt.Println(string(b))

}
