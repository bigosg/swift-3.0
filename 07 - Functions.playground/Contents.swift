//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/****** 函数的定义与调用 ******/
func sayHello(personName: String) -> String {
    let greeting = "Hello, " + personName + "!"
    return greeting
}

print(sayHello("Anna"))

func sayHelloAgain(personName: String) -> String {
    return "Hello again, " + personName + "!"
}

print(sayHelloAgain("Anna"))

/****** 函数参数与返回值 ******/
// 无参函数
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// prints "hello, world"

// 多参数函数
func sayHello(personName: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return sayHelloAgain(personName)
    } else {
        return sayHello(personName)
    }
}
print(sayHello("Tim", alreadyGreeted: true))


// 无返回值函数

// 严格上来说，虽然没有返回值被定义，sayGoodbye(_:) 函数依然返回了值。没有定义返回类型的函数会返回特殊的值，叫 Void。它其实是一个空的元组（tuple），没有任何元素，可以写成()。
func sayGoodbye(personName: String) {
    print("Goodbye, \(personName)!")
}
sayGoodbye("Dave")
// prints "Goodbye, Dave!"

// 多重返回值函数
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[1]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax([8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")


// 可选元组返回类型
/* 如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的（Optional） 元组返回类型反映整个元组可以是nil的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如(Int, Int)?或(String, Int, Bool)?
  可选元组类型如(Int, Int)?与元组包含可选类型如(Int?, Int?)是不同的.可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值。

 */

func minMax1(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    
    return (currentMin, currentMax)
}


if let bounds1 = minMax1([8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds1.min) and max is \(bounds1.max)")
}
// prints "min is -6 and max is 109"


/****** 函数参数名称 ******/

/*
  函数参数都有一个外部参数名（external parameter name）和一个局部参数名（local parameter name）。外部参数名用于在函数调用时标注传递给函数的参数，局部参数名在函数的实现内部使用。

 func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // function body goes here
    // firstParameterName and secondParameterName refer to
    // the argument values for the first and second parameters
 }

 一般情况下，第一个参数省略其外部参数名，第二个以及随后的参数使用其局部参数名作为外部参数名。所有参数必须有独一无二的局部参数名。尽管多个参数可以有相同的外部参数名，但不同的外部参数名能让你的代码更有可读性。
 someFunction(1, secondParameterName: 2)
*/

// 指定外部参数名
// 你可以在局部参数名前指定外部参数名，中间以空格分隔, 如果你提供了外部参数名，那么函数在被调用时，必须使用外部参数名。

/*
 func someFunction(externalParameterName localParameterName: Int) {
    // function body goes here, and can use localParameterName
    // to refer to the argument value for that parameter
 }
 */
func sayHello(to person: String, and anotherPerson: String) -> String {
    return "Hello \(person) and \(anotherPerson)"
}

print(sayHello(to: "Bill", and: "Ted"))


//忽略外部参数名

// 如果你不想为第二个及后续的参数设置外部参数名，用一个下划线（_）代替一个明确的参数名。
func someFuction(firstParameterName: Int, _ secondParameterName: Int) {
    print("\(firstParameterName) + \(secondParameterName)")
}

someFuction(1, 2)

// 默认参数值
func somFunction(parameterWithDefault: Int = 12) {
    print("\(parameterWithDefault)")
}

//somFunction(6)
somFunction()

// 可变参数

// 一个函数最多只能有一个可变参数。 如果函数有一个或多个带默认值的参数，而且还有一个可变参数，那么把可变参数放在参数表的最后。
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

arithmeticMean(1, 2, 3, 4, 5)

arithmeticMean(3, 8.25, 18.75)


// 常量参数和变量参数

/*
 函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。这意味着你不能错误地更改参数值。

 但是，有时候，如果函数中有传入参数的变量值副本将是很有用的。你可以通过指定一个或多个参数为变量参数，从而避免自己在函数中定义新的变量。变量参数不是常量，你可以在函数中把它当做新的可修改副本来使用。

 通过在参数名前加关键字 var 来定义变量参数：

 对变量参数所进行的修改在函数调用结束后便消失了，并且对于函数体外是不可见的。变量参数仅仅存在于函数调用的生命周期中。
 */
func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
    let amountToPad = totalLength - string.characters.count
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    return string
}

let originalString = "hello"
let paddedString = alignRight(originalString, totalLength: 10, pad: "-")


// 输入输出参数

/*
变量参数，正如上面所述，仅仅能在函数体内被更改。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。

定义一个输入输出参数时，在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。想获取更多的关于输入输出参数的细节和相关的编译器优化，请查看输入输出参数一节。

你只能传递变量给输入输出参数。你不能传入常量或者字面量（literal value），因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加&符，表示这个值可以被函数修改。

输入输出参数不能有默认值，而且可变参数不能用 inout 标记。如果你用 inout 标记一个参数，这个参数不能被 var 或者 let 标记。

 */


// 输入输出参数和返回值是不一样的。上面的 swapTwoInts 函数并没有定义任何返回值，但仍然修改了 someInt 和 anotherInt 的值。输入输出参数是函数对函数体外产生影响的另一种方式。
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swap(&someInt, &anotherInt)

print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")


func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, _ b: Int) -> Int {
    return a * b
}


/****** 函数类型 ******/

// 使用函数类型

/*
 这个可以解读为：

 “定义一个叫做 mathFunction 的变量，类型是‘一个有两个 Int 型的参数并返回一个 Int 型的值的函数’，并让这个新变量指向 addTwoInts 函数”。

 addTwoInts 和 mathFunction 有同样的类型，所以这个赋值过程在 Swift 类型检查中是允许的。
 */
var mathFunction: (Int, Int) -> Int = multiplyTwoInts

print("Result: \(mathFunction(2,3))")


// 函数类型作为参数类型
/*
  你可以用(Int, Int) -> Int这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函数的调用者来提供。
 */


/*
这个例子定义了 printMathResult(_:_:_:) 函数，它有三个参数：第一个参数叫 mathFunction，类型是(Int, Int) -> Int，你可以传入任何这种类型的函数；第二个和第三个参数叫 a 和 b，它们的类型都是 Int，这两个值作为已给出的函数的输入值。

当 printMathResult(_:_:_:) 被调用时，它被传入 addTwoInts 函数和整数3和5。它用传入3和5调用 addTwoInts，并输出结果：8。
 */
func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

//printMathResult(addTwoInts, 3, 5)

printMathResult(multiplyTwoInts, 3, 5)


// 函数类型作为返回类型
/*
  你可以用函数类型作为另一个函数的返回类型。你需要做的是在返回箭头（->）后写一个完整的函数类型。
 */

func stepForward(input: Int) -> Int {
    return input + 1
}

func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward :stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)

print("Counting to zero")
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}

print("zero!")


/****** 嵌套函数 ******/

/*
 这章中你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。你也可以把函数定义在别的函数体中，称作嵌套函数（nested functions）。

 默认情况下，嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。

 */

func chooseStepFunction1(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int {return input + 1}
    func stepBackward(input: Int) -> Int {return input - 1}
    return backwards ? stepBackward : stepForward
}

var currentValue1 = -4
let moveNearerToZero1 = chooseStepFunction1(currentValue1 > 0)

while currentValue1 != 0 {
    print("\(currentValue1)... ")
    currentValue1 = moveNearerToZero1(currentValue1)
}

print("zero")






















