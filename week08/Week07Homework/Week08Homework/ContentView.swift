//https://www.hackingwithswift.com/example-code/media/how-to-read-the-average-color-of-a-uiimage-using-ciareaaverage

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var averageImg: UIImage?
    
    @State var label:String = ""
    @State var averageImgStr = ""
    
    let context = CIContext()
    
    @EnvironmentObject var document:Document

    var body: some View {
        
            VStack {
                if (image != nil) {
                    Text("Tap the image to select a new picture")
                        .padding(.top, 40.0).font(.subheadline)
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
                                .aspectRatio(contentMode: .fill).frame(width: 200, height: 200).clipped()
                            
                            Image(uiImage: averageImg!)
                            
                        }
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                Spacer()
                if (image != nil){
                    Form {
                        TextField("Label", text: $label)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }.frame(maxHeight: 120)
                    
                    HStack {
                        Button("Save to photos", action: save).buttonStyle(.bordered)
                        Spacer()
                        Button("Add to collection") {
                            withAnimation {
                                let _ = document.addItem(label: label, image: averageImgStr)
                                document.save("items.json")
                                image = nil
                                inputImage = nil
                                averageImg = nil
                                label = ""
                                averageImgStr = ""
                            }
                        }.buttonStyle(.borderedProminent)
                    }
                }
    
            }
            .padding([.horizontal, .bottom])
            .onChange(of: inputImage) { _ in loadImage()
                averageImg = renderAverage()
                averageImgStr = averageImg!.toPngString()!
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
            for num in 0...4 {
                (inputImage?.averageColor(offset: num) ?? UIColor.black).setFill()
                context.fill(CGRect(x: width/4*num, y: 0, width: width/4, height: 200))
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
    func averageColor(offset: Int) -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let extentVector: CIVector;
        
        if (inputImage.extent.size.width > inputImage.extent.size.height) {
            extentVector = CIVector(
                x: inputImage.extent.origin.x + (inputImage.extent.size.width-inputImage.extent.size.height)/2 + CGFloat(offset)*inputImage.extent.size.height/4,
                y: inputImage.extent.origin.y,
                z: inputImage.extent.size.height/4,
                w: inputImage.extent.size.height)
        } else {
            extentVector = CIVector(
                x: inputImage.extent.origin.x + CGFloat(offset)*inputImage.extent.size.width/4,
                y: inputImage.extent.origin.y + (inputImage.extent.size.height-inputImage.extent.size.width)/2,
                z: inputImage.extent.size.width/4,
                w: inputImage.extent.size.height - (inputImage.extent.size.height-inputImage.extent.size.width))
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
    }
}
