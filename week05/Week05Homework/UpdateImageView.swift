//
//  UpdateImageView.swift
//  Week05Homework
//
//  Created by Victoria Liu on 10/6/23.
//

import SwiftUI

struct UpdateImageView: View {
    var action: String // "Update" or "Add"
    var id: UUID
    
    @State var label:String = ""
    @State var systemName1:String = ""
    @State var systemName2:String = ""
    @State var systemName3:String = ""
    @State var systemName4:String = ""
    
    @State var uiImage:UIImage?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var document:Document
    
    var body: some View {
        VStack {
            VStack {
                HStack{
                    Image(systemName: systemName1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Image(systemName: systemName2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                HStack{
                    Image(systemName: systemName3)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Image(systemName: systemName4)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }.padding(20)
            HStack {
                Button("Update") {
                    print("UpdateImageView Update")
                    document.updateItem(id: id, label: label, systemName1: systemName1, systemName2: systemName2, systemName3: systemName3, systemName4: systemName4)
                    dismiss()
                }
                Spacer()
                Button("Delete") {
                    document.deleteItem(id: id)
                    dismiss();
                }
            }.padding(.horizontal, 35)
            Form {
                TextField("Title", text: $label)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                TextField("System Name 1", text: $systemName1)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                TextField("System Name 2", text: $systemName2)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                TextField("System Name 3", text: $systemName3)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                TextField("System Name 4", text: $systemName4)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
        }
    }
}

struct UpdateImageView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateImageView(action: "action", id: UUID())
    }
}

