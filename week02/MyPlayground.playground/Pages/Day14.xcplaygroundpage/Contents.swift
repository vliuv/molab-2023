//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!handle missing data with optionals
//optionals are data that might be present or not
//need to unwrap the optional in order to use it to see if there is a value in it

let opposites = [
    "mario": "wario",
    "luigi": "waluigi"
]

//if let - reads the optional value from the dict, if there is a string inside, it gets unwrapped and placed in marioOpposite
if let marioOpposite = opposites["mario"] {
    print("mario's opposite is \(marioOpposite)")
} else {
    print("optional empty")
}

//an optional Int, String, Array, Dict, etc. set to nil has no value
//any data type can be optional if needed

func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil
//if let unwrappedNumber = number {
//    print(square(number: unwrappedNumber))
//}

//it is common to unwrap optionals into a constant of the same name
if let number = number {
    print(square(number: number))
}
//shadowing - temporarily creating a second constant of the same name only available in the condition's body, inside here the Int is real, and outside the Int? is optional

//!unwrap optionals with guard

//guard let checks if there is a value inside an optional and will retrieve it and place into a constant
func printSquare(of number: Int?) {
    guard let number = number else {
        print("missing input")
        return
    }

    print("\(number) x \(number) is \(number * number)")
}

var myVar: Int? = 3

//if let unwrapped = myVar {
//    print("run if myVar has a value inside")
//}

//guard let unwrapped = myVar else {
//    print("run if myVar doesn't have a value inside")
//}

//if let runs its code if the opt has a value and guard let runs if the opt doesn't have a value
//guard provides ability to check if our program stat is what we expect, if not bail (like exit function)
//early return - check all function's inputs are valid when the function starts, if not then run code to exit

//if you use guard to check a function's inputs are valid, swift will make you return if the check fails, if it passes and the optional has a value inside, it can be used after guard code finishes

//use if let to unwrap opts so you can process, use guard let to make sure opts have something inside and exit otherwise

//!unwrap optionals with nil coalescing

let captains = [
    "enterprise": "picard",
    "voyager": "janeway",
    "defiant": "sisko"
]

//reads val from captains dict and try to unwrap, if value then will be stored in new, if not, then "N/A"
let new = captains["serenity"] ?? "N/A"

//using with randomElement() - returns a random item from array but returns opt because it might be called on an empty array
let tvShows = ["archer", "babylon 5", "ted lasso"]
let favorite = tvShows.randomElement() ?? "none"

//using with struct
struct Book {
    let title: String
    let author: String?
}

let book = Book(title: "beowulf", author: nil)
let author = book.author ?? "anonymous"
print(author)

//use when creating integer from a string
let input = ""
let number2 = Int(input) ?? 0
print(number2)

//use nil coalescing operator to provide a default value if an opt is missing

//!handle multiple optionals using optional chaining
//optional chaining is simplified syntax for reading optionals inside optionals

let names = ["arya", "bran", "robb", "sansa"]

let chosen = names.randomElement()?.uppercased() ?? "no one"
print("next in line: \(chosen)")
//if the optional has a value inside, unwrap it... then add more code after ?.
//this case - if we get a random element from array then uppercase it

//same struct as above
//struct Book {
//    let title: String
//    let author: String?
//}

var book2: Book? = nil
let author2 = book2?.author?.first?.uppercased() ?? "A"
print(author2)
//if we have a book and the book has an author and the author has a first letter then uppercase it and send back, otherwise send "A"

//!handle function failure with optionals

//if all you care about is if the function succeeded or failed, use optional try to have function return an opt value (nil)

enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("user: \(user)")
}
//getUser() will always throw a networkFailed for testing purposes
//try? makes getUser() return an opt string

//try? with nil coalescing - attempt to get the return value from the function, if fails then use default val instead

let user = (try? getUser(id: 23)) ?? "anonymous"
print(user)

//find try? used with guard let to exit the current function if try? returns nil, or with nil coalescing to attempt something or give a default value on failure, or when calling any throwing function without a return value when you don't care if it succeeds or not

//!checkpoint 9
//how to test for the empty array?

let numArray = [1,2,3,4,5]

func checkpoint(array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}

let res1 = checkpoint(array: numArray)
print(res1)

//: [Next](@next)
