//
//  LineItemView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct LineItemView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack{
            NavigationLink(destination: PageView(), label:{
                Text (item.title)
            })
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
                
        }
        .font(.title2)
        .padding()
    }
}


struct LineItemView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "", isCompleted: false)
    
    static var previews: some View {
        LineItemView(item: item1)
    }
}
