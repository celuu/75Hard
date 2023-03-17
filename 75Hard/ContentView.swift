//
//  ContentView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Text("Detail 1"), label:{
                    Text ("1 Gallon of Water")
                })
                NavigationLink(destination: Text("Detail 2"), label:{
                    Text ("Read 10 Pages")
                })
                NavigationLink(destination: Text("Detail 3"), label:{
                    Text ("45 Min Workout")
                })
                NavigationLink(destination: Text("Detail 4"), label:{
                    Text ("45 Min Workout - Outside")
                })
                NavigationLink(destination: Text("Detail 5"), label:{
                    Text ("Follow Macros")
                })
                NavigationLink(destination: Text("Detail 6"), label:{
                    Text ("Progress Photo")
                })
            }
            .navigationTitle("75 Hard - Day BLANK")
            .navigationBarTitleDisplayMode(.inline)
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
