import UIKit

var greeting = "Hello, playground"

//!variables & constants

//variable
var name = "ted"
name = "rebecca" //change variable, don't use var again or else error

//constant - can't change
let character = "daphne"
//character = "eloise" will not work

//print
var playerName = "roy"
print(playerName)

//!strings

//strings
let actor = "denzel washington"
let filename = "paris.jpg"
let result = "⭐️ you win! ⭐️" //can include emojis
let quote = "\"hello\"" //escape quotation inside string with backslash

let movie = """
a day in
the life of an
apple engineer
""" //use triple quotes for multi line string

//.count
print(actor.count) //will print 17, length of string
let nameLength = actor.count

//uppercased()
print(result.uppercased()) //uppercases the string

//hasPrefix() - if string starts with
print(movie.hasPrefix("a day")) //prints true

//hasSuffix() - if string ends with
print(filename.hasSuffix(".jpg")) //prints true

//!whole numbers

//integer
let score = 10
let reallyBig = 100_000_000 //can use underscores to break up big numbers

//operators
let lowerScore = score - 2 //can use operators like -+*/ to make ints from ints
var counter = 10

counter = counter + 5
counter += 5 //shorthand
print(counter) //20

//isMultiple(of:) - if int is a multiple of another
let number = 120
print(number.isMultiple(of: 3))
print(120.isMultiple(of: 3)) //both true

//!decimals

//double - double-precision floating-point number
//ints (100% accurate) can't be mixed with decimals unless specified

let a = 1
let b = 2.0
//let c = a+b - error
let c = a + Int(b)
//or
let d = Double(a) + b

//once you assign a variable a data type, you can't hold a different data type

var rating = 5.0
rating *= 2 //can use same range of operators for decimals as integers
