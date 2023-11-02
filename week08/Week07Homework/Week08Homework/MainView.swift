//
//  MainView.swift
//  Week07Homework
//
//  Created by Victoria Liu on 10/26/23.
//

import Foundation
import SwiftUI

let model = Document()

struct MainView: View {
    
    @EnvironmentObject var document:Document
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Image", systemImage: "photo")
                }

            DisplayImages()
                .tabItem {
                    Label("Collection", systemImage: "folder")
                }
        }.onAppear {
            document.restore("items.json")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(model)
    }
}
