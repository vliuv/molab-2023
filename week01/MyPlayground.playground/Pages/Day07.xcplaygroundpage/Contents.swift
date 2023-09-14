//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!reusing code with functions
func showWelcome() {
    print("welcome")
}

showWelcome() //the function's call site

func printTimesTables(number: Int, end: Int) { //parameters need specified data type
    for i in 1...end {
        print("\(i) x \(number) is \(i*number)")
    }
}

printTimesTables(number: 5, end: 20) //need to write the parameter names when called with arguments and in same order

//!return values

func identical(s1: String, s2: String) -> Bool { //specify data type being returned
    return s1.sorted() == s2.sorted() //can acutally remove "return" if code is one line
}

let test = identical(s1: "abc", s2: "cab")
print(test) //true

//sqrt() - sqrts a number
//return can also be used to force the function to exit

//!return multiple values

//tuples
func getUser() -> (first: String, last: String) {
//    (first: "taylor", last: "swift")
    ("taylor", "swift") //the above tuple can be written like this when you are using return
}

let user = getUser()
print("name: \(user.first) \(user.last)")

//tuples different from dictionaries because when u access value, swift knows there is something there, but dict don't so you have to provide a default value

let (first, last) = getUser()
print("name: \(user.first) \(user.last)")
//converts the tuple returned into two constants

let (first2, _) = getUser()
//use _ to ignore part of tuple

//tuples where elements don't have a name
func getUser2() -> (String, String) {
    ("taylor", "swift")
}

let user2 = getUser2()
print("name: \(user.0) \(user.1)") //can access elements by position

//!customize parameter labels

//using _
//when you don't want to have an external name for a parameter

func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO"
let result = isUppercase(string) //no need to put (string: string)

//using 2 names
//when one parameter name makes sense internally but a different one does externally

func printTimesTables(for number: Int){
    for i in 1...12 {
        print("\(i) x \(number) is \(i*number)")
    }
}

printTimesTables(for: 5)
//external name is for, and internal name is number, the type is int

//: [Next](@next)
