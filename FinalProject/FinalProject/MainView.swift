//
//  MainView.swift
//  FinalProject
//
//  Created by Victoria Liu on 11/13/23.
//

import Foundation
import SwiftUI

let model = Document()
let loadingModel = LoadingModel()

struct MainView: View {
    
    @EnvironmentObject var document:Document
    @EnvironmentObject var loadingModel: LoadingModel
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Create", systemImage: "paintbrush.pointed")
                }

            DisplayImages()
                .tabItem {
                    Label("Collection", systemImage: "photo.on.rectangle.angled")
                }
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }.onAppear {
            document.restore("items.json")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(model).environmentObject(loadingModel)
    }
}

