//
//  75HardApp.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

@main
struct _5HardApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(listViewModel)
            
        }
    }
}
