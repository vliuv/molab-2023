//
//  ContentView.swift
//  FinalProject
//
//  Created by Victoria Liu on 11/13/23.
//

//https://www.hackingwithswift.com/example-code/media/how-to-read-the-average-color-of-a-uiimage-using-ciareaaverage
//https://swdevnotes.com/swift/2023/convert-color-from-rgb-to-hsb-in-swift/

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

class LoadingModel: ObservableObject {
    @Published var loading = false
}

let gradient = LinearGradient(colors: [Color(red:176/255, green:124/255, blue:252/255), Color(red:124/255, green:147/255, blue:252/255)], startPoint: .top, endPoint: .bottom)

struct ContentView: View {
    
    @State private var image: Image?

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var averageImg: UIImage?
    @State private var emojiImg: UIImage?
    
    @State var label:String = ""
    
    @State private var repeated:Bool = false
    @State private var blank:Bool = false
    
    let context = CIContext()
    
    let bgCol = Color(red: 1, green: 1, blue: 1)
    
    @EnvironmentObject var document:Document
    @EnvironmentObject var loadingModel:LoadingModel
    
    var body: some View {
        
        ZStack{
            ZStack{
            VStack {
                if (image != nil) {
                    Text("Tap the image to select a new picture")
                        .foregroundStyle(.white).bold()
                        .frame(maxWidth: .infinity).frame(height: 60.0)
                        .background(Rectangle().fill(gradient).cornerRadius(10)).padding(.bottom, 4.0)
                } else {
                    Text("EMOJI ABSTRACTION").font(.title2).tracking(4)
                        .foregroundStyle(.white).bold()
                        .frame(maxWidth: .infinity).frame(height: 80.0)
                        .background(Rectangle().fill(gradient).cornerRadius(10)).padding(.bottom, 4.0)
                }
                Spacer()
                ZStack {
                    if (image == nil) {
                        Text("Tap to select a picture")
                            .foregroundColor(.white).font(.title3).tracking(2)
                            .frame(maxWidth: .infinity).frame(maxHeight: .infinity)
                            .background(Rectangle().fill(Color(red: 0.1, green: 0.1, blue: 0.1).opacity(0.9)).cornerRadius(10))
                        }
                    
                    if (image != nil) {
                        VStack {
                            Image(uiImage: inputImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill).frame(width: 160, height: 160).clipped()
                            
                            Image(uiImage: averageImg!)
                                .resizable()
                                .aspectRatio(contentMode: .fill).frame(width: 160, height: 160)
                            
                            Image(uiImage: emojiImg!)
                                .resizable()
                                .aspectRatio(contentMode: .fill).frame(width: 160, height: 160)
                        }.frame(maxWidth: .infinity).frame(maxHeight: .infinity)
                            .background(Rectangle().fill(.white).cornerRadius(10).shadow(radius: 2))
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                    image = nil
                    loadingModel.loading = true
                    label = ""
                    repeated = false
                    blank = false
                }
                
                Spacer()
                
                if (image != nil){
                    
                    if (repeated) {
                        Text("Pick a unique label").foregroundColor(.gray).font(.callout).italic()
                    }
                    
                    if (blank){
                        Text("Please add a label for your image").foregroundColor(.gray).font(.callout).italic()
                    }

                    TextField("Label this image", text: $label)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .textFieldStyle(.plain)
                        .padding(.horizontal)
                        .font(.body)
                        .frame(maxWidth: .infinity).frame(height: 40)
                        .background(Rectangle().fill(Color(red: 0.9, green: 0.9, blue: 0.9).opacity(0.9)).cornerRadius(6))

                    HStack {
                        Button("Clear"){
                            withAnimation{
                                image = nil
                                inputImage = nil
                                averageImg = nil
                                emojiImg = nil

                                label = ""
                                
                            }
                        }.padding(.horizontal)
                        Spacer()
                        Button("Download", action: save).buttonStyle(.bordered)
                        
                        Button("Add to collection") {
                            withAnimation {
                                for item in document.model.items {
                                    if (label == item.label) {
                                        repeated = true
                                        blank = false
                                    } else {
                                        repeated = false
                                    }
                                }
                                
                                if (label == ""){
                                    blank = true
                                } else {
                                    blank = false
                                }
                                
                                if (!repeated && !blank) {
                                    let _ = document.addItem(label: label)
                                    saveImage(imageName: label, image: averageImg!)
                                    saveImage(imageName: label+"emoji", image: emojiImg!)
                                    document.save("items.json")
                                    
//                                    image = nil
//                                    inputImage = nil
//                                    averageImg = nil
//                                    emojiImg = nil
//
//                                    label = ""
                                }
                            }
                        }.buttonStyle(.borderedProminent)
                    }
                }

            }
            .padding(.all)
            .onChange(of: inputImage) { _ in loadImage()
                averageImg = renderAverage()
                emojiImg = renderEmojis()
            }
        
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            
            if (loadingModel.loading){
                ZStack {
                    bgCol
                    VStack {
                        Image(systemName: "paintpalette")
                                .renderingMode(.original)
                                .font(.system(size: 100))
                                .padding(.bottom, 40)
                        ProgressView().padding(.bottom, 30).tint(.white).scaleEffect(1.6)
                        Text("ABSTRACTING YOUR IMAGE...").bold()
                    }.foregroundColor(.white).font(.subheadline).tracking(4)
                        .frame(maxWidth: .infinity).frame(maxHeight: .infinity)
                        .background(Rectangle().fill(Color(red: 0.1, green: 0.1, blue: 0.1).opacity(0.9)).cornerRadius(10))
                }
                .padding(.all)
            }
        }}
    }

    
    func renderAverage() -> UIImage {
        let width = 160;
        let height = 160;
        let sz = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: sz)
        let image = renderer.image { context in
            for numX in 0...7 {
                for numY in 0...7 {
                    (inputImage?.averageColor(offsetX: numX, offsetY: numY) ?? UIColor.black).setFill()
                    context.fill(CGRect(x: width/8*numX-1, y: height-height/8*(numY+1), width: width/8, height: width/8))
                }
            }
        }
        return image;
    }
    
