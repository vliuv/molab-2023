//
//  Document.swift
//  Week05Homework
//
//  Created by Victoria Liu on 10/6/23.
//

import Foundation

class Document: ObservableObject {
    @Published var items:[ItemModel]
    init() {
        print("Model init")
        // items for testing
        items = [
            ItemModel(label:"Seasons", systemName1: "camera.macro", systemName2: "sun.max.fill" , systemName3: "leaf.fill" , systemName4: "snowflake"),
            ItemModel(label:"Sports", systemName1: "figure.basketball", systemName2: "figure.outdoor.cycle" , systemName3: "figure.pool.swim" , systemName4: "figure.tennis"),
            ItemModel(label:"Fun", systemName1: "bubbles.and.sparkles.fill", systemName2: "teddybear.fill" , systemName3: "popcorn.fill" , systemName4: "gamecontroller.fill")
        ]
    }
    
    func addItem(label:String, systemName1: String, systemName2: String, systemName3: String, systemName4: String) -> ItemModel {
        let item = ItemModel(label:label, systemName1: systemName1, systemName2: systemName2, systemName3: systemName3, systemName4: systemName4)
        items.append(item)
        return item
    }
    
    func newItem() -> ItemModel {
        return addItem(label: "", systemName1: "", systemName2: "", systemName3: "", systemName4: "")
    }
    
    func updateItem(id: UUID, label:String, systemName1: String, systemName2: String, systemName3: String, systemName4: String) {
        if let index = findIndex(id) {
            items[index].label = label
            items[index].systemName1 = systemName1
            items[index].systemName2 = systemName2
            items[index].systemName3 = systemName3
            items[index].systemName4 = systemName4
        }
    }
    
    func deleteItem(id: UUID) {
        if let index = findIndex(id) {
            items.remove(at: index)
        }
    }
    
    func findIndex(_ id: UUID) -> Int? {
        return items.firstIndex { item in item.id == id }
    }
}

