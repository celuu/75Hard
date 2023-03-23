//
//  LineItemView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct LineItemView: View {
    
    let item: ItemModel
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        HStack{
            NavigationLink(destination: getDestination(pageType: item.pageType), label:{
                Text (item.title)
            })
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
                .onTapGesture {
                    withAnimation(.linear){
                        listViewModel.updateItem(item: item)
                    }
                }
                
        }
        .font(.title2)
        .padding()
    }
    
    @ViewBuilder
    func getDestination(pageType: ItemModel.PageType) -> some View {
        switch pageType {
        case .water:
            WaterView()
        case .reading:
            PageView()
        case .workout:
            WorkoutView()
        case .outsideWorkout:
            WorkoutView()
        case .macros:
            MacroView()
        case .photo:
            AddPhotoView()
        case .drink:
            DrinkView()
        }
    }
    
}


struct LineItemView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "", isCompleted: false, pageType: .water)
    
    static var previews: some View {
        LineItemView(item: item1)
    }
    
}
