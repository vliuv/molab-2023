//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Victoria Liu on 11/13/23.
//

import SwiftUI

@main
struct FinalProjectApp: App {
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(model).environmentObject(loadingModel)
        }
    }
}
