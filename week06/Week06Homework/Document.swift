//
//  Document.swift
//  Week06Homework
//
//  Created by Victoria Liu on 10/15/23.
//

import Foundation
import SwiftUI

class Document: ObservableObject
{
    @Published var model: Groceries
    
    init() {
        model = Groceries()
    }
    
    var items:[GroceryProduct] {
        model.items
    }
    
    func addItem(name: String, quantity: Int, notes: String?) {
        let item = GroceryProduct(name: name, quantity: quantity, notes: notes ?? "")
        model.addItem(item)
    }
    
    func save(_ fileName: String) {
        model.saveAsJSON(fileName: fileName)
    }
    
    func restore(_ fileName: String) {
        model = Groceries(JSONfileName: fileName)
    }
    
    func clear () {
        model.reset()
    }

}
