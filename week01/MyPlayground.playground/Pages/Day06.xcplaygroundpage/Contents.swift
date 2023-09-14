//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!for loops
for i in 1...12 {
    print("5 x \(i) is \(5*i)")
}

//ranges
//x...y - inclusive
//x..<y - not y inclusive

//replacing loop variable with _ if you don't use it

var lyric = "haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric)

//!while loops

//random(in:) - sends a random int or double in the range
let id = Int.random(in: 1...1000)

var roll = 0

while roll != 20 {
    roll = Int.random(in:1...20)
    print(roll)
}

print("critical hit")

//break & continue
//break skips all remaining iterations
//continue skips current iteration

let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }
    print("found picture \(filename)")
}

//!checkpoint 3
for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("fizzbuzz")
    } else if i.isMultiple(of: 3) {
        print("fizz")
    } else if i.isMultiple(of: 5) {
        print("buzz")
    } else {
        print(i)
    }
}

//: [Next](@next)
