//
//  ContentView.swift
//  FinalProject
//
//  Created by Victoria Liu on 11/13/23.
//

//https://www.hackingwithswift.com/example-code/media/how-to-read-the-average-color-of-a-uiimage-using-ciareaaverage

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

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
    
    @EnvironmentObject var document:Document

    var body: some View {
        
            VStack {
                if (image != nil) {
                    Text("Tap the image to select a new picture")
                        .padding(.top, 20.0).font(.subheadline)
                } else {
                    Text("Color Breakdown").padding(.top, 40.0).font(.title)
                }
                Spacer()
                ZStack {
                    if (image == nil) {
                        Rectangle()
                            .fill(.blue.opacity(0.2)).frame(width: 240, height: 50).cornerRadius(10)
                        
                        Text("Tap to select a picture")
                            .foregroundColor(.blue)
                            .font(.headline)
                    }
                    
                    VStack {
                        if (image != nil) {

                            Image(uiImage: inputImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill).frame(width: 160, height: 160).clipped()
                            
                            Image(uiImage: averageImg!)
                                .resizable()
                                .aspectRatio(contentMode: .fill).frame(width: 160, height: 160)
                            
                            Image(uiImage: averageImg!)
                                .resizable()
                                .aspectRatio(contentMode: .fill).frame(width: 160, height: 160)
                            
                            
                            if (repeated) {
                                Text("Pick a unique label")
                            }
                            
                            if (blank){
                                Text("Please add a label for your image")
                            }
                            
                        }
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                Spacer()
                
                if (image != nil){
                    
//                    Form {
                        TextField("Label this image", text: $label)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .textFieldStyle(.roundedBorder)
                            .padding(.bottom, 13.0)
//                    }

                    
                    HStack {
                        Button("Save to photos", action: save).buttonStyle(.bordered)
                        Spacer()
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
                                    document.save("items.json")
                                    
                                    image = nil
                                    inputImage = nil
                                    averageImg = nil
                                    emojiImg = nil

                                    label = ""
                                    
                                }
                            }
                        }.buttonStyle(.borderedProminent)
                    }
                }
    
            }
            .padding([.horizontal, .bottom])
            .onChange(of: inputImage) { _ in loadImage()
                averageImg = renderAverage()
            }
        
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        
    }
    
    func renderAverage() -> UIImage {
        let width = 200;
        let height = 200;
        let sz = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: sz)
        let image = renderer.image { context in
            for numX in 0...7 {
                for numY in 0...7 {
                    (inputImage?.averageColor(offsetX: numX, offsetY: numY) ?? UIColor.black).setFill()
                    context.fill(CGRect(x: width/8*numX+1, y: height-height/8*(numY+1), width: width/8+1, height: width/8))
                }
            }
        }
        return image;
    }
    

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }

    func save() {
        guard let averageImage = averageImg else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
        }
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: averageImage)
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
        ContentView().environmentObject(model)
        MainView().environmentObject(model)
    }
}
