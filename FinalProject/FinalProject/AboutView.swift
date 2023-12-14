//
//  AboutView.swift
//  FinalProject
//
//  Created by Victoria Liu on 12/2/23.
//

import Foundation
import SwiftUI

struct AboutView: View {
    @State private var testColor = Color(red:0.8, green:0.8, blue:0.8)
    
    @State private var testEmoji = "❔"
    
    var body: some View {
        VStack(alignment: .leading){
            Text("EMOJI ABSTRACTION").font(.title2).tracking(4)
                .foregroundStyle(.white).bold()
                .frame(maxWidth: .infinity).frame(height: 80.0)
                .background(Rectangle().fill(gradient).cornerRadius(10)).padding(.bottom, 4.0)
            Text("How it works:").fontWeight(.bold).padding(.vertical)
            Text("This app takes your uploaded images and breaks it down into a 8x8 grid of squares and finds the average color of each square.").padding(.bottom)
            Text("It then takes all 64 of those average colors and looks at both the hue & brightness to get an emoji approximation.").padding(.bottom)
            Text("Use the color picker below to test out some color to emoji conversions!")
                .padding(.bottom)
            ColorPicker("Pick a color", selection: $testColor).fontWeight(.bold).onChange(of: testColor) { testColor in
                let testHsb = getHsb(testColor)
                testEmoji = getEmoji(testHsb.0*360, testHsb.2*100)
            }
            HStack{
                Text(testEmoji).font(.title).scaleEffect(6.0).frame(maxWidth: .infinity).frame(maxHeight: .infinity)
                    .background(Rectangle().fill(testColor).frame(maxWidth: .infinity).frame(maxHeight: .infinity).cornerRadius(10))
            }
        }.padding(.all)
    }
    
    func getHsb(_ col: Color) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
            var hue: CGFloat  = 0.0
            var saturation: CGFloat = 0.0
            var brightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            
            let uiColor = UIColor(col)
            uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            
            return (hue, saturation, brightness, alpha)
    }
    
    func getEmoji(_ thisHue: CGFloat, _ thisBri: CGFloat) -> String {
        var emojiAdd: String
        
        if thisHue > 335 || thisHue < 5 {
            if thisBri < 33 {
                emojiAdd = "🛢️"
            } else if thisBri > 66 {
                emojiAdd = "🎟️"
            } else {
                emojiAdd = "🔴"
            }
        } else if thisHue < 35 {
            if thisBri < 33 {
                emojiAdd = "🧶"
            } else if thisBri > 66 {
                emojiAdd = "🐡"
            } else {
                emojiAdd = "🟠"
            }
        } else if thisHue < 65 {
            if thisBri < 33 {
                emojiAdd = "🏆"
            } else if thisBri > 66 {
                emojiAdd = "🌝"
            } else {
                emojiAdd = "🟡"
            }
        } else if thisHue < 95 {
            if thisBri < 33 {
                emojiAdd = "🫒"
            } else if thisBri > 66 {
                emojiAdd = "🥑"
            } else {
                emojiAdd = "🎾"
            }
        } else if thisHue < 125 {
            if thisBri < 33 {
                emojiAdd = "🫑"
            } else if thisBri > 66 {
                emojiAdd = "🍈"
            } else {
                emojiAdd = "🍏"
            }
        } else if thisHue < 155 {
            if thisBri < 33 {
                emojiAdd = "🥦"
            } else if thisBri > 66 {
                emojiAdd = "🧩"
            } else {
                emojiAdd = "🟢"
            }
        } else if thisHue < 185 {
            if thisBri < 33 {
                emojiAdd = "🪣"
            } else if thisBri > 66 {
                emojiAdd = "⚗️"
            } else {
                emojiAdd = "🧼"
            }
        } else if thisHue < 215 {
            if thisBri < 33 {
                emojiAdd = "🌃"
            } else if thisBri > 66 {
                emojiAdd = "🐬"
            } else {
                emojiAdd = "🥶"
            }
        } else if thisHue < 245 {
            if thisBri < 33 {
                emojiAdd = "🌑"
            } else if thisBri > 66 {
                emojiAdd = "🩵"
            } else {
                emojiAdd = "🔵"
            }
        } else if thisHue < 275 {
            if thisBri < 33 {
                emojiAdd = "👾"
            } else if thisBri > 66 {
                emojiAdd = "👚"
            } else {
                emojiAdd = "🟣"
            }
        } else if thisHue < 305 {
            if thisBri < 33 {
                emojiAdd = "🍇"
            } else if thisBri > 66 {
                emojiAdd = "🌸"
            } else {
                emojiAdd = "🩷"
            }
        } else {
            if thisBri < 33 {
                emojiAdd = "🐙"
            } else if thisBri > 66 {
                emojiAdd = "🐽"
            } else {
                emojiAdd = "🌺"
            }
        }
        
        return emojiAdd
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
        MainView().environmentObject(model).environmentObject(loadingModel)
    }
}
