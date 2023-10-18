//
//  ItemRow.swift
//  Week05Homework
//
//  Created by Victoria Liu on 10/6/23.
//

import Foundation
import SwiftUI

struct ItemRow: View {
    var item:ItemModel
    
    @State var uiImage:UIImage?
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                HStack{
                    Image(systemName: item.systemName1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Image(systemName: item.systemName2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                HStack{
                    Image(systemName: item.systemName3)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Image(systemName: item.systemName4)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }.frame(width: 100, height: 100)
            Text(item.label)
            Spacer()
        }
    }
}


