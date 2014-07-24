package main

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"strings"
)

func sayhelloName(w http.ResponseWriter, r *http.Request) {
	r.ParseForm() //解析参数, 默认不解析的

	fmt.Println(r.Form) //参数信息
	fmt.Println("path", r.URL.Path)
	fmt.Println("scheme", r.URL.Scheme)

	fmt.Println(r.Form["url_long"])

	for k, v := range r.Form {
		fmt.Println("key:", k)
		fmt.Println("value", strings.Join(v, ""))
	}

	fmt.Fprintf(w, "Hello!")

}

func login(w http.ResponseWriter, r *http.Request) {

	fmt.Println("method:", r.Method)

	if r.Method == "GET" {
		t, _ := template.ParseFiles("login.gtpl")
		t.Execute(w, nil)
	} else {
		r.ParseForm()
		fmt.Println("username:", r.Form["username"])

		// r.Form.Get()
	}
}

func main() {

	http.HandleFunc("/", sayhelloName) //设置访问路由
	http.HandleFunc("/login", login)

	err := http.ListenAndServe(":9090", nil) //设置监听端口

	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}

	// http://localhost:9090/?url_long=111

}
