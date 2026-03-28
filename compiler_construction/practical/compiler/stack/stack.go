package stack

type Stack[T any] struct {
	arr []T
}

func (self *Stack[T]) Push(c T) {
	self.arr = append(self.arr, c)
}

func (self *Stack[T]) Pop() T {
	n := len(self.arr)
	last := self.arr[n-1]
	self.arr = self.arr[:n-1]
	return last
}

func (self *Stack[T]) Peek() T {
	n := len(self.arr)
	return self.arr[n-1]
}

func (self Stack[T]) IsEmpty() bool {
	return len(self.arr) == 0
}

func (self Stack[T]) Length() int {
	return len(self.arr)
}
