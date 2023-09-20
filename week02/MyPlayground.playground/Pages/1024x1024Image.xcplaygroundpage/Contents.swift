//: [Previous](@previous)

import UIKit

//🌇 1024x1024 image

let sz = CGSize(width: 1024, height: 1024)
let renderer = UIGraphicsImageRenderer(size: sz)

let image = renderer.image { context in
    
    var rt = renderer.format.bounds

    //sunset gradient
    let repeatSz = 60.0
    let repeatDt = 40.0
    var font = UIFont.systemFont(ofSize: repeatSz)
    
    let length = 30
    var x = -50.0
    var y = -25.0
    
    let array = ["🔴","🍅","🍅","🥮","🏀","🧡","🟧","🟠","🟠","🔶","🩳","😍","🤗","😶","😶","🌞","🟨","🟡","🟡","💛","🌝","🌝","⭐","⭐"]
    
    for emoji in array {
        for _ in 1...length {
            var emojiD = NSAttributedString(string: emoji, attributes: [.font: font ])
            emojiD.draw(at: CGPoint(x: x, y: y))
            x += repeatDt
        }
        
        if x == -50.0+repeatDt*30 {
            x = -25.0
        } else {
            x = -50.0
        }
        
        y += repeatDt
    }
    
    //rays
    func ray (_ x: Double, _ y: Double, _ DtX: Double, _ DtY: Double, _ incX: Double, _ incY: Double) {
        let rayL = 10
        var raySz = 80.0
        
        var rayX = x
        var rayY = y
        var rayDtX = DtX
        var rayDtY = DtY
        
        for _ in 1...rayL {
            font = UIFont.systemFont(ofSize: raySz)
            var emojiD = NSAttributedString(string: "🌟", attributes: [.font: font ])
            emojiD.draw(at: CGPoint(x: rayX, y: rayY))
            
            rayDtX += incX
            rayDtY += incY
            rayX += rayDtX
            rayY += rayDtY
            
            raySz += 20
        }
    }

    ray(300, 360, -60, 20, -10, 5)
    ray(800, 360, 60, 20, 10, 5)
    ray(300, 180, -60, -20, -10, -5)
    ray(800, 180, 60, -20, 10, -5)
    ray(440, 500, -30, 40, -10, 10)
    ray(440, 10, -30, -40, -10, -10)
    ray(680, 10, 30, -40, 10, -10)
    
    //sun
    font = UIFont.systemFont(ofSize: rt.height * 0.50)
    let oCircle = NSAttributedString(string: "🟠", attributes: [.font: font ])
    oCircle.draw(at: CGPoint(x: 320, y: -10))
    
    font = UIFont.systemFont(ofSize: rt.height * 0.8)
    let sun = NSAttributedString(string: "☀️", attributes: [.font: font ])
    sun.draw(at: CGPoint(x: 160, y: -200))
    
    font = UIFont.systemFont(ofSize: rt.height * 0.45)
    let moon = NSAttributedString(string: "🌝", attributes: [.font: font ])
    moon.draw(at: CGPoint(x: 345, y: 20))
    
    //back buildings
    UIColor(red: 0.81, green: 0.45, blue: 0.28, alpha: 1.0).setFill()
    context.fill(CGRect(x: 0, y: 540, width: 100, height: 1000))
    context.fill(CGRect(x: 100, y: 840, width: 140, height: 1000))
    context.fill(CGRect(x: 400, y: 600, width: 80, height: 1000))
    context.fill(CGRect(x: 480, y: 680, width: 80, height: 1000))
    
    //mid buildings
    UIColor(red: 0.71, green: 0.25, blue: 0.23, alpha: 1.0).setFill()
    context.fill(CGRect(x: 0, y: 800, width: 70, height: 1000))
    context.fill(CGRect(x: 70, y: 690, width: 100, height: 1000))
    context.fill(CGRect(x: 520, y: 350, width: 250, height: 1000))
    context.fill(CGRect(x: 720, y: 660, width: 180, height: 1000))
    context.fill(CGRect(x: 920, y: 500, width: 180, height: 1000))
    
    //front buildings
    UIColor(red: 0.24, green: 0.12, blue: 0.13, alpha: 1.0).setFill()
    context.fill(CGRect(x: 0, y: 850, width: 120, height: 1000))
    context.fill(CGRect(x: 200, y: 920, width: 120, height: 1000))
    context.fill(CGRect(x: 280, y: 500, width: 160, height: 1000))
    context.fill(CGRect(x: 560, y: 700, width: 260, height: 1000))
    context.fill(CGRect(x: 620, y: 600, width: 140, height: 1000))
    context.fill(CGRect(x: 890, y: 630, width: 160, height: 1000))
    
}

image

//: [Next](@next)
