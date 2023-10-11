//
//  ItemDetail.swift
//  Week05Homework
//
//  Created by Victoria Liu on 10/6/23.
//

//import SwiftUI
//
//struct ItemDetail: View {
//    var item:ItemModel
//
//    @State var uiImage:UIImage?
//
//    @EnvironmentObject var document:Document
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        VStack {
//            VStack {
//                HStack{
//                    Image(systemName: item.systemName1)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                    Image(systemName: item.systemName2)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                }
//                HStack{
//                    Image(systemName: item.systemName3)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                    Image(systemName: item.systemName4)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                }
//            }
//            HStack {
//                Text("label: ")
//                Text(item.label)
//                Spacer()
//            }
//            HStack {
//                Text("systemName1: ")
//                Text(item.systemName1)
//                Spacer()
//            }
//            HStack {
//                Text("systemName2: ")
//                Text(item.systemName2)
//                Spacer()
//            }
//            HStack {
//                Text("systemName3: ")
//                Text(item.systemName3)
//                Spacer()
//            }
//            HStack {
//                Text("systemName4: ")
//                Text(item.systemName4)
//                Spacer()
//            }
//            Button("Delete") {
//                document.deleteItem(id: item.id)
//                dismiss();
//            }
//        }
//    }
//}
//

