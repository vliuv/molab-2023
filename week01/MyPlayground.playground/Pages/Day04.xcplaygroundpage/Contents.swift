//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//type annotations - allow you to be explicit about data types,
let surname: String = "lasso"
var score: Int = 0

//helpful in cases like this, otherwise swift would infer an int
var newScore: Double = 0

//arrays
var albums: [String] = ["red", "fearless"]

//dictionaries
var user: [String: String] = ["id": "@twostraws"]

//sets
var books: Set<String> = Set(["the bluest eye", "foundation"])

//using type annotation
var cities: [String] = []

//using type inferece
var clues = [String]()

//enums - values of an enum have the same type as the enum itself
enum UIStyle {
    case light, dark, system
}

var style = UIStyle.light
style = .dark //no need UIStyle because style must be some kind of UIStyle

//when to use
//when you don't have a constant value yet
let username: String
username = "twoStraws" //if this line didn't exist, error with no value for username
print(username)
//also can't set username again

//!checkpoint 2
let myStringsA = ["a", "b", "c", "a"]
print(myStringsA.count)
let myStringsS = Set(myStringsA)
print(myStringsS.count)

//: [Next](@next)
