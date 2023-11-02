//
//  Document.swift
//  Week07Homework
//
//  Created by Victoria Liu on 10/26/23.
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
    
    func addItem(label: String, image: String) -> ItemModel {
        let item = ItemModel(label: label, image: image)
        model.addItem(item)
        return item
    }
    
    func newItem() -> ItemModel {
        return addItem(label: "", image: "")
    }
    
    func updateItem(id: Int, label: String, image: String) {
        if let index = findIndex(id) {
            model.items[index].label = label
            model.items[index].image = image
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


