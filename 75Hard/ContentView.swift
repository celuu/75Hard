//
//  ContentView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel;
    


    var body: some View {
            List {
                ForEach(listViewModel.items) {
                    item in LineItemView(item: item)
                }
                .onDelete(perform: listViewModel.deleteItem)
                .onMove(perform: listViewModel.moveItem)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("75 Hard - Day BLANK")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    NavigationLink("Add", destination: AddHabitView() )
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

