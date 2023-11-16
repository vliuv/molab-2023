//
//  ImageFileSave.swift
//  FinalProject
//
//  Created by Victoria Liu on 11/13/23.
//

//https://stackoverflow.com/questions/37344822/saving-image-and-then-loading-it-in-swift-ios

import Foundation
import SwiftUI

func saveImage(imageName: String, image: UIImage) {

 guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

    let fileName = imageName
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    guard let data = image.jpegData(compressionQuality: 1) else { return }

    //Checks if file exists, removes it if so.
    if FileManager.default.fileExists(atPath: fileURL.path) {
        do {
            try FileManager.default.removeItem(atPath: fileURL.path)
            print("Removed old image")
        } catch let removeError {
            print("couldn't remove file at path", removeError)
        }

    }

    do {
        try data.write(to: fileURL)
    } catch let error {
        print("error saving file with error", error)
    }

}



func loadImageFromDiskWith(fileName: String) -> UIImage? {

  let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

    let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

    if let dirPath = paths.first {
        let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
        let image = UIImage(contentsOfFile: imageUrl.path)
        return image

    }

    return nil
}

