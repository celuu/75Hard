//
//  ItemModel.swift
//  75Hard
//
//  Created by Christine Luu on 3/20/23.
//

import Foundation

//Immutable struct
struct ItemModel: Identifiable{
    let id: String
    let title: String
    let isCompleted: Bool
    let pageType: PageType
    
    
    enum PageType {
        case water
        case reading
        case workout
        case outsideWorkout
        case macros
        case photo
        case drink
    }
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, pageType: PageType) {
        self.id = UUID().uuidString;
        self.title = title
        self.isCompleted = isCompleted
        self.pageType = pageType
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, pageType: pageType)
    }
}
