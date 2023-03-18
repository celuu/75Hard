//
//  ContentView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var items: [String] = [
        "1 Gallon of Water",
        "Read 10 Pages",
        "45 Min Workout",
        "45 Min Workout - Outside",
        "Follow Macros",
        "Progress Photo"
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) {
                    item in LineItemView(title: item)
                }
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

