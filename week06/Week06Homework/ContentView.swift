//
//  ContentView.swift
//  Week06Homework
//
//  Created by Victoria Liu on 10/13/23.
//

import SwiftUI

struct ContentView: View {
//    @State private var products = printData()
    
    @EnvironmentObject var document: Document
    
    @State private var name: String = ""
    @State private var quantity: Int? = nil
    @State private var notes: String? = ""
    
    let background = Color(red: 242/255, green: 242/255, blue: 247/255)
    
    var body: some View {
        ZStack {
            background
            
            VStack {
                Text("Grocery List").font(.title).padding(.top, 70.0)
                List {
                    ForEach(document.model.items) { item in
                        HStack {
//                            Text("\(item.id)")
                            Text(item.name + ":")
                            Text("\(item.quantity)   ")
                            Text(item.notes ?? "").font(.caption2)
                            Spacer()
                            Button {
                                document.model.delete(item.id)
                                document.save("groceries.json")
                            } label: {
                                Image(systemName: "xmark").tint(.red)
                            }
                        }
                    }
                    Button("Clear All") {
                        document.model.reset()
                        document.save("groceries.json")
                    }.frame(maxWidth: .infinity, alignment: .center).listRowBackground(Color(red: 209/255, green: 209/255, blue: 209/255)).tint(.black)
                }
                
                Form {
                    TextField("Name", text: $name)
                    TextField("Quantity", value: $quantity, format: .number)
                    TextField("Notes", text: $notes.defaultValue(""))
                    Button("Add") {
                        withAnimation {
                            document.addItem(name: name, quantity: quantity ?? 1, notes: notes)
                            name = ""
                            quantity = nil
                            notes = ""
                            document.save("groceries.json")
                        }
                    }.frame(maxWidth: .infinity, alignment: .center).listRowBackground(Color.green).tint(.white)
                }.frame(maxHeight: 250)
                
            }
            .padding().onAppear {
                document.restore("groceries.json")
                print(document.model)
            }
        }.ignoresSafeArea()
    }
}

struct Groceries: Encodable, Decodable {
    var items = [GroceryProduct]()
    var uniqueId = 0
    
    init () {
        items = [GroceryProduct]()
        self.reset();
    }
    
    mutating func reset () {
        uniqueId = 0
        items = []
    }
    
    mutating func addItem(_ item: GroceryProduct) {
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

struct GroceryProduct: Identifiable, Hashable, Encodable, Decodable {
    var id: Int = 0
    var name: String = ""
    var quantity: Int = 1
    var notes: String? = nil
}

//let json = """
//[
//{
//"id": 1,
//"name": "Bananas",
//"quantity": 5,
//"description": "ripe"
//},
//{
//"id": 2,
//"name": "Oranges",
//"quantity": 2
//}
//]
//""".data(using: .utf8)!
//
//func printData() -> [GroceryProduct] {
//    let decoder = JSONDecoder()
//
//    let products = try! decoder.decode([GroceryProduct].self, from: json)
//
//    return products
//}

//https://betterprogramming.pub/swiftui-binding-extensions-b6a9f27d2858
extension Binding {
    public func defaultValue<T>(_ value: T) -> Binding<T> where Value == Optional<T> {
        Binding<T> {
            wrappedValue ?? value
        } set: {
            wrappedValue = $0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let document = Document()
        ContentView().environmentObject(document)
    }
}
    
