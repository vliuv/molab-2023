//
//  Document.swift
//  FinalProject
//
//  Created by Victoria Liu on 11/13/23.
//

import Foundation
import SwiftUI

class Document: ObservableObject {
    
    @Published var model: AllItems
    
    init() {
        model = AllItems()
    }
    
    var items:[ItemModel] {
        model.items
    }
    
    func addItem(label: String) -> ItemModel {
        let item = ItemModel(label: label)
        model.addItem(item)
        return item
    }
    
    func newItem() -> ItemModel {
        return addItem(label: "")
    }
    
    func updateItem(id: Int, label: String) {
        if let index = findIndex(id) {
            model.items[index].label = label
        }
    }
    
    func deleteItem(id: Int) {
        if let index = findIndex(id) {
            model.items.remove(at: index)
        }
    }
    
    func findIndex(_ id: Int) -> Int? {
        return items.firstIndex { item in item.id == id }
    }
    
    func save(_ fileName: String) {
        model.saveAsJSON(fileName: fileName)
    }
    
    func restore(_ fileName: String) {
        model = AllItems(JSONfileName: fileName)
    }
}

