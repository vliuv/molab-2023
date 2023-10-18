//
//  Flower.swift
//  Week05Homework
//
//  Created by Victoria Liu on 10/6/23.
//

import Foundation
import SwiftUI

struct FlowerBloomView: View {
    @State private var blooming = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                if blooming {
                    BloomingFlower()
                } else {
                    ResetFlower()
                }
            }
            Spacer()
            PlayResetButton(animating: $blooming)
        }
        .navigationTitle("Blooming Flower")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//245, 120, 66
let petalCol1 = Color(red: 245/255, green: 120/255, blue: 66/255)
//245, 144, 66
let petalCol2 = Color(red: 245/255, green: 144/255, blue: 66/255)
//245, 176, 66
let petalCol3 = Color(red: 245/255, green: 176/255, blue: 66/255)

//255, 85, 66
let petalGlow = Color(red: 255/255, green: 85/255, blue: 66/255)

//79, 143, 63
let leafCol = Color(red: 79/255, green: 143/255, blue: 63/255)

//https://developer.apple.com/documentation/swiftui/view/rotationeffect(_:anchor:)
//https://developer.apple.com/documentation/uikit/uibezierpath/1624357-addcurve

struct ResetFlower: View {
    var body: some View {
        
        Stem()
            .frame(width: 100, height: 600)
            .foregroundColor(leafCol)
            .shadow(color: leafCol, radius: 5)
        
        Petal()
            .frame(width: 100, height: 200)
            .foregroundColor(petalCol1)
            .shadow(color: petalGlow, radius: 10)
        
    }
}

struct BloomingFlower: View {
    @State private var rotate1: CGFloat = 15
    @State private var rotate2: CGFloat = 40
    @State private var rotate3: CGFloat = 70
    
    @State private var rotate4: CGFloat = -15
    @State private var rotate5: CGFloat = -40
    @State private var rotate6: CGFloat = -70
    
    var body: some View {
        
        Stem()
            .frame(width: 100, height: 600)
            .foregroundColor(leafCol)
            .shadow(color: leafCol, radius: 5)
            
        Petal()
            .frame(width: 100, height: 200)
            .foregroundColor(petalCol1)
            .rotationEffect(.degrees(rotate1), anchor: .bottom)
            .shadow(color: petalGlow, radius: 10)
            .onAppear{
                withAnimation(.easeInOut.repeatForever(autoreverses: true)) {
                    rotate1 = 2 * rotate1
                }
            }
        
        Petal()
            .frame(width: 100, height: 200)
            .foregroundColor(petalCol1)
            .rotationEffect(.degrees(rotate4), anchor: .bottom)
            .shadow(color: petalGlow, radius: 10)
            .onAppear{
                withAnimation(.easeInOut.repeatForever(autoreverses: true)) {
                    rotate4 = 2 * rotate4
                }
            }
        
        Petal()
            .frame(width: 100, height: 200)
            .foregroundColor(petalCol2)
            .rotationEffect(.degrees(rotate2), anchor: .bottom)
            .shadow(color: petalGlow, radius: 10)
            .onAppear{
                withAnimation(.easeInOut.repeatForever(autoreverses: true)) {
                    rotate2 = 2 * rotate2
                }
            }
        
        Petal()
            .frame(width: 100, height: 200)
            .foregroundColor(petalCol2)
            .rotationEffect(.degrees(rotate5), anchor: .bottom)
            .shadow(color: petalGlow, radius: 10)
            .onAppear{
                withAnimation(.easeInOut.repeatForever(autoreverses: true)) {
                    rotate5 = 2 * rotate5
                }
            }
        
        Petal()
            .frame(width: 100, height: 200)
            .foregroundColor(petalCol3)
            .rotationEffect(.degrees(rotate3), anchor: .bottom)
            .shadow(color: petalGlow, radius: 10)
            .onAppear{
                withAnimation(.easeInOut.repeatForever(autoreverses: true)) {
                    rotate3 = 2 * rotate3
                }
            }
        
        Petal()
            .frame(width: 100, height: 200)
            .foregroundColor(petalCol3)
            .rotationEffect(.degrees(rotate6), anchor: .bottom)
            .shadow(color: petalGlow, radius: 10)
            .onAppear{
                withAnimation(.easeInOut.repeatForever(autoreverses: true)) {
                    rotate6 = 2 * rotate6
                }
            }
        
    }
}

struct Petal: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.midY),
                      control1:CGPoint(x: rect.midX, y: rect.height*3/4),
                      control2:CGPoint(x: rect.minX, y: rect.height*3/4))
        
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.minY),
                      control1:CGPoint(x: rect.minX, y: rect.height/4),
                      control2:CGPoint(x: rect.midX, y: rect.height/4))
        
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                      control1:CGPoint(x: rect.midX, y: rect.height/4),
                      control2:CGPoint(x: rect.maxX, y: rect.height/4))
        
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                      control1:CGPoint(x: rect.maxX, y: rect.height*3/4),
                      control2:CGPoint(x: rect.midX, y: rect.height*3/4))
        
        return path
    }
}

struct Stem: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.midY),
                      control1:CGPoint(x: rect.width/4, y: rect.maxY),
                      control2:CGPoint(x: rect.width/2, y: rect.height*3/4))
        
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                      control1:CGPoint(x: rect.width/2, y: rect.height*3/4),
                      control2:CGPoint(x: rect.width*3/4, y: rect.maxY))
        
        return path
    }
}

struct FlowerBloomView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerBloomView()
    }
}

