import UIKit

var greeting = "Hello, playground"

//!default function parameters

func printTimesTables(for number: Int, end: Int = 12) { //sets 12 to default end
    for i in 1...end {
        print("\(i) x \(number) is \(i*number)")
    }
}
printTimesTables(for: 5)

//!errors

//telling swift of possible errors
enum PasswordError: Error {
    case short, obvious //2 possible errors exist but doesn't define what they mean
}

//writing function that can flag the errors
func checkPassword(_ password: String) throws -> String { //mark function as throws if it might throw an error
    if password.count < 5 {
        throw PasswordError.short //throws the error and exits function
    }
    
    if password == "12345" {
        throw PasswordError.obvious
    }
    
    if password.count < 8 {
        return "ok"
    } else if password.count < 10 {
        return "good"
    } else {
        return "excellent"
    }
}

//calling the function and handling errors
let string = "12345"

do {
    let result = try checkPassword(string)
    print("password rating: \(result)") //if checkPassword works correctly, it returns a value into result to print
} catch PasswordError.short {
    print("use longer password")
} catch PasswordError.obvious {
    print("too obvious")
} catch {
    print("there was an error") //if there is an error, it will go to the catch blocks
}

//try must be written before calling any functions that might throw errors
//try must be inside a do block and you need at least one catch block to handle errors
//try! does not require do and catch but will crash when an error is thrown

//!checkpoint 4
enum numError: Error {
    case out, noRoot
}

func checkSqrt(_ num: Int) throws -> String {
    if num>=1 && num<=10_000 {
        for i in 1...100 {
            if i*i == num {
                return String(i)
            }
        }
        throw numError.noRoot
    } else {
        throw numError.out
    }
}

let num = 2000000

do {
    let result = try checkSqrt(num)
    print(result)
} catch numError.out {
    print("out of bounds")
} catch numError.noRoot {
    print("no root")
}
