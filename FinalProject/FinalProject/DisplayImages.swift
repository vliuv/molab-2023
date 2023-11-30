//
//  DisplayImages.swift
//  FinalProject
//
//  Created by Victoria Liu on 11/13/23.
//

//https://www.appsloveworld.com/swift/100/312/how-to-handle-ondelete-for-swiftui-list-array-with-reversed#google_vignette
//https://www.hackingwithswift.com/quick-start/swiftui/adding-swipe-to-delete-and-editbutton

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct DisplayImages: View {
    
    let context = CIContext()
    
    @EnvironmentObject var document:Document
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    Section {
                        // Display in reverse order to see new additions first
                        ForEach(document.model.items.reversed()) { item in
                            
                            NavigationLink(
                                destination:
                                    ItemDetail(filename: item.label, avgImg: loadImageFromDiskWith(fileName: item.label)!, emjImg: loadImageFromDiskWith(fileName: item.label+"emoji")!)
                            )
                            {
                                let avgImg = loadImageFromDiskWith(fileName: item.label)
                                let emjImg = loadImageFromDiskWith(fileName: item.label+"emoji")
                                HStack {
//                                    Text("\(document.model.itemIndex(id: item.id)!)")
//                                    Text("\(item.id)")
                                    Text(item.label)
                                    Spacer()
                                    Image(uiImage: avgImg!).resizable()
                                        .aspectRatio(contentMode: .fill).frame(width: 80, height: 80).clipped()
                                    Image(uiImage: emjImg!).resizable()
                                        .aspectRatio(contentMode: .fill).frame(width: 80, height: 80).clipped()
                                }
                            }
                        }.onDelete { index in
                            // get the item from the reversed list
                            let theItem = document.model.items.reversed()[index.first!]
                            // get the index of the item from the viewModel, and remove it
                            if let ndx = document.model.items.firstIndex(of: theItem) {
                                document.model.items.remove(at: ndx)
                            }
                            document.save("items.json")
                        }
                    } header: {
                        Text("Image Collection").padding(.top).font(.headline)
                    } footer: {
                        //                Text("Pick an existing image collection or add your own at the top right.")
                    }
                    
                }.navigationTitle("").toolbar {
                    EditButton()
                }
            }
        }
    }
}

struct ItemDetail: View {
    
    @EnvironmentObject var document:Document
    
    var filename: String
    var avgImg: UIImage
    var emjImg: UIImage
    
    var body: some View {
        VStack {
            Text("\(filename)")
            Image(uiImage: avgImg).resizable()
                .aspectRatio(contentMode: .fill).frame(width: 200, height: 200).clipped()
            Image(uiImage: emjImg).resizable()
                .aspectRatio(contentMode: .fill).frame(width: 200, height: 200).clipped()
        }
    }
}



struct DisplayImages_Previews: PreviewProvider {
    static var previews: some View {
        DisplayImages().environmentObject(model).environmentObject(loadingModel)
        ItemDetail(filename: String(), avgImg: UIImage(), emjImg: UIImage()).environmentObject(model).environmentObject(loadingModel)
        MainView().environmentObject(model).environmentObject(loadingModel)
    }
}

