//
//  ItemModel.swift
//  75Hard
//
//  Created by Christine Luu on 3/20/23.
//

import Foundation


struct ItemModel: Identifiable{
    let id = UUID();
    let title: String;
    let isCompleted: Bool;
    
}
