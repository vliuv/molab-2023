//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!create and use closures

let sayHello = { (name: String) -> String in //in marks end of parameters and return type and the start of the body of the closure (the actual functionality)
    "hi \(name)"
}

//functions have types based on what params they receive and what they return back (the data types not the names)
func greetUser() {
    print("hi there")
}

var greetCopy: () -> Void = greetUser //accepts no params, return type is nothing (Void)

//sorted allows you to pass in a function to it - must take 2 params and return a bool

let team = ["gloria", "suzanne", "piper", "tiffany", "tasha"]
let sortedTeam = team.sorted()

//func captainFirstSorted(name1: String, name2: String) -> Bool {
//    if name1 == "suzanne" {
//        return true
//    } else if name2 == "suzanne" {
//        return false
//    }
//    return name1 < name2
//}

//let captainFirstTeam = team.sorted(by: captainFirstSorted)
//print(captainFirstTeam) //suzanne, then everyone alphabetical

let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "suzanne" {
        return true
    } else if name2 == "suzanne" {
        return false
    }
    return name1 < name2
})

print(captainFirstTeam)

//!trailing closures and shorthand syntax

//you can remove the data types of str and bool
//can remove the (by: )
//automatic param names, $0, $1..., remove in
let captainFirstTeam2 = team.sorted {
    if $0 == "suzanne" {
        return true
    } else if $1 == "suzanne" {
        return false
    }
    return $0 < $1
}

print(captainFirstTeam2)

//.filter tests everything in the array and sends back array with all matches
let tOnly = team.filter { $0.hasPrefix("t") }
print(tOnly)

//.map transforms everything in the array
let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

//!accept functions as parameters

//function makeArray, params: size & generator (function that takes no params and returns an int), makeArray returns an int array
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()
    
    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }
    
    return numbers
}

//rolling 20 sided die 50 times
let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

print(rolls)

//make function accept multiple function params
//how does this work?
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("about to start first")
    first()
    print("about to start second")
    second()
    print("about to start third")
    third()
    print("done")
}

doImportantWork {
    print("this is first work")
} second: {
    print("this is second work")
} third: {
    print("this is third work")
}

//!checkpoint 5
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

luckyNumbers.filter{!($0.isMultiple(of: 2))}.sorted().map{print($0, "is a lucky number")}


//: [Next](@next)
