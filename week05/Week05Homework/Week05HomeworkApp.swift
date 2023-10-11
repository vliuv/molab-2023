//
//  Week05HomeworkApp.swift
//  Week05Homework
//
//  Created by Victoria Liu on 10/5/23.
//

import SwiftUI

@main
struct Week05HomeworkApp: App {
    
    @StateObject var document = Document()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(document)
        }
    }
}
