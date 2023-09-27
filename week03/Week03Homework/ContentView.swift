//
//  ContentView.swift
//  Week03Homework
//
//  Created by Victoria Liu on 9/21/23.
//

import SwiftUI

let descArr = ["lovely","wonderful","spectacular","dazzling","magnificent"]

let smileyArr = ["🥰","🥳","😛","🤩","😗","🤑"]

//"🥰","🥳","😛","🤩","😗","🤑"

let heartArr = ["❤️","🩷","🧡","💛","💚","💙","🩵","💜","🖤","🩶","🤎"]

//"❤️","🩷","🧡","💛","💚","💙","🩵","💜","🖤","🩶","🤎"

//background
//https://developer.apple.com/documentation/swiftui/adding-a-background-to-your-view
//https://developer.apple.com/documentation/swiftui/color

let backgroundGradient = LinearGradient(
    colors: [Color(red: 0.9, green: 0.9, blue: 0.9), Color(red: 0.35, green: 0.4, blue: 0.75)],
    startPoint: .top, endPoint: .bottom)

//var aquarium

struct ContentView: View {
    var body: some View {
        ZStack {
            backgroundGradient
            VStack {
                Text("Aquarium Generator").padding(.bottom).font(.largeTitle)
                Text(smileyArr.randomElement()! + " Welcome to my " + descArr.randomElement()! + " aquarium! " + smileyArr.randomElement()!)
                    .padding(.vertical)
                    .font(.subheadline)
                aquarium
                Text(heartArr.randomElement()!)
                    .padding(.vertical)
                    .font(.largeTitle)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
    
    var aquarium: some View {
            Image(uiImage: renderAquarium())
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let bgArr = [UIColor(red: 1.0, green: 0.85, blue: 0.5, alpha: 1.0),UIColor(red: 0.55, green: 0.65, blue: 0.45, alpha: 1.0),UIColor(red: 0.85, green: 0.75, blue: 0.95, alpha: 1.0),UIColor(red: 1.0, green: 0.75, blue: 0.85, alpha: 1.0),UIColor(red: 1.0, green: 0.7, blue: 0.45, alpha: 1.0)]

let waterArr = [UIColor(red: 0.6, green: 0.75, blue: 0.9, alpha: 1.0),UIColor(red: 0.2, green: 0.3, blue: 0.45, alpha: 1.0),UIColor(red: 0.3, green: 0.55, blue: 0.6, alpha: 1.0)]

let frameArr = [UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0),UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0),UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)]

let coralPos = [40,70,150,200]

let bubblePos = [50,80,160,210]

let animalArr = ["🐙","🦑","🦐","🦞","🦀","🪼","🐡","🐠","🐟","🐬","🐳","🐋","🦈"]

//"🐙","🦑","🦐","🦞","🦀","🪼","🐡","🐠","🐟","🐬","🐳","🐋","🦈"


func renderAquarium() -> UIImage {
    let width = 300;
    let height = 300;
    let sz = CGSize(width: width, height: height)
    let renderer = UIGraphicsImageRenderer(size: sz)
    let image = renderer.image { context in
        //small background
        bgArr.randomElement()!.setFill()
        context.fill(CGRect(x: 0, y: 0, width: 300, height: 300))
        
        //water
        waterArr.randomElement()!.setFill()
        context.fill(CGRect(x: 25, y: 50, width: 250, height: 200))
        
        //sand
        UIColor(red: 0.7, green: 0.6, blue: 0.4, alpha: 1.0).setFill()
        context.fill(CGRect(x: 25, y: 220, width: 250, height: 30))
        
        //frame
        frameArr.randomElement()!.setFill()
        context.fill(CGRect(x: 20, y: 50, width: 260, height: 10))
        context.fill(CGRect(x: 20, y: 250, width: 260, height: 10))
        
        //coral
        let coral = NSAttributedString(string: "🪸", attributes: [.font: UIFont.systemFont(ofSize: 55) ])
        coral.draw(at: CGPoint(x: coralPos.randomElement()!, y: 175))
        
        //bubble
        let bubble = NSAttributedString(string: "🫧", attributes: [.font: UIFont.systemFont(ofSize: 40) ])
        bubble.draw(at: CGPoint(x: bubblePos.randomElement()!, y: 80))
        
        //animal
        var animal: NSAttributedString
        let animalString = animalArr.randomElement()!
        if animalString == "🐙" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 60) ])
            animal.draw(at: CGPoint(x: 50, y: 100))
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 40) ])
            animal.draw(at: CGPoint(x: 150, y: 150))
        } else if animalString == "🦑" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 80) ])
            animal.draw(at: CGPoint(x: 160, y: 100))
        } else if animalString == "🦐" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 40) ])
            animal.draw(at: CGPoint(x: 180, y: 80))
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 20) ])
            animal.draw(at: CGPoint(x: 140, y: 120))
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 30) ])
            animal.draw(at: CGPoint(x: 200, y: 160))
        } else if animalString == "🦞" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 70) ])
            animal.draw(at: CGPoint(x: 180, y: 160))
        } else if animalString == "🦀" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 60) ])
            animal.draw(at: CGPoint(x: 60, y: 170))
        } else if animalString == "🪼" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 60) ])
            animal.draw(at: CGPoint(x: 70, y: 100))
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 40) ])
            animal.draw(at: CGPoint(x: 170, y: 170))
        } else if animalString == "🐡" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 60) ])
            animal.draw(at: CGPoint(x: 100, y: 100))
        } else if animalString == "🐠" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 50) ])
            animal.draw(at: CGPoint(x: 170, y: 130))
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 30) ])
            animal.draw(at: CGPoint(x: 130, y: 90))
        } else if animalString == "🐟" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 50) ])
            animal.draw(at: CGPoint(x: 60, y: 130))
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 40) ])
            animal.draw(at: CGPoint(x: 110, y: 90))
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 30) ])
            animal.draw(at: CGPoint(x: 180, y: 150))
        } else if animalString == "🐬" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 120) ])
            animal.draw(at: CGPoint(x: 130, y: 80))
        } else if animalString == "🐳" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 130) ])
            animal.draw(at: CGPoint(x: 90, y: 70))
        } else if animalString == "🐋" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 150) ])
            animal.draw(at: CGPoint(x: 60, y: 50))
        } else if animalString == "🦈" {
            animal = NSAttributedString(string: animalString, attributes: [.font: UIFont.systemFont(ofSize: 140) ])
            animal.draw(at: CGPoint(x: 70, y: 80))
        }
    }
    return image;
}
