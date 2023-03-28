//
//  ListViewModel.swift
//  75Hard
//
//  Created by Christine Luu on 3/20/23.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = []

    @Published var currentDayID = Date.now.localDayID
    
    init(){
        getItems()
    }
    
    func getItems() {
        let newItems = [
            ItemModel(title: "1 Gallon of Water", isCompleted: false, pageType: .water),
            ItemModel(title: "Read 10 Pages", isCompleted: false, pageType: .reading),
            ItemModel(title: "45 Min Workout", isCompleted: false, pageType: .workout),
            ItemModel(title: "45 Min Workout - Outside", isCompleted: false, pageType: .outsideWorkout),
            ItemModel(title: "Follow Macros", isCompleted: false, pageType: .macros),
            ItemModel(title: "Progress Photo", isCompleted: false, pageType: .photo),
            ItemModel(title: "Did not drink", isCompleted: false, pageType: .drink)
        ]
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false, pageType: .water)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel){
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }

    func moveCurrentDateForward() {
        currentDayID = Date.fromDayID(currentDayID).adjusting(days: 1).dayID
    }

    func moveCurrentDateBackward() {
        currentDayID = Date.fromDayID(currentDayID).adjusting(days: -1).dayID
    }
}
