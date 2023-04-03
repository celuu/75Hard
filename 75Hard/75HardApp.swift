//
//  75HardApp.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

@main
struct _5HardApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel(dayID: Date.now.localDayID)
    @StateObject private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(listViewModel)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
