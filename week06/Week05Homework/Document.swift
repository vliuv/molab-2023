//
//  Document.swift
//  Week05Homework
//
//  Created by Victoria Liu on 10/6/23.
//

import Foundation

class Document: ObservableObject {
    
    @Published var model: AllItems
    
    init() {
        model = AllItems()
    }
    
    var items:[ItemModel] {
        model.items
    }
    
    func addItem(label:String, systemName1: String, systemName2: String, systemName3: String, systemName4: String) -> ItemModel {
        let item = ItemModel(label:label, systemName1: systemName1, systemName2: systemName2, systemName3: systemName3, systemName4: systemName4)
        model.addItem(item)
        return item
    }
    
    func newItem() -> ItemModel {
        return addItem(label: "", systemName1: "", systemName2: "", systemName3: "", systemName4: "")
    }
    
    func updateItem(id: Int, label:String, systemName1: String, systemName2: String, systemName3: String, systemName4: String) {
        if let index = findIndex(id) {
            model.items[index].label = label
            model.items[index].systemName1 = systemName1
            model.items[index].systemName2 = systemName2
            model.items[index].systemName3 = systemName3
            model.items[index].systemName4 = systemName4
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

