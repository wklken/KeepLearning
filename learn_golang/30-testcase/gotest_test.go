package gotest

import (
	"testing"
)

func Test_Division_1(t *testing.T) {
	if i, e := Division(6, 2); i != 3 || e != nil {
		t.Error("Divison test fail")
	} else {
		t.Log("Divsion test pass")
	}
}

func Test_Division_2(t *testing.T) {
	t.Error("Test 2 fail")
}

// go test
// go test -v
