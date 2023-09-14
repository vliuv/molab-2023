//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!arrays

//arrays can only have one type of data
var beatles = ["john", "paul", "george", "ringo"]
print(beatles[0]) //john

//append()
beatles.append("adrian")

//specifying data type
var scores = Array<Int>() //specialized array type
scores.append(100)
scores.append(80)
print(scores[1]) //80

var albums = [String]() //special way to create array for strings instead of above
albums.append("folklore")

//.count can also be used
print(albums.count) //1

//remove(at:) - remove by position
var characters = ["lana", "pam", "ray", "sterling"]
characters.remove(at:2) //removes ray
print(characters)

//removeAll()
characters.removeAll()
print(characters.count) //0

//contains() - check for item in array
let bondMovies = ["casino royale", "spectre", "no time to die"]
print(bondMovies.contains("frozen")) //false

//sorted() - sorts in ascending order (alphabetical for strings), original array unchanged
//can be used on strings too
print(bondMovies.sorted()) //casino, no time, spectre

//reversed()
//can be used on strings too
print(bondMovies.reversed())

//!dictionaries
let employee2 = [
    "name": "taylor swift",
    "job": "singer",
    "location": "nashville"
]

//reading data with keys
//print(employee2["name"]) will give Optional("taylor swift") because the existence of data there is optional-might be there or not

//instead, provide default value to use if key doesn't exist
print(employee2["name", default: "unknown"]) //taylor swift

//starting w empty dict
var heights = [String: Int]() //need to specify type for key and values
heights["yao ming"] = 229
heights["shaquille o'neal"] = 216

//no duplicate keys, if you do it will overwrite
var archEnemies = [String: String]()
archEnemies["batman"] = "the joker"
archEnemies["batman"] = "penguin"

//.count & removeAll() work for dictionaries

//!sets - like arrays but no duplicate items allowed and no order

//from fixed data, array put into set - will remove duplicates and lose order (stores in optimized order)
let people = Set(["denzel washington", "tom cruise", "nicolas cage", "samuel l jackson"])

//starting empty set
//insert() - add to set
var newPeople = Set<String>()
newPeople.insert("denzel washington")

//contains() and .count work for sets
//sorted() will return an array

//!enums - set of named values
enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

//this prevents you from accidentally typing in the weekday wrong or typing something else
var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday

//another easier way to make and use enums
enum newWeekday {
    case monday, tuesday, wednesday, thursday, friday
}

var newDay = newWeekday.monday
day = .tuesday
day = .friday

//enums are also stored in optimized form

//: [Next](@next)
