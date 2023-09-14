//: [Previous](@previous)

import Foundation

func wall(_ length: Int) -> String {
    var wall = ""
    for _ in 1...length {
        wall += "="
    }
    return wall
}

func blank(_ length: Int) -> String {
    var blank = ""
    for _ in 1...length {
        blank += " "
    }
    return blank
}

func ghost1(_ ghosts: Int, _ spaces: Int) -> String {
    var ghost = blank(6)
    for _ in 1...ghosts {
        ghost += "  ____  " + blank(spaces)
    }
    return ghost
}

func ghost2(_ ghosts: Int, _ spaces: Int) -> String {
    var ghost = blank(6)
    for _ in 1...ghosts {
        ghost += " /    \\ " + blank(spaces)
    }
    return ghost
}

func ghost3(_ ghosts: Int, _ spaces: Int) -> String {
    var ghost = blank(6)
    for _ in 1...ghosts {
        ghost += "°  @ @ \"" + blank(spaces)
    }
    return ghost
}

func ghost4(_ ghosts: Int, _ spaces: Int) -> String {
    var ghost = blank(6)
    for _ in 1...ghosts {
        ghost += "|  ~~~ |" + blank(spaces)
    }
    return ghost
}

func ghost5(_ ghosts: Int, _ spaces: Int) -> String {
    var ghost = blank(6)
    for _ in 1...ghosts {
        ghost += "|      |" + blank(spaces)
    }
    return ghost
}

func ghost6(_ ghosts: Int, _ spaces: Int) -> String {
    var ghost = blank(6)
    for _ in 1...ghosts {
        ghost += "|/\\/\\/\\|" + blank(spaces)
    }
    return ghost
}

let space1 = blank(4)
let space2 = blank(6)
let space3 = blank(6)

let pelletS = blank(4)
let pellet1 = " ,, "
let pellet2 = "(  )"
let pellet3 = " '' "

let ghosts = 3
let spaces = 6

let wall = 91

print()
print(wall(wall))
print()

print(space1 + "  ,_-----_  " + space2 + pelletS + ghost1(ghosts, spaces))
print(space1 + " /         \\" + space2 + pelletS + ghost2(ghosts, spaces))
print(space1 + "/       _-' " + space2 + pellet1 + ghost3(ghosts, spaces) + pellet1 + space3 + pellet1)
print(space1 + "[      <    " + space2 + pellet2 + ghost4(ghosts, spaces) + pellet2 + space3 + pellet2)
print(space1 + "\\       '-_ " + space2 + pellet3 + ghost5(ghosts, spaces) + pellet3 + space3 + pellet3)
print(space1 + " \\         /" + space2 + pelletS + ghost6(ghosts, spaces))
print(space1 + "  \"-_____-° " + space2)

print()
print()
print(wall(wall))


//: [Next](@next)
