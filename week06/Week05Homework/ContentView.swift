//
//  ContentView.swift
//  week05
//
//  Created by Victoria Liu on 10/5/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var document:Document
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        FlowerBloomView()
                    } label: {
                        Text("Blooming Flower 🌷")
                    }
                } header: {
                    Text("Animation").padding(.top).font(.headline)
                } footer: {
                    Text("Press to view animation.")
                }
                
                Section {
                    // Display in reverse order to see new additions first
                    ForEach(document.model.items.reversed()) { item in
                        NavigationLink(
                            destination:
                                UpdateImageView(action: "Update",
                                                id: item.id,
                                                label: item.label,
                                                systemName1: item.systemName1, systemName2: item.systemName2, systemName3: item.systemName3, systemName4: item.systemName4)
                        )
                        {
                            ItemRow(item: item)
                        }
                    }
                } header: {
                    Text("Image Collections").padding(.top).font(.headline)
                } footer: {
                    Text("Pick an existing image collection or add your own at the top right.")
                }
                
            }.navigationTitle("Navigation App").navigationBarItems(
                trailing:
                    NavigationLink(
                        destination:
                            AddImageView()
                    )
                {
                    Text("Add Image")
                }
            )
        }.onAppear {
            document.restore("items.json")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Document()
        ContentView().environmentObject(model)
    }
}
