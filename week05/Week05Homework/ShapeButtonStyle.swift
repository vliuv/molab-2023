//
//  ShapeButtonStyle.swift
//  Week05Homework
//
//  Created by Victoria Liu on 10/6/23.
//

import Foundation
import SwiftUI

struct ShapesButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(minWidth: 125, minHeight: 60)
            .background(petalGlow.opacity(0.15))
            .foregroundColor(petalGlow)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.bottom, 30)
    }
}

struct PlayResetButton: View {
    @Binding var animating: Bool
    var resetOnly : Bool = false
    var action: () -> Void = { }

    var body: some View {
        Button() {
            animating.toggle()
            action()
        } label: {
            if resetOnly {
                Label("Stop", systemImage: "xmark.circle.fill")
            } else {
                Label(animating ? "Stop": "Bloom", systemImage: animating ? "xmark.circle.fill" : "camera.macro")
            }
           
        }
        .buttonStyle(ShapesButton())
        
    }
}

