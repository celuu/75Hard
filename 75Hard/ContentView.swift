//
//  ContentView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var items: [ItemModel] = [
        ItemModel(title: "1 Gallon of Water", isCompleted: false),
        ItemModel(title: "Read 10 Pages", isCompleted: false),
        ItemModel(title: "45 Min Workout", isCompleted: false),
        ItemModel(title: "45 Min Workout - Outside", isCompleted: false),
        ItemModel(title: "Follow Macros", isCompleted: false),
        ItemModel(title: "Progress Photo", isCompleted: false)
    ]
    
    @State var title: String = ""

    var body: some View {
            List {
                ForEach(items) {
                    item in LineItemView(item: item)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("75 Hard - Day BLANK")
            .navigationBarTitleDisplayMode(.inline)

    }

    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}

