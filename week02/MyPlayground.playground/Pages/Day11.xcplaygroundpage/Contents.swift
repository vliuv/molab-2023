//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!limit access to internal data using access control

struct BankAccount {
    private var funds = 0 //add private so you can't access funds outside the struct

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("withdrew money successfully")
} else {
    print("failed to get the money")
}

//private - nothing outside struct can access
//fileprivate - nothing outside current file can access
//public - anyone anywhere can use
//private(set) - anyone can read it but can't write it

//!static properties and methods

struct School {
    static var studentCount = 0 //static makes the property/method belong to the struct rather than instances

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "taylor swift") //adding student directly to the struct
print(School.studentCount)

//self refers to current value of the struct, Self refers to the current type

//why use static properties
//to check/display shared values in multiple places
struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

//to create examples of structs, good for sample data to preview how it displays
struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfederighi", password: "hairforceone")
}

//!checkpoint 6
struct Car {
    let model: String
    let seats: Int
    private(set) var currentGear: Int
    
    mutating func changeGear(direction: String) {
        if direction == "up" {
            if currentGear == 10 {
                print("highest gear already")
            } else {
                currentGear += 1
                print(currentGear)
            }
        } else if direction == "down" {
            if currentGear == 1 {
                print("lowest gear already")
            } else {
                currentGear -= 1
                print(currentGear)
            }
        } else {
            print("invalid")
        }
    }
}

var myCar = Car(model: "model", seats: 4, currentGear: 1)
myCar.changeGear(direction: "down")
myCar.changeGear(direction: "up")
myCar.changeGear(direction: "hello")

//: [Next](@next)
