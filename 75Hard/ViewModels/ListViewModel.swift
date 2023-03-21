//
//  ListViewModel.swift
//  75Hard
//
//  Created by Christine Luu on 3/20/23.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [];
    
    init(){
        getItems()
    }
    
    func getItems() {
        let newItems = [
            ItemModel(title: "1 Gallon of Water", isCompleted: false),
            ItemModel(title: "Read 10 Pages", isCompleted: false),
            ItemModel(title: "45 Min Workout", isCompleted: false),
            ItemModel(title: "45 Min Workout - Outside", isCompleted: false),
            ItemModel(title: "Follow Macros", isCompleted: false),
            ItemModel(title: "Progress Photo", isCompleted: false),
            ItemModel(title: "Did not drink", isCompleted: false)
        ]
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title:String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
}
