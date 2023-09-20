//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//!creating classes
//like structs - can add properties and methods, property observers and access control, create custom initializers
//diff from structs - you can build a class on functionality in another class gaining all properties and methods as a starting point (then selectively override if needed), need to write an initializer or assign default values to properties, when you copy an instance, they share the same data, you can run a deinitializer when the final copy of an instance is destroyed, you can still change properties even if you make a class constant

class Game {
    var score = 0 {
        didSet {
            print("score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

//!how to make one class inherit from another

class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("i work \(hours) hours a day")
    }
}

class Developer: Employee {
    func work() {
        print("i'm writing code for \(hours) hours")
    }
    
    override func printSummary() { //overrides the parent class function
        print("i'm a developer who works \(hours) hours a day")
    }
}

let robert = Developer(hours: 8)
robert.work()
robert.printSummary()

//!adding initializers
//if a child class has custom inits they must call the parent's after they finish setting their own properties

class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric //assigning parameter to the property of the same name
    }
}

class Car: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric) //need to ask super class to run its own initializer
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)

//!how to copy classes

//any changes to one copy of class will change the other copies
class User {
    var username = "anonymous"
}

var user1 = User()
var user2 = user1
user2.username = "taylor" //both user1 and 2 will be taylor

//creating unique copy of class (deep copy)
class User2 {
    var username = "anonymous"

    func copy() -> User2 {
        let user = User2()
        user.username = username
        return user
    }
}

//then can call copy() to get an object with the same starting data but changes won't affect the original

//!create deinitializer for a class
//deinitializers can't take params or return, are automatically called when final copy of class instance is destroyed (like if it was made in a function that is now finishing), never called directly,

//if you create a var in a func, if, or for loop, they can't be accessed outside, so when a value exits scope it means the context it was created in is going away

class User3 {
    let id: Int

    init(id: Int) {
        self.id = id
        print("user \(id): i'm alive!")
    }

    deinit {
        print("user \(id): i'm dead!")
    }
}

for i in 1...3 {
    let user = User3(id: i)
    print("user \(user.id): i'm in control!")
}
//create and destroy instances of User3 in a loop, when you create User3 inside, it is destroyed when the loop is finished, each user is being created then destroyed before another is created

var users = [User3]()

for i in 1...3 {
    let user = User3(id: i)
    print("user \(user.id): I'm in control!")
    users.append(user)
}

print("loop is finished!")
users.removeAll()
print("array is clear!")

//adding User3 instances as they are created, only destroyed when array is cleared

//!working with variables inside classes

class User4 {
    var name = "paul"
}

var user = User4()
user.name = "taylor"
user = User4()
print(user.name)

//would print paul because even though the name of the user was changed to taylor, we overwrote the user object with a new one, resetting it to paul

//constant instance & property - points to same user always, always has same name
//constant instance, var property - points to same user, but name can change
//var instance, const prop - can point to dif users, but names never change
//var instance & prop (like above) - can point to dif users, and names can change

//!checkpoint 7

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("bark")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    func speak() {
        print("meow")
    }
}

class Corgi: Dog {
    override func speak() {
        print("corgi bark")
    }
}

class Poodle: Dog {
    override func speak() {
        print("poodle bark")
    }
}

class Persian: Cat {
    override func speak() {
        print("persian meow")
    }
}

class Lion: Cat {
    override func speak() {
        print("lion meow")
    }
}

let dog1 = Corgi(legs:4)
dog1.speak()

let dog2 = Poodle(legs:4)
dog2.speak()

let cat1 = Persian(legs:4, isTame: true)
cat1.speak()

let cat2 = Lion(legs:4, isTame: false)
cat2.speak()

//: [Next](@next)
