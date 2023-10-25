//
//  ContentView.swift
//  Instafilter
//
//  Created by Paul Hudson on 01/12/2021.
//

//https://www.hackingwithswift.com/example-code/media/how-to-read-the-average-color-of-a-uiimage-using-ciareaaverage

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?

    // Initial filter choice
    @State private var currentFilter: CIFilter = CIFilter.pixellate()
    
    let context = CIContext()

    @State private var showingFilterSheet = false
    
    @State private var newCol1: UIColor = UIColor.white
    @State private var newCol2: UIColor = UIColor.white
    @State private var newCol3: UIColor = UIColor.white
    @State private var newCol4: UIColor = UIColor.white

    var body: some View {
// NavigationView { // Removed to improve preview on iPad
        
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
                            
                            image?
                                .resizable()
                                .aspectRatio(contentMode: .fill).frame(width: 200, height: 200).clipped()
                            
                            HStack {
                                Rectangle()
                                    .fill(Color(newCol1))
                                Rectangle()
                                    .fill(Color(newCol2))
                                Rectangle()
                                    .fill(Color(newCol3))
                                Rectangle()
                                    .fill(Color(newCol4))
                            }.frame(width: 200, height: 200)
                        }
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                Spacer()

                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing() }
                }
                .padding(.vertical)
                

                Button("Save", action: save)
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage()
                newCol1 = inputImage?.averageColor(offset: 0) ?? UIColor.black
                newCol2 = inputImage?.averageColor(offset: 1) ?? UIColor.black
                newCol3 = inputImage?.averageColor(offset: 2) ?? UIColor.black
                newCol4 = inputImage?.averageColor(offset: 3) ?? UIColor.black
            }
        
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
                
            }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
        }
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        print("applyProcessing inputKeys", inputKeys)
        // Determine the value range for filter intensity
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputScaleKey)
        }
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

extension UIImage {
    func averageColor(offset: Int) -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let extentVector: CIVector;
        
        if (inputImage.extent.size.width > inputImage.extent.size.height) {
            extentVector = CIVector(
//                x: inputImage.extent.origin.x + (inputImage.extent.size.width-inputImage.extent.size.height)/2 + CGFloat(offset)*inputImage.extent.size.height/4,
//                y: inputImage.extent.origin.y,
//                z: inputImage.extent.origin.x + (inputImage.extent.size.width-inputImage.extent.size.height)/2 + CGFloat(offset+1)*inputImage.extent.size.height/4,
//                w: inputImage.extent.size.height)
            
                x: inputImage.extent.origin.x + (inputImage.extent.size.width-inputImage.extent.size.height)/2 + CGFloat(offset)*inputImage.extent.size.height/4,
                y: inputImage.extent.origin.y,
                z: inputImage.extent.size.height/4,
                w: inputImage.extent.size.height)
        } else {
            extentVector = CIVector(
//                x: inputImage.extent.origin.x + CGFloat(offset)*inputImage.extent.size.width/4,
//                y: inputImage.extent.origin.y + (inputImage.extent.size.height-inputImage.extent.size.width)/2,
//                z: inputImage.extent.origin.x + CGFloat(offset+1)*inputImage.extent.size.width/4,
//                w: inputImage.extent.size.height - (inputImage.extent.size.height-inputImage.extent.size.width)/2)
            
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
        ContentView()
    }
}
