//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!structs
struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print("\(title) (\(year) by \(artist)")
    }
}
//creates new type: Album, with 2 str and 1 int consts

let red = Album(title: "red", artist: "taylor swift", year: 2012)

print(red.title)
red.printSummary()

//if you want to create
struct Employee {
    let name: String
    var vacationRemain: Int
    
    mutating func takeVacation(days: Int) {
        if vacationRemain > days {
            vacationRemain -= days
            print(vacationRemain)
        } else {
            print("no more")
        }
    }
}
//use "mutating" to allow changes for function

var archer = Employee(name: "sterling archer", vacationRemain: 14)
archer.takeVacation(days: 5)
print(archer.vacationRemain)

//!computing property values dynamically
struct Employee2 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int { //computed property, allows you to still store the acationAllocated
        get { //getter - code that reads
            vacationAllocated - vacationTaken
        }

        set { //setter - code that writes
            vacationAllocated = vacationTaken + newValue //newValue auto provided by swift
        } //makes it so that if you change the vacationRemaining, it changes the vacationAllocated not the vacationTaken
    }
}

var archer2 = Employee2(name: "sterling archer", vacationAllocated: 14)
archer2.vacationTaken += 4
archer2.vacationRemaining = 5 //now can modify vacationRemaining
print(archer2.vacationAllocated)

//!property changes

//property observers - code that runs when properties change
struct Game {
    var score = 0 {
        didSet { //each time the score changes, it will automatically print the new score
            print("score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3
game.score += 1

struct App {
    var contacts = [String]() {
        willSet { //runs before the property changes
            print("current value is: \(contacts)")
            print("new value will be: \(newValue)")
        }

        didSet { //runs after
            print("there are now \(contacts.count) contacts")
            print("old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("adrian e")
app.contacts.append("allen w")

//!custom initializers
struct Player {
    let name: String
    let number: Int

    init(name: String) {
        self.name = name //assign the name param to my name property
        number = Int.random(in: 1...99) //custom init doesn't have to work like the default swift way above, for example the number can be randomized
    }
}

let player = Player(name: "megan r")
print(player.number)

//: [Next](@next)
