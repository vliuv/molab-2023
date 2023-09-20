//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!create and use protocols
//protocols define a series of properties and methods we want to use like a blueprint

protocol Vehicle {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle { //tell swift Car conforms to Vehicle
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("i'm driving \(distance)km")
    }

    func openSunroof() { //you can add other methods not in the protocol, protocol only describes minimum functionality
        print("it's a nice day!")
    }
}
//all methods in Vehicle must exist exactly in Car

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("that's too slow")
    } else {
        vehicle.travel(distance: distance)
    }
}
//saying this function can be called with any type of data as long as that type conforms to Vehicle

let car = Car()
commute(distance: 100, using: car)

//!opaque return types
func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

//Equatable - protocol that means can be compared for equality
//opaque return types let us hide info in our code, focus on the functionality we want to return rather than the type, allows us to change our mind in the future and stops us from needing to write very long complex return types every time

//!create and use extensions
//extensions let us add functionality to any type

//trimmingCharacters(in:) - removes certain kinds of characters from start or end of string
//.whitespacesAndNewlines is built-in Foundation
extension String { //tell swift to add functionality to an existing type
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        self = self.trimmed() //change the string directly
    }
}

var quote = "   The truth is rarely pure and never simple   "
var quote2 = "   The truth is rarely pure and never simple   "
let trimmed = quote.trimmed()
quote2.trim()
print(trimmed, quote2)

//returning a new value rather than changing should use endings like ed, ing
//when you use extensions to add properties to types they must be computed not stored (otherwise that would affect the size of the data types)

//when you give a struct a custom initializer, the memberwise one is disabled, but if you want to have both you can put the custom initializer inside the extension to resolve this

//adding extension to a Book struct
//extension Book {
//    init(title: String, pageCount: Int) {
//        self.title = title
//        self.pageCount = pageCount
//        self.readingHours = pageCount / 50
//    }
//}

//!create and use protocol extensions

let guests = ["mario", "luigi", "peach"]

//instead of this
//if guests.isEmpty == false {
//    print("guest count: \(guests.count)")
//}

//use extension
extension Array { //if you wanted this to apply to sets and dicts you can change Array to Collection
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

if guests.isNotEmpty {
    print("guest count: \(guests.count)")
}

//!checkpoint 8

protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var agentName: String { get }
    func summary()
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var agentName: String
    func summary() {
        print("cost of a \(rooms) room house is \(cost) dollars, sold by \(agentName)")
    }
}

struct Office: Building {
    var rooms: Int
    var cost: Int
    var agentName: String
    func summary() {
        print("cost of a \(rooms) room office is \(cost) dollars, sold by \(agentName)")
    }
}

let house = House(rooms: 2, cost: 10, agentName: "bob")
house.summary()
let office = Office(rooms: 5, cost: 50, agentName: "me")
office.summary()

//: [Next](@next)
