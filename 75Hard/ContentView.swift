//
//  ContentView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel;
    let dayOne = "2023-03-26"
    
    var body: some View {
            List {
                ForEach(PageType.all) { pageType in
                    LineItemView(pageType: pageType, dayID: listViewModel.dayID)
                }
            }
            .listStyle(PlainListStyle())
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("75 Hard - Day 1")
                        Text(listViewModel.dayID)
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
              leading: Button(action: {
                  listViewModel.moveCurrentDateBackward()
              }, label: {
                Image(systemName: "arrow.left")
              }),
                trailing:
                Button(action: {
                    listViewModel.moveCurrentDateForward()
                }, label: {
                  Image(systemName: "arrow.right")
                })
            )



    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        .environmentObject(ListViewModel())
    }
}

