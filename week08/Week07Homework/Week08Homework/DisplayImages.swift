//
//  DisplayImages.swift
//  Week07Homework
//
//  Created by Victoria Liu on 10/26/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct DisplayImages: View {
    
let context = CIContext()
@State var editMode = false

@EnvironmentObject var document:Document

var body: some View {
    VStack {
        HStack {
            Spacer()
            if (!editMode){
                Button("Edit") {
                    editMode = true
                }.padding(.trailing).buttonStyle(.bordered)
            } else {
                Button("Done") {
                    editMode = false
                }.padding(.trailing).buttonStyle(.borderedProminent)
            }
        }
        List {
            Section {
                // Display in reverse order to see new additions first
                ForEach(document.model.items.reversed()) { item in
                    let thisImg = item.image.toImage()
                    HStack {
                        Text(item.label)
                        Spacer()
                        Image(uiImage: thisImg!).resizable()
                            .aspectRatio(contentMode: .fill).frame(width: 50, height: 50).clipped()
                        if (editMode) {
                            Button {
                                document.model.delete(item.id)
                                document.save("items.json")
                            } label: {
                                Image(systemName: "minus.circle").tint(.red)
                            }
                            .padding(.leading)
                        }
                    }
                }
            } header: {
                Text("Image Collection").padding(.top).font(.headline)
            } footer: {
//                Text("Pick an existing image collection or add your own at the top right.")
            }
            
        }.navigationTitle("")
    }
}

}



struct DisplayImages_Previews: PreviewProvider {
    static var previews: some View {
        DisplayImages().environmentObject(model)
    }
}

