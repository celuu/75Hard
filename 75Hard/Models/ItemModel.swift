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
    let title: String;
    let isCompleted: Bool
    let pageType: enum
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = UUID().uuidString;
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
