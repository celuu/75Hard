//
//  75HardApp.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

@main
struct _5HardApp: App {
    

    @StateObject private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(dayID: Date.now.localDayID)
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
