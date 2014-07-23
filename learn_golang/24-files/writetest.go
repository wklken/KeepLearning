package main

import (
	"fmt"
	"os"
)

/*

创建文件

func Create(name string) (file *File, err Error)
默认权限0666, 可读写

func NewFile(fd uintptr, name string) *File


--------------

打开文件

func Open(name string) (file *File, err Error)
只读方式打开

func OpenFile(name string , flag int, perm uint32) (file *File, err Error)
flag是打开方式, perm权限

-------------

写文件

func (file *File) Write(b []byte) (n int, err Error)

func (file *File) WriteAt(b []byte, off int64) (n int, err Error)


func (file *File) WriteString(s string) (ret int, err Error)


*/

func main() {

	// 重复运行也都是最新的
	userFile := "test.txt"
	fout, err := os.Create(userFile)

	if err != nil {
		fmt.Println(userFile, err)
		return
	}

	defer fout.Close()

	for i := 0; i < 10; i++ {
		fout.WriteString("Just a test\r\n")
		fout.Write([]byte("Just a test2\r\n"))
	}

}
