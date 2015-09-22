//: Playground - noun: a place where people can play

import UIKit

//当嵌套值和引用类型的时候有四种不同的组合。只这其中的一种就会让你的生活很有趣。

//1   如果你有一个引用类型嵌套了另外一个引用类型，没有什么特别的事会发生。像通常那样，任何一个指向内部或者外部值的指针都能操纵他指向的对象。只要其中一个引用操纵值使其改变，其他引用指向的值也就跟着变了。
/*
class Inner {
    var value = 99
}
class Outter {
    var value = 99
    var inner = Inner()
    
}

var out1 = Outter()
var out2 = out1
out1.value = 100
out1.inner.value = 100

print("outer2.value=\(out2.value) outer2.inner.value=\(out2.inner.value)")
*/

// 2 如果你有一个值类型嵌套了另外一个值类型，这就会有效地使值所占的内存区域变大。内部值是外部值的一部分。如果你把外部值放到一块新的存储空间里，所有的值包括内部值都会被拷贝。如果你把内部值放进一块新的存储空间中，只有内部值会被拷贝。
/*
struct Inner {
  var   value = 99
}
struct Outter {
    var inner = Inner()
    var value = 99
    
}
var out1 = Outter()
var out2 = out1
out1.value = 100
out1.inner.value = 100


print("outer2.value=\(out2.value) outer2.inner.value=\(out2.inner.value)")
var out3 = Outter()
var innter = out3.inner
innter.value = 100
out3.value //99
out3.inner.value //99




*/
// 互相修改

//3 一个引用类型嵌套了一个值类型会有效扩大这个引用类型所占内存区域。任何指向外部值的指针都可以操纵一切，包括嵌套的内部值。内部值的任何改变对于引用外部值的指针来说都是可见的。如果你把内部值放进一块新的存储区，就会在那块存储区拷贝一份新的值。
/*
struct Inner {
    var value = 99
}
class Outter {
    var inner = Inner()
    var value = 99
}

var out1 = Outter()
var out2 = out1
out1.value = 100
out1.inner.value = 100

print("outer2.value=\(out2.value) outer2.inner.value=\(out2.inner.value)")
*/

//引用类型会扩大值类型的所占的内存空间   打印结果为 100 ， 100

// 4  一个值类型嵌套一个引用类型就没有那么简单了。你可以有效地打破值语义而不被察觉。这可能是好的也可能是坏的，取决于你怎么做。当你把一个引用类型嵌套进一个值类型中，外部值被放进一块新的内存区域时就会被拷贝，但是拷贝的对象仍然指向原始的那个嵌套对象。下面是一个举例：



class Inner{
    var value = 99
}
struct Outter {
    var inner = Inner()
    var value = 99
}

var out1 = Outter()
var out2 = out1
out1.value = 100
out1.inner.value = 100

print("outer2.value=\(out2.value) outer2.inner.value=\(out2.inner.value)")
//打印结果  99 100

//尽管outer2获取了value的一份拷贝，它只拷贝了inner的引用，因此两个结构体就共用了同一个inner对象。这样一来当改变outer.inner.value的值也会影响outer2.inner.value的值。哎呀！

//这个行为会很有用。当你小心使用，你创建的结构体就具有写时拷贝功能（只有当你执行outer2.value = 43时才会真正的产生一个副本，否则outer2与outer仍指向共同的资源），这种高效的值语义的实现不会使数据拷贝得到处都是。Swift 中的集合就是这么做的，你也可以自己创建一个这样的类型。想要了解更多请看Let’s Build Swift.Array.





//无论在什么时候你移动一个值类型他都会被拷贝，而引用类型则是产生了对同样的底层对象的一个新的引用。那也就意味着引用类型的改变对所有其他的引用都是可见的，而改变值类型只影响你改变的那块内存区域。当选择使用哪种类型时，考虑你的类型是否适合被拷贝，当类型从本质上来说是可拷贝时倾向使用值类型。最后，记住如果你在值类型中嵌入引用类型，不小心的话就会出错！



class Person {
    var value = 99

}
let p1 = Person()
let p2 = Person()
let p3 = Person()
let p4 = Person()
let p5 = Person()

var array1:Array<Person> = [p1,p2,p3,p4,p5]
var array2 = array1
array2.removeLast()
array2.first!.value = 100
print(array1.first!.value)















