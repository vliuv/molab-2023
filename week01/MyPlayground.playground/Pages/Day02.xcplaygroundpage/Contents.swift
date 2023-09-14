//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!booleans
let goodDogs = true
var gameOver = false

//operator ! - means not
var isAuthenticated = false
isAuthenticated = !isAuthenticated
print(isAuthenticated) //true

//toggle() - flips boolean value
gameOver.toggle()
print(gameOver) //change from false to true

//!joining strings

//+ to join
let firstPart = "hello, "
let secondPart = "world!"
let newGreeting = firstPart+secondPart

//string interpolation - efficiently create strings from strings, int, dec, and more
let name = "taylor"
let age = 26
//use backslash and put var/const in the parentheses
let message = "hello, my name is \(name) and I'm \(age) years old"
print(message)

let number = 11
var missionMessage = "apollo" + String(number) + "landed on the moon"
missionMessage = "apollo \(number) landed on the moon" //this is faster than above

print("5x5 is \(5*5)") //can put calculations in interpolation

//!checkpoint 1
let celsius = 25.0
let fahrenheit = celsius*9/5+32
print("c=\(celsius) f=\(fahrenheit)")

//: [Next](@next)
