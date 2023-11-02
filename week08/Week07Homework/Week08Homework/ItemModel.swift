//
//  ItemModel.swift
//  Week07Homework
//
//  Created by Victoria Liu on 10/26/23.
//

import Foundation

struct AllItems: Encodable, Decodable {
    var items = [ItemModel]()
    var uniqueId = 0
    
    init () {
        items = [ItemModel]()
        self.reset();
    }
    
    mutating func reset () {
        uniqueId = 0
        items = []
    }
    
    mutating func addItem(_ item: ItemModel) {
        var nitem = item;
        nitem.id = uniqueId;
        uniqueId += 1
        items.append(nitem);
    }
    
    
    mutating func delete(_ id: Int) {
        if let index = itemIndex(id: id) {
            items.remove(at: index)
        }
    }
    
    func itemIndex(id: Int) -> Int? {
        items.firstIndex { $0.id == id }
    }
    
}

struct ItemModel : Identifiable, Hashable, Encodable, Decodable {
    var id = 0
    var label: String = ""
    var image: String = ""
}


