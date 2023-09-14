//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!checking conditions
let ourName = "dave lister"
let friendName = "arnold rimmer"

//alphabetically first is less than alphabetically last
if ourName < friendName {
    print(friendName)
}
if ourName > friendName {
    print(ourName)
}

var numbers = [1,2,3]
numbers.append(4)

if numbers.count > 3 {
    numbers.remove(at: 0)
}

print(numbers) //[2,3,4]

//check if string is empty
var username = "hello"

//string to string
if username == "" {
    username = "anonymous"
}

//integer comparison - fastern than above
if username.count == 0 {
    username = "anonymous"
}

//.isEmpty can apply to str, dict, sets
if username.isEmpty {
    username = "anonymous"
}

//!multiple conditions
//use if, else if, else
//&& and || or

enum TransportOption {
    case plane, helicopter, bike, car, scooter
}

let transport = TransportOption.plane

if transport == .plane || transport == .helicopter {
    print("fly")
}

//!switch statements
//- use to eliminate need for writing the same thing you are checking for repeatedly
//- prevents errors like forgeting to check one value or checking one twice
enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast = Weather.sun

switch forecast { //what value we want to check
case .sun: //case statements - vals to compare forecast to
    print("it should be a nice day")
case .rain:
    print("pack umbrella")
case .wind:
    print("wear something warm")
case .snow:
    print("school is cancelled")
case .unknown:
    print("broken!")
}

//switch statements must be exhaustive - all vals must be handled
//otherwise if needed, use a default case to run if no other cases match
//place default at the end

let place = "metropolis"

switch place {
case "gotham":
    print("batman")
case "mega-city one":
    print("judge dredd")
case "wakanda":
    print("black panther")
default:
    print("?")
} //prints ?

//swift will execute only the first case that matches the condition you're checking
//otherwise use fallthrough

let day = 5
print("my true love gave to me")

switch day {
case 5:
    print("5 golden rings")
    fallthrough
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 french hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("a partride in a pear tree")
} //prints all of them

//!ternary conditional operator
//+, -, ==, etc. are binary operators - work with 2 inputs like 2 + 5
//ternary operators work with 3 inputs

let age = 18
let canVote = age >= 18 ? "yes" : "no" //canVote will be set to "yes"
//what, true, false

let hour = 23
print(hour < 12 ? "before noon" : "after noon") //result not assigned anywhere

enum Theme {
    case light, dark
}

let theme = Theme.dark

let background = theme == .dark ? "black" : "white"
print(background) //black

//: [Next](@next)