    func renderEmojis() -> UIImage {
        let width = 200;
        let height = 200;
        let sz = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: sz)
        let image = renderer.image { context in
            for numX in 0...7 {
                for numY in 0...7 {
                    let thisCol = getHsb(Color(inputImage?.averageColor(offsetX: numX, offsetY: numY) ?? UIColor.black))
                    let thisHue = thisCol.0*360
                    let thisBri = thisCol.2*100
                    
                    let emojiAdd = getEmoji(thisHue, thisBri)
                    
                    let font = UIFont.systemFont(ofSize: CGFloat(width/8))
                    let displayEmoji = NSAttributedString(string: emojiAdd, attributes: [.font: font ])
                    if(inputImage!.size.width > inputImage!.size.height){
                        displayEmoji.draw(at: CGPoint(x: width/8*numX-1, y: height-height/8*(numY+1)-3))
                    }else{
                        displayEmoji.draw(at: CGPoint(x: width/8*numX-1, y: height-height/8*(numY+1)-3))
                    }
                }
            }
        }
        loadingModel.loading = false
        return image;
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
    

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }

    func save() {
        guard let averageImage = averageImg else { return }
        guard let emojiImage = emojiImg else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
        }
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: averageImage)
        imageSaver.writeToPhotoAlbum(image: emojiImage)
    }
    
}


extension UIImage {
    func averageColor(offsetX: Int, offsetY: Int) -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let extentVector: CIVector;
        
        if (inputImage.extent.size.width > inputImage.extent.size.height) {
            extentVector = CIVector(
                x: inputImage.extent.origin.x + (inputImage.extent.size.width-inputImage.extent.size.height)/2 + CGFloat(offsetX)*inputImage.extent.size.height/8,
                y: inputImage.extent.origin.y + CGFloat(offsetY)*inputImage.extent.size.height/8,
                z: inputImage.extent.size.height/8,
                w: inputImage.extent.size.height/8)
        } else {
            extentVector = CIVector(
                x: inputImage.extent.origin.x + CGFloat(offsetX)*inputImage.extent.size.width/8,
                y: inputImage.extent.origin.y + (inputImage.extent.size.height-inputImage.extent.size.width)/2 + inputImage.extent.size.width/8*CGFloat(offsetY),
                z: inputImage.extent.size.width/8,
                w: inputImage.extent.size.width/8)
        }
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(model).environmentObject(loadingModel)
        MainView().environmentObject(model).environmentObject(loadingModel)
    }
}
